using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour
{
	private int TotalNumberOfLevels;

	public string SceneToNavigate;

	public GameObject[] MadIcons;

	public int NextLevel;

	private void Start()
	{
		TotalNumberOfLevels = MadIcons.Length;
		LevelChecker();
	}

	private void Update()
	{
	}

	public void MadClick(int i)
	{
		if (!MadIcons[i - 1].transform.GetChild(1).gameObject.activeSelf)
		{
			PlayerPrefs.SetInt("CurrentLevel", i);
			SceneManager.LoadScene(SceneToNavigate);
		}
	}

	public void LevelChecker()
	{
		for (int i = 1; i <= TotalNumberOfLevels; i++)
		{
			if (PlayerPrefs.GetInt("Level" + i, 0) == 1)
			{
				MadIcons[i - 1].transform.GetChild(1).gameObject.SetActive(value: false);
				NextLevel = i;
			}
		}
		if (NextLevel < TotalNumberOfLevels)
		{
			MadIcons[NextLevel].GetComponent<Animator>().enabled = true;
			MadIcons[NextLevel++].transform.GetChild(1).gameObject.SetActive(value: false);
		}
	}

	public static void LevelCompleted()
	{
		PlayerPrefs.SetInt("Level" + PlayerPrefs.GetInt("CurrentLevel"), 1);
	}

	public void Reset()
	{
		//GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowAd();
		for (int i = 1; i <= TotalNumberOfLevels; i++)
		{
			PlayerPrefs.SetInt("Level" + i, 0);
		}
		SceneManager.LoadScene("LevelManager");
	}

	public void Back()
	{
		//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
		//BannerAd.showBanner = false;
		SceneManager.LoadScene("InappScene");
	}
}
