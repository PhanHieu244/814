using System.Collections;
using UnityEngine;
using UnityEngine.AI;

public class pick_script : MonoBehaviour
{
	public GameObject Player;

	public Animator anim;

	public GameObject car1;

	public GameObject car2;

	public GameObject car3;

	public GameObject car4;

	public GameObject car5;

	public GameObject car6;

	public GameObject car7;

	public GameObject pickButton;

	public GameObject Generate_Pos;

	public static bool pick;

	public GameObject Child_Current_Car;

	private void Start()
	{
	}

	private void Update()
	{
		if (Player == null)
		{
			Player = GameObject.FindGameObjectWithTag("Player");
		}
		if (anim == null)
		{
			anim = Player.GetComponent<Animator>();
		}
		if (Generate_Pos == null)
		{
			Generate_Pos = GameObject.FindGameObjectWithTag("generate_car");
		}
		if (detection.current_car_No == 1)
		{
			Child_Current_Car = car1;
		}
		else if (detection.current_car_No == 2)
		{
			Child_Current_Car = car2;
		}
		else if (detection.current_car_No == 3)
		{
			Child_Current_Car = car3;
		}
		if (detection.current_car_No == 4)
		{
			Child_Current_Car = car4;
		}
		else if (detection.current_car_No == 5)
		{
			Child_Current_Car = car5;
		}
		else if (detection.current_car_No == 6)
		{
			Child_Current_Car = car6;
		}
		else if (detection.current_car_No == 7)
		{
			Child_Current_Car = car7;
		}
	}

	public void pick_Car()
	{
		if (detection.current_car.GetComponent<NavMeshAgent>() != null)
		{
			detection.current_car.GetComponent<NavMeshAgent>().Stop();
		}
		anim.Play("Giant2HandGrab");
		StartCoroutine(real_car());
	}

	private IEnumerator real_car()
	{
		yield return new WaitForSeconds(1.25f);
		GameObject car_N = Object.Instantiate(Child_Current_Car, Generate_Pos.transform.position, detection.current_car.transform.rotation);
		detection.current_car.SetActive(value: false);
		if (detection.current_car.tag == "carMission")
		{
		}
		pickButton.SetActive(value: false);
		yield return new WaitForSeconds(0.1f);
		car_N.GetComponent<Rigidbody>().isKinematic = true;
		yield return new WaitForSeconds(0.9f);
		car_N.GetComponent<Rigidbody>().useGravity = true;
		car_N.GetComponent<Rigidbody>().isKinematic = false;
		car_N.transform.rotation = Quaternion.Euler(25f, 10f, 45f);
		Rigidbody component = car_N.GetComponent<Rigidbody>();
		Vector3 forward = Player.transform.forward;
		float x = forward.x;
		Vector3 forward2 = Player.transform.forward;
		component.AddForce(new Vector3(x, 0.08f, forward2.z) * 2000f);
		Object.Destroy(car_N, 10f);
	}
}
