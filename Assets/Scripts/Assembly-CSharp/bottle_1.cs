using UnityEngine;

public class bottle_1 : MonoBehaviour
{
	public GameObject power1;

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
			power1.SetActive(value: true);
			Object.Destroy(base.gameObject, 0.2f);
		}
	}
}
