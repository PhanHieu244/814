using Invector.EventSystems;
using Invector.ItemManager;
using System;
using UnityEngine;
using UnityEngine.Events;

namespace Invector.CharacterController
{
	public class vMeleeCombatInput : vThirdPersonInput, vIMeleeFighter
	{
		[Serializable]
		public class OnUpdateEvent : UnityEvent<vMeleeCombatInput>
		{
		}

		protected vMeleeManager meleeManager;

		protected vItemManager itemManager;

		protected bool isAttacking;

		protected bool isBlocking;

		protected bool isLockingOn;

		[Header("MeleeCombat Inputs")]
		public GenericInput weakAttackInput = new GenericInput("Mouse0", "RB", "RB");

		public GenericInput strongAttackInput = new GenericInput("Alpha1", keyboardAxis: false, "RT", joystickAxis: true, "RT", mobileAxis: false);

		public GenericInput blockInput = new GenericInput("Mouse1", "LB", "LB");

		public bool strafeWhileLockOn = true;

		public GenericInput lockOnInput = new GenericInput("Tab", "RightStickClick", "RightStickClick");

		[HideInInspector]
		public OnUpdateEvent onUpdateInput = new OnUpdateEvent();

		[HideInInspector]
		public bool lockInputByItemManager;

		public virtual bool lockInventory => isAttacking;

		protected virtual bool MeleeAttackConditions
		{
			get
			{
				if (meleeManager == null)
				{
					meleeManager = GetComponent<vMeleeManager>();
				}
				return meleeManager != null && !cc.doingCustomAction && !cc.lockMovement && !cc.isCrouching;
			}
		}

		protected override void Start()
		{
			base.Start();
			itemManager = GetComponent<vItemManager>();
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			onUpdateInput.Invoke(this);
		}

		protected override void InputHandle()
		{
			if (!(cc == null))
			{
				if (MeleeAttackConditions && !lockInputByItemManager)
				{
					MeleeWeakAttackInput();
					MeleeStrongAttackInput();
					BlockingInput();
				}
				else
				{
					isBlocking = false;
				}
				if (!isAttacking)
				{
					base.InputHandle();
					UpdateMeleeAnimations();
				}
				LockOnInput();
			}
		}

		protected virtual void MeleeWeakAttackInput()
		{
			if (!(cc.animator == null) && weakAttackInput.GetButtonDown() && MeleeAttackStaminaConditions())
			{
				cc.animator.SetInteger("AttackID", meleeManager.GetAttackID());
				cc.animator.SetTrigger("WeakAttack");
			}
		}

		protected virtual void MeleeStrongAttackInput()
		{
			if (!(cc.animator == null) && strongAttackInput.GetButtonDown() && MeleeAttackStaminaConditions())
			{
				cc.animator.SetInteger("AttackID", meleeManager.GetAttackID());
				cc.animator.SetTrigger("StrongAttack");
			}
		}

		protected virtual void BlockingInput()
		{
			if (!(cc.animator == null))
			{
				isBlocking = (blockInput.GetButton() && cc.currentStamina > 0f);
			}
		}

		protected override void ActionInput()
		{
			if (cc.triggerAction == null)
			{
				return;
			}
			vItemCollection component = cc.triggerAction.GetComponent<vItemCollection>();
			if (actionInput.GetButtonDown() && !cc.doingCustomAction)
			{
				cc.TriggerAction(cc.triggerAction);
				if ((bool)component && (bool)itemManager)
				{
					CollectItem(component);
				}
			}
			else if (cc.triggerAction.autoAction && (bool)component && (bool)itemManager)
			{
				CollectItem(component);
			}
			if (!cc.triggerAction.CanUse())
			{
				cc.triggerAction = null;
			}
		}

		protected void LockOnInput()
		{
			if (lockOnInput.GetButtonDown() && !cc.actions)
			{
				isLockingOn = !isLockingOn;
				tpCamera.UpdateLockOn(isLockingOn);
			}
			else if (isLockingOn && tpCamera.lockTarget == null)
			{
				isLockingOn = false;
				tpCamera.UpdateLockOn(value: false);
			}
			if (!cc.locomotionType.Equals(vThirdPersonMotor.LocomotionType.OnlyStrafe))
			{
				if (strafeWhileLockOn && isLockingOn && tpCamera.lockTarget != null)
				{
					cc.isStrafing = true;
				}
				else
				{
					cc.isStrafing = false;
				}
			}
			SwitchTargetsInput();
		}

