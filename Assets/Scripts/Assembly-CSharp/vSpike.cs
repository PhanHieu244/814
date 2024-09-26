using UnityEngine;

public class vSpike : MonoBehaviour
{
	private HingeJoint joint;

	[HideInInspector]
	public vSpikeControl control;

	private bool inConect;

	private Transform impaled;

	private void Start()
	{
		joint = GetComponent<HingeJoint>();
	}

	private void OnCollisionEnter(Collision collision)
	{
		if (!(collision.rigidbody != null) || !(collision.collider.GetComponent<vCollisionMessage>() != null) || inConect)
		{
			return;
		}
		bool flag = control == null || !control.attachColliders.Contains(collision.collider.transform);
		if ((bool)control)
		{
			control.attachColliders.Add(collision.collider.transform);
		}
		if (flag)
		{
			inConect = true;
			if ((bool)joint && (bool)collision.rigidbody)
			{
				joint.connectedBody = collision.rigidbody;
			}
			impaled = collision.transform;
			Rigidbody[] componentsInChildren = collision.transform.root.GetComponentsInChildren<Rigidbody>();
			foreach (Rigidbody rigidbody in componentsInChildren)
			{
				rigidbody.velocity = Vector3.zero;
			}
			vCollisionMessage component = collision.collider.GetComponent<vCollisionMessage>();
			if ((bool)component)
			{
				component.ragdoll.iChar.currentHealth = 0f;
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.transform != null && impaled != null && other.transform == impaled)
		{
			if ((bool)joint)
			{
				joint.connectedBody = null;
			}
			impaled = null;
			if (control != null && control.attachColliders.Contains(impaled))
			{
				control.attachColliders.Remove(impaled);
			}
			inConect = false;
		}
	}
}
