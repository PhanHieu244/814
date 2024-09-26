using System;
using UnityEngine;

[Serializable]
public class HitEffect
{
	public string hitName = string.Empty;

	public GameObject hitPrefab;

	[Tooltip("Attach prefab in Damage Receiver transform")]
	public bool attachInReceiver;
}
