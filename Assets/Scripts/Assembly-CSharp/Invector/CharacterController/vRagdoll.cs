using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Invector.CharacterController
{
	public class vRagdoll : MonoBehaviour
	{
		private enum RagdollState
		{
			animated,
			ragdolled,
			blendToAnim
		}

		private class BodyPart
		{
			public Transform transform;

			public Vector3 storedPosition;

			public Quaternion storedRotation;
		}

		public bool removePhysicsAfterDie;

		[Tooltip("Press the B key to enable the ragdoll")]
		public bool debug;

		[Tooltip("Keep true to use body detection for the Shooter")]
		public bool disableColliders = true;

		public AudioSource collisionSource;

		public AudioClip collisionClip;

		[Header("Add Tags for Weapons or Itens here:")]
		public List<string> ignoreTags = new List<string>
		{
			"Weapon",
			"Ignore Ragdoll"
		};

		public AnimatorStateInfo stateInfo;

		[HideInInspector]
		public vCharacter iChar;

		private Animator animator;

		[HideInInspector]
		public Transform characterChest;

		[HideInInspector]
		public Transform characterHips;

		private bool inStabilize;

		private bool isActive;

		private bool updateBeharivour;

		private RagdollState state;

		private float ragdollToMecanimBlendTime = 0.5f;

		private float mecanimToGetUpTransitionTime = 0.05f;

		private float ragdollingEndTime = -100f;

		private Vector3 ragdolledHipPosition;

		private Vector3 ragdolledHeadPosition;

		private Vector3 ragdolledFeetPosition;

		private List<BodyPart> bodyParts = new List<BodyPart>();

		private Transform hipsParent;

		private bool inApplyDamage;

		private bool ragdolled
		{
			get
			{
				return state != RagdollState.animated;
			}
			set
			{
				if (value)
				{
					if (state == RagdollState.animated)
					{
						setKinematic(newValue: false);
						setCollider(newValue: false);
						animator.enabled = false;
						state = RagdollState.ragdolled;
					}
					return;
				}
				characterHips.parent = hipsParent;
				if (state == RagdollState.ragdolled)
				{
					setKinematic(newValue: true);
					setCollider(newValue: true);
					ragdollingEndTime = Time.time;
					animator.enabled = true;
					state = RagdollState.blendToAnim;
					foreach (BodyPart bodyPart in bodyParts)
					{
						bodyPart.storedRotation = bodyPart.transform.rotation;
						bodyPart.storedPosition = bodyPart.transform.position;
					}
					ragdolledFeetPosition = 0.5f * (animator.GetBoneTransform(HumanBodyBones.LeftToes).position + animator.GetBoneTransform(HumanBodyBones.RightToes).position);
					ragdolledHeadPosition = animator.GetBoneTransform(HumanBodyBones.Head).position;
					ragdolledHipPosition = animator.GetBoneTransform(HumanBodyBones.Hips).position;
					Vector3 forward = animator.GetBoneTransform(HumanBodyBones.Hips).forward;
					if (forward.y > 0f)
					{
						animator.Play("StandUp@FromBack");
					}
					else
					{
						animator.Play("StandUp@FromBelly");
					}
				}
			}
		}

		private void Start()
		{
			animator = GetComponent<Animator>();
			iChar = GetComponent<vCharacter>();
			if ((bool)iChar)
			{
				iChar.onActiveRagdoll.AddListener(ActivateRagdoll);
			}
			characterChest = animator.GetBoneTransform(HumanBodyBones.Chest);
			characterHips = animator.GetBoneTransform(HumanBodyBones.Hips);
			hipsParent = characterHips.parent;
			setKinematic(newValue: true);
			setCollider(newValue: true);
			Component[] componentsInChildren = GetComponentsInChildren(typeof(Transform));
			Component[] array = componentsInChildren;
			foreach (Component component in array)
			{
				if (!ignoreTags.Contains(component.tag))
				{
					BodyPart bodyPart = new BodyPart();
					bodyPart.transform = (component as Transform);
					if (component.GetComponent<Rigidbody>() != null)
					{
						component.tag = base.gameObject.tag;
					}
					bodyParts.Add(bodyPart);
				}
			}
		}

		private void LateUpdate()
		{
			if (!(animator == null) && (updateBeharivour || animator.updateMode != AnimatorUpdateMode.AnimatePhysics))
			{
				updateBeharivour = false;
				RagdollBehaviour();
				if (debug && Input.GetKeyDown(KeyCode.B))
				{
					ActivateRagdoll();
				}
			}
		}

		private void FixedUpdate()
		{
			updateBeharivour = true;
			if (iChar.currentHealth > 0f)
			{
				if (inStabilize)
				{
					StartCoroutine(RagdollStabilizer(2f));
				}
				if ((animator != null && !animator.isActiveAndEnabled && ragdolled) || (animator == null && ragdolled))
				{
					base.transform.position = characterHips.position;
				}
			}
		}

		private void ResetDamage()
		{
			inApplyDamage = false;
		}

		public void ApplyDamage(Damage damage)
		{
			if (isActive && ragdolled && !inApplyDamage && (bool)iChar)
			{
				inApplyDamage = true;
				iChar.TakeDamage(damage);
				Invoke("ResetDamage", 0.2f);
			}
		}

		public void ActivateRagdoll()
		{
			if (!isActive)
			{
				inApplyDamage = true;
				isActive = true;
				if (base.transform.parent != null)
				{
					base.transform.parent = null;
				}
				iChar.EnableRagdoll();
				bool flag = !(iChar.currentHealth > 0f);
				if (flag)
				{
					Object.Destroy(animator);
				}
				ragdolled = true;
				inStabilize = true;
				if (!flag)
				{
					characterHips.parent = null;
				}
				Invoke("ResetDamage", 0.2f);
			}
		}

		public void OnRagdollCollisionEnter(vRagdollCollision ragdolCollision)
		{
			if (ragdolCollision.ImpactForce > 1f)
			{
				collisionSource.clip = collisionClip;
				collisionSource.volume = ragdolCollision.ImpactForce * 0.05f;
				if (!collisionSource.isPlaying)
				{
					collisionSource.Play();
				}
			}
		}

		private IEnumerator RagdollStabilizer(float delay)
		{
			inStabilize = false;
			float rdStabilize = float.PositiveInfinity;
			yield return new WaitForSeconds(delay);
			bool isDead = !(iChar.currentHealth > 0f);
			while (rdStabilize > ((!isDead) ? 0.1f : 0.0001f) && animator != null && !animator.isActiveAndEnabled)
			{
				rdStabilize = characterChest.GetComponent<Rigidbody>().velocity.magnitude;
				yield return new WaitForEndOfFrame();
			}
			if (!isDead)
			{
				ragdolled = false;
				StartCoroutine(ResetPlayer(1f));
			}
			else
			{
				Object.Destroy(iChar);
				yield return new WaitForEndOfFrame();
				DestroyComponents();
			}
		}

		private IEnumerator ResetPlayer(float waitTime)
		{
			yield return new WaitForSeconds(waitTime);
			isActive = false;
			iChar.ResetRagdoll();
		}

		private void RagdollBehaviour()
		{
			if (!(iChar.currentHealth > 0f) || !iChar.ragdolled || state != RagdollState.blendToAnim)
			{
				return;
			}
			if (Time.time <= ragdollingEndTime + mecanimToGetUpTransitionTime)
			{
				Vector3 b = ragdolledHipPosition - animator.GetBoneTransform(HumanBodyBones.Hips).position;
				Vector3 vector = base.transform.position + b;
				RaycastHit[] array = Physics.RaycastAll(new Ray(vector + Vector3.up, Vector3.down));
				RaycastHit[] array2 = array;
				for (int i = 0; i < array2.Length; i++)
				{
					RaycastHit raycastHit = array2[i];
					if (!raycastHit.transform.IsChildOf(base.transform))
					{
						float y = vector.y;
						Vector3 point = raycastHit.point;
						vector.y = Mathf.Max(y, point.y);
					}
				}
				base.transform.position = vector;
				Vector3 vector2 = ragdolledHeadPosition - ragdolledFeetPosition;
				vector2.y = 0f;
				Vector3 b2 = 0.5f * (animator.GetBoneTransform(HumanBodyBones.LeftFoot).position + animator.GetBoneTransform(HumanBodyBones.RightFoot).position);
				Vector3 vector3 = animator.GetBoneTransform(HumanBodyBones.Head).position - b2;
				vector3.y = 0f;
				base.transform.rotation *= Quaternion.FromToRotation(vector3.normalized, vector2.normalized);
			}
			float value = 1f - (Time.time - ragdollingEndTime - mecanimToGetUpTransitionTime) / ragdollToMecanimBlendTime;
			value = Mathf.Clamp01(value);
			foreach (BodyPart bodyPart in bodyParts)
			{
				if (bodyPart.transform != base.transform)
				{
					if (bodyPart.transform == animator.GetBoneTransform(HumanBodyBones.Hips))
					{
						bodyPart.transform.position = Vector3.Lerp(bodyPart.transform.position, bodyPart.storedPosition, value);
					}
					bodyPart.transform.rotation = Quaternion.Slerp(bodyPart.transform.rotation, bodyPart.storedRotation, value);
				}
			}
			if (value == 0f)
			{
				state = RagdollState.animated;
			}
		}

		private void setKinematic(bool newValue)
		{
			Rigidbody component = characterHips.GetComponent<Rigidbody>();
			component.isKinematic = newValue;
			Component[] componentsInChildren = component.transform.GetComponentsInChildren(typeof(Rigidbody));
			Component[] array = componentsInChildren;
			foreach (Component component2 in array)
			{
				if (!ignoreTags.Contains(component2.transform.tag))
				{
					(component2 as Rigidbody).isKinematic = newValue;
				}
			}
		}

		private void setCollider(bool newValue)
		{
			if (!disableColliders)
			{
				return;
			}
			Collider component = characterHips.GetComponent<Collider>();
			component.enabled = !newValue;
			Component[] componentsInChildren = component.transform.GetComponentsInChildren(typeof(Collider));
			Component[] array = componentsInChildren;
			foreach (Component component2 in array)
			{
				if (!ignoreTags.Contains(component2.transform.tag) && !component2.transform.Equals(base.transform))
				{
					(component2 as Collider).enabled = !newValue;
				}
			}
		}

		private void DestroyComponents()
		{
			if (removePhysicsAfterDie)
			{
				CharacterJoint[] componentsInChildren = GetComponentsInChildren<CharacterJoint>();
				if (componentsInChildren != null)
				{
					CharacterJoint[] array = componentsInChildren;
					foreach (CharacterJoint characterJoint in array)
					{
						if (!ignoreTags.Contains(characterJoint.gameObject.tag))
						{
							Object.DestroyObject(characterJoint);
						}
					}
				}
				Rigidbody[] componentsInChildren2 = GetComponentsInChildren<Rigidbody>();
				if (componentsInChildren2 != null)
				{
					Rigidbody[] array2 = componentsInChildren2;
					foreach (Rigidbody rigidbody in array2)
					{
						if (!ignoreTags.Contains(rigidbody.gameObject.tag))
						{
							Object.DestroyObject(rigidbody);
						}
					}
				}
				Collider[] componentsInChildren3 = GetComponentsInChildren<Collider>();
				if (componentsInChildren3 != null)
				{
					Collider[] array3 = componentsInChildren3;
					foreach (Collider collider in array3)
					{
						if (!ignoreTags.Contains(collider.gameObject.tag))
						{
							Object.DestroyObject(collider);
						}
					}
				}
			}
			else
			{
				Collider component = GetComponent<Collider>();
				Rigidbody component2 = GetComponent<Rigidbody>();
				Object.Destroy(component2);
				Object.Destroy(component);
			}
			MonoBehaviour[] componentsInChildren4 = GetComponentsInChildren<MonoBehaviour>();
			if (componentsInChildren4 == null)
			{
				return;
			}
			MonoBehaviour[] array4 = componentsInChildren4;
			foreach (MonoBehaviour monoBehaviour in array4)
			{
				if (!ignoreTags.Contains(monoBehaviour.gameObject.tag))
				{
					Object.DestroyObject(monoBehaviour);
				}
			}
		}
	}
}
