using Invector;
using Invector.EventSystems;
using System;
using System.Collections.Generic;
using UnityEngine;

public class vMeleeManager : MonoBehaviour
{
	public List<BodyMember> Members = new List<BodyMember>();

	public Damage defaultDamage = new Damage(10);

	public HitProperties hitProperties;

	public vMeleeWeapon leftWeapon;

	public vMeleeWeapon rightWeapon;

	public OnHitEvent onDamageHit;

	public OnHitEvent onRecoilHit;

	[Tooltip("NPC ONLY- Ideal distance for the attack")]
	public float defaultAttackDistance = 1f;

	[Tooltip("Default cost for stamina when attack")]
	public float defaultStaminaCost = 20f;

	[Tooltip("Default recovery delay for stamina when attack")]
	public float defaultStaminaRecoveryDelay = 1f;

	[Range(0f, 100f)]
	public int defaultDefenseRate = 50;

	[Range(0f, 180f)]
	public float defaultDefenseRange = 90f;

	[HideInInspector]
	public vIMeleeFighter fighter;

	private int damageMultiplier;

	private int currentRecoilID;

	private int currentReactionID;

	private bool ignoreDefense;

	private bool activeRagdoll;

	private bool inRecoil;

	private string attackName;

	protected virtual void Start()
	{
		Init();
	}

	protected virtual void Init()
	{
		fighter = base.gameObject.GetMeleeFighter();
		foreach (BodyMember member in Members)
		{
			member.attackObject.damage.value = defaultDamage.value;
			if (member.bodyPart == HumanBodyBones.LeftLowerArm.ToString())
			{
				vMeleeWeapon vMeleeWeapon = leftWeapon = member.attackObject.GetComponentInChildren<vMeleeWeapon>();
			}
			if (member.bodyPart == HumanBodyBones.RightLowerArm.ToString())
			{
				vMeleeWeapon vMeleeWeapon2 = rightWeapon = member.attackObject.GetComponentInChildren<vMeleeWeapon>();
			}
			member.attackObject.meleeManager = this;
			member.SetActiveDamage(active: false);
		}
		if (leftWeapon != null)
		{
			leftWeapon.SetActiveDamage(value: false);
			leftWeapon.meleeManager = this;
		}
		if (rightWeapon != null)
		{
			rightWeapon.meleeManager = this;
			rightWeapon.SetActiveDamage(value: false);
		}
	}

	public virtual void SetActiveAttack(List<string> bodyParts, AttackType type, bool active = true, int damageMultiplier = 0, int recoilID = 0, int reactionID = 0, bool ignoreDefense = false, bool activeRagdoll = false, string attackName = "")
	{
		for (int i = 0; i < bodyParts.Count; i++)
		{
			string bodyPart = bodyParts[i];
			SetActiveAttack(bodyPart, type, active, damageMultiplier, recoilID, reactionID, ignoreDefense, activeRagdoll, attackName);
		}
	}

	public virtual void SetActiveAttack(string bodyPart, AttackType type, bool active = true, int damageMultiplier = 0, int recoilID = 0, int reactionID = 0, bool ignoreDefense = false, bool activeRagdoll = false, string attackName = "")
	{
		this.damageMultiplier = damageMultiplier;
		currentRecoilID = recoilID;
		currentReactionID = reactionID;
		this.ignoreDefense = ignoreDefense;
		this.activeRagdoll = activeRagdoll;
		this.attackName = attackName;
		if (type == AttackType.Unarmed)
		{
			Members.Find((BodyMember member) => member.bodyPart == bodyPart)?.SetActiveDamage(active);
		}
		else if (bodyPart == "RightLowerArm" && rightWeapon != null)
		{
			rightWeapon.meleeManager = this;
			rightWeapon.SetActiveDamage(active);
		}
		else if (bodyPart == "LeftLowerArm" && leftWeapon != null)
		{
			leftWeapon.meleeManager = this;
			leftWeapon.SetActiveDamage(active);
		}
	}

	public virtual void OnDamageHit(HitInfo hitInfo)
	{
		Damage damage = new Damage(hitInfo.attackObject.damage);
		damage.sender = base.transform;
		damage.reaction_id = currentReactionID;
		damage.recoil_id = currentRecoilID;
		if (activeRagdoll)
		{
			damage.activeRagdoll = activeRagdoll;
		}
		if (attackName != string.Empty)
		{
			damage.attackName = attackName;
		}
		if (ignoreDefense)
		{
			damage.ignoreDefense = ignoreDefense;
		}
		damage.value *= ((damageMultiplier <= 1) ? 1 : damageMultiplier);
		hitInfo.attackObject.ApplyDamage(hitInfo.hitBox, hitInfo.targetCollider, damage);
		onDamageHit.Invoke(hitInfo);
	}

	public virtual void OnRecoilHit(HitInfo hitInfo)
	{
		if (hitProperties.useRecoil && InRecoilRange(hitInfo) && !inRecoil)
		{
			inRecoil = true;
			int recoilID = currentRecoilID;
			fighter.OnRecoil(recoilID);
			onRecoilHit.Invoke(hitInfo);
			Invoke("ResetRecoil", 1f);
		}
	}

	public virtual void OnDefense()
	{
		if (leftWeapon != null && leftWeapon.meleeType != MeleeType.OnlyAttack && leftWeapon.gameObject.activeSelf)
		{
			leftWeapon.OnDefense();
		}
		if (rightWeapon != null && rightWeapon.meleeType != MeleeType.OnlyAttack && rightWeapon.gameObject.activeSelf)
		{
			rightWeapon.OnDefense();
		}
	}

