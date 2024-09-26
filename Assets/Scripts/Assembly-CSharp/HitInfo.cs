using UnityEngine;

public class HitInfo
{
	public vMeleeAttackObject attackObject;

	public vHitBox hitBox;

	public Vector3 hitPoint;

	public Collider targetCollider;

	public HitInfo(vMeleeAttackObject attackObject, vHitBox hitBox, Collider targetCollider, Vector3 hitPoint)
	{
		this.attackObject = attackObject;
		this.hitBox = hitBox;
		this.targetCollider = targetCollider;
		this.hitPoint = hitPoint;
	}
}
