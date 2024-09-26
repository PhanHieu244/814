using Invector.EventSystems;
using System.Collections.Generic;
using UnityEngine;

public class vObjectDamage : MonoBehaviour
{
	public Damage damage;

	[Tooltip("List of tags that can be hit")]
	public List<string> tags;

	[HideInInspector]
	public bool useCollision;

	[HideInInspector]
	[Tooltip("Check to use the damage Frequence")]
	public bool continuousDamage;

	[HideInInspector]
	[Tooltip("Apply damage to each end of the frequency in seconds ")]
	public float damageFrequency = 0.5f;

	private List<Collider> targets;

	private List<Collider> disabledTarget;

	private float currentTime;

	protected virtual void Start()
	{
		targets = new List<Collider>();
		disabledTarget = new List<Collider>();
	}

	protected virtual void Update()
	{
		if (!continuousDamage || targets == null || targets.Count <= 0)
		{
			return;
		}
		if (currentTime > 0f)
		{
			currentTime -= Time.deltaTime;
			return;
		}
		currentTime = damageFrequency;
		foreach (Collider target in targets)
		{
			if (target != null)
			{
				if (target.enabled)
				{
					ApplyDamage(target.transform, base.transform.position);
				}
				else
				{
					disabledTarget.Add(target);
				}
			}
		}
		if (disabledTarget.Count > 0)
		{
			int num = disabledTarget.Count;
			while (num >= 0 && disabledTarget.Count != 0)
			{
				try
				{
					if (targets.Contains(disabledTarget[num]))
					{
						targets.Remove(disabledTarget[num]);
					}
				}
				catch
				{
					goto IL_0152;
				}
				num--;
			}
		}
		goto IL_0152;
		IL_0152:
		if (disabledTarget.Count > 0)
		{
			disabledTarget.Clear();
		}
	}

	protected virtual void OnCollisionEnter(Collision hit)
	{
		if (useCollision && !continuousDamage && tags.Contains(hit.gameObject.tag))
		{
			ApplyDamage(hit.transform, hit.contacts[0].point);
		}
	}

	protected virtual void OnTriggerEnter(Collider hit)
	{
		if (!useCollision)
		{
			if (continuousDamage && tags.Contains(hit.transform.tag) && !targets.Contains(hit))
			{
				targets.Add(hit);
			}
			else if (tags.Contains(hit.gameObject.tag))
			{
				ApplyDamage(hit.transform, base.transform.position);
			}
		}
	}

	protected virtual void OnTriggerExit(Collider hit)
	{
		if ((!useCollision || continuousDamage) && tags.Contains(hit.gameObject.tag) && targets.Contains(hit))
		{
			targets.Remove(hit);
		}
	}

	protected virtual void ApplyDamage(Transform target, Vector3 hitPoint)
	{
		damage.sender = base.transform;
		damage.hitPosition = hitPoint;
		target.gameObject.ApplyDamage(damage);
	}
}
