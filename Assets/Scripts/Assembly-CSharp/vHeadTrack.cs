using Invector;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class vHeadTrack : MonoBehaviour
{
	[HideInInspector]
	public float minAngleX = -90f;

	[HideInInspector]
	public float maxAngleX = 90f;

	[HideInInspector]
	public float minAngleY = -90f;

	[HideInInspector]
	public float maxAngleY = 90f;

	public Transform head;

	public float strafeHeadWeight = 0.8f;

	public float strafeBodyWeight = 0.8f;

	public float freeHeadWeight = 1f;

	public float freeBodyWeight = 0.4f;

	public float distanceToDetect = 10f;

	public float smooth = 12f;

	public float updateTargetInteration = 1f;

	public LayerMask obstacleLayer = 1;

	[Header("--- Gameobjects Tags to detect ---")]
	public List<string> tagsToDetect = new List<string>
	{
		"LookAt"
	};

	[Header("--- Animator State Tag to ignore the HeadTrack ---")]
	public List<string> animatorTags = new List<string>
	{
		"Attack",
		"LockMovement",
		"CustomAction"
	};

	public bool followCamera = true;

	public bool useLimitAngle = true;

	[Tooltip("Head Track work with AnimatorIK of LateUpdate (using Invector logic)")]
	public bool useUnityAnimatorIK;

	[HideInInspector]
	public Vector2 offsetSpine;

	[HideInInspector]
	public bool updateIK;

	protected List<vLookTarget> targetsInArea = new List<vLookTarget>();

	private float yRotation;

	private float xRotation;

	private float _currentHeadWeight;

	private float _currentbodyWeight;

	private Animator animator;

	private float headHeight;

	private vLookTarget lookTarget;

	private Transform simpleTarget;

	private List<int> tagsHash;

	private vHeadTrackSensor sensor;

	private float interation;

	private vCharacter vchar;

	private Vector2 cameraAngle;

	private Vector2 targetAngle;

	private List<Transform> spines;

	private float yAngle;

	private float xAngle;

	private float _yAngle;

	private float _xAngle;

	[HideInInspector]
	public UnityEvent onInitUpdate = new UnityEvent();

	[HideInInspector]
	public UnityEvent onFinishUpdate = new UnityEvent();

	private Vector3 headPoint => base.transform.position + base.transform.up * headHeight;

	private bool lookConditions => (head != null && followCamera && Camera.main != null) || (!followCamera && ((bool)lookTarget || (bool)simpleTarget));

	private void Start()
	{
		if (!sensor)
		{
			GameObject gameObject = new GameObject("HeadTrackSensor");
			sensor = gameObject.AddComponent<vHeadTrackSensor>();
		}
		vchar = GetComponent<vCharacter>();
		sensor.headTrack = this;
		animator = GetComponentInParent<Animator>();
		head = animator.GetBoneTransform(HumanBodyBones.Head);
		Transform boneTransform = animator.GetBoneTransform(HumanBodyBones.Spine);
		Transform boneTransform2 = animator.GetBoneTransform(HumanBodyBones.Chest);
		spines = new List<Transform>();
		spines.Add(boneTransform);
		spines.Add(boneTransform2);
		Transform boneTransform3 = animator.GetBoneTransform(HumanBodyBones.Neck);
		if (boneTransform3.parent != boneTransform2)
		{
			spines.Add(boneTransform3.parent);
		}
		if ((bool)head)
		{
			headHeight = Vector3.Distance(base.transform.position, head.position);
			sensor.transform.position = head.transform.position;
		}
		else
		{
			sensor.transform.position = base.transform.position;
		}
		int layer = LayerMask.NameToLayer("HeadTrack");
		sensor.transform.parent = base.transform;
		sensor.gameObject.layer = layer;
		sensor.gameObject.tag = base.transform.tag;
		tagsHash = new List<int>();
		for (int i = 0; i < animatorTags.Count; i++)
		{
			tagsHash.Add(Animator.StringToHash(animatorTags[i]));
		}
		GetLookPoint();
	}

	private void OnAnimatorIK()
	{
		if (useUnityAnimatorIK && vchar != null && vchar.currentHealth > 0f)
		{
			onInitUpdate.Invoke();
			animator.SetLookAtWeight(_currentHeadWeight, _currentbodyWeight);
			animator.SetLookAtPosition(GetLookPoint());
			onFinishUpdate.Invoke();
		}
	}

	private void FixedUpdate()
	{
		updateIK = true;
	}

	private void LateUpdate()
	{
		if (!(animator == null) && !useUnityAnimatorIK && (updateIK || animator.updateMode != AnimatorUpdateMode.AnimatePhysics))
		{
			updateIK = false;
			if (vchar != null && vchar.currentHealth > 0f && animator != null && animator.enabled)
			{
				onInitUpdate.Invoke();
				SetLookAtPosition(GetLookPoint(), _currentHeadWeight, _currentbodyWeight);
				onFinishUpdate.Invoke();
			}
		}
	}

	public virtual void SetLookAtPosition(Vector3 point, float strafeHeadWeight, float spineWeight)
	{
		Vector3 vector = Quaternion.LookRotation(GetLookPoint() - spines[spines.Count - 1].position).eulerAngles - base.transform.eulerAngles;
		float b = NormalizeAngle(vector.y);
		float b2 = NormalizeAngle(vector.x);
		xAngle = Mathf.Clamp(Mathf.Lerp(xAngle, b2, smooth * Time.fixedDeltaTime), minAngleX, maxAngleX);
		yAngle = Mathf.Clamp(Mathf.Lerp(yAngle, b, smooth * Time.fixedDeltaTime), minAngleY, maxAngleY);
		float num = xAngle;
		Vector3 eulerAngles = Quaternion.Euler(offsetSpine).eulerAngles;
		xAngle = NormalizeAngle(num + eulerAngles.x);
		float num2 = yAngle;
		Vector3 eulerAngles2 = Quaternion.Euler(offsetSpine).eulerAngles;
		yAngle = NormalizeAngle(num2 + eulerAngles2.y);
		foreach (Transform spine in spines)
		{
			Quaternion lhs = Quaternion.AngleAxis(xAngle * spineWeight / (float)spines.Count, spine.InverseTransformDirection(base.transform.right));
			Quaternion rhs = Quaternion.AngleAxis(yAngle * spineWeight / (float)spines.Count, spine.InverseTransformDirection(base.transform.up));
			spine.rotation *= lhs * rhs;
		}
		_yAngle = Mathf.Lerp(_yAngle, (yAngle - yAngle * spineWeight) * strafeHeadWeight, smooth * Time.fixedDeltaTime);
		_xAngle = Mathf.Lerp(_xAngle, (xAngle - xAngle * spineWeight) * strafeHeadWeight, smooth * Time.fixedDeltaTime);
		Quaternion lhs2 = Quaternion.AngleAxis(_xAngle, head.InverseTransformDirection(base.transform.right));
		Quaternion rhs2 = Quaternion.AngleAxis(_yAngle, head.InverseTransformDirection(base.transform.up));
		head.rotation *= lhs2 * rhs2;
	}

	private Vector3 GetLookPoint()
	{
		int num = 100;
		if (lookConditions && !IgnoreHeadTrack())
		{
			Vector3 a = headPoint + base.transform.forward * num;
			if (followCamera)
			{
				a = Camera.main.transform.position + Camera.main.transform.forward * num;
			}
			Vector3 direction = a - headPoint;
			if (lookTarget != null && TargetIsOnRange(lookTarget.lookPoint - headPoint) && lookTarget.IsVisible(headPoint, obstacleLayer))
			{
				direction = lookTarget.lookPoint - headPoint;
			}
			else if (simpleTarget != null)
			{
				direction = simpleTarget.position - headPoint;
			}
			Vector2 vector = GetTargetAngle(direction);
			if (useLimitAngle)
			{
				if (TargetIsOnRange(direction))
				{
					if (animator.GetBool("IsStrafing"))
					{
						SmoothValues(strafeHeadWeight, strafeBodyWeight, vector.x, vector.y);
					}
					else
					{
						SmoothValues(freeHeadWeight, freeBodyWeight, vector.x, vector.y);
					}
				}
				else
				{
					SmoothValues();
				}
			}
			else if (animator.GetBool("IsStrafing"))
			{
				SmoothValues(strafeHeadWeight, strafeBodyWeight, vector.x, vector.y);
			}
			else
			{
				SmoothValues(freeHeadWeight, freeBodyWeight, vector.x, vector.y);
			}
			if (targetsInArea.Count > 1)
			{
				SortTargets();
			}
		}
		else
		{
			SmoothValues();
			if (targetsInArea.Count > 1)
			{
				SortTargets();
			}
		}
		Quaternion lhs = Quaternion.AngleAxis(yRotation, base.transform.up);
		Quaternion rhs = Quaternion.AngleAxis(xRotation, base.transform.right);
		Quaternion rotation = lhs * rhs;
		Vector3 a2 = rotation * base.transform.forward;
		return headPoint + a2 * num;
	}

	private Vector2 GetTargetAngle(Vector3 direction)
	{
		Vector3 euler = Quaternion.LookRotation(direction, base.transform.up).eulerAngles - base.transform.eulerAngles;
		Quaternion quaternion = Quaternion.Euler(euler);
		Vector3 eulerAngles = quaternion.eulerAngles;
		float x = (float)Math.Round(NormalizeAngle(eulerAngles.x), 2);
		Vector3 eulerAngles2 = quaternion.eulerAngles;
		float y = (float)Math.Round(NormalizeAngle(eulerAngles2.y), 2);
		return new Vector2(x, y);
	}

	private bool TargetIsOnRange(Vector3 direction)
	{
		Vector2 vector = GetTargetAngle(direction);
		return vector.x >= minAngleX && vector.x <= maxAngleX && vector.y >= minAngleY && vector.y <= maxAngleY;
	}

	public void SetLookTarget(vLookTarget target, bool priority = false)
	{
		if (!targetsInArea.Contains(target))
		{
			targetsInArea.Add(target);
		}
		if (priority)
		{
			lookTarget = target;
		}
	}

	public void SetLookTarget(Transform target)
	{
		simpleTarget = target;
	}

	public void RemoveLookTarget(vLookTarget target)
	{
		if (targetsInArea.Contains(target))
		{
			targetsInArea.Remove(target);
		}
		if (lookTarget == target)
		{
			lookTarget = null;
		}
	}

	public void RemoveLookTarget(Transform target)
	{
		if (simpleTarget == target)
		{
			simpleTarget = null;
		}
	}

	private float NormalizeAngle(float angle)
	{
		if (angle < -180f)
		{
			return angle + 360f;
		}
		if (angle > 180f)
		{
			return angle - 360f;
		}
		return angle;
	}

	private void ResetValues()
	{
		_currentHeadWeight = 0f;
		_currentbodyWeight = 0f;
		yRotation = 0f;
		xRotation = 0f;
	}

	private void SmoothValues(float _headWeight = 0f, float _bodyWeight = 0f, float _x = 0f, float _y = 0f)
	{
		_currentHeadWeight = Mathf.Lerp(_currentHeadWeight, _headWeight, smooth * Time.deltaTime);
		_currentbodyWeight = Mathf.Lerp(_currentbodyWeight, _bodyWeight, smooth * Time.deltaTime);
		yRotation = Mathf.Lerp(yRotation, _y, smooth * Time.deltaTime);
		xRotation = Mathf.Lerp(xRotation, _x, smooth * Time.deltaTime);
		yRotation = Mathf.Clamp(yRotation, minAngleY, maxAngleY);
		xRotation = Mathf.Clamp(xRotation, minAngleX, maxAngleX);
	}

	private void SortTargets()
	{
		interation += Time.deltaTime;
		if (!(interation > updateTargetInteration))
		{
			return;
		}
		interation -= updateTargetInteration;
		if (targetsInArea == null || targetsInArea.Count < 2)
		{
			if (targetsInArea != null && targetsInArea.Count > 0)
			{
				lookTarget = targetsInArea[0];
			}
			return;
		}
		for (int num = targetsInArea.Count - 1; num >= 0; num--)
		{
			if (targetsInArea[num] == null)
			{
				targetsInArea.RemoveAt(num);
			}
		}
		targetsInArea.Sort((vLookTarget c1, vLookTarget c2) => Vector3.Distance(base.transform.position, (!(c1 != null)) ? (Vector3.one * float.PositiveInfinity) : c1.transform.position).CompareTo(Vector3.Distance(base.transform.position, (!(c2 != null)) ? (Vector3.one * float.PositiveInfinity) : c2.transform.position)));
		if (targetsInArea.Count > 0)
		{
			lookTarget = targetsInArea[0];
		}
	}

	public void OnDetect(Collider other)
	{
		if (tagsToDetect.Contains(other.gameObject.tag) && other.GetComponent<vLookTarget>() != null)
		{
			lookTarget = other.GetComponent<vLookTarget>();
			vHeadTrack componentInParent = other.GetComponentInParent<vHeadTrack>();
			if (!targetsInArea.Contains(lookTarget) && (componentInParent == null || componentInParent != this))
			{
				targetsInArea.Add(lookTarget);
				SortTargets();
				lookTarget = targetsInArea[0];
			}
		}
	}

	public void OnLost(Collider other)
	{
		if (tagsToDetect.Contains(other.gameObject.tag) && other.GetComponentInParent<vLookTarget>() != null)
		{
			lookTarget = other.GetComponentInParent<vLookTarget>();
			if (targetsInArea.Contains(lookTarget))
			{
				targetsInArea.Remove(lookTarget);
			}
			SortTargets();
			if (targetsInArea.Count > 0)
			{
				lookTarget = targetsInArea[0];
			}
			else
			{
				lookTarget = null;
			}
		}
	}

	public bool IgnoreHeadTrack()
	{
		for (int i = 0; i < animator.layerCount; i++)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(i);
			if (tagsHash.Contains(currentAnimatorStateInfo.tagHash))
			{
				return true;
			}
		}
		return false;
	}
}
