using UnityEngine;
using UnityEngine.SceneManagement;

public class missionComplete : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	public void LevelComplete()
	{
		LevelManager.LevelCompleted();
		SceneManager.LoadScene(0);
	}
}
