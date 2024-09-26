using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class inapppurchase : MonoBehaviour
{
	[Header("Items to purchase")]
	public GameObject[] items;

	[Header("Animations if Exist")]
	public string[] Animations;

	[Header("Items Price (Follow Same Order)")]
	public int[] Prices;

	[Header("Health Damage Sprint)")]
	public float[] P_Health;

	public float[] P_Damage;

	public float[] P_Sprint;

	[Header("Text Section")]
	public Text price;

	public Text TotalCoins;

	[Header("Health & Walk Speed")]
	public GameObject Health;

	public GameObject Damage;

	public GameObject Sprint;

	[Header("Button Section")]
	public GameObject BuyButton;

	public GameObject PlayButton;

	public GameObject WatchVideoButton;

	[Header("Player Preference Variable")]
	public string PlayerPreference;

	[Header("Canvas Section")]
	public GameObject Buy_canvas;

	[Header("Scene To Navigate on Play")]
	public string SceneName;

	private int currentItem;

	public int BuyItem;

	public static inapppurchase instance
	{
		get;
		set;
	}

	private void Awake()
	{
		instance = this;
	}

	private void Start()
	{
		items[0].SetActive(value: true);
		price.text = "SELECTED";
		currentItem = 0;
		PlayerPrefs.SetInt("item" + items[0].name, 1);
		BuyButton.SetActive(value: false);
		items[0].GetComponent<Animator>().Play(Animations[0]);
	}

	private void Update()
	{
		TotalCoins.text = PlayerPrefs.GetInt("Score").ToString();
	}

	public void NextItem()
	{
		if (currentItem < items.Length - 1)
		{
			currentItem++;
			if (PlayerPrefs.GetInt("item" + items[currentItem].name, 0) == 0)
			{
				items[currentItem - 1].SetActive(value: false);
				items[currentItem].SetActive(value: true);
				items[currentItem].GetComponent<Animator>().Play(Animations[currentItem]);
				BuyButton.SetActive(value: true);
				PlayButton.SetActive(value: false);
				price.text = Prices[currentItem].ToString();
				Health.GetComponent<Image>().fillAmount = P_Health[currentItem];
				Damage.GetComponent<Image>().fillAmount = P_Damage[currentItem];
				Sprint.GetComponent<Image>().fillAmount = P_Sprint[currentItem];
			}
			else
			{
				items[currentItem - 1].SetActive(value: false);
				items[currentItem].SetActive(value: true);
				items[currentItem].GetComponent<Animator>().Play(Animations[currentItem]);
				PlayButton.SetActive(value: true);
				BuyButton.SetActive(value: false);
				price.text = Prices[currentItem].ToString();
				Health.GetComponent<Image>().fillAmount = P_Health[currentItem];
				Damage.GetComponent<Image>().fillAmount = P_Damage[currentItem];
				Sprint.GetComponent<Image>().fillAmount = P_Sprint[currentItem];
				price.text = "SELECTED";
			}
		}
	}

	public void PreviousItem()
	{
		if (currentItem > 0)
		{
			currentItem--;
			if (PlayerPrefs.GetInt("item" + items[currentItem].name, 0) == 0)
			{
				items[currentItem + 1].SetActive(value: false);
				items[currentItem].SetActive(value: true);
				items[currentItem].GetComponent<Animator>().Play(Animations[currentItem]);
				BuyButton.SetActive(value: true);
				PlayButton.SetActive(value: false);
				price.text = Prices[currentItem].ToString();
				Health.GetComponent<Image>().fillAmount = P_Health[currentItem];
				Damage.GetComponent<Image>().fillAmount = P_Damage[currentItem];
				Sprint.GetComponent<Image>().fillAmount = P_Sprint[currentItem];
			}
			else
			{
				items[currentItem + 1].SetActive(value: false);
				items[currentItem].SetActive(value: true);
				items[currentItem].GetComponent<Animator>().Play(Animations[currentItem]);
				PlayButton.SetActive(value: true);
				BuyButton.SetActive(value: false);
				price.text = Prices[currentItem].ToString();
				Health.GetComponent<Image>().fillAmount = P_Health[currentItem];
				Damage.GetComponent<Image>().fillAmount = P_Damage[currentItem];
				Sprint.GetComponent<Image>().fillAmount = P_Sprint[currentItem];
				price.text = "SELECTED";
			}
		}
	}

	public void Buy()
	{
		if (PlayerPrefs.GetInt(PlayerPreference) >= Prices[currentItem])
		{
			PlayerPrefs.SetInt("item" + items[currentItem].name, 1);
			PlayerPrefs.SetInt(PlayerPreference, PlayerPrefs.GetInt(PlayerPreference) - Prices[currentItem]);
			BuyButton.SetActive(value: false);
			PlayButton.SetActive(value: true);
			BuyItem = currentItem;
			price.text = "SELECTED";
			Health.GetComponent<Image>().fillAmount = P_Health[currentItem];
			Damage.GetComponent<Image>().fillAmount = P_Damage[currentItem];
			Sprint.GetComponent<Image>().fillAmount = P_Sprint[currentItem];
		}
		else
		{
			return;
			Buy_canvas.SetActive(value: true);
		}
	}

	public void BuyPaid()
	{
		PlayerPrefs.SetInt("item" + items[currentItem].name, 1);
		PlayButton.SetActive(value: true);
		BuyItem = currentItem;
		price.text = "SELECTED";
		Health.GetComponent<Image>().fillAmount = P_Health[currentItem];
		Damage.GetComponent<Image>().fillAmount = P_Damage[currentItem];
		Sprint.GetComponent<Image>().fillAmount = P_Sprint[currentItem];
	}

	public void Play()
	{
		//GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowAd();
		if (PlayerPrefs.GetInt("item" + items[currentItem].name, 0) == 0)
		{
			PlayerPrefs.SetInt("CurrentItemInPlay", BuyItem);
		}
		else
		{
			PlayerPrefs.SetInt("CurrentItemInPlay", currentItem);
		}
		SceneManager.LoadScene(SceneName);
	}

	public void Reset()
	{
		//GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowRewardedAd();
		PlayerPrefs.DeleteAll();
	}

	public void WatchVideo()
	{
	//	GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowRewardedAd();
		Buy_canvas.SetActive(value: false);
	}

	public void HideBuy()
	{
		//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
		Buy_canvas.SetActive(value: false);
	}

	public void back()
	{
		//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
		//BannerAd.showBanner = false;
		SceneManager.LoadScene("MainMenu");
	}
}
