using Invector.EventSystems;
using System;
using UnityEngine;

namespace Invector.CharacterController
{
	public abstract class vThirdPersonMotor : vCharacter
	{
		public enum LocomotionType
		{
			FreeWithStrafe,
			OnlyStrafe,
			OnlyFree
		}

		[Header("--- Stamina Consumption ---")]
		[SerializeField]
		protected float sprintStamina = 30f;

		[SerializeField]
		protected float jumpStamina = 30f;

		[SerializeField]
		protected float rollStamina = 25f;

		[SerializeField]
		protected float flyStaminaIdle;

		[SerializeField]
		protected float flyStaminaMove = 10f;

		[Header("---! Layers !---")]
		[Tooltip("Layers that the character can walk on")]
		public LayerMask groundLayer = 1;

		[Tooltip("Distance to became not grounded")]
		[SerializeField]
		protected float groundMinDistance = 0.2f;

		[SerializeField]
		protected float groundMaxDistance = 0.5f;

		[Tooltip("What objects can make the character auto crouch")]
		public LayerMask autoCrouchLayer = 1;

		[Tooltip("[SPHERECAST] ADJUST IN PLAY MODE - White Spherecast put just above the head, this will make the character Auto-Crouch if something hit the sphere.")]
		public float headDetect = 0.95f;

		[Tooltip("Select the layers the your character will stop moving when close to")]
		public LayerMask stopMoveLayer;

		[Tooltip("[RAYCAST] Stopmove Raycast Height")]
		public float stopMoveHeight = 0.65f;

		[Tooltip("[RAYCAST] Stopmove Raycast Distance")]
		public float stopMoveDistance = 0.5f;

		[Header("--- Locomotion Setup ---")]
		public LocomotionType locomotionType;

		[HideInInspector]
		public bool doingCustomAction;

		[Tooltip("Use this to rotate the character using the World axis, or false to use the camera axis - CHECK for Isometric Camera")]
		[SerializeField]
		public bool rotateByWorld;

		[SerializeField]
		protected bool turnOnSpotAnim;

		[Tooltip("Can control the roll direction")]
		[SerializeField]
		protected bool rollControl;

		[Tooltip("Speed of the rotation on free directional movement")]
		[SerializeField]
		public float freeRotationSpeed = 10f;

		[Tooltip("Speed of the rotation while strafe movement")]
		public float strafeRotationSpeed = 10f;

		[Tooltip("Put your Random Idle animations at the AnimatorController and select a value to randomize, 0 is disable.")]
		[SerializeField]
		protected float randomIdleTime;

		[Header("Jump Options")]
		[Tooltip("Check to control the character while jumping")]
		public bool jumpAirControl = true;

		[Tooltip("How much time the character will be jumping")]
		public float jumpTimer = 0.3f;

		[HideInInspector]
		public float jumpCounter;

		[Tooltip("Add Extra jump speed, based on your speed input the character will move forward")]
		public float jumpForward = 3f;

		[Tooltip("Add Extra jump height, if you want to jump only with Root Motion leave the value with 0.")]
		public float jumpHeight = 4f;

		[Header("Fly Options")]
		[Tooltip("Add extra fly speed, based on your speed input the character will fly forward")]
		public float flyForward = 12f;

		[Tooltip("Force applied to the rigidbody when flying up/down")]
		public float flyUpDownForce = 30f;

		[Tooltip("Transition lerp speed between up/down movement")]
		public float flyForceLerp = 3f;

		[Tooltip("(optional) Change collider size when flying. Should be fine for most characters")]
		public float flyColliderRadius = 0.5f;

		protected int flyUpDownChange;

		protected int lastFlyUpDownChange;

		protected bool flyDirectionChanged;

		[Header("--- Movement Speed ---")]
		[Tooltip("Turn off if you have 'in place' animations and use this values above to move the character, or use with root motion as extra speed")]
		public bool useRootMotion = true;

		[Tooltip("Character will walk by default and run when the sprint input is pressed. The Sprint animation will not play")]
		public bool freeWalkByDefault;

		[Tooltip("Character will walk by default and run when the sprint input is pressed. The Sprint animation will not play")]
		public bool strafeWalkByDefault = true;

		[Tooltip("Add extra speed for the locomotion movement, keep this value at 0 if you want to use only root motion speed.")]
		public float freeWalkSpeed = 1f;

		[Tooltip("Add extra speed for the locomotion movement, keep this value at 0 if you want to use only root motion speed.")]
		public float freeRunningSpeed = 1f;

		[Tooltip("Add extra speed for the locomotion movement, keep this value at 0 if you want to use only root motion speed.")]
		public float freeSprintSpeed = 1f;

		[Tooltip("Add extra speed for the locomotion movement, keep this value at 0 if you want to use only root motion speed.")]
		public float freeCrouchSpeed = 1f;

