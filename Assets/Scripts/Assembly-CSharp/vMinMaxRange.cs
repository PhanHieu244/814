using System;
using UnityEngine;

[Serializable]
public class vMinMaxRange
{
	public float rangeStart;

	public float rangeEnd;

	public float GetRandomValue()
	{
		return UnityEngine.Random.Range(rangeStart, rangeEnd);
	}
}
