using Invector.CharacterController;
using Invector.EventSystems;
using UnityEngine;

public class vCollisionMessage : MonoBehaviour, vIDamageReceiver
{
	[HideInInspector]
	public vRagdoll ragdoll;

	private bool inAddDamage;

	private void Start()
	{
		ragdoll = GetComponentInParent<vRagdoll>();
	}

	private void OnCollisionEnter(Collision collision)
	{
		if (collision == null || !ragdoll)
		{
			return;
		}
		ragdoll.OnRagdollCollisionEnter(new vRagdollCollision(base.gameObject, collision));
		if (!inAddDamage)
		{
			Vector3 relativeVelocity = collision.relativeVelocity;
			float x = relativeVelocity.x;
			Vector3 relativeVelocity2 = collision.relativeVelocity;
			float num = x + relativeVelocity2.y;
			Vector3 relativeVelocity3 = collision.relativeVelocity;
			float num2 = num + relativeVelocity3.z;
			if (num2 > 10f || num2 < -10f)
			{
				inAddDamage = true;
				Damage damage = new Damage((int)Mathf.Abs(num2) - 10);
				damage.ignoreDefense = true;
				damage.sender = collision.transform;
				damage.hitPosition = collision.contacts[0].point;
				ragdoll.ApplyDamage(damage);
				Invoke("ResetAddDamage", 0.1f);
			}
		}
	}

	private void ResetAddDamage()
	{
		inAddDamage = false;
	}

	public void TakeDamage(Damage damage, bool hitReaction = true)
	{
		if ((bool)ragdoll && !ragdoll.iChar.isDead)
		{
			inAddDamage = true;
			ragdoll.ApplyDamage(damage);
			Invoke("ResetAddDamage", 0.1f);
		}
	}
}