		[Tooltip("Add extra speed for the strafe movement, keep this value at 0 if you want to use only root motion speed.")]
		public float strafeWalkSpeed = 1f;

		[Tooltip("Add extra speed for the locomotion movement, keep this value at 0 if you want to use only root motion speed.")]
		public float strafeRunningSpeed = 1f;

		[Tooltip("Add extra speed for the locomotion movement, keep this value at 0 if you want to use only root motion speed.")]
		public float strafeSprintSpeed = 1f;

		[Tooltip("Add extra speed for the strafe movement, keep this value at 0 if you want to use only root motion speed.")]
		public float strafeCrouchSpeed = 1f;

		[Header("--- Grounded Setup ---")]
		[Tooltip("ADJUST IN PLAY MODE - Offset height limit for sters - GREY Raycast in front of the legs")]
		public float stepOffsetEnd = 0.45f;

		[Tooltip("ADJUST IN PLAY MODE - Offset height origin for sters, make sure to keep slight above the floor - GREY Raycast in front of the legs")]
		public float stepOffsetStart = 0.05f;

		[Tooltip("Higher value will result jittering on ramps, lower values will have difficulty on steps")]
		public float stepSmooth = 4f;

		[Tooltip("Max angle to walk")]
		[SerializeField]
		protected float slopeLimit = 45f;

		[Tooltip("Apply extra gravity when the character is not grounded")]
		[SerializeField]
		protected float extraGravity = -10f;

		[Tooltip("Turn the Ragdoll On when falling at high speed (check VerticalVelocity) - leave the value with 0 if you don't want this feature")]
		[SerializeField]
		protected float ragdollVel = -16f;

		protected float groundDistance;

		public RaycastHit groundHit;

		[Header("--- Debug Info ---")]
		public bool debugWindow;

		[HideInInspector]
		public bool isGrounded;

		[HideInInspector]
		public bool isCrouching;

		[HideInInspector]
		public bool inCrouchArea;

		[HideInInspector]
		public bool isStrafing;

		[HideInInspector]
		public bool isSprinting;

		[HideInInspector]
		public bool isSliding;

		[HideInInspector]
		public bool stopMove;

		[HideInInspector]
		public bool autoCrouch;

		[HideInInspector]
		public bool isFlying;

		[HideInInspector]
		public bool isRolling;

		[HideInInspector]
		public bool isJumping;

		[HideInInspector]
		public bool isUsingLadder;

		[HideInInspector]
		public bool isGettingUp;

		[HideInInspector]
		public bool inTurn;

		[HideInInspector]
		public bool quickStop;

		[HideInInspector]
		public bool landHigh;

		[HideInInspector]
		public bool jumpOver;

		[HideInInspector]
		public bool stepUp;

		[HideInInspector]
		public bool climbUp;

		[HideInInspector]
		public Vector3 targetDirection;

		protected Quaternion targetRotation;

		[HideInInspector]
		public float strafeInput;

		[HideInInspector]
		public Quaternion freeRotation;

		[HideInInspector]
		public bool keepDirection;

		[HideInInspector]
		public Vector2 oldInput;

		[HideInInspector]
		public vTriggerAction triggerAction;

		[HideInInspector]
		public vTriggerLadderAction ladderAction;

		[HideInInspector]
		public Rigidbody _rigidbody;

		[HideInInspector]
		public PhysicMaterial frictionPhysics;

		[HideInInspector]
		public PhysicMaterial maxFrictionPhysics;

		[HideInInspector]
		public PhysicMaterial slippyPhysics;

		[HideInInspector]
		public CapsuleCollider _capsuleCollider;

		[HideInInspector]
		public bool lockMovement;

		[HideInInspector]
		public float colliderRadius;

		[HideInInspector]
		public float colliderHeight;

		[HideInInspector]
		public Vector3 colliderCenter;

		[HideInInspector]
		public Vector2 input;

		[HideInInspector]
		public float speed;

		[HideInInspector]
		public float direction;

		[HideInInspector]
		public float verticalVelocity;

		[HideInInspector]
		public float velocity;

		[HideInInspector]
		public AnimatorStateInfo baseLayerInfo;

		[HideInInspector]
		public AnimatorStateInfo underBodyInfo;

		[HideInInspector]
		public AnimatorStateInfo rightArmInfo;

		[HideInInspector]
		public AnimatorStateInfo leftArmInfo;

		[HideInInspector]
		public AnimatorStateInfo fullBodyInfo;

		[HideInInspector]
		public AnimatorStateInfo upperBodyInfo;

		[HideInInspector]
		public bool actions => jumpOver || stepUp || climbUp || isUsingLadder || isRolling || quickStop || landHigh;

