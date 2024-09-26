using Invector;
using System.Collections;
using UnityEngine;

public class Rescue_Complete : MonoBehaviour
{
	public GameObject canvas_MC;

	public GameObject mobile_control;

	public AudioSource win_sound;

	public Animator anim;

	public GameObject Player;

	public bool condition_checker;

	public GameObject rescue_person;

	private void Start()
	{
		Player = GameObject.FindGameObjectWithTag("Player");
		anim = Player.GetComponent<Animator>();
		condition_checker = true;
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision Coll)
	{
		if (Coll.gameObject.tag == "Player" && condition_checker)
		{
			rescue_person.SetActive(value: false);
			condition_checker = false;
			MonoBehaviour.print("Mission Complete Level Set");
			StartCoroutine(MC());
		}
	}

	private IEnumerator MC()
	{
		yield return new WaitForSeconds(2f);
		mission_complete();
		yield return new WaitForSeconds(2f);
		canvas_MC.SetActive(value: true);
		mobile_control.SetActive(value: false);
	}

	public void mission_complete()
	{
		win_sound.Play();
		anim.Play("Victory11");
		vGameController.time_run = false;
	}
}
