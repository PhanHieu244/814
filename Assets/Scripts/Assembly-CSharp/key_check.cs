using Invector;
using UnityEngine;

public class key_check : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider col)
	{
		if (col.gameObject.tag == "Player")
		{
			vGameController.key = true;
			Object.Destroy(base.gameObject);
		}
	}
}
