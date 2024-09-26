using Invector;
using UnityEngine;

public class vCharacterStandalone : vCharacter
{
	[HideInInspector]
	public v_SpriteHealth healthSlider;

	private void Start()
	{
		isDead = false;
		currentHealth = maxHealth;
		currentHealthRecoveryDelay = healthRecoveryDelay;
		currentStamina = maxStamina;
		healthSlider = GetComponentInChildren<v_SpriteHealth>();
	}

	public override void TakeDamage(Damage damage, bool hitReaction)
	{
		if (!isDead)
		{
			Vector3 position = base.transform.position;
			float x = position.x;
			float y = damage.hitPosition.y;
			Vector3 position2 = base.transform.position;
			Quaternion rotation = Quaternion.LookRotation(new Vector3(x, y, position2.z) - damage.hitPosition);
			Vector3 position3 = base.transform.position;
			float x2 = position3.x;
			float y2 = damage.hitPosition.y;
			Vector3 position4 = base.transform.position;
			SendMessage("TriggerHitParticle", new HittEffectInfo(new Vector3(x2, y2, position4.z), rotation, damage.attackName), SendMessageOptions.DontRequireReceiver);
			currentHealth -= damage.value;
			currentHealthRecoveryDelay = healthRecoveryDelay;
			if (healthSlider != null)
			{
				healthSlider.Damage(damage.value);
			}
			if (damage.sender != null)
			{
				damage.sender.SendMessage("PlayHitSound", SendMessageOptions.DontRequireReceiver);
			}
			base.transform.SendMessage("GamepadVibration", 0.25f, SendMessageOptions.DontRequireReceiver);
			onReceiveDamage.Invoke(damage);
		}
	}
}
