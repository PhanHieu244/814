using UnityEngine;

namespace Invector.CharacterController
{
	public abstract class vThirdPersonAnimator : vThirdPersonMotor
	{
		[HideInInspector]
		public Transform matchTarget;

		[HideInInspector]
		public float lookAtWeight;

		[HideInInspector]
		public bool exitingLadder;

		private float randomIdleCount;

		private float randomIdle;

		private Vector3 lookPosition;

		private float _speed;

		private float _direction;

		private bool triggerDieBehaviour;

		private int baseLayer => animator.GetLayerIndex("Base Layer");

		private int underBodyLayer => animator.GetLayerIndex("UnderBody");

		private int rightArmLayer => animator.GetLayerIndex("RightArm");

		private int leftArmLayer => animator.GetLayerIndex("LeftArm");

		private int upperBodyLayer => animator.GetLayerIndex("UpperBody");

		private int fullbodyLayer => animator.GetLayerIndex("FullBody");

		public virtual void UpdateAnimator()
		{
			if (!(animator == null) && animator.enabled)
			{
				LayerControl();
				ActionsControl();
				RandomIdle();
				JumpOverAnimation();
				ClimbUpAnimation();
				StepUpAnimation();
				RollAnimation();
				LadderAnimation();
				TriggerLandHighAnimation();
				LocomotionAnimation();
				DeadAnimation();
			}
		}

		private void LayerControl()
		{
			baseLayerInfo = animator.GetCurrentAnimatorStateInfo(baseLayer);
			underBodyInfo = animator.GetCurrentAnimatorStateInfo(underBodyLayer);
			rightArmInfo = animator.GetCurrentAnimatorStateInfo(rightArmLayer);
			leftArmInfo = animator.GetCurrentAnimatorStateInfo(leftArmLayer);
			upperBodyInfo = animator.GetCurrentAnimatorStateInfo(upperBodyLayer);
			fullBodyInfo = animator.GetCurrentAnimatorStateInfo(fullbodyLayer);
		}

		private void ActionsControl()
		{
			stepUp = baseLayerInfo.IsName("StepUp");
			jumpOver = baseLayerInfo.IsName("JumpOver");
			climbUp = baseLayerInfo.IsName("ClimbUp");
			landHigh = baseLayerInfo.IsName("LandHigh");
			quickStop = baseLayerInfo.IsName("QuickStop");
			isRolling = baseLayerInfo.IsName("Roll");
			inTurn = baseLayerInfo.IsName("TurnOnSpot");
			isUsingLadder = (baseLayerInfo.IsName("EnterLadderBottom") || baseLayerInfo.IsName("ExitLadderBottom") || baseLayerInfo.IsName("ExitLadderTop") || baseLayerInfo.IsName("EnterLadderTop") || baseLayerInfo.IsName("ClimbLadder"));
			lockMovement = IsAnimatorTag("LockMovement");
			doingCustomAction = IsAnimatorTag("CustomAction");
		}

		private void RandomIdle()
		{
			if (input != Vector2.zero || base.actions || !(randomIdleTime > 0f))
			{
				return;
			}
			if (input.sqrMagnitude == 0f && !isCrouching && _capsuleCollider.enabled && isGrounded)
			{
				randomIdleCount += Time.fixedDeltaTime;
				if (randomIdleCount > 6f)
				{
					randomIdleCount = 0f;
					animator.SetTrigger("IdleRandomTrigger");
					animator.SetInteger("IdleRandom", Random.Range(1, 4));
				}
			}
			else
			{
				randomIdleCount = 0f;
				animator.SetInteger("IdleRandom", 0);
			}
		}

		private void LocomotionAnimation()
		{
			animator.SetBool("IsStrafing", isStrafing);
			animator.SetBool("IsCrouching", isCrouching);
			animator.SetBool("IsGrounded", isGrounded);
			animator.SetFloat("GroundDistance", groundDistance);
			if (!isGrounded)
			{
				animator.SetFloat("VerticalVelocity", verticalVelocity);
			}
			if (isStrafing)
			{
				animator.SetFloat("InputHorizontal", (stopMove || lockMovement) ? 0f : direction, 0.25f, Time.deltaTime);
			}
			animator.SetFloat("InputVertical", (stopMove || lockMovement) ? 0f : speed, 0.25f, Time.deltaTime);
			if (turnOnSpotAnim)
			{
				GetTurnOnSpotDirection(base.transform, Camera.main.transform, ref _speed, ref _direction, input);
				FreeTurnOnSpot(_direction * 180f);
			}
		}

