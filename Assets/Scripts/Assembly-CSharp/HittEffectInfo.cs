using UnityEngine;

public class HittEffectInfo
{
	public Transform receiver;

	public Vector3 position;

	public Quaternion rotation;

	public string hitName;

	public HittEffectInfo(Vector3 position, Quaternion rotation, string hitName = "", Transform receiver = null)
	{
		this.receiver = receiver;
		this.position = position;
		this.rotation = rotation;
		this.hitName = hitName;
	}
}
