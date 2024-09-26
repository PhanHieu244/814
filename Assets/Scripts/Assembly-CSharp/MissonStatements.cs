using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class MissonStatements : MonoBehaviour
{
	public int currentLevel;

	public string[] missionStatements;

	public float letterPause = 0.1f;

	private Text textcomp;

	public AudioSource tik;

	private void Start()
	{
		currentLevel = PlayerPrefs.GetInt("CurrentLevel", 1);
		textcomp = base.transform.GetComponentInChildren<Text>();
		StartCoroutine(TypeText());
	}

	private IEnumerator TypeText()
	{
		char[] array = missionStatements[currentLevel - 1].ToCharArray();
		foreach (char letter in array)
		{
			textcomp.text += letter;
			tik.Play();
			yield return new WaitForSeconds(letterPause);
		}
	}
}