	public virtual int GetAttackID()
	{
		if (rightWeapon != null && rightWeapon.meleeType != 0 && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.attackID;
		}
		return 0;
	}

	public virtual float GetAttackStaminaCost()
	{
		if (rightWeapon != null && rightWeapon.meleeType != 0 && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.staminaCost;
		}
		return defaultStaminaCost;
	}

	public virtual float GetAttackStaminaRecoveryDelay()
	{
		if (rightWeapon != null && rightWeapon.meleeType != 0 && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.staminaRecoveryDelay;
		}
		return defaultStaminaRecoveryDelay;
	}

	public virtual float GetAttackDistance()
	{
		if (rightWeapon != null && rightWeapon.meleeType != 0 && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.distanceToAttack;
		}
		return defaultAttackDistance;
	}

	public virtual int GetDefenseID()
	{
		if (leftWeapon != null && leftWeapon.meleeType != MeleeType.OnlyAttack && leftWeapon.gameObject.activeSelf)
		{
			GetComponent<Animator>().SetBool("FlipAnimation", value: false);
			return leftWeapon.defenseID;
		}
		if (rightWeapon != null && rightWeapon.meleeType != MeleeType.OnlyAttack && rightWeapon.gameObject.activeSelf)
		{
			GetComponent<Animator>().SetBool("FlipAnimation", value: true);
			return rightWeapon.defenseID;
		}
		return 0;
	}

	public int GetDefenseRate()
	{
		if (leftWeapon != null && leftWeapon.meleeType != MeleeType.OnlyAttack && leftWeapon.gameObject.activeSelf)
		{
			return leftWeapon.defenseRate;
		}
		if (rightWeapon != null && rightWeapon.meleeType != MeleeType.OnlyAttack && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.defenseRate;
		}
		return defaultDefenseRate;
	}

	public virtual int GetMoveSetID()
	{
		if (rightWeapon != null && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.movesetID;
		}
		return 0;
	}

	public virtual bool CanBreakAttack()
	{
		if (leftWeapon != null && leftWeapon.meleeType != MeleeType.OnlyAttack && leftWeapon.gameObject.activeSelf)
		{
			return leftWeapon.breakAttack;
		}
		if (rightWeapon != null && rightWeapon.meleeType != MeleeType.OnlyAttack && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.breakAttack;
		}
		return false;
	}

	public virtual bool CanBlockAttack(Vector3 attackPoint)
	{
		if (leftWeapon != null && leftWeapon.meleeType != MeleeType.OnlyAttack && leftWeapon.gameObject.activeSelf)
		{
			return Math.Abs(base.transform.HitAngle(attackPoint)) <= leftWeapon.defenseRange;
		}
		if (rightWeapon != null && rightWeapon.meleeType != MeleeType.OnlyAttack && rightWeapon.gameObject.activeSelf)
		{
			return Math.Abs(base.transform.HitAngle(attackPoint)) <= rightWeapon.defenseRange;
		}
		return Math.Abs(base.transform.HitAngle(attackPoint)) <= defaultDefenseRange;
	}

	public virtual int GetDefenseRecoilID()
	{
		if (leftWeapon != null && leftWeapon.meleeType != MeleeType.OnlyAttack && leftWeapon.gameObject.activeSelf)
		{
			return leftWeapon.recoilID;
		}
		if (rightWeapon != null && rightWeapon.meleeType != MeleeType.OnlyAttack && rightWeapon.gameObject.activeSelf)
		{
			return rightWeapon.recoilID;
		}
		return 0;
	}

	protected virtual bool InRecoilRange(HitInfo hitInfo)
	{
		Vector3 position = base.transform.position;
		float x = position.x;
		float y = hitInfo.hitPoint.y;
		Vector3 position2 = base.transform.position;
		Vector3 b = new Vector3(x, y, position2.z);
		Vector3 vector = (Quaternion.LookRotation(hitInfo.hitPoint - b).eulerAngles - base.transform.eulerAngles).NormalizeAngle();
		return vector.y <= hitProperties.recoilRange;
	}

	public void SetLeftWeapon(GameObject weaponObject)
	{
		if ((bool)weaponObject)
		{
			leftWeapon = weaponObject.GetComponent<vMeleeWeapon>();
			if ((bool)leftWeapon)
			{
				leftWeapon.SetActiveDamage(value: false);
				leftWeapon.meleeManager = this;
			}
		}
	}

	public void SetRightWeapon(GameObject weaponObject)
	{
		if ((bool)weaponObject)
		{
			rightWeapon = weaponObject.GetComponent<vMeleeWeapon>();
			if ((bool)rightWeapon)
			{
				rightWeapon.meleeManager = this;
				rightWeapon.SetActiveDamage(value: false);
			}
		}
	}

	public void SetLeftWeapon(vMeleeWeapon weapon)
	{
		if ((bool)weapon)
		{
			leftWeapon = weapon;
			leftWeapon.SetActiveDamage(value: false);
			leftWeapon.meleeManager = this;
		}
	}

	public void SetRightWeapon(vMeleeWeapon weapon)
	{
		if ((bool)weapon)
		{
			rightWeapon = weapon;
			rightWeapon.meleeManager = this;
			rightWeapon.SetActiveDamage(value: false);
		}
	}

	private void ResetRecoil()
	{
		inRecoil = false;
	}
}
