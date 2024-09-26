using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class loading_handler : MonoBehaviour
{
	public GameObject instruction;

	private void Start()
	{
		StartCoroutine(Play());
	}

	private void Update()
	{
	}

	private IEnumerator Play()
	{
		yield return new WaitForSeconds(1.5f);
		if (PlayerPrefs.GetInt("show", 0) == 0)
		{
			instruction.SetActive(value: true);
		}
		else
		{
			SceneManager.LoadScene("MainScene");
		}
	}

	public void ok()
	{
		instruction.SetActive(value: false);
		PlayerPrefs.SetInt("show", 1);
		SceneManager.LoadScene("MainScene");
	}
}
