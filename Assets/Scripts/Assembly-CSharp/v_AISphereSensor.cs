using Invector;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SphereCollider))]
public class v_AISphereSensor : MonoBehaviour
{
	[Header("Who the AI can chase")]
	[Tooltip("Character won't hit back when receive damage, check false and it will automatically add the Tag of the attacker")]
	[HideInInspector]
	public bool passiveToDamage;

	[HideInInspector]
	public List<string> tagsToDetect = new List<string>
	{
		"Player"
	};

	public LayerMask obstacleLayer = 1;

	[HideInInspector]
	public bool getFromDistance;

	public List<Transform> targetsInArea;

	private void Start()
	{
		targetsInArea = new List<Transform>();
	}

	public void SetTagToDetect(Transform _transform)
	{
		if (_transform != null && tagsToDetect != null && !tagsToDetect.Contains(_transform.tag))
		{
			tagsToDetect.Add(_transform.tag);
			targetsInArea.Add(_transform);
		}
	}

	public void RemoveTag(Transform _transform)
	{
		if (tagsToDetect != null && tagsToDetect.Contains(_transform.tag))
		{
			tagsToDetect.Remove(_transform.tag);
			if (targetsInArea.Contains(_transform))
			{
				targetsInArea.Remove(_transform);
			}
		}
	}

	public void SetColliderRadius(float radius)
	{
		SphereCollider component = GetComponent<SphereCollider>();
		if ((bool)component)
		{
			component.radius = radius;
		}
	}

	public Transform GetTargetTransform()
	{
		if (targetsInArea.Count > 0)
		{
			SortTargets();
			if (targetsInArea.Count > 0)
			{
				return targetsInArea[0];
			}
		}
		return null;
	}

	public vCharacter GetTargetvCharacter()
	{
		if (targetsInArea.Count > 0)
		{
			SortCharacters();
			if (targetsInArea.Count > 0)
			{
				vCharacter component = targetsInArea[0].GetComponent<vCharacter>();
				if (component != null && component.currentHealth > 0f)
				{
					return component;
				}
			}
		}
		return null;
	}

	private void SortCharacters()
	{
		for (int num = targetsInArea.Count - 1; num >= 0; num--)
		{
			Transform transform = targetsInArea[num];
			if (transform == null || transform.GetComponent<vCharacter>() == null)
			{
				targetsInArea.RemoveAt(num);
			}
		}
		if (getFromDistance)
		{
			targetsInArea.Sort((Transform c1, Transform c2) => Vector3.Distance(base.transform.position, (!(c1 != null)) ? (Vector3.one * float.PositiveInfinity) : c1.transform.position).CompareTo(Vector3.Distance(base.transform.position, (!(c2 != null)) ? (Vector3.one * float.PositiveInfinity) : c2.transform.position)));
		}
	}

	private void SortTargets()
	{
		for (int num = targetsInArea.Count - 1; num >= 0; num--)
		{
			Transform x = targetsInArea[num];
			if (x == null)
			{
				targetsInArea.RemoveAt(num);
			}
		}
		if (getFromDistance)
		{
			targetsInArea.Sort((Transform c1, Transform c2) => Vector3.Distance(base.transform.position, (!(c1 != null)) ? (Vector3.one * float.PositiveInfinity) : c1.transform.position).CompareTo(Vector3.Distance(base.transform.position, (!(c2 != null)) ? (Vector3.one * float.PositiveInfinity) : c2.transform.position)));
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (tagsToDetect.Contains(other.gameObject.tag) && !targetsInArea.Contains(other.transform))
		{
			targetsInArea.Add(other.transform);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (tagsToDetect.Contains(other.gameObject.tag) && targetsInArea.Contains(other.transform))
		{
			targetsInArea.Remove(other.transform);
		}
	}
}