		public void OnAnimatorMove()
		{
			if (!isGrounded)
			{
				return;
			}
			base.transform.rotation = animator.rootRotation;
			Vector2 vector = new Vector2(direction, speed);
			float num = ((!isSprinting) ? 1f : 1.5f) * Mathf.Clamp(vector.magnitude, 0f, 1f);
			if (isStrafing)
			{
				if (num <= 0.5f)
				{
					ControlSpeed(strafeWalkSpeed);
				}
				else if (num > 0.5f && num <= 1f)
				{
					ControlSpeed(strafeRunningSpeed);
				}
				else
				{
					ControlSpeed(strafeSprintSpeed);
				}
				if (isCrouching)
				{
					ControlSpeed(strafeCrouchSpeed);
				}
			}
			else if (!isStrafing)
			{
				if (speed <= 0.5f)
				{
					ControlSpeed(freeWalkSpeed);
				}
				else if ((double)speed > 0.5 && speed <= 1f)
				{
					ControlSpeed(freeRunningSpeed);
				}
				else
				{
					ControlSpeed(freeSprintSpeed);
				}
				if (isCrouching)
				{
					ControlSpeed(freeCrouchSpeed);
				}
			}
		}

		public void FreeTurnOnSpot(float direction)
		{
			bool flag = animator.IsInTransition(0);
			float dampTime = (inTurn || flag) ? 1000000 : 0;
			animator.SetFloat("TurnOnSpotDirection", direction, dampTime, Time.deltaTime);
		}

		public void GetTurnOnSpotDirection(Transform root, Transform camera, ref float _speed, ref float _direction, Vector2 input)
		{
			Vector3 forward = root.forward;
			Vector3 vector = new Vector3(input.x, 0f, input.y);
			Vector3 forward2 = camera.forward;
			forward2.y = 0f;
			Quaternion rotation = Quaternion.FromToRotation(Vector3.forward, forward2);
			Vector3 vector2 = (!rotateByWorld) ? (rotation * vector) : vector;
			_speed = Mathf.Clamp(new Vector2(input.x, input.y).magnitude, 0f, 1f);
			if (_speed > 0.01f)
			{
				Vector3 vector3 = Vector3.Cross(forward, vector2);
				_direction = Vector3.Angle(forward, vector2) / 180f * (float)((!(vector3.y < 0f)) ? 1 : (-1));
			}
			else
			{
				_direction = 0f;
			}
		}

		private void StepUpAnimation()
		{
			if (stepUp)
			{
				DisableGravityAndCollision();
				MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.LeftHand, new MatchTargetWeightMask(new Vector3(0f, 1f, 1f), 0f), 0f, 0.3f);
				EnableGravityAndCollision(0.8f);
			}
		}

