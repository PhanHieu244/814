using System.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace Invector.CharacterController
{
	public class vThirdPersonController : vThirdPersonAnimator
	{
		public GameObject Fly_button;

		public GameObject Fly_buttons_Up;

		public GameObject Fly_buttons_Down;

		public GameObject mobile_inputs;

		public GameObject power1;

		public GameObject power2;

		public GameObject power3;

		public GameObject power4;

		public GameObject player;

		public GameObject part1;

		public GameObject part2;

		public static vThirdPersonController instance;

		protected virtual void Awake()
		{
			StartCoroutine(UpdateRaycast());
		}

		protected virtual void Start()
		{
			part1 = GameObject.FindGameObjectWithTag("part_1");
			part2 = GameObject.FindGameObjectWithTag("part_2");
			Cursor.visible = false;
		}

		public virtual void Sprint(bool value)
		{
			if (value)
			{
				if (currentStamina > 0f && input.sqrMagnitude > 0.1f && isGrounded && !isCrouching)
				{
					isSprinting = !isSprinting;
				}
			}
			else if (currentStamina <= 0f || input.sqrMagnitude < 0.1f || base.actions || (isStrafing && !strafeWalkByDefault && ((double)direction >= 0.5 || (double)direction <= -0.5 || speed <= 0f)))
			{
				isSprinting = false;
			}
		}

		public virtual void Crouch()
		{
			if (isGrounded && !base.actions)
			{
				if (isCrouching && CanExitCrouch())
				{
					isCrouching = false;
				}
				else
				{
					isCrouching = true;
				}
			}
		}

		public virtual void Strafe()
		{
			isStrafing = !isStrafing;
		}

		public virtual void Jump()
		{
			if (animator.IsInTransition(0))
			{
				return;
			}
			bool flag = currentStamina > jumpStamina;
			if (!isCrouching && isGrounded && !base.actions && flag && !isJumping)
			{
				jumpCounter = jumpTimer;
				isJumping = true;
				if (input.sqrMagnitude < 0.1f)
				{
					animator.CrossFadeInFixedTime("Jump", 0.1f);
				}
				else
				{
					animator.CrossFadeInFixedTime("JumpMove", 0.2f);
				}
				ReduceStamina(jumpStamina, accumulative: false);
				currentStaminaRecoveryDelay = 1f;
			}
		}

		public virtual void Fly()
		{
			if (isFlying)
			{
				isFlying = false;
				animator.SetBool("IsFlying", isFlying);
				_rigidbody.useGravity = true;
			}
			else if (!animator.IsInTransition(0))
			{
				bool flag = currentStamina > flyStaminaMove;
				if (!isCrouching && !base.actions && !isGrounded && flag)
				{
					isFlying = true;
					isJumping = false;
					animator.SetBool("IsFlying", isFlying);
				}
			}
		}

		public virtual void Roll()
		{
			if (!animator.IsInTransition(0))
			{
				bool flag = currentStamina > rollStamina;
				bool flag2 = !base.actions || (base.actions && quickStop);
				if ((input != Vector2.zero || speed > 0.25f) && flag2 && isGrounded && flag && !isJumping && !isRolling)
				{
					animator.SetTrigger("ResetState");
					animator.CrossFadeInFixedTime("Roll", 0.1f);
					ReduceStamina(rollStamina, accumulative: false);
					currentStaminaRecoveryDelay = 2f;
				}
			}
		}

		public virtual void RotateWithAnotherTransform(Transform referenceTransform)
		{
			Vector3 eulerAngles = base.transform.eulerAngles;
			float x = eulerAngles.x;
			Vector3 eulerAngles2 = referenceTransform.eulerAngles;
			float y = eulerAngles2.y;
			Vector3 eulerAngles3 = base.transform.eulerAngles;
			Vector3 euler = new Vector3(x, y, eulerAngles3.z);
			base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(euler), strafeRotationSpeed * Time.fixedDeltaTime);
			targetRotation = base.transform.rotation;
		}

		public virtual void CheckTriggers(Collider other)
		{
			try
			{
				CheckForTriggerAction(other);
				CheckForLadderAction(other);
				CheckForAutoCrouch(other);
			}
			catch (UnityException ex)
			{
				Debug.LogWarning(ex.Message);
			}
		}

		public virtual void CheckTriggerExit(Collider other)
		{
			TriggerActionExit(other);
			AutoCrouchExit(other);
		}

		public virtual void TriggerAction(vTriggerAction triggerAction)
		{
			if (!triggerAction.CanUse())
			{
				triggerAction = null;
				return;
			}
			triggerAction.DoAction(this);
			matchTarget = triggerAction.target;
			if (triggerAction.useTriggerRotation)
			{
				Quaternion rotation = triggerAction.transform.rotation;
				base.transform.rotation = rotation;
			}
			if (!string.IsNullOrEmpty(triggerAction.playAnimation))
			{
				animator.CrossFadeInFixedTime(triggerAction.playAnimation, 0.1f);
			}
		}

		public void FixedUpdate()
		{
			if (isGrounded)
			{
				Fly_buttons_Up.GetComponent<Image>().enabled = false;
				Fly_buttons_Down.GetComponent<Image>().enabled = false;
				Fly_button.GetComponent<Image>().enabled = false;
				if (!vGameController.Mission)
				{
					mobile_inputs.SetActive(value: true);
				}
				power1.GetComponent<Button>().interactable = true;
				power2.GetComponent<Button>().interactable = true;
				power3.SetActive(value: true);
				power4.GetComponent<Button>().interactable = true;
				part1.SetActive(value: false);
				part2.SetActive(value: false);
			}
			else if (!isGrounded)
			{
				power1.GetComponent<Button>().interactable = false;
				power2.GetComponent<Button>().interactable = false;
				power3.SetActive(value: false);
				power4.GetComponent<Button>().interactable = false;
				mobile_inputs.SetActive(value: false);
				Fly_button.GetComponent<Image>().enabled = true;
				part1.SetActive(value: true);
				part2.SetActive(value: true);
				if (isFlying)
				{
					Fly_buttons_Up.GetComponent<Image>().enabled = true;
					Fly_buttons_Down.GetComponent<Image>().enabled = true;
				}
			}
		}

		public void LateUpdate()
		{
			if (player == null)
			{
				player = GameObject.FindGameObjectWithTag("Player");
			}
		}

		protected IEnumerator UpdateRaycast()
		{
			while (true)
			{
				yield return new WaitForEndOfFrame();
				AutoCrouch();
				StopMove();
			}
		}

		protected virtual void TriggerActionExit(Collider other)
		{
			if (other.CompareTag("Action"))
			{
				triggerAction = null;
				ladderAction = null;
			}
		}

		protected virtual void CheckForTriggerAction(Collider other)
		{
			if (!other.gameObject.CompareTag("Action") || triggerAction != null)
			{
				return;
			}
			vTriggerAction component = other.GetComponent<vTriggerAction>();
			if (component == null)
			{
				triggerAction = null;
				return;
			}
			float num = Vector3.Distance(base.transform.forward, component.transform.forward);
			if (!component.activeFromForward || num <= 0.8f)
			{
				triggerAction = component;
				AutoTriggerAction(triggerAction);
			}
			else
			{
				triggerAction = null;
			}
		}

		protected virtual void AutoTriggerAction(vTriggerAction triggerAction)
		{
			if (!animator.IsInTransition(0) && !base.actions && triggerAction.autoAction && !base.actions)
			{
				TriggerAction(triggerAction);
			}
		}

		public virtual void CheckForLadderAction(Collider other)
		{
			if (other.gameObject.CompareTag("Action") && (bool)other.GetComponent<vTriggerLadderAction>())
			{
				vTriggerLadderAction component = other.GetComponent<vTriggerLadderAction>();
				float num = Vector3.Distance(base.transform.forward, component.transform.forward);
				if (isUsingLadder && component != null)
				{
					ladderAction = component;
				}
				else if (num <= 0.8f && !isUsingLadder)
				{
					ladderAction = component;
					AutoEnterLadder(ladderAction);
				}
				else
				{
					ladderAction = null;
				}
			}
		}

		public virtual void AutoEnterLadder(vTriggerLadderAction ladderAction)
		{
			if (!isUsingLadder && !animator.IsInTransition(0))
			{
				float num = Vector3.Distance(targetDirection, ladderAction.transform.forward);
				if (ladderAction.autoAction && num <= 0.8f && input != Vector2.zero && !base.actions)
				{
					TriggerEnterLadder(ladderAction);
				}
			}
		}

		public virtual void TriggerEnterLadder(vTriggerLadderAction ladderAction)
		{
			matchTarget = ladderAction.enterTarget;
			Quaternion rotation = ladderAction.transform.rotation;
			base.transform.rotation = rotation;
			animator.CrossFadeInFixedTime(ladderAction.enterAnimation, 0.1f);
		}

		public virtual void ExitLadder(int value, bool immediateExit = false)
		{
			if (immediateExit)
			{
				isUsingLadder = false;
				EnableGravityAndCollision(0f);
				animator.SetInteger("ActionState", 0);
			}
			else
			{
				exitingLadder = true;
				animator.SetInteger("ActionState", value);
			}
		}

		protected virtual void AutoCrouch()
		{
			if (autoCrouch)
			{
				isCrouching = true;
			}
			if (autoCrouch && !inCrouchArea && CanExitCrouch())
			{
				autoCrouch = false;
				isCrouching = false;
			}
		}

		protected virtual bool CanExitCrouch()
		{
			float radius = _capsuleCollider.radius * 0.9f;
			Vector3 origin = base.transform.position + Vector3.up * (colliderHeight * 0.5f - colliderRadius);
			Ray ray = new Ray(origin, Vector3.up);
			if (Physics.SphereCast(ray, radius, out groundHit, headDetect - colliderRadius * 0.1f, autoCrouchLayer))
			{
				return false;
			}
			return true;
		}

		protected virtual void AutoCrouchExit(Collider other)
		{
			if (other.CompareTag("AutoCrouch"))
			{
				inCrouchArea = false;
			}
		}

		protected virtual void CheckForAutoCrouch(Collider other)
		{
			if (other.gameObject.CompareTag("AutoCrouch"))
			{
				autoCrouch = true;
				inCrouchArea = true;
			}
		}
	}
}
