using UnityEngine;
using UnityEngine.UI;

public class img_loading : MonoBehaviour
{
	public GameObject b_g_img;

	public GameObject loading_img;

	private void Start()
	{
		loading_img.GetComponent<Image>().fillAmount = 0f;
	}

	private void Update()
	{
		if (loading_img.GetComponent<Image>().fillAmount == 1f)
		{
			b_g_img.SetActive(value: false);
			loading_img.SetActive(value: false);
		}
	}
}
