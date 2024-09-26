using Invector;
using UnityEngine;

public class door_check : MonoBehaviour
{
	public GameObject prisoner;

	public GameObject Door;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision col)
	{
		if (col.gameObject.tag == "Player")
		{
			prisoner.GetComponent<Animator>().Play("Victory11");
			Door.SetActive(value: false);
			vGameController.key = true;
		}
	}
}