		protected bool freeLocomotionConditions
		{
			get
			{
				if (locomotionType.Equals(LocomotionType.OnlyStrafe))
				{
					isStrafing = true;
				}
				return (!isStrafing && !isUsingLadder && !landHigh && !base.ragdolled && !locomotionType.Equals(LocomotionType.OnlyStrafe)) || locomotionType.Equals(LocomotionType.OnlyFree);
			}
		}

		protected bool jumpFwdCondition
		{
			get
			{
				Vector3 vector = base.transform.position + _capsuleCollider.center + Vector3.up * (0f - _capsuleCollider.height) * 0.5f;
				Vector3 point = vector + Vector3.up * _capsuleCollider.height;
				return Physics.CapsuleCastAll(vector, point, _capsuleCollider.radius * 0.5f, base.transform.forward, 0.6f, groundLayer).Length == 0;
			}
		}

		protected void RemoveComponents()
		{
			if (_capsuleCollider != null)
			{
				UnityEngine.Object.Destroy(_capsuleCollider);
			}
			if (_rigidbody != null)
			{
				UnityEngine.Object.Destroy(_rigidbody);
			}
			if (animator != null)
			{
				UnityEngine.Object.Destroy(animator);
			}
			MonoBehaviour[] components = GetComponents<MonoBehaviour>();
			for (int i = 0; i < components.Length; i++)
			{
				UnityEngine.Object.Destroy(components[i]);
			}
		}

		public void Init()
		{
			animator = GetComponent<Animator>();
			animator.applyRootMotion = true;
			frictionPhysics = new PhysicMaterial();
			frictionPhysics.name = "frictionPhysics";
			frictionPhysics.staticFriction = 0.25f;
			frictionPhysics.dynamicFriction = 0.25f;
			frictionPhysics.frictionCombine = PhysicMaterialCombine.Multiply;
			maxFrictionPhysics = new PhysicMaterial();
			maxFrictionPhysics.name = "maxFrictionPhysics";
			maxFrictionPhysics.staticFriction = 1f;
			maxFrictionPhysics.dynamicFriction = 1f;
			maxFrictionPhysics.frictionCombine = PhysicMaterialCombine.Maximum;
			slippyPhysics = new PhysicMaterial();
			slippyPhysics.name = "slippyPhysics";
			slippyPhysics.staticFriction = 0f;
			slippyPhysics.dynamicFriction = 0f;
			slippyPhysics.frictionCombine = PhysicMaterialCombine.Minimum;
			_rigidbody = GetComponent<Rigidbody>();
			_capsuleCollider = GetComponent<CapsuleCollider>();
			colliderCenter = GetComponent<CapsuleCollider>().center;
			colliderRadius = GetComponent<CapsuleCollider>().radius;
			colliderHeight = GetComponent<CapsuleCollider>().height;
			Collider[] componentsInChildren = GetComponentsInChildren<Collider>();
			Collider component = GetComponent<Collider>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				Physics.IgnoreCollision(component, componentsInChildren[i]);
			}
			currentHealth = maxHealth;
			currentHealthRecoveryDelay = healthRecoveryDelay;
			currentStamina = maxStamina;
		}

		public virtual void UpdateMotor()
		{
			CheckHealth();
			CheckStamina();
			CheckGround();
			CheckRagdoll();
			ControlCapsuleHeight();
			ControlJumpBehaviour();
			ControlFlyBehaviour();
			ControlLocomotion();
			StaminaRecovery();
			HealthRecovery();
		}

		public override void TakeDamage(Damage damage, bool hitReaction = true)
		{
			if (currentHealth <= 0f || (!damage.ignoreDefense && isRolling))
			{
				return;
			}
			currentHealth -= damage.value;
			currentHealthRecoveryDelay = healthRecoveryDelay;
			if ((!actions || actions || isUsingLadder) && !isJumping && currentHealth > 0f)
			{
				animator.SetInteger("HitDirection", (int)base.transform.HitAngle(damage.sender.position));
				if (hitReaction)
				{
					animator.SetInteger("ReactionID", damage.reaction_id);
					animator.SetTrigger("TriggerReaction");
				}
				else
				{
					animator.SetInteger("RecoilID", damage.recoil_id);
					animator.SetTrigger("TriggerRecoil");
				}
			}
			onReceiveDamage.Invoke(damage);
			vInput.instance.GamepadVibration(0.25f);
			if (damage.activeRagdoll)
			{
				onActiveRagdoll.Invoke();
			}
		}

		public void ReduceStamina(float value, bool accumulative)
		{
			if (accumulative)
			{
				currentStamina -= value * Time.deltaTime;
			}
			else
			{
				currentStamina -= value;
			}
			if (currentStamina < 0f)
			{
				currentStamina = 0f;
			}
		}

		public void DeathBehaviour()
		{
			lockMovement = true;
			animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
			if (deathBy == DeathBy.Animation || deathBy == DeathBy.AnimationWithRagdoll)
			{
				animator.SetBool("isDead", value: true);
			}
		}

