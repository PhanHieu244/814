using UnityEngine;

public class theif_active : MonoBehaviour
{
	public GameObject Theif;

	public GameObject Mission_Enemeis;

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
			Theif.SetActive(value: false);
			Mission_Enemeis.SetActive(value: true);
		}
	}
}