		private void JumpOverAnimation()
		{
			if (jumpOver)
			{
				DisableGravityAndCollision();
				MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.LeftHand, new MatchTargetWeightMask(new Vector3(0f, 1f, 1f), 0f), 0f, 0.6f);
				EnableGravityAndCollision(0.8f);
			}
		}

		private void ClimbUpAnimation()
		{
			if (climbUp)
			{
				DisableGravityAndCollision();
				MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.LeftHand, new MatchTargetWeightMask(new Vector3(0f, 1f, 1f), 0f), 0f, 0.2f);
				EnableGravityAndCollision(0.9f);
			}
		}

		private void LadderAnimation()
		{
			if (!isUsingLadder)
			{
				exitingLadder = false;
			}
			LadderBottom();
			LadderTop();
		}

		private void LadderBottom()
		{
			if (baseLayerInfo.IsName("EnterLadderBottom"))
			{
				DisableGravityAndCollision();
				if (baseLayerInfo.normalizedTime < 0.25f && !animator.IsInTransition(0))
				{
					MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.Root, new MatchTargetWeightMask(new Vector3(1f, 0f, 0.1f), 0f), 0f, 0.25f);
				}
				else if (!animator.IsInTransition(0))
				{
					MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.Root, new MatchTargetWeightMask(new Vector3(1f, 1f, 1f), 0f), 0.25f, 0.7f);
				}
			}
			if (baseLayerInfo.IsName("ExitLadderBottom"))
			{
				Invoke("ResetActionState", 0.1f);
				EnableGravityAndCollision(0.1f);
			}
		}

		private void LadderTop()
		{
			if (baseLayerInfo.IsName("EnterLadderTop"))
			{
				DisableGravityAndCollision();
				if (baseLayerInfo.normalizedTime < 0.25f && !animator.IsInTransition(0))
				{
					MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.Root, new MatchTargetWeightMask(new Vector3(1f, 0f, 0.1f), 1f), 0f, 0.25f);
				}
				else if (!animator.IsInTransition(0))
				{
					MatchTarget(matchTarget.position, matchTarget.rotation, AvatarTarget.Root, new MatchTargetWeightMask(new Vector3(1f, 1f, 1f), 1f), 0.25f, 0.7f);
				}
			}
			if (baseLayerInfo.IsName("ExitLadderTop"))
			{
				Invoke("ResetActionState", 0.1f);
				EnableGravityAndCollision(0.8f);
			}
		}

		private void RollAnimation()
		{
			if (isRolling)
			{
				autoCrouch = true;
				if (isStrafing && (input != Vector2.zero || speed > 0.25f))
				{
					Vector3 forward = Vector3.RotateTowards(base.transform.forward, targetDirection, 25f * Time.fixedDeltaTime, 0f);
					Quaternion quaternion = Quaternion.LookRotation(forward);
					Vector3 eulerAngles = base.transform.eulerAngles;
					float x = eulerAngles.x;
					Vector3 eulerAngles2 = quaternion.eulerAngles;
					float y = eulerAngles2.y;
					Vector3 eulerAngles3 = base.transform.eulerAngles;
					Vector3 eulerAngles4 = new Vector3(x, y, eulerAngles3.z);
					base.transform.eulerAngles = eulerAngles4;
				}
				if (baseLayerInfo.normalizedTime > 0.1f && baseLayerInfo.normalizedTime < 0.3f)
				{
					_rigidbody.useGravity = false;
				}
				if (verticalVelocity >= 1f)
				{
					_rigidbody.velocity = Vector3.ProjectOnPlane(_rigidbody.velocity, groundHit.normal);
				}
				if (baseLayerInfo.normalizedTime > 0.3f)
				{
					_rigidbody.useGravity = true;
				}
			}
		}

		private void DeadAnimation()
		{
			if (!isDead)
			{
				return;
			}
			if (!triggerDieBehaviour)
			{
				triggerDieBehaviour = true;
				DeathBehaviour();
			}
			if (deathBy == DeathBy.Animation)
			{
				if (fullBodyInfo.IsName("Dead") && fullBodyInfo.normalizedTime >= 0.99f && groundDistance <= 0.15f)
				{
					RemoveComponents();
				}
			}
			else if (deathBy == DeathBy.AnimationWithRagdoll)
			{
				if (fullBodyInfo.IsName("Dead") && fullBodyInfo.normalizedTime >= 0.8f)
				{
					SendMessage("ActivateRagdoll", SendMessageOptions.DontRequireReceiver);
				}
			}
			else if (deathBy == DeathBy.Ragdoll)
			{
				SendMessage("ActivateRagdoll", SendMessageOptions.DontRequireReceiver);
			}
		}

		private void ResetActionState()
		{
			animator.SetInteger("ActionState", 0);
		}

		public void MatchTarget(Vector3 matchPosition, Quaternion matchRotation, AvatarTarget target, MatchTargetWeightMask weightMask, float normalisedStartTime, float normalisedEndTime)
		{
			if (!animator.isMatchingTarget && !animator.IsInTransition(0))
			{
				float num = Mathf.Repeat(animator.GetCurrentAnimatorStateInfo(0).normalizedTime, 1f);
				if (!(num > normalisedEndTime))
				{
					animator.MatchTarget(matchPosition, matchRotation, target, weightMask, normalisedStartTime, normalisedEndTime);
				}
			}
		}

		public void TriggerAnimationState(string animationClip, float transition)
		{
			animator.CrossFadeInFixedTime(animationClip, transition);
		}

		public bool IsAnimatorTag(string tag)
		{
			if (animator == null)
			{
				return false;
			}
			if (baseLayerInfo.IsTag(tag))
			{
				return true;
			}
			if (underBodyInfo.IsTag(tag))
			{
				return true;
			}
			if (rightArmInfo.IsTag(tag))
			{
				return true;
			}
			if (leftArmInfo.IsTag(tag))
			{
				return true;
			}
			if (upperBodyInfo.IsTag(tag))
			{
				return true;
			}
			if (fullBodyInfo.IsTag(tag))
			{
				return true;
			}
			return false;
		}

		private void TriggerLandHighAnimation()
		{
			if (!landHigh)
			{
			}
		}
	}
}
