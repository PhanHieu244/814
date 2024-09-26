using UnityEngine;

public class rescue_thing : MonoBehaviour
{
	public GameObject rescue_Maal;

	public GameObject rescue_Destination;

	public GameObject rescue_icon;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision Col)
	{
		if (Col.gameObject.tag == "Player")
		{
			rescue_Maal.SetActive(value: true);
			rescue_icon.SetActive(value: true);
			rescue_Destination.SetActive(value: true);
			Object.Destroy(base.gameObject);
		}
	}
}
