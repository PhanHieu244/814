using UnityEngine;
using UnityEngine.SceneManagement;

public class loadingScript : MonoBehaviour
{
	private void Start()
	{
		SceneManager.LoadScene("MainScene");
	}

	private void Update()
	{
	}
}
