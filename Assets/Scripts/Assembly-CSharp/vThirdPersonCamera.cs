using Invector;
using UnityEngine;

public class vThirdPersonCamera : MonoBehaviour
{
	private static vThirdPersonCamera _instance;

	public Transform target;

	[Tooltip("Lerp speed between Camera States")]
	public float smoothBetweenState = 3f;

	public float smoothCameraRotation = 8f;

	public float scrollSpeed = 10f;

	[Tooltip("What layer will be culled")]
	public LayerMask cullingLayer = 1;

	[Tooltip("Change this value If the camera pass through the wall")]
	public float clipPlaneMargin;

	public float checkHeightRadius;

	public bool showGizmos;

	[Tooltip("Debug purposes, lock the camera behind the character for better align the states")]
	public bool lockCamera;

	[HideInInspector]
	public int indexList;

	[HideInInspector]
	public int indexLookPoint;

	[HideInInspector]
	public float offSetPlayerPivot;

	[HideInInspector]
	public float distance = 5f;

	[HideInInspector]
	public string currentStateName;

	[HideInInspector]
	public Transform currentTarget;

	[HideInInspector]
	public vThirdPersonCameraState currentState;

	[HideInInspector]
	public vThirdPersonCameraListData CameraStateList;

	[HideInInspector]
	public Transform lockTarget;

	[HideInInspector]
	public Vector2 movementSpeed;

	[HideInInspector]
	public vThirdPersonCameraState lerpState;

	private vLockOnTargetControl lockOn;

	private Transform targetLookAt;

	private Vector3 currentTargetPos;

	private Vector3 lookPoint;

	private Vector3 current_cPos;

	private Vector3 desired_cPos;

	private Vector3 lookTargetOffSet;

	private Camera _camera;

	private float mouseY;

	private float mouseX;

	private float currentHeight;

	private float currentZoom;

	private float cullingHeight;

	private float cullingDistance;

	private float switchRight;

	private float currentSwitchRight;

	private bool useSmooth;

	private bool isNewTarget;

