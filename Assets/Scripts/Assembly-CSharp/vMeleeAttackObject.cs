using Invector.EventSystems;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class vMeleeAttackObject : MonoBehaviour
{
	public Damage damage;

	public List<vHitBox> hitBoxes;

	public int damageModifier;

	[HideInInspector]
	public bool canApplyDamage;

	[HideInInspector]
	public OnHitEnter onDamageHit;

	[HideInInspector]
	public OnHitEnter onRecoilHit;

	[HideInInspector]
	public UnityEvent onEnableDamage;

	[HideInInspector]
	public UnityEvent onDisableDamage;

	private Dictionary<vHitBox, List<GameObject>> targetColliders;

	[HideInInspector]
	public vMeleeManager meleeManager;

	protected virtual void Start()
	{
		targetColliders = new Dictionary<vHitBox, List<GameObject>>();
		if (hitBoxes.Count > 0)
		{
			foreach (vHitBox hitBox in hitBoxes)
			{
				hitBox.attackObject = this;
				targetColliders.Add(hitBox, new List<GameObject>());
			}
		}
		else
		{
			base.enabled = false;
		}
	}

	public virtual void SetActiveDamage(bool value)
	{
		canApplyDamage = value;
		for (int i = 0; i < hitBoxes.Count; i++)
		{
			vHitBox vHitBox = hitBoxes[i];
			vHitBox.trigger.enabled = value;
			if (!value && targetColliders != null)
			{
				targetColliders[vHitBox].Clear();
			}
		}
		if (value)
		{
			onEnableDamage.Invoke();
		}
		else
		{
			onDisableDamage.Invoke();
		}
	}

	public virtual void OnHit(vHitBox hitBox, Collider other)
	{
		if (!canApplyDamage || targetColliders[hitBox].Contains(other.gameObject) || !(meleeManager != null) || !(other.gameObject != meleeManager.gameObject))
		{
			return;
		}
		bool flag = false;
		bool flag2 = false;
		if (meleeManager == null)
		{
			meleeManager = GetComponentInParent<vMeleeManager>();
		}
		HitProperties hitProperties = meleeManager.hitProperties;
		if (((hitBox.triggerType & vHitBoxType.Damage) != 0 && hitProperties.hitDamageTags == null) || hitProperties.hitDamageTags.Count == 0)
		{
			flag = true;
		}
		else if ((hitBox.triggerType & vHitBoxType.Damage) != 0 && hitProperties.hitDamageTags.Contains(other.tag))
		{
			flag = true;
		}
		else if ((hitBox.triggerType & vHitBoxType.Recoil) != 0 && (int)hitProperties.hitRecoilLayer == ((int)hitProperties.hitRecoilLayer | (1 << other.gameObject.layer)))
		{
			flag2 = true;
		}
		if (!flag && !flag2)
		{
			return;
		}
		targetColliders[hitBox].Add(other.gameObject);
		HitInfo hitInfo = new HitInfo(this, hitBox, other, hitBox.transform.position);
		if (flag)
		{
			if ((bool)meleeManager)
			{
				meleeManager.OnDamageHit(hitInfo);
			}
			else
			{
				damage.sender = base.transform;
				ApplyDamage(hitBox, other, damage);
			}
			onDamageHit.Invoke(hitInfo);
		}
		if (flag2)
		{
			if ((bool)meleeManager)
			{
				meleeManager.OnRecoilHit(hitInfo);
			}
			onRecoilHit.Invoke(hitInfo);
		}
	}

	public void ApplyDamage(vHitBox hitBox, Collider other, Damage damage)
	{
		Damage damage2 = new Damage(damage);
		damage2.value = Mathf.RoundToInt((float)(damage.value + damageModifier) * ((float)hitBox.damagePercentage * 0.01f));
		damage2.hitPosition = hitBox.transform.position;
		if (other.gameObject.IsAMeleeFighter())
		{
			other.gameObject.GetMeleeFighter().OnReceiveAttack(damage2, meleeManager.fighter);
		}
		else if (other.gameObject.CanReceiveDamage())
		{
			other.gameObject.ApplyDamage(damage2);
		}
	}
}
