using UnityEngine;

public class police_active : MonoBehaviour
{
	public GameObject Police_Man_Enemies;

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
			Police_Man_Enemies.SetActive(value: true);
		}
	}
}
