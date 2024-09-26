using UnityEngine;

public class FootStepObject
{
	public string name;

	public Transform sender;

	public Transform ground;

	public FootStepObject(Transform sender, Transform ground, string name = "")
	{
		this.name = name;
		this.sender = sender;
		this.ground = ground;
	}
}
