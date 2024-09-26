using Invector;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class Story : MonoBehaviour
{
	public GameObject story_canvas;

	public GameObject mobile_control;

	public Text story_statement_text;

	public AudioSource tik;

	public string missionStatements;

	public int story_start_on_enemies;

	public GameObject new_enemies_on;

	private bool conditiion_checker;

	private bool check;

	private float letterPause = 0.1f;

	private void Start()
	{
		check = false;
		conditiion_checker = true;
	}

	private IEnumerator TypeText()
	{
		char[] array = missionStatements.ToCharArray();
		foreach (char letter in array)
		{
			story_statement_text.text += letter;
			if (!story_can_enem_contr.continuehogya)
			{
				tik.Play();
			}
			yield return new WaitForSeconds(letterPause);
		}
	}

	private void Update()
	{
		if (v_AIMotor.kill == story_start_on_enemies && !check)
		{
			StartCoroutine(story_things());
			vGameController.time_run = false;
			mobile_control.SetActive(value: false);
			GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = false;
			GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = false;
			check = true;
		}
		if (story_can_enem_contr.active_enemies && conditiion_checker)
		{
			new_enemies_on.SetActive(value: true);
			vGameController.time_run = true;
			mobile_control.SetActive(value: true);
			GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = true;
			GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = true;
			conditiion_checker = false;
		}
	}

	private IEnumerator story_things()
	{
		yield return new WaitForSeconds(2f);
		story_canvas.SetActive(value: true);
		StartCoroutine(TypeText());
	}
}
