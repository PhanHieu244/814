using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class transform_control : MonoBehaviour
{
	public GameObject hero_false_transform;

	[Header("--- Hero ---")]
	public Animator anim;

	public GameObject hero;

	public GameObject hero_camera;

	public GameObject hero_input;

	public GameObject hero_button;

	public GameObject hero_car_position;

	[Header("--- Car ---")]
	public GameObject car;

	public GameObject car_camera;

	public GameObject car_input;

	public GameObject car_button;

	public AudioSource sound_of_transform;

	private void Start()
	{
		anim = hero.GetComponent<Animator>();
	}

	private void Update()
	{
	}

	public void transfor_car()
	{
		car_button.SetActive(value: false);
		sound_of_transform.Play();
		anim.Play("Giant2HandSlamSwing");
		hero_input.SetActive(value: false);
		GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = false;
		GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = false;
		hero_input.SetActive(value: false);
		StartCoroutine(transfor_car_set());
	}

	private IEnumerator transfor_car_set()
	{
		yield return new WaitForSeconds(1f);
		hero_button.SetActive(value: true);
		hero_camera.SetActive(value: false);
		car_camera.SetActive(value: true);
		car.SetActive(value: true);
		car.transform.position = hero_car_position.transform.position;
		car.transform.rotation = hero_car_position.transform.rotation;
		hero.transform.position = hero_false_transform.transform.position;
		hero.SetActive(value: false);
		car_camera.SetActive(value: true);
		car_input.SetActive(value: true);
		hero_camera.SetActive(value: false);
		hero_input.SetActive(value: false);
	}

	public void transfor_Hero()
	{
		hero_button.SetActive(value: false);
		hero.SetActive(value: true);
		hero.transform.position = car.transform.position;
		hero.transform.rotation = car.transform.rotation;
		car.SetActive(value: false);
		sound_of_transform.Play();
		anim.Play("Giant2HandGrab");
		GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = true;
		GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = true;
		hero_input.SetActive(value: true);
		hero_camera.SetActive(value: true);
		car_input.SetActive(value: false);
		car_camera.SetActive(value: false);
	}

	private IEnumerator transfor_hero_set()
	{
		yield return new WaitForSeconds(2f);
	}
}
