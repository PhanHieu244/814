using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class JsonScrollHandler : MonoBehaviour
{
	public GameObject ScrollViewContent;

	public GameObject Button_instantiate;

	public GameObject CP_Panel;

	private void Start()
	{
		StartCoroutine(LoadScrollView());
	}

	private IEnumerator LoadScrollView()
	{
		if (CallForData.parseJSON.BackImages != null)
		{
			for (int i = 0; i < CallForData.parseJSON.BackImageLink.Count; i++)
			{
				GameObject TempGameObject = UnityEngine.Object.Instantiate(Button_instantiate, ScrollViewContent.transform);
				TempGameObject.gameObject.name = i.ToString();
				yield return new WWW(CallForData.parseJSON.BackImageLink[i].ToString());
				TempGameObject.GetComponent<Image>().sprite = CallForData.parseJSON.BackImages[i];
				TempGameObject.GetComponent<Button>().onClick.AddListener(ClickOnScrollView);
			}
		}
	}

	public void ClickOnScrollView()
	{
		Application.OpenURL(CallForData.parseJSON.link[Convert.ToInt16(EventSystem.current.currentSelectedGameObject.name)].ToString());
	}

	private void Update()
	{
	}
}
