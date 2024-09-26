using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Handling : MonoBehaviour
{
	public Text Score;

	public GameObject rate_canvas;

	public GameObject rate_exit_canvas;

	public GameObject exit_canvas;

	public bool vloume = true;

	public GameObject VolumeOn;

	public GameObject VolumeOff;

	public GameObject Reset_Panel;

	public GameObject CP_Pannel;

	private void Start()
	{
		Score.text = PlayerPrefs.GetInt("Score").ToString();
	}

	private void Update()
	{
	}

	public void play()
	{
		
	}

	public void rate()
	{
		rate_canvas.SetActive(value: true);
	}

	public void rate_exit()
	{
		rate_exit_canvas.SetActive(value: true);
	}

	public void moreapps()
	{
		
	}

	public void volume()
	{
	}

	public void rate_yes()
	{
		rate_canvas.SetActive(value: false);
		PlayerPrefs.SetInt("rated", 1);
		
	}

	public void rate_no()
	{
		rate_canvas.SetActive(value: false);
	}

	public void exit()
	{
		if (PlayerPrefs.GetInt("rated") == 0)
		{
			rate_canvas.SetActive(value: true);
		}
		else
		{
			exit_canvas.SetActive(value: true);
		}
	}

	public void rate_no_exit()
	{
		rate_exit_canvas.SetActive(value: false);
		exit_canvas.SetActive(value: true);
	}

	public void exit_yes()
	{
		Application.Quit();
	}

	public void exit_no()
	{
		exit_canvas.SetActive(value: false);
	}

	public void no_ad()
	{
		
	}

	public void VolumeHandler()
	{
		if (vloume)
		{
			VolumeOff.SetActive(value: true);
			VolumeOn.SetActive(value: false);
			AudioListener.volume = 0f;
		}
		else
		{
			VolumeOn.SetActive(value: true);
			VolumeOff.SetActive(value: false);
			AudioListener.volume = 1f;
		}
		vloume = !vloume;
	}

	public void hide_CP_Pannel()
	{
		//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
		CP_Pannel.SetActive(value: false);
	}

	public void privacy_policy()
	{
		
	}

	public void share()
	{
		AndroidJavaClass androidJavaClass = new AndroidJavaClass("android.content.Intent");
		AndroidJavaObject androidJavaObject = new AndroidJavaObject("android.content.Intent");
		androidJavaObject.Call<AndroidJavaObject>("setAction", new object[1]
		{
			androidJavaClass.GetStatic<string>("ACTION_SEND")
		});
		androidJavaObject.Call<AndroidJavaObject>("setType", new object[1]
		{
			"text/plain"
		});
		androidJavaObject.Call<AndroidJavaObject>("putExtra", new object[2]
		{
			androidJavaClass.GetStatic<string>("EXTRA_SUBJECT"),
			"Checkout Iron Hero Fight Game!!!"
		});
		androidJavaObject.Call<AndroidJavaObject>("putExtra", new object[2]
		{
			androidJavaClass.GetStatic<string>("EXTRA_TEXT"),
			"Amazing Supeer Hero game !! https://play.google.com/store/apps/details?id=com.myhero.testgame"
		});
		AndroidJavaClass androidJavaClass2 = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
		AndroidJavaObject @static = androidJavaClass2.GetStatic<AndroidJavaObject>("currentActivity");
		@static.Call("startActivity", androidJavaObject);
	}
}
