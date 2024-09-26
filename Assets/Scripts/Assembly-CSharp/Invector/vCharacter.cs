using Invector.EventSystems;
using System;
using UnityEngine;

namespace Invector
{
	[Serializable]
	public abstract class vCharacter : MonoBehaviour, vIDamageReceiver
	{
		public enum DeathBy
		{
			Animation,
			AnimationWithRagdoll,
			Ragdoll
		}

		[Header("--- Health & Stamina ---")]
		public float maxHealth = 100f;

		public float healthRecovery;

		public float maxStamina = 200f;

		public float staminaRecovery = 1.2f;

		[HideInInspector]
		public float currentStaminaRecoveryDelay;

		[HideInInspector]
		public float healthRecoveryDelay;

		[HideInInspector]
		public float currentHealthRecoveryDelay;

		[HideInInspector]
		public float currentStamina;

		[HideInInspector]
		public float currentHealth;

		protected bool recoveringStamina;

		protected bool canRecovery;

		[HideInInspector]
		public bool isDead;

		public DeathBy deathBy;

		[HideInInspector]
		public Animator animator;

		[HideInInspector]
		public OnReceiveDamage onReceiveDamage = new OnReceiveDamage();

		[HideInInspector]
		public OnDead onDead = new OnDead();

		[HideInInspector]
		public OnActiveRagdoll onActiveRagdoll = new OnActiveRagdoll();

		[HideInInspector]
		public bool ragdolled
		{
			get;
			set;
		}

		public Transform GetTransform => base.transform;

		private void Update()
		{
			if (Increase_Health.increasehealth)
			{
				currentHealth += 22f;
				Increase_Health.increasehealth = false;
			}
		}

		public virtual void ChangeHealth(int value)
		{
			currentHealth += value;
			currentHealth = Mathf.Clamp(currentHealth, 0f, maxHealth);
		}

		public virtual void ChangeMaxHealth(int value)
		{
			maxHealth += value;
			if (maxHealth < 0f)
			{
				maxHealth = 0f;
			}
		}

		public virtual void ChangeStamina(int value)
		{
			currentStamina += value;
			currentStamina = Mathf.Clamp(currentStamina, 0f, maxStamina);
		}

		public virtual void ChangeMaxStamina(int value)
		{
			maxStamina += value;
			if (maxStamina < 0f)
			{
				maxStamina = 0f;
			}
		}

		public virtual void ResetRagdoll()
		{
		}

		public virtual void EnableRagdoll()
		{
		}

		public virtual void TakeDamage(Damage damage, bool hitReaction = true)
		{
			if (damage != null)
			{
				currentHealth -= damage.value;
				if (damage.activeRagdoll)
				{
					EnableRagdoll();
				}
			}
		}
	}
}
