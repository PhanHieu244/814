using Invector;
using UnityEngine;

public class door_check_2 : MonoBehaviour
{
	public GameObject prisoner;

	public GameObject prisoner_2;

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
			prisoner_2.GetComponent<Animator>().Play("Victory11");
			Door.SetActive(value: false);
			vGameController.key = true;
		}
	}
}