		private void SwitchTargetsInput()
		{
			if (tpCamera == null || !tpCamera.lockTarget)
			{
				return;
			}
			if (base.inputDevice == InputDevice.MouseKeyboard)
			{
				if (Input.GetKey(KeyCode.X))
				{
					tpCamera.gameObject.SendMessage("ChangeTarget", 1, SendMessageOptions.DontRequireReceiver);
				}
				else if (Input.GetKey(KeyCode.Z))
				{
					tpCamera.gameObject.SendMessage("ChangeTarget", -1, SendMessageOptions.DontRequireReceiver);
				}
			}
			else if (base.inputDevice == InputDevice.Joystick)
			{
				float axisRaw = Input.GetAxisRaw("RightAnalogHorizontal");
				if (axisRaw == 1f)
				{
					tpCamera.gameObject.SendMessage("ChangeTarget", 1, SendMessageOptions.DontRequireReceiver);
				}
				else if (axisRaw == -1f)
				{
					tpCamera.gameObject.SendMessage("ChangeTarget", -1, SendMessageOptions.DontRequireReceiver);
				}
			}
		}

		protected virtual bool MeleeAttackStaminaConditions()
		{
			float num = cc.currentStamina - meleeManager.GetAttackStaminaCost();
			return num >= 0f;
		}

		protected virtual void UpdateMeleeAnimations()
		{
			if (!(cc.animator == null) && !(meleeManager == null))
			{
				cc.animator.SetInteger("AttackID", meleeManager.GetAttackID());
				cc.animator.SetInteger("DefenseID", meleeManager.GetDefenseID());
				cc.animator.SetBool("IsBlocking", isBlocking);
				cc.animator.SetFloat("MoveSet_ID", meleeManager.GetMoveSetID(), 0.2f, Time.deltaTime);
			}
		}

		public virtual void SetRecoil(int id)
		{
			if (!(cc.animator == null))
			{
				cc.animator.SetTrigger("TriggerRecoil");
				cc.animator.SetInteger("RecoilID", id);
				cc.animator.ResetTrigger("WeakAttack");
				cc.animator.ResetTrigger("StrongAttack");
			}
		}

		protected override void OnTriggerStay(Collider other)
		{
			base.OnTriggerStay(other);
		}

		protected override void OnTriggerExit(Collider other)
		{
			base.OnTriggerExit(other);
		}

		protected virtual void CollectItem(vItemCollection collection)
		{
			foreach (ItemReference item in collection.items)
			{
				itemManager.AddItem(item);
			}
			collection.OnCollectItems(base.gameObject);
		}

		public void OnEnableAttack()
		{
			cc.currentStaminaRecoveryDelay = meleeManager.GetAttackStaminaRecoveryDelay();
			cc.currentStamina -= meleeManager.GetAttackStaminaCost();
			isAttacking = true;
		}

		public void OnDisableAttack()
		{
			isAttacking = false;
		}

		public void ResetAttackTriggers()
		{
			cc.animator.ResetTrigger("WeakAttack");
			cc.animator.ResetTrigger("StrongAttack");
		}

		public void BreakAttack(int breakAtkID)
		{
			ResetAttackTriggers();
			OnRecoil(breakAtkID);
		}

		public void OnRecoil(int recoilID)
		{
			cc.animator.SetInteger("RecoilID", recoilID);
			cc.animator.SetTrigger("TriggerRecoil");
		}

		public void OnReceiveAttack(Damage damage, vIMeleeFighter attacker)
		{
			if (!damage.ignoreDefense && isBlocking && meleeManager != null && meleeManager.CanBlockAttack(attacker.Character().transform.position))
			{
				int defenseRate = meleeManager.GetDefenseRate();
				if (defenseRate > 0)
				{
					damage.ReduceDamage(defenseRate);
				}
				if (attacker != null && meleeManager != null && meleeManager.CanBreakAttack())
				{
					attacker.OnRecoil(meleeManager.GetDefenseRecoilID());
				}
				meleeManager.OnDefense();
				cc.currentStaminaRecoveryDelay = damage.staminaRecoveryDelay;
				cc.currentStamina -= damage.staminaBlockCost;
			}
			cc.TakeDamage(damage, !isBlocking);
		}

		public vCharacter Character()
		{
			return cc;
		}
	}
}
