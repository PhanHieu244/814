using LitJson;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CallForData : MonoBehaviour
{
	public class parseJSON
	{
		public static string title;

		public static ArrayList icon;

		public static ArrayList link;

		public static List<Sprite> IconImages;

		public static List<Sprite> BackImages;

		public static ArrayList BackImageLink;
	}

	public static bool Fetched;

	private JsonData jsonvale;

	public GameObject CPShort;

	public GameObject JSONHandler;

	public GameObject CrossPromotionScroller;

	public string CurrentAppPackageName;

	public bool DataDone;

	public void Start()
	{
		DataDone = false;
		if (!Fetched)
		{
			StartCoroutine(FetchData());
			Fetched = true;
		}
		else
		{
			CPShort.SetActive(value: true);
			JSONHandler.GetComponent<JsonScrollHandler>().enabled = true;
		}
	}

	private IEnumerator FetchData()
	{
		MonoBehaviour.print("Fetching data");
		string url = "http://wp.com";
		WWW www = new WWW(url);
		yield return www;
		if (www.error == null)
		{
			Processjson(www.text);
			yield break;
		}
		Debug.Log("ERROR: " + www.error);
		CPShort.SetActive(value: false);
		CrossPromotionScroller.SetActive(value: false);
	}

	private void Processjson(string jsonString)
	{
		MonoBehaviour.print("Process Data");
		jsonvale = JsonMapper.ToObject(jsonString);
		parseJSON.title = jsonvale["title"].ToString();
		parseJSON.icon = new ArrayList();
		parseJSON.link = new ArrayList();
		parseJSON.BackImageLink = new ArrayList();
		parseJSON.IconImages = new List<Sprite>();
		parseJSON.BackImages = new List<Sprite>();
		for (int i = 0; i < jsonvale["games"].Count; i++)
		{
			if (jsonvale["games"][i]["packagename"].ToString() == CurrentAppPackageName)
			{
				MonoBehaviour.print("Skip Data");
				continue;
			}
			MonoBehaviour.print("ADD Data");
			parseJSON.icon.Add(jsonvale["games"][i]["icon"].ToString());
			parseJSON.link.Add(jsonvale["games"][i]["linkofgame"].ToString());
			parseJSON.BackImageLink.Add(jsonvale["games"][i]["image"].ToString());
		}
		DataDone = true;
		StartCoroutine(CallConvertToSprite());
	}

	private IEnumerator CallConvertToSprite()
	{
		MonoBehaviour.print("ConvertTospriteCall");
		yield return new WaitUntil(() => DataDone);
		StartCoroutine(ConvertToSprite());
		StartCoroutine(ConvertToSpriteBackImage());
	}

	private IEnumerator ConvertToSprite()
	{
		MonoBehaviour.print("ConvertTosprite");
		for (int i = 0; i < parseJSON.icon.Count; i++)
		{
			WWW www = new WWW(parseJSON.icon[i].ToString());
			yield return www;
			parseJSON.IconImages.Add(Sprite.Create(www.texture, new Rect(0f, 0f, www.texture.width, www.texture.height), new Vector2(0f, 0f)));
		}
		CPShort.SetActive(value: true);
	}

	private IEnumerator ConvertToSpriteBackImage()
	{
		MonoBehaviour.print("ConvertTospriteBackImage");
		for (int i = 0; i < parseJSON.icon.Count; i++)
		{
			WWW www = new WWW(parseJSON.BackImageLink[i].ToString());
			yield return www;
			parseJSON.BackImages.Add(Sprite.Create(www.texture, new Rect(0f, 0f, www.texture.width, www.texture.height), new Vector2(0f, 0f)));
		}
		MonoBehaviour.print("Scroller Turn on");
		CrossPromotionScroller.SetActive(value: true);
		JSONHandler.GetComponent<JsonScrollHandler>().enabled = true;
	}
}
