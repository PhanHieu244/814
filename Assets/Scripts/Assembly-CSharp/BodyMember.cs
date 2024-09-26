using System;
using UnityEngine;

[Serializable]
public class BodyMember
{
	public Transform transform;

	public string bodyPart;

	public vMeleeAttackObject attackObject;

	public bool isHuman;

	public void SetActiveDamage(bool active)
	{
		attackObject.SetActiveDamage(active);
	}
}
