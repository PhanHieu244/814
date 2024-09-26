using UnityEngine;
using UnityEngine.AI;

namespace Invector
{
	public class v_AIAnimator : v_AIMotor
	{
		private bool triggerDieBehaviour;

		private bool resetState;

		private float strafeInput;

		public AnimatorStateInfo baseLayerInfo;

		public AnimatorStateInfo rightArmInfo;

		public AnimatorStateInfo leftArmInfo;

		public AnimatorStateInfo fullBodyInfo;

		public AnimatorStateInfo upperBodyInfo;

		public AnimatorStateInfo underBodyInfo;

		private int baseLayer => animator.GetLayerIndex("Base Layer");

		private int underBodyLayer => animator.GetLayerIndex("UnderBody");

		private int rightArmLayer => animator.GetLayerIndex("RightArm");

		private int leftArmLayer => animator.GetLayerIndex("LeftArm");

		private int upperBodyLayer => animator.GetLayerIndex("UpperBody");

		private int fullbodyLayer => animator.GetLayerIndex("FullBody");

		protected virtual float maxSpeed => (currentState.Equals(AIStates.PatrolSubPoints) || currentState.Equals(AIStates.PatrolWaypoints)) ? patrolSpeed : ((!base.OnStrafeArea) ? chaseSpeed : strafeSpeed);

		public void UpdateAnimator(float _speed, float _direction)
		{
			if (!(animator == null) && animator.enabled)
			{
				LayerControl();
				LocomotionAnimation(_speed, _direction);
				RollAnimation();
				CrouchAnimation();
				ResetAndLockAgent();
				MoveSetIDControl();
				MeleeATK_Animation();
				DEF_Animation();
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

		private void OnAnimatorMove()
		{
			if (Time.timeScale == 0f)
			{
				return;
			}
			if (agent.enabled && !agent.isOnOffMeshLink && agent.updatePosition)
			{
				agent.velocity = animator.deltaPosition / Time.deltaTime;
			}
			if (!_rigidbody.useGravity && !base.actions && !agent.isOnOffMeshLink)
			{
				_rigidbody.velocity = animator.deltaPosition;
			}
			if (!agent.updatePosition && !base.actions)
			{
				Vector3 vector = (!agent.enabled) ? destination : agent.nextPosition;
				if (Vector3.Distance(base.transform.position, vector) > 0.5f)
				{
					desiredRotation = Quaternion.LookRotation(vector - base.transform.position);
					Vector3 eulerAngles = base.transform.eulerAngles;
					float x = eulerAngles.x;
					Vector3 eulerAngles2 = desiredRotation.eulerAngles;
					float y = eulerAngles2.y;
					Vector3 eulerAngles3 = base.transform.eulerAngles;
					Quaternion to = Quaternion.Euler(x, y, eulerAngles3.z);
					base.transform.rotation = Quaternion.RotateTowards(base.transform.rotation, to, agent.angularSpeed * Time.deltaTime);
				}
				base.transform.position = animator.rootPosition;
			}
			else if (base.OnStrafeArea && !base.actions && base.target != null && canSeeTarget && currentHealth > 0f)
			{
				Vector3 target = base.target.position - base.transform.position;
				float maxRadiansDelta = (!(meleeManager != null) || !isAttacking) ? (strafeRotationSpeed * Time.deltaTime) : (attackRotationSpeed * Time.deltaTime);
				Vector3 forward = Vector3.RotateTowards(base.transform.forward, target, maxRadiansDelta, 0f);
				Quaternion quaternion = Quaternion.LookRotation(forward);
				Transform transform = base.transform;
				Vector3 eulerAngles4 = base.transform.eulerAngles;
				float x2 = eulerAngles4.x;
				Vector3 eulerAngles5 = quaternion.eulerAngles;
				float y2 = eulerAngles5.y;
				Vector3 eulerAngles6 = base.transform.eulerAngles;
				transform.eulerAngles = new Vector3(x2, y2, eulerAngles6.z);
			}
			else if (agent.isOnOffMeshLink && !base.actions)
			{
				Vector3 vector2 = targetPos = agent.nextOffMeshLinkData.endPos;
				OffMeshLinkData currentOffMeshLinkData = agent.currentOffMeshLinkData;
				Vector3 endPos = currentOffMeshLinkData.endPos;
				float x3 = endPos.x;
				Vector3 position = base.transform.position;
				float y3 = position.y;
				Vector3 endPos2 = currentOffMeshLinkData.endPos;
				desiredRotation = Quaternion.LookRotation(new Vector3(x3, y3, endPos2.z) - base.transform.position);
				base.transform.rotation = Quaternion.RotateTowards(base.transform.rotation, desiredRotation, agent.angularSpeed * 2f * Time.deltaTime);
			}
			else if (agent.desiredVelocity.magnitude > 0.1f && !base.actions && agent.enabled && currentHealth > 0f)
			{
				if (meleeManager != null && isAttacking)
				{
					desiredRotation = Quaternion.LookRotation(agent.desiredVelocity);
					base.transform.rotation = Quaternion.RotateTowards(base.transform.rotation, desiredRotation, agent.angularSpeed * attackRotationSpeed * Time.deltaTime);
				}
				else
				{
					desiredRotation = Quaternion.LookRotation(agent.desiredVelocity);
					base.transform.rotation = Quaternion.RotateTowards(base.transform.rotation, desiredRotation, agent.angularSpeed * Time.deltaTime);
				}
			}
			else if (base.actions || currentHealth <= 0f || isAttacking)
			{
				if (isRolling)
				{
					desiredRotation = Quaternion.LookRotation(rollDirection, Vector3.up);
					base.transform.rotation = desiredRotation;
				}
				else
				{
					base.transform.rotation = animator.rootRotation;
				}
				if (!agent.enabled)
				{
					destination = base.transform.position;
					base.transform.position = animator.rootPosition;
				}
			}
		}

		private void LocomotionAnimation(float _speed, float _direction)
		{
			isGrounded = (agent.enabled ? agent.isOnNavMesh : (isRolling || groundDistance <= groundCheckDistance));
			animator.SetBool("IsGrounded", isGrounded);
			_speed = Mathf.Clamp(_speed, 0f - maxSpeed, maxSpeed);
			if (base.OnStrafeArea)
			{
				_direction = Mathf.Clamp(_direction, 0f - strafeSpeed, strafeSpeed);
			}
			strafeInput = Mathf.Clamp(new Vector2(_speed, _direction).magnitude, 0f, 1.5f);
			animator.SetFloat("InputMagnitude", strafeInput, 0.2f, Time.deltaTime);
			animator.SetFloat("InputVertical", base.actions ? 0f : ((_speed == 0f) ? 0f : _speed), 0.2f, Time.fixedDeltaTime);
			animator.SetFloat("InputHorizontal", _direction, 0.2f, Time.fixedDeltaTime);
			animator.SetBool("IsStrafing", base.OnStrafeArea);
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
					RemoveComponents();
				}
			}
			else if (deathBy == DeathBy.Ragdoll)
			{
				SendMessage("ActivateRagdoll", SendMessageOptions.DontRequireReceiver);
				RemoveComponents();
			}
		}

