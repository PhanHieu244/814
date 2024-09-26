using Invector.ItemManager;
using UnityEngine;
using UnityEngine.Events;

public class vMeleeWeapon : vMeleeAttackObject, vIEquipment
{
	[Header("Melee Weapon Settings")]
	public MeleeType meleeType = MeleeType.OnlyAttack;

	[Header("Attack Settings")]
	public float distanceToAttack = 1f;

	[Tooltip("Trigger a Attack Animation")]
	public int attackID;

	[Tooltip("Change the MoveSet when using this Weapon")]
	public int movesetID;

	[Tooltip("How much stamina will be consumed when attack")]
	public float staminaCost;

	[Tooltip("How much time the stamina will wait to start recover")]
	public float staminaRecoveryDelay;

	[Header("Defense Settings")]
	[Range(0f, 100f)]
	public int defenseRate = 100;

	[Range(0f, 180f)]
	public float defenseRange = 90f;

	[Tooltip("Trigger a Defense Animation")]
	public int defenseID;

	[Tooltip("What recoil animatil will trigger")]
	public int recoilID;

	[Tooltip("Can break the oponent attack, will trigger a recoil animation")]
	public bool breakAttack;

	[HideInInspector]
	public UnityEvent onDefense;

	public void OnEquip(vItem item)
	{
		vItemAttribute vItemAttribute = item.attributes.Find((vItemAttribute attribute) => attribute.name == Invector.ItemManager.vItemAttributes.Damage);
		vItemAttribute vItemAttribute2 = item.attributes.Find((vItemAttribute attribute) => attribute.name == Invector.ItemManager.vItemAttributes.StaminaCost);
		vItemAttribute vItemAttribute3 = item.attributes.Find((vItemAttribute attribute) => attribute.name == Invector.ItemManager.vItemAttributes.DefenseRate);
		vItemAttribute vItemAttribute4 = item.attributes.Find((vItemAttribute attribute) => attribute.name == Invector.ItemManager.vItemAttributes.DefenseRange);
		if (vItemAttribute != null)
		{
			damage.value = vItemAttribute.value;
		}
		if (vItemAttribute2 != null)
		{
			staminaCost = vItemAttribute2.value;
		}
		if (vItemAttribute3 != null)
		{
			defenseRate = vItemAttribute3.value;
		}
		if (vItemAttribute4 != null)
		{
			defenseRange = vItemAttribute3.value;
		}
	}

	public void OnUnequip(vItem item)
	{
	}

	public void OnDefense()
	{
		onDefense.Invoke();
	}
}
