using System.Collections.Generic;
using UnityEngine;

public class vSpikeControl : MonoBehaviour
{
	[HideInInspector]
	public List<Transform> attachColliders;

	private void Start()
	{
		attachColliders = new List<Transform>();
		vSpike[] componentsInChildren = GetComponentsInChildren<vSpike>();
		vSpike[] array = componentsInChildren;
		foreach (vSpike vSpike in array)
		{
			vSpike.control = this;
		}
	}
}