		private void DeathBehaviour()
		{
			animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
			if (deathBy == DeathBy.Animation || deathBy == DeathBy.AnimationWithRagdoll)
			{
				animator.SetBool("isDead", isDead);
			}
		}

		private void CrouchAnimation()
		{
			animator.SetBool("IsCrouching", isCrouched);
			if (animator != null && animator.enabled)
			{
				CheckAutoCrouch();
			}
		}

		protected void RollAnimation()
		{
			if (!(animator == null) && animator.enabled)
			{
				isRolling = baseLayerInfo.IsName("Roll");
				if (isRolling)
				{
					_rigidbody.constraints = RigidbodyConstraints.FreezeRotation;
					_rigidbody.useGravity = true;
					agent.enabled = false;
					agent.updatePosition = false;
				}
			}
		}

		private void ResetAIRotation()
		{
			Transform transform = base.transform;
			Vector3 eulerAngles = base.transform.eulerAngles;
			transform.eulerAngles = new Vector3(0f, eulerAngles.y, 0f);
		}

		private void MoveSetIDControl()
		{
			if (!(meleeManager == null))
			{
				animator.SetFloat("MoveSet_ID", meleeManager.GetMoveSetID());
			}
		}

		private void MeleeATK_Animation()
		{
			if (!(meleeManager == null))
			{
				if (base.actions)
				{
					attackCount = 0;
				}
				animator.SetInteger("AttackID", meleeManager.GetAttackID());
			}
		}

		private void DEF_Animation()
		{
			if (!(meleeManager == null))
			{
				if (isBlocking)
				{
					animator.SetInteger("DefenseID", meleeManager.GetDefenseID());
				}
				animator.SetBool("IsBlocking", isBlocking);
			}
		}

		public void MeleeAttack()
		{
			if (animator != null && animator.enabled && !base.actions)
			{
				animator.SetTrigger("WeakAttack");
			}
		}

		private void ResetAndLockAgent()
		{
			lockMovement = (fullBodyInfo.IsTag("LockMovement") || upperBodyInfo.IsTag("ResetState"));
			if (lockMovement)
			{
				if (attackCount > 0)
				{
					canAttack = false;
					attackCount = 0;
				}
				if (baseLayerInfo.normalizedTime > 0.1f)
				{
					animator.ResetTrigger("ResetState");
					_rigidbody.constraints = RigidbodyConstraints.FreezeRotation;
					_rigidbody.useGravity = true;
					agent.enabled = false;
					agent.updatePosition = false;
				}
			}
		}

		public void TriggerRecoil(int recoil_id)
		{
			if (animator != null && animator.enabled && !isRolling)
			{
				animator.SetInteger("RecoilID", recoil_id);
				animator.SetTrigger("TriggerRecoil");
				animator.SetTrigger("ResetState");
			}
		}
	}
}
