using System;
using UnityEngine;

[Serializable]
public class Damage
{
	[Tooltip("Apply damage to the Character Health")]
	public int value = 15;

	[Tooltip("How much stamina the target will lost when blocking this attack")]
	public float staminaBlockCost = 5f;

	[Tooltip("How much time the stamina of the target will wait to recovery")]
	public float staminaRecoveryDelay = 1f;

	[Tooltip("Apply damage even if the Character is blocking")]
	public bool ignoreDefense;

	[Tooltip("Activated Ragdoll when hit the Character")]
	public bool activeRagdoll;

	[HideInInspector]
	public Transform sender;

	[HideInInspector]
	public Transform receiver;

	[HideInInspector]
	public Vector3 hitPosition;

	[HideInInspector]
	public int recoil_id;

	[HideInInspector]
	public int reaction_id;

	public string attackName;

	public Damage(int value)
	{
		this.value = value;
	}

	public Damage(Damage damage)
	{
		value = damage.value;
		staminaBlockCost = damage.staminaBlockCost;
		staminaRecoveryDelay = damage.staminaRecoveryDelay;
		ignoreDefense = damage.ignoreDefense;
		activeRagdoll = damage.activeRagdoll;
		sender = damage.sender;
		receiver = damage.receiver;
		recoil_id = damage.recoil_id;
		reaction_id = damage.reaction_id;
		attackName = damage.attackName;
		hitPosition = damage.hitPosition;
	}

	public void ReduceDamage(float damageReduction)
	{
		int num = value = (int)((float)value - (float)value * damageReduction / 100f);
	}
}
public class damage : MonoBehaviour
{
	public GameObject dmg_part;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision col)
	{
		if (col.gameObject.tag == "planee")
		{
			dmg_part.SetActive(value: true);
		}
	}
}
