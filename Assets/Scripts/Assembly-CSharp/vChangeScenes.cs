using Invector;
using UnityEngine;
using UnityEngine.SceneManagement;

public class vChangeScenes : MonoBehaviour
{
	private vGameController gm;

	private void Start()
	{
		gm = Object.FindObjectOfType<vGameController>();
	}

	public void LoadThirdPersonScene()
	{
		Object.Destroy(gm.currentPlayer);
		Object.Destroy(gm.gameObject);
		SceneManager.LoadScene("3rdPersonController-Demo");
	}

	public void LoadTopDownScene()
	{
		Object.Destroy(gm.currentPlayer);
		Object.Destroy(gm.gameObject);
		SceneManager.LoadScene("TopDownController-Demo");
	}

	public void LoadPlatformScene()
	{
		Object.Destroy(gm.currentPlayer);
		Object.Destroy(gm.gameObject);
		SceneManager.LoadScene("2.5DController-Demo");
	}

	public void LoadIsometricScene()
	{
		Object.Destroy(gm.currentPlayer);
		Object.Destroy(gm.gameObject);
		SceneManager.LoadScene("IsometricController-Demo");
	}

	public void LoadVMansion()
	{
		Object.Destroy(gm.currentPlayer);
		Object.Destroy(gm.gameObject);
		SceneManager.LoadScene("V-Mansion");
	}
}
