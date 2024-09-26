using UnityEngine;

public class theif_action : MonoBehaviour
{
	public GameObject theif;

	private void Start()
	{
		theif.GetComponent<Animator>().Play("AttackHit");
	}

	private void Update()
	{
	}
}
