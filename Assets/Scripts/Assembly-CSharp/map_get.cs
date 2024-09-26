using UnityEngine;

public class map_get : MonoBehaviour
{
	public GameObject New_Enemies;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider Col)
	{
		if (Col.gameObject.tag == "Player")
		{
			New_Enemies.SetActive(value: true);
			Object.Destroy(base.gameObject);
		}
	}
}
