using UnityEngine;

public class vDynamicTriggerAction : vTriggerAction
{
	[HideInInspector]
	public vBoxTrigger[] boxTriggers;

	public Transform rootTransform;

	protected override void Start()
	{
		if (!rootTransform)
		{
			return;
		}
		Collider[] componentsInChildren = rootTransform.GetComponentsInChildren<Collider>();
		foreach (Collider collider in componentsInChildren)
		{
			for (int j = 0; j < boxTriggers.Length; j++)
			{
				Collider component = boxTriggers[j].GetComponent<Collider>();
				if (component != collider)
				{
					Physics.IgnoreCollision(component, collider);
				}
			}
		}
	}

	public override bool CanUse()
	{
		for (int i = 0; i < boxTriggers.Length; i++)
		{
			if (BoxCast(boxTriggers[i]))
			{
				return false;
			}
		}
		return true;
	}

	private bool BoxCast(vBoxTrigger boxCast)
	{
		return boxCast.inCollision;
	}
}