	public static vThirdPersonCamera instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = Object.FindObjectOfType<vThirdPersonCamera>();
			}
			return _instance;
		}
	}

	private bool isValidFixedPoint => currentState.lookPoints != null && currentState.cameraMode.Equals(TPCameraMode.FixedPoint) && (indexLookPoint < currentState.lookPoints.Count || currentState.lookPoints.Count > 0);

	private void OnDrawGizmos()
	{
		if (showGizmos && (bool)currentTarget)
		{
			Vector3 position = currentTarget.position;
			float x = position.x;
			Vector3 position2 = currentTarget.position;
			float y = position2.y + offSetPlayerPivot;
			Vector3 position3 = currentTarget.position;
			Vector3 vector = new Vector3(x, y, position3.z);
			Gizmos.DrawWireSphere(vector + Vector3.up * cullingHeight, checkHeightRadius);
			Gizmos.DrawLine(vector, vector + Vector3.up * cullingHeight);
		}
	}

	private void Start()
	{
		Init();
	}

	public void Init()
	{
		if (!(target == null))
		{
			_camera = GetComponent<Camera>();
			currentTarget = target;
			Vector3 position = currentTarget.position;
			float x = position.x;
			Vector3 position2 = currentTarget.position;
			float y = position2.y + offSetPlayerPivot;
			Vector3 position3 = currentTarget.position;
			currentTargetPos = new Vector3(x, y, position3.z);
			targetLookAt = new GameObject("targetLookAt").transform;
			targetLookAt.position = currentTarget.position;
			targetLookAt.hideFlags = HideFlags.HideInHierarchy;
			targetLookAt.rotation = currentTarget.rotation;
			Vector3 eulerAngles = currentTarget.eulerAngles;
			mouseY = eulerAngles.x;
			Vector3 eulerAngles2 = currentTarget.eulerAngles;
			mouseX = eulerAngles2.y;
			switchRight = 1f;
			currentSwitchRight = 1f;
			lockOn = GetComponent<vLockOnTargetControl>();
			ChangeState("Default", hasSmooth: false);
			currentZoom = currentState.defaultDistance;
			distance = currentState.defaultDistance;
			currentHeight = currentState.height;
			useSmooth = true;
		}
	}

	private void FixedUpdate()
	{
		if (!(target == null) && !(targetLookAt == null) && currentState != null && lerpState != null)
		{
			switch (currentState.cameraMode)
			{
			case TPCameraMode.FreeDirectional:
				CameraMovement();
				break;
			case TPCameraMode.FixedAngle:
				CameraMovement();
				break;
			case TPCameraMode.FixedPoint:
				CameraFixed();
				break;
			}
		}
	}

	public void SetTargetLockOn(Transform _lockTarget)
	{
		if (_lockTarget != null)
		{
			currentTarget.SendMessage("FindTargetLockOn", _lockTarget, SendMessageOptions.DontRequireReceiver);
		}
		lockTarget = _lockTarget;
		isNewTarget = (_lockTarget != null);
	}

	public void ClearTargetLockOn()
	{
		lockTarget = null;
		currentTarget.SendMessage("LostTargetLockOn", SendMessageOptions.DontRequireReceiver);
		vLockOnTargetControl component = GetComponent<vLockOnTargetControl>();
		if (component != null)
		{
			component.StopLockOn();
		}
	}

	public void SetTarget(Transform newTarget)
	{
		currentTarget = ((!newTarget) ? target : newTarget);
	}

	public void SetMainTarget(Transform newTarget)
	{
		target = newTarget;
		currentTarget = newTarget;
		Vector3 eulerAngles = currentTarget.rotation.eulerAngles;
		mouseY = eulerAngles.x;
		Vector3 eulerAngles2 = currentTarget.rotation.eulerAngles;
		mouseX = eulerAngles2.y;
		Init();
	}

	public void UpdateLockOn(bool value)
	{
		if ((bool)lockOn)
		{
			lockOn.UpdateLockOn(value);
		}
	}

	public Ray ScreenPointToRay(Vector3 Point)
	{
		return GetComponent<Camera>().ScreenPointToRay(Point);
	}

	public void ChangeState(string stateName, bool hasSmooth)
	{
		if (currentState != null && currentState.Name.Equals(stateName))
		{
			return;
		}
		vThirdPersonCameraState vThirdPersonCameraState = (!(CameraStateList != null)) ? new vThirdPersonCameraState("Default") : CameraStateList.tpCameraStates.Find((vThirdPersonCameraState obj) => obj.Name.Equals(stateName));
		if (vThirdPersonCameraState != null)
		{
			currentStateName = stateName;
			currentState.cameraMode = vThirdPersonCameraState.cameraMode;
			lerpState = vThirdPersonCameraState;
			if (currentState != null && !hasSmooth)
			{
				currentState.CopyState(vThirdPersonCameraState);
			}
		}
		else if (CameraStateList != null && CameraStateList.tpCameraStates.Count > 0)
		{
			vThirdPersonCameraState = CameraStateList.tpCameraStates[0];
			currentStateName = vThirdPersonCameraState.Name;
			currentState.cameraMode = vThirdPersonCameraState.cameraMode;
			lerpState = vThirdPersonCameraState;
			if (currentState != null && !hasSmooth)
			{
				currentState.CopyState(vThirdPersonCameraState);
			}
		}
		if (currentState == null)
		{
			currentState = new vThirdPersonCameraState("Null");
			currentStateName = currentState.Name;
		}
		if (CameraStateList != null)
		{
			indexList = CameraStateList.tpCameraStates.IndexOf(vThirdPersonCameraState);
		}
		currentZoom = vThirdPersonCameraState.defaultDistance;
		currentState.fixedAngle = new Vector3(mouseX, mouseY);
		useSmooth = hasSmooth;
		indexLookPoint = 0;
	}

	public void ChangeState(string stateName, string pointName, bool hasSmooth)
	{
		useSmooth = hasSmooth;
		if (!currentState.Name.Equals(stateName))
		{
			vThirdPersonCameraState vThirdPersonCameraState = CameraStateList.tpCameraStates.Find((vThirdPersonCameraState obj) => obj.Name.Equals(stateName));
			if (vThirdPersonCameraState != null)
			{
				currentStateName = stateName;
				currentState.cameraMode = vThirdPersonCameraState.cameraMode;
				lerpState = vThirdPersonCameraState;
				if (currentState != null && !hasSmooth)
				{
					currentState.CopyState(vThirdPersonCameraState);
				}
			}
			else if (CameraStateList.tpCameraStates.Count > 0)
			{
				vThirdPersonCameraState = CameraStateList.tpCameraStates[0];
				currentStateName = vThirdPersonCameraState.Name;
				currentState.cameraMode = vThirdPersonCameraState.cameraMode;
				lerpState = vThirdPersonCameraState;
				if (currentState != null && !hasSmooth)
				{
					currentState.CopyState(vThirdPersonCameraState);
				}
			}
			if (currentState == null)
			{
				currentState = new vThirdPersonCameraState("Null");
				currentStateName = currentState.Name;
			}
			indexList = CameraStateList.tpCameraStates.IndexOf(vThirdPersonCameraState);
			currentZoom = vThirdPersonCameraState.defaultDistance;
			currentState.fixedAngle = new Vector3(mouseX, mouseY);
			indexLookPoint = 0;
		}
		if (currentState.cameraMode == TPCameraMode.FixedPoint)
		{
			LookPoint lookPoint = currentState.lookPoints.Find((LookPoint obj) => obj.pointName.Equals(pointName));
			if (lookPoint != null)
			{
				indexLookPoint = currentState.lookPoints.IndexOf(lookPoint);
			}
			else
			{
				indexLookPoint = 0;
			}
		}
	}

	public void ChangePoint(string pointName)
	{
		if (currentState != null && currentState.cameraMode == TPCameraMode.FixedPoint && currentState.lookPoints != null)
		{
			LookPoint lookPoint = currentState.lookPoints.Find((LookPoint obj) => obj.pointName.Equals(pointName));
			if (lookPoint != null)
			{
				indexLookPoint = currentState.lookPoints.IndexOf(lookPoint);
			}
			else
			{
				indexLookPoint = 0;
			}
		}
	}

	public void Zoom(float scroolValue)
	{
		currentZoom -= scroolValue * scrollSpeed;
	}

	public void RotateCamera(float x, float y)
	{
		if (currentState.cameraMode.Equals(TPCameraMode.FixedPoint))
		{
			return;
		}
		if (!currentState.cameraMode.Equals(TPCameraMode.FixedAngle))
		{
			if ((bool)lockTarget)
			{
				CalculeLockOnPoint();
				return;
			}
			mouseX += x * currentState.xMouseSensitivity;
			mouseY -= y * currentState.yMouseSensitivity;
			movementSpeed.x = x;
			movementSpeed.y = 0f - y;
			if (!lockCamera)
			{
				mouseY = vExtensions.ClampAngle(mouseY, currentState.yMinLimit, currentState.yMaxLimit);
				mouseX = vExtensions.ClampAngle(mouseX, currentState.xMinLimit, currentState.xMaxLimit);
				return;
			}
			Vector3 localEulerAngles = currentTarget.root.localEulerAngles;
			mouseY = localEulerAngles.x;
			Vector3 localEulerAngles2 = currentTarget.root.localEulerAngles;
			mouseX = localEulerAngles2.y;
		}
		else
		{
			mouseX = currentState.fixedAngle.x;
			mouseY = currentState.fixedAngle.y;
		}
	}

	public void SwitchRight(bool value = false)
	{
		switchRight = ((!value) ? 1 : (-1));
	}

	private void CalculeLockOnPoint()
	{
		if (currentState.cameraMode.Equals(TPCameraMode.FixedAngle) && (bool)lockTarget)
		{
			return;
		}
		Collider component = lockTarget.GetComponent<Collider>();
		if (component == null)
		{
			return;
		}
		Vector3 center = component.bounds.center;
		Vector3 forward = center - current_cPos;
		Quaternion quaternion = Quaternion.LookRotation(forward);
		float num = 0f;
		Vector3 eulerAngles = quaternion.eulerAngles;
		float y = eulerAngles.y;
		Vector3 eulerAngles2 = quaternion.eulerAngles;
		if (eulerAngles2.x < -180f)
		{
			Vector3 eulerAngles3 = quaternion.eulerAngles;
			num = eulerAngles3.x + 360f;
		}
		else
		{
			Vector3 eulerAngles4 = quaternion.eulerAngles;
			if (eulerAngles4.x > 180f)
			{
				Vector3 eulerAngles5 = quaternion.eulerAngles;
				num = eulerAngles5.x - 360f;
			}
			else
			{
				Vector3 eulerAngles6 = quaternion.eulerAngles;
				num = eulerAngles6.x;
			}
		}
		mouseY = vExtensions.ClampAngle(num, currentState.yMinLimit, currentState.yMaxLimit);
		mouseX = vExtensions.ClampAngle(y, currentState.xMinLimit, currentState.xMaxLimit);
	}

	private void CameraMovement()
	{
		if (currentTarget == null)
		{
			return;
		}
		if (useSmooth)
		{
			currentState.Slerp(lerpState, smoothBetweenState * Time.fixedDeltaTime);
		}
		else
		{
			currentState.CopyState(lerpState);
		}
		if (currentState.useZoom)
		{
			currentZoom = Mathf.Clamp(currentZoom, currentState.minDistance, currentState.maxDistance);
			distance = ((!useSmooth) ? currentZoom : Mathf.Lerp(distance, currentZoom, lerpState.smoothFollow * Time.fixedDeltaTime));
		}
		else
		{
			distance = ((!useSmooth) ? currentState.defaultDistance : Mathf.Lerp(distance, currentState.defaultDistance, lerpState.smoothFollow * Time.fixedDeltaTime));
			currentZoom = currentState.defaultDistance;
		}
		_camera.fieldOfView = currentState.fov;
		cullingDistance = Mathf.Lerp(cullingDistance, currentZoom, smoothBetweenState * Time.fixedDeltaTime);
		currentSwitchRight = Mathf.Lerp(currentSwitchRight, switchRight, smoothBetweenState * Time.fixedDeltaTime);
		Vector3 normalized = (currentState.forward * targetLookAt.forward + currentState.right * currentSwitchRight * targetLookAt.right).normalized;
		Vector3 position = currentTarget.position;
		float x = position.x;
		Vector3 position2 = currentTarget.position;
		float y = position2.y + offSetPlayerPivot;
		Vector3 position3 = currentTarget.position;
		Vector3 vector = new Vector3(x, y, position3.z);
		currentTargetPos = ((!useSmooth) ? vector : Vector3.Lerp(currentTargetPos, vector, lerpState.smoothFollow * Time.fixedDeltaTime));
		desired_cPos = vector + new Vector3(0f, currentState.height, 0f);
		current_cPos = currentTargetPos + new Vector3(0f, currentHeight, 0f);
		ClipPlanePoints to = _camera.NearClipPlanePoints(current_cPos + normalized * distance, clipPlaneMargin);
		ClipPlanePoints to2 = _camera.NearClipPlanePoints(desired_cPos + normalized * currentZoom, clipPlaneMargin);
		if (Physics.SphereCast(vector, checkHeightRadius, Vector3.up, out RaycastHit hitInfo, currentState.cullingHeight + 0.2f, cullingLayer))
		{
			float num = hitInfo.distance - 0.2f;
			num -= currentState.height;
			num /= currentState.cullingHeight - currentState.height;
			cullingHeight = Mathf.Lerp(currentState.height, currentState.cullingHeight, Mathf.Clamp(num, 0f, 1f));
		}
		else
		{
			cullingHeight = ((!useSmooth) ? currentState.cullingHeight : Mathf.Lerp(cullingHeight, currentState.cullingHeight, smoothBetweenState * Time.fixedDeltaTime));
		}
		if (CullingRayCast(desired_cPos, to2, out hitInfo, currentZoom + 0.2f, cullingLayer, Color.blue))
		{
			distance = hitInfo.distance - 0.2f;
			if (distance < currentState.defaultDistance)
			{
				float num2 = hitInfo.distance;
				num2 -= currentState.cullingMinDist;
				num2 /= currentZoom - currentState.cullingMinDist;
				currentHeight = Mathf.Lerp(cullingHeight, currentState.height, Mathf.Clamp(num2, 0f, 1f));
				current_cPos = currentTargetPos + new Vector3(0f, currentHeight, 0f);
			}
		}
		else
		{
			currentHeight = ((!useSmooth) ? currentState.height : Mathf.Lerp(currentHeight, currentState.height, smoothBetweenState * Time.fixedDeltaTime));
		}
		if (CullingRayCast(current_cPos, to, out hitInfo, distance, cullingLayer, Color.cyan))
		{
			distance = Mathf.Clamp(cullingDistance, 0f, currentState.defaultDistance);
		}
		Vector3 a = current_cPos + targetLookAt.forward * 2f;
		a += targetLookAt.right * Vector3.Dot(normalized * distance, targetLookAt.right);
		targetLookAt.position = current_cPos;
		Quaternion quaternion = Quaternion.Euler(mouseY, mouseX, 0f);
		targetLookAt.rotation = ((!useSmooth) ? quaternion : Quaternion.Slerp(targetLookAt.rotation, quaternion, smoothCameraRotation * Time.fixedDeltaTime));
		base.transform.position = current_cPos + normalized * distance;
		Quaternion quaternion2 = Quaternion.LookRotation(a - base.transform.position);
		if ((bool)lockTarget)
		{
			if (!currentState.cameraMode.Equals(TPCameraMode.FixedAngle))
			{
				Collider component = lockTarget.GetComponent<Collider>();
				if (component != null)
				{
					Vector3 forward = component.bounds.center - base.transform.position;
					Vector3 b = Quaternion.LookRotation(forward).eulerAngles - quaternion2.eulerAngles;
					if (isNewTarget)
					{
						lookTargetOffSet = Vector3.MoveTowards(lookTargetOffSet, b, currentState.smoothFollow * Time.fixedDeltaTime);
						if (Vector3.Distance(lookTargetOffSet, b) < 1f)
						{
							isNewTarget = false;
						}
					}
					else
					{
						lookTargetOffSet = b;
					}
				}
			}
		}
		else
		{
			lookTargetOffSet = Vector3.Lerp(lookTargetOffSet, Vector3.zero, 1f * Time.fixedDeltaTime);
		}
		quaternion2.eulerAngles += currentState.rotationOffSet;
		Vector3 eulerAngles = quaternion2.eulerAngles;
		float x2 = eulerAngles.x + lookTargetOffSet.x;
		Vector3 eulerAngles2 = quaternion2.eulerAngles;
		Quaternion rotation = Quaternion.Euler(x2, eulerAngles2.y + lookTargetOffSet.y, lookTargetOffSet.z);
		base.transform.rotation = rotation;
		movementSpeed = Vector2.zero;
	}

	private void CameraFixed()
	{
		if (useSmooth)
		{
			currentState.Slerp(lerpState, smoothBetweenState);
		}
		else
		{
			currentState.CopyState(lerpState);
		}
		Vector3 position = currentTarget.position;
		float x = position.x;
		Vector3 position2 = currentTarget.position;
		float y = position2.y + offSetPlayerPivot + currentState.height;
		Vector3 position3 = currentTarget.position;
		Vector3 vector = new Vector3(x, y, position3.z);
		currentTargetPos = ((!useSmooth) ? vector : Vector3.MoveTowards(currentTargetPos, vector, currentState.smoothFollow * Time.fixedDeltaTime));
		current_cPos = currentTargetPos;
		Vector3 vector2 = (!isValidFixedPoint) ? base.transform.position : currentState.lookPoints[indexLookPoint].positionPoint;
		base.transform.position = ((!useSmooth) ? vector2 : Vector3.Lerp(base.transform.position, vector2, currentState.smoothFollow * Time.fixedDeltaTime));
		targetLookAt.position = current_cPos;
		if (isValidFixedPoint && currentState.lookPoints[indexLookPoint].freeRotation)
		{
			Quaternion quaternion = Quaternion.Euler(currentState.lookPoints[indexLookPoint].eulerAngle);
			base.transform.rotation = ((!useSmooth) ? quaternion : Quaternion.Slerp(base.transform.rotation, quaternion, currentState.smoothFollow * 0.5f * Time.fixedDeltaTime));
		}
		else if (isValidFixedPoint)
		{
			Quaternion quaternion2 = Quaternion.LookRotation(currentTargetPos - base.transform.position);
			base.transform.rotation = ((!useSmooth) ? quaternion2 : Quaternion.Slerp(base.transform.rotation, quaternion2, currentState.smoothFollow * Time.fixedDeltaTime));
		}
		_camera.fieldOfView = currentState.fov;
	}

	private bool CullingRayCast(Vector3 from, ClipPlanePoints _to, out RaycastHit hitInfo, float distance, LayerMask cullingLayer, Color color)
	{
		bool result = false;
		if (showGizmos)
		{
			Debug.DrawRay(from, _to.LowerLeft - from, color);
			Debug.DrawLine(_to.LowerLeft, _to.LowerRight, color);
			Debug.DrawLine(_to.UpperLeft, _to.UpperRight, color);
			Debug.DrawLine(_to.UpperLeft, _to.LowerLeft, color);
			Debug.DrawLine(_to.UpperRight, _to.LowerRight, color);
			Debug.DrawRay(from, _to.LowerRight - from, color);
			Debug.DrawRay(from, _to.UpperLeft - from, color);
			Debug.DrawRay(from, _to.UpperRight - from, color);
		}
		if (Physics.Raycast(from, _to.LowerLeft - from, out hitInfo, distance, cullingLayer))
		{
			result = true;
			cullingDistance = hitInfo.distance;
		}
		if (Physics.Raycast(from, _to.LowerRight - from, out hitInfo, distance, cullingLayer))
		{
			result = true;
			if (cullingDistance > hitInfo.distance)
			{
				cullingDistance = hitInfo.distance;
			}
		}
		if (Physics.Raycast(from, _to.UpperLeft - from, out hitInfo, distance, cullingLayer))
		{
			result = true;
			if (cullingDistance > hitInfo.distance)
			{
				cullingDistance = hitInfo.distance;
			}
		}
		if (Physics.Raycast(from, _to.UpperRight - from, out hitInfo, distance, cullingLayer))
		{
			result = true;
			if (cullingDistance > hitInfo.distance)
			{
				cullingDistance = hitInfo.distance;
			}
		}
		return result;
	}
}
