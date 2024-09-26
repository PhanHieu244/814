using UnityEngine;

public class vHitBox : MonoBehaviour
{
	[HideInInspector]
	public vMeleeAttackObject attackObject;

	[HideInInspector]
	public Collider trigger;

	public int damagePercentage = 100;

	[EnumFlag]
	public vHitBoxType triggerType = vHitBoxType.Damage | vHitBoxType.Recoil;

	private bool canHit;

	private void OnDrawGizmos()
	{
		trigger = GetComponent<Collider>();
		Color color = ((triggerType & vHitBoxType.Damage) != 0 && (triggerType & vHitBoxType.Recoil) == 0) ? Color.green : (((triggerType & vHitBoxType.Damage) != 0 && (triggerType & vHitBoxType.Recoil) != 0) ? Color.yellow : (((triggerType & vHitBoxType.Recoil) == 0 || (triggerType & vHitBoxType.Damage) != 0) ? Color.black : Color.red));
		color.a = 0.6f;
		Gizmos.color = color;
		if ((bool)trigger && trigger.enabled && (bool)(trigger as BoxCollider))
		{
			BoxCollider boxCollider = trigger as BoxCollider;
			Vector3 lossyScale = base.transform.lossyScale;
			float x = lossyScale.x;
			Vector3 size = boxCollider.size;
			float x2 = x * size.x;
			Vector3 lossyScale2 = base.transform.lossyScale;
			float y = lossyScale2.y;
			Vector3 size2 = boxCollider.size;
			float y2 = y * size2.y;
			Vector3 lossyScale3 = base.transform.lossyScale;
			float z = lossyScale3.z;
			Vector3 size3 = boxCollider.size;
			float z2 = z * size3.z;
			Matrix4x4 matrix4x2 = Gizmos.matrix = Matrix4x4.TRS(boxCollider.bounds.center, base.transform.rotation, new Vector3(x2, y2, z2));
			Gizmos.DrawCube(Vector3.zero, Vector3.one);
		}
	}

	private void Start()
	{
		trigger = GetComponent<Collider>();
		if ((bool)trigger)
		{
			trigger.isTrigger = true;
			trigger.enabled = false;
		}
		else
		{
			Object.Destroy(this);
		}
		canHit = ((triggerType & vHitBoxType.Damage) != 0 || (triggerType & vHitBoxType.Recoil) != 0);
	}

	private void OnTriggerEnter(Collider other)
	{
		if (TriggerCondictions(other) && attackObject != null)
		{
			attackObject.OnHit(this, other);
		}
	}

	private bool TriggerCondictions(Collider other)
	{
		return canHit && attackObject != null && (attackObject.meleeManager == null || other.gameObject != attackObject.meleeManager.gameObject);
	}
}
