using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class JsonConvert : MonoBehaviour
{
	private int count;

	private bool TurnOnStart;

	private void Start()
	{
		StartCoroutine(LoadOthers());
	}

	private IEnumerator LoadOthers()
	{
		yield return new WaitForSeconds(2f);
		if (CallForData.parseJSON.icon[count] != null && count < CallForData.parseJSON.icon.Count)
		{
			GameObject.FindGameObjectWithTag("CPButton").GetComponent<Image>().sprite = CallForData.parseJSON.IconImages[count];
			if (count != CallForData.parseJSON.icon.Count - 1)
			{
				count++;
			}
			else
			{
				count = 0;
			}
		}
		StartCoroutine(LoadOthers());
	}

	public void CrossPromotionClick()
	{
		if (count == 0)
		{
			Application.OpenURL(CallForData.parseJSON.link[count].ToString());
		}
		else
		{
			Application.OpenURL(CallForData.parseJSON.link[count - 1].ToString());
		}
	}

	public void NAVIG(string name)
	{
		Application.LoadLevel(name);
	}
}
