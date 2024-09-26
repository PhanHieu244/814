using UnityEngine;

public class bottle_2 : MonoBehaviour
{
	public GameObject power2;

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
			power2.SetActive(value: true);
			Object.Destroy(base.gameObject, 0.2f);
		}
	}
}
