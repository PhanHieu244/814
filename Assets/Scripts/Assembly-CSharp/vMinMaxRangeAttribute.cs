using UnityEngine;

public class vMinMaxRangeAttribute : PropertyAttribute
{
	public float minLimit;

	public float maxLimit;

	public vMinMaxRangeAttribute(float minLimit, float maxLimit)
	{
		this.minLimit = minLimit;
		this.maxLimit = maxLimit;
	}
}