		private void CheckHealth()
		{
			if (currentHealth <= 0f && !isDead)
			{
				isDead = true;
				if (onDead != null)
				{
					onDead.Invoke(base.gameObject);
				}
			}
		}

		private void HealthRecovery()
		{
			if (currentHealth <= 0f)
			{
				return;
			}
			if (currentHealthRecoveryDelay > 0f)
			{
				currentHealthRecoveryDelay -= Time.deltaTime;
				return;
			}
			if (currentHealth > maxHealth)
			{
				currentHealth = maxHealth;
			}
			if (currentHealth < maxHealth)
			{
				currentHealth = Mathf.Lerp(currentHealth, maxHealth, healthRecovery * Time.deltaTime);
			}
		}

		private void CheckStamina()
		{
			if (isSprinting)
			{
				currentStaminaRecoveryDelay = 0.25f;
				ReduceStamina(sprintStamina, accumulative: true);
			}
			if (isFlying)
			{
				currentStaminaRecoveryDelay = 0.5f;
				float value = (!(speed > 0.1f) && flyUpDownChange == 0) ? flyStaminaIdle : flyStaminaMove;
				ReduceStamina(value, accumulative: true);
			}
		}

		private void StaminaRecovery()
		{
			if (currentStaminaRecoveryDelay > 0f)
			{
				currentStaminaRecoveryDelay -= Time.deltaTime;
				return;
			}
			if (currentStamina > maxStamina)
			{
				currentStamina = maxStamina;
			}
			if (currentStamina < maxStamina)
			{
				currentStamina += staminaRecovery;
			}
		}

		private void ControlLocomotion()
		{
			if (!lockMovement && !(currentHealth <= 0f))
			{
				if (freeLocomotionConditions)
				{
					FreeMovement();
				}
				else
				{
					StrafeMovement();
				}
			}
		}

		public virtual void StrafeMovement()
		{
			if (strafeWalkByDefault)
			{
				StrafeLimitSpeed(0.5f);
			}
			else
			{
				StrafeLimitSpeed(1f);
			}
			if (isSprinting)
			{
				strafeInput += 0.5f;
			}
			if (stopMove)
			{
				strafeInput = 0f;
			}
			animator.SetFloat("InputMagnitude", strafeInput, 0.2f, Time.deltaTime);
		}

		private void StrafeLimitSpeed(float value)
		{
			float num = Mathf.Clamp(input.y, -1f, 1f);
			float num2 = Mathf.Clamp(input.x, -1f, 1f);
			speed = num;
			direction = num2;
			strafeInput = Mathf.Clamp(new Vector2(speed, direction).magnitude, 0f, value);
		}

