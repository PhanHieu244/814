using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class AutoScrollVertical : MonoBehaviour
{
	private ScrollRect sr;

	private RectTransform contentRect;

	public void Awake()
	{
		sr = base.gameObject.GetComponent<ScrollRect>();
		if ((bool)sr)
		{
			contentRect = sr.content;
		}
	}

	private void Update()
	{
		OnUpdateSelected();
	}

	public void OnUpdateSelected()
	{
		GameObject currentSelectedGameObject = EventSystem.current.currentSelectedGameObject;
		if (currentSelectedGameObject == null || currentSelectedGameObject.transform.parent != contentRect.transform)
		{
			return;
		}
		float height = sr.content.rect.height;
		float height2 = sr.viewport.rect.height;
		Vector3 localPosition = currentSelectedGameObject.transform.localPosition;
		float y = localPosition.y;
		float num = y + currentSelectedGameObject.GetComponent<RectTransform>().rect.height / 2f;
		float num2 = y - currentSelectedGameObject.GetComponent<RectTransform>().rect.height / 2f;
		float num3 = height - height2;
		Vector2 normalizedPosition = sr.normalizedPosition;
		float num4 = num3 * normalizedPosition.y - height * 0.5f;
		float num5 = num4 + height2;
		float num6;
		if (num > num5)
		{
			num6 = num - height2 + currentSelectedGameObject.GetComponent<RectTransform>().rect.height;
		}
		else
		{
			if (!(num2 < num4))
			{
				return;
			}
			num6 = num2 - currentSelectedGameObject.GetComponent<RectTransform>().rect.height;
		}
		float value = (num6 + height) / (height - height2);
		Vector2 b = new Vector2(0f, Mathf.Clamp01(value));
		sr.normalizedPosition = Vector2.Lerp(sr.normalizedPosition, b, 10f * Time.fixedDeltaTime);
	}
}
