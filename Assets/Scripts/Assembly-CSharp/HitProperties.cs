using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class HitProperties
{
	[Tooltip("Tag to receiver Damage")]
	public List<string> hitDamageTags = new List<string>
	{
		"Enemy"
	};

	[Tooltip("Trigger a HitRecoil animation if the character attacks a obstacle")]
	public bool useRecoil = true;

	public bool drawRecoilGizmos;

	[Range(0f, 180f)]
	public float recoilRange = 90f;

	[Tooltip("layer to Recoil Damage")]
	public LayerMask hitRecoilLayer = 1;
}