		private void FreeMovement()
		{
			if (animator.IsInTransition(0))
			{
				return;
			}
			speed = Mathf.Abs(input.x) + Mathf.Abs(input.y);
			if (freeWalkByDefault)
			{
				speed = Mathf.Clamp(speed, 0f, 0.5f);
			}
			else
			{
				speed = Mathf.Clamp(speed, 0f, 1f);
			}
			if (isSprinting)
			{
				speed += 0.5f;
			}
			if (stopMove)
			{
				speed = 0f;
			}
			animator.SetFloat("InputMagnitude", speed, 0.2f, Time.deltaTime);
			bool flag = !actions || quickStop || (isRolling && rollControl);
			if (!(input != Vector2.zero) || !(targetDirection.magnitude > 0.1f) || !flag)
			{
				return;
			}
			Vector3 normalized = targetDirection.normalized;
			freeRotation = Quaternion.LookRotation(normalized, base.transform.up);
			Vector3 eulerAngles = freeRotation.eulerAngles;
			float y = eulerAngles.y;
			Vector3 eulerAngles2 = base.transform.eulerAngles;
			float num = y - eulerAngles2.y;
			Vector3 eulerAngles3 = base.transform.eulerAngles;
			float y2 = eulerAngles3.y;
			if (isGrounded || (!isGrounded && jumpAirControl))
			{
				if (num < 0f || num > 0f)
				{
					Vector3 eulerAngles4 = freeRotation.eulerAngles;
					y2 = eulerAngles4.y;
				}
				Vector3 euler = new Vector3(0f, y2, 0f);
				if (animator.IsInTransition(0) || inTurn)
				{
					return;
				}
				base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(euler), freeRotationSpeed * Time.deltaTime);
			}
			if (!keepDirection)
			{
				oldInput = input;
			}
			if (Vector2.Distance(oldInput, input) > 0.9f && keepDirection)
			{
				keepDirection = false;
			}
		}

		protected void ControlSpeed(float velocity)
		{
			if (Time.deltaTime == 0f)
			{
				return;
			}
			if (useRootMotion && !actions)
			{
				this.velocity = velocity;
				Vector3 deltaPosition = animator.deltaPosition;
				float x = deltaPosition.x;
				Vector3 position = base.transform.position;
				float y = position.y;
				Vector3 deltaPosition2 = animator.deltaPosition;
				Vector3 a = new Vector3(x, y, deltaPosition2.z);
				Vector3 b = a * ((!(velocity > 0f)) ? 1f : velocity) / Time.deltaTime;
				Vector3 vector = _rigidbody.velocity;
				b.y = vector.y;
				_rigidbody.velocity = Vector3.Lerp(_rigidbody.velocity, b, 20f * Time.deltaTime);
				return;
			}
			if (actions)
			{
				this.velocity = velocity;
				Vector3 zero = Vector3.zero;
				Vector3 vector2 = _rigidbody.velocity;
				zero.y = vector2.y;
				_rigidbody.velocity = zero;
				base.transform.position = animator.rootPosition;
				return;
			}
			Vector3 vector3 = base.transform.forward * velocity * speed;
			Vector3 vector4 = _rigidbody.velocity;
			vector3.y = vector4.y;
			Vector3 vector5 = base.transform.right * velocity * direction;
			Vector3 vector6 = _rigidbody.velocity;
			vector5.x = vector6.x;
			if (isStrafing)
			{
				Vector3 b2 = base.transform.TransformDirection(new Vector3(input.x, 0f, input.y)) * ((!(velocity > 0f)) ? 1f : velocity);
				Vector3 vector7 = _rigidbody.velocity;
				b2.y = vector7.y;
				_rigidbody.velocity = Vector3.Lerp(_rigidbody.velocity, b2, 20f * Time.deltaTime);
			}
			else
			{
				_rigidbody.velocity = vector3;
				_rigidbody.AddForce(base.transform.forward * (velocity * speed) * Time.deltaTime, ForceMode.VelocityChange);
			}
		}

		protected void StopMove()
		{
			if ((double)input.sqrMagnitude < 0.1 || !isGrounded)
			{
				return;
			}
			Ray ray = new Ray(base.transform.position + new Vector3(0f, stopMoveHeight, 0f), targetDirection.normalized);
			if (Physics.Raycast(ray, out RaycastHit hitInfo, _capsuleCollider.radius + stopMoveDistance, stopMoveLayer) && !isUsingLadder)
			{
				float num = Vector3.Angle(Vector3.up, hitInfo.normal);
				if (hitInfo.distance <= stopMoveDistance && num > 85f)
				{
					stopMove = true;
				}
				else if (num >= slopeLimit + 1f && num <= 85f)
				{
					stopMove = true;
				}
			}
			else if (Physics.Raycast(ray, out hitInfo, 1f, groundLayer) && !isUsingLadder)
			{
				float num2 = Vector3.Angle(Vector3.up, hitInfo.normal);
				if (num2 >= slopeLimit + 1f && num2 <= 85f)
				{
					stopMove = true;
				}
			}
			else
			{
				stopMove = false;
			}
		}

		protected void ControlJumpBehaviour()
		{
			if (isJumping)
			{
				jumpCounter -= Time.deltaTime;
				if (jumpCounter <= 0f)
				{
					jumpCounter = 0f;
					isJumping = false;
				}
				Vector3 vector = _rigidbody.velocity;
				vector.y = jumpHeight;
				_rigidbody.velocity = vector;
			}
		}

		public void AirControl()
		{
			if (isGrounded || isFlying || !jumpFwdCondition)
			{
				return;
			}
			Vector3 vector = base.transform.forward * jumpForward * speed;
			Vector3 vector2 = _rigidbody.velocity;
			vector.y = vector2.y;
			Vector3 vector3 = base.transform.right * jumpForward * direction;
			Vector3 vector4 = _rigidbody.velocity;
			vector3.x = vector4.x;
			EnableGravityAndCollision(0f);
			if (jumpAirControl)
			{
				if (isStrafing)
				{
					Rigidbody rigidbody = _rigidbody;
					float x = vector3.x;
					float y = vector.y;
					Vector3 vector5 = _rigidbody.velocity;
					rigidbody.velocity = new Vector3(x, y, vector5.z);
					Vector3 vector6 = base.transform.forward * (jumpForward * speed) + base.transform.right * (jumpForward * direction);
					Rigidbody rigidbody2 = _rigidbody;
					float x2 = vector6.x;
					Vector3 vector7 = _rigidbody.velocity;
					rigidbody2.velocity = new Vector3(x2, vector7.y, vector6.z);
				}
				else
				{
					Vector3 vector8 = base.transform.forward * (jumpForward * speed);
					Rigidbody rigidbody3 = _rigidbody;
					float x3 = vector8.x;
					Vector3 vector9 = _rigidbody.velocity;
					rigidbody3.velocity = new Vector3(x3, vector9.y, vector8.z);
				}
			}
			else
			{
				Vector3 vector10 = base.transform.forward * jumpForward;
				Rigidbody rigidbody4 = _rigidbody;
				float x4 = vector10.x;
				Vector3 vector11 = _rigidbody.velocity;
				rigidbody4.velocity = new Vector3(x4, vector11.y, vector10.z);
			}
		}

		protected void ControlFlyBehaviour()
		{
			if (!isFlying)
			{
				return;
			}
			bool flag = false;
			if (currentStamina <= 0f)
			{
				flag = ((!(speed >= 0.1f) && flyUpDownChange == 0) ? (flyStaminaIdle > 0f) : (flyStaminaMove > 0f));
			}
			if (flag || (isGrounded && isFlying))
			{
				isFlying = false;
				animator.SetBool("IsFlying", isFlying);
				_rigidbody.useGravity = true;
				return;
			}
			_rigidbody.useGravity = false;
			if (flyUpDownChange != 0)
			{
				float d = (flyUpDownChange <= 0) ? (0f - flyUpDownForce) : flyUpDownForce;
				_rigidbody.AddForce(base.transform.up * d * Time.deltaTime, ForceMode.VelocityChange);
			}
			int num;
			if (flyUpDownChange == 0)
			{
				Vector3 vector = _rigidbody.velocity;
				num = ((vector.y != 0f) ? 1 : 0);
			}
			else
			{
				num = 0;
			}
			bool flag2 = (byte)num != 0;
			bool flag3 = lastFlyUpDownChange != flyUpDownChange;
			if (flag2 || flag3)
			{
				Vector3 vector2 = _rigidbody.velocity;
				vector2.y = Mathf.Lerp(vector2.y, 0f, flyForceLerp * Time.deltaTime);
				_rigidbody.velocity = vector2;
			}
		}

		public void ChangeFlyDirection(int _direction)
		{
			if (_direction == 0)
			{
				flyDirectionChanged = false;
				flyUpDownChange = 0;
				return;
			}
			if (lastFlyUpDownChange != _direction && !flyDirectionChanged)
			{
				flyDirectionChanged = true;
				lastFlyUpDownChange = flyUpDownChange;
			}
			flyUpDownChange = _direction;
		}

		public void FlyAirControl()
		{
			if (!isGrounded && isFlying)
			{
				Vector3 b = base.transform.forward * flyForward * speed;
				Vector3 vector = _rigidbody.velocity;
				b.y = vector.y;
				_rigidbody.velocity = Vector3.Lerp(_rigidbody.velocity, b, 4f * Time.deltaTime);
				if (isStrafing)
				{
					_rigidbody.AddForce(base.transform.forward * (flyForward * speed) * Time.deltaTime, ForceMode.VelocityChange);
					_rigidbody.AddForce(base.transform.right * (flyForward * direction) * Time.deltaTime, ForceMode.VelocityChange);
				}
				else
				{
					_rigidbody.AddForce(base.transform.forward * (flyForward * speed) * Time.deltaTime, ForceMode.VelocityChange);
				}
			}
		}

		private void CheckGround()
		{
			CheckGroundDistance();
			if (isDead)
			{
				isGrounded = true;
				return;
			}
			_capsuleCollider.material = ((!isGrounded || !(GroundAngle() <= slopeLimit + 1f)) ? slippyPhysics : frictionPhysics);
			if (isGrounded && input == Vector2.zero)
			{
				_capsuleCollider.material = maxFrictionPhysics;
			}
			else if (isGrounded && input != Vector2.zero)
			{
				_capsuleCollider.material = frictionPhysics;
			}
			else
			{
				_capsuleCollider.material = slippyPhysics;
			}
			bool flag = !jumpOver && !stepUp && !climbUp && !isUsingLadder && !isRolling;
			Vector3 vector = _rigidbody.velocity;
			float x = vector.x;
			Vector3 vector2 = _rigidbody.velocity;
			Vector3 vector3 = new Vector3(x, 0f, vector2.z);
			float value = (float)Math.Round(vector3.magnitude, 2);
			value = Mathf.Clamp(value, 0f, 1f);
			float num = groundMinDistance;
			if (value > 0.25f)
			{
				num = groundMaxDistance;
			}
			if (!flag)
			{
				return;
			}
			bool flag2 = StepOffset();
			if (groundDistance <= 0.05f)
			{
				isGrounded = true;
				Sliding();
			}
			else if (groundDistance >= num)
			{
				isGrounded = false;
				Vector3 vector4 = _rigidbody.velocity;
				verticalVelocity = vector4.y;
				if (!flag2 && !isJumping && !isFlying)
				{
					_rigidbody.AddForce(base.transform.up * extraGravity * Time.deltaTime, ForceMode.VelocityChange);
				}
			}
			else if (!flag2 && !isJumping && !isFlying)
			{
				_rigidbody.AddForce(base.transform.up * (extraGravity * 2f) * Time.deltaTime, ForceMode.VelocityChange);
			}
		}

		private void CheckGroundDistance()
		{
			if (!isDead && _capsuleCollider != null)
			{
				float radius = _capsuleCollider.radius * 0.9f;
				float num = 10f;
				Vector3 origin = base.transform.position + Vector3.up * _capsuleCollider.radius;
				Ray ray = new Ray(base.transform.position + new Vector3(0f, colliderHeight / 2f, 0f), Vector3.down);
				Ray ray2 = new Ray(origin, -Vector3.up);
				if (Physics.Raycast(ray, out groundHit, colliderHeight / 2f + 2f, groundLayer))
				{
					Vector3 position = base.transform.position;
					float y = position.y;
					Vector3 point = groundHit.point;
					num = y - point.y;
				}
				if (Physics.SphereCast(ray2, radius, out groundHit, _capsuleCollider.radius + 2f, groundLayer) && num > groundHit.distance - _capsuleCollider.radius * 0.1f)
				{
					num = groundHit.distance - _capsuleCollider.radius * 0.1f;
				}
				groundDistance = (float)Math.Round(num, 2);
			}
		}

		public virtual float GroundAngle()
		{
			return Vector3.Angle(groundHit.normal, Vector3.up);
		}

		public virtual float GroundAngleFromDirection()
		{
			Vector3 from = (!isStrafing || !(input.magnitude > 0f)) ? base.transform.forward : (base.transform.right * input.x + base.transform.forward * input.y).normalized;
			return Vector3.Angle(from, groundHit.normal) - 90f;
		}

		private void Sliding()
		{
			bool flag = StepOffset();
			float num = 0f;
			Ray ray = new Ray(base.transform.position, -base.transform.up);
			if (Physics.Raycast(ray, out RaycastHit hitInfo, 1f, groundLayer))
			{
				num = Vector3.Angle(Vector3.up, hitInfo.normal);
			}
			if (GroundAngle() > slopeLimit + 1f && GroundAngle() <= 85f && num > slopeLimit + 1f && num <= 85f && groundDistance <= 0.05f && !flag)
			{
				isSliding = true;
				isGrounded = false;
				float value = (GroundAngle() - slopeLimit) * 2f;
				value = Mathf.Clamp(value, 0f, 10f);
				Rigidbody rigidbody = _rigidbody;
				Vector3 vector = _rigidbody.velocity;
				float x = vector.x;
				float y = 0f - value;
				Vector3 vector2 = _rigidbody.velocity;
				rigidbody.velocity = new Vector3(x, y, vector2.z);
			}
			else
			{
				isSliding = false;
				isGrounded = true;
			}
		}

		private bool StepOffset()
		{
			if ((double)input.sqrMagnitude < 0.1 || !isGrounded)
			{
				return false;
			}
			RaycastHit hitInfo = default(RaycastHit);
			Vector3 a = (!isStrafing || !(input.magnitude > 0f)) ? base.transform.forward : (base.transform.right * input.x + base.transform.forward * input.y).normalized;
			Ray ray = new Ray(base.transform.position + new Vector3(0f, stepOffsetEnd, 0f) + a * (_capsuleCollider.radius + 0.05f), Vector3.down);
			if (Physics.Raycast(ray, out hitInfo, stepOffsetEnd - stepOffsetStart, groundLayer))
			{
				Vector3 point = hitInfo.point;
				float y = point.y;
				Vector3 position = base.transform.position;
				if (y >= position.y)
				{
					Vector3 point2 = hitInfo.point;
					float y2 = point2.y;
					Vector3 position2 = base.transform.position;
					if (y2 <= position2.y + stepOffsetEnd)
					{
						float num = (!isStrafing) ? speed : Mathf.Clamp(input.magnitude, 0f, 1f);
						Vector3 a2 = (!isStrafing) ? (hitInfo.point - base.transform.position).normalized : (hitInfo.point - base.transform.position);
						_rigidbody.velocity = a2 * stepSmooth * (num * ((!(velocity > 1f)) ? 1f : velocity));
						return true;
					}
				}
			}
			return false;
		}

		private void ControlCapsuleHeight()
		{
			if (isCrouching || isRolling || landHigh)
			{
				_capsuleCollider.center = colliderCenter / 1.4f;
				_capsuleCollider.height = colliderHeight / 1.4f;
			}
			else if (isUsingLadder)
			{
				_capsuleCollider.radius = colliderRadius / 1.25f;
			}
			else if (isFlying)
			{
				_capsuleCollider.radius = flyColliderRadius;
				_capsuleCollider.height = flyColliderRadius;
			}
			else
			{
				_capsuleCollider.center = colliderCenter;
				_capsuleCollider.radius = colliderRadius;
				_capsuleCollider.height = colliderHeight;
			}
		}

		protected void DisableGravityAndCollision()
		{
			animator.SetFloat("InputHorizontal", 0f);
			animator.SetFloat("InputVertical", 0f);
			animator.SetFloat("VerticalVelocity", 0f);
			_rigidbody.useGravity = false;
			_capsuleCollider.isTrigger = true;
		}

		protected void EnableGravityAndCollision(float normalizedTime)
		{
			if (baseLayerInfo.normalizedTime >= normalizedTime)
			{
				_capsuleCollider.isTrigger = false;
				_rigidbody.useGravity = true;
			}
		}

		public virtual void RotateToTarget(Transform target)
		{
			if ((bool)target)
			{
				Quaternion quaternion = Quaternion.LookRotation(target.position - base.transform.position);
				Vector3 eulerAngles = base.transform.eulerAngles;
				float x = eulerAngles.x;
				Vector3 eulerAngles2 = quaternion.eulerAngles;
				float y = eulerAngles2.y;
				Vector3 eulerAngles3 = base.transform.eulerAngles;
				Vector3 euler = new Vector3(x, y, eulerAngles3.z);
				targetRotation = Quaternion.Euler(euler);
				base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(euler), strafeRotationSpeed * Time.deltaTime);
			}
		}

		public virtual void UpdateTargetDirection(Transform referenceTransform = null)
		{
			if ((bool)referenceTransform && !rotateByWorld)
			{
				Vector3 vector = (!keepDirection) ? referenceTransform.TransformDirection(Vector3.forward) : referenceTransform.forward;
				vector.y = 0f;
				vector = ((!keepDirection) ? referenceTransform.TransformDirection(Vector3.forward) : vector);
				vector.y = 0f;
				Vector3 a = (!keepDirection) ? referenceTransform.TransformDirection(Vector3.right) : referenceTransform.right;
				targetDirection = input.x * a + input.y * vector;
			}
			else
			{
				targetDirection = ((!keepDirection) ? new Vector3(input.x, 0f, input.y) : targetDirection);
			}
		}

		private void CheckRagdoll()
		{
			if (ragdollVel != 0f && verticalVelocity <= ragdollVel && groundDistance <= 0.1f)
			{
				base.transform.SendMessage("ActivateRagdoll", SendMessageOptions.DontRequireReceiver);
			}
		}

		public override void ResetRagdoll()
		{
			lockMovement = false;
			verticalVelocity = 0f;
			base.ragdolled = false;
			_rigidbody.WakeUp();
			_rigidbody.useGravity = true;
			_rigidbody.isKinematic = false;
			_capsuleCollider.isTrigger = false;
		}

		public override void EnableRagdoll()
		{
			animator.SetFloat("InputHorizontal", 0f);
			animator.SetFloat("InputVertical", 0f);
			animator.SetFloat("VerticalVelocity", 0f);
			isUsingLadder = false;
			base.ragdolled = true;
			_capsuleCollider.isTrigger = true;
			_rigidbody.useGravity = false;
			_rigidbody.isKinematic = true;
			lockMovement = true;
		}

		public virtual string DebugInfo(string additionalText = "")
		{
			string result = string.Empty;
			if (debugWindow)
			{
				float smoothDeltaTime = Time.smoothDeltaTime;
				float num = 1f / smoothDeltaTime;
				result = "FPS " + num.ToString("#,##0 fps") + "\ninputVertical = " + input.y.ToString("0.0") + "\ninputHorizontal = " + input.x.ToString("0.0") + "\nverticalVelocity = " + verticalVelocity.ToString("0.00") + "\ngroundDistance = " + groundDistance.ToString("0.00") + "\ngroundAngle = " + GroundAngle().ToString("0.00") + "\nuseGravity = " + _rigidbody.useGravity.ToString() + "\ncolliderIsTrigger = " + _capsuleCollider.isTrigger.ToString() + "\n\n--- Movement Bools ---\nonGround = " + isGrounded.ToString() + "\nlockPlayer = " + lockMovement.ToString() + "\nstopMove = " + stopMove.ToString() + "\nsliding = " + isSliding.ToString() + "\nsprinting = " + isSprinting.ToString() + "\ncrouch = " + isCrouching.ToString() + "\nstrafe = " + isStrafing.ToString() + "\nquickStop = " + quickStop.ToString() + "\nlandHigh = " + landHigh.ToString() + "\n\n--- Actions Bools ---\nroll = " + isRolling.ToString() + "\nstepUp = " + stepUp.ToString() + "\njumpOver = " + jumpOver.ToString() + "\nclimbUp = " + climbUp.ToString() + "\nisJumping = " + isJumping.ToString() + "\nisUsingLadder = " + isUsingLadder.ToString() + "\nragdoll = " + base.ragdolled.ToString() + "\nactions = " + actions.ToString() + "\n" + additionalText;
			}
			return result;
		}
	}
}
