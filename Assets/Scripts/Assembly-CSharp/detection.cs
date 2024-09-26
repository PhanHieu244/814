using UnityEngine;

public class detection : MonoBehaviour
{
	public int car_No;

	public GameObject Pick_Button;

	public GameObject Player;

	public static int current_car_No;

	public static GameObject current_car;

	private void Start()
	{
		Player = GameObject.FindGameObjectWithTag("Player");
	}

	private void Update()
	{
		if (Player == null)
		{
			Player = GameObject.FindGameObjectWithTag("Player");
		}
	}

	private void OnTriggerStay(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			Pick_Button.SetActive(value: true);
			current_car_No = car_No;
			current_car = base.gameObject;
		}
	}

	private void OnTriggerExit(Collider other)
	{
		Pick_Button.SetActive(value: false);
	}
}
