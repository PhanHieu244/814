using UnityEngine;

public class FixShaderQueue : MonoBehaviour
{
	public int AddQueue = 1;

	private void Start()
	{
		if (GetComponent<Renderer>() != null)
		{
			GetComponent<Renderer>().sharedMaterial.renderQueue += AddQueue;
		}
		else
		{
			Invoke("SetProjectorQueue", 0.1f);
		}
	}

	private void SetProjectorQueue()
	{
		GetComponent<Projector>().material.renderQueue += AddQueue;
	}

	private void Update()
	{
	}
}
