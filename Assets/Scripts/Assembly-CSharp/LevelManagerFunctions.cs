using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManagerFunctions : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	public void ResetLevel()
	{
		PlayerPrefs.DeleteAll();
		SceneManager.LoadScene("LevelManager");
	}

	public void NextLevelOpen()
	{
		PlayerPrefs.SetInt("CurrentLevel", PlayerPrefs.GetInt("CurrentLevel") + 1);
		PlayerPrefs.SetInt("Level" + PlayerPrefs.GetInt("CurrentLevel"), 1);
		SceneManager.LoadScene("LevelManager");
	}
}
