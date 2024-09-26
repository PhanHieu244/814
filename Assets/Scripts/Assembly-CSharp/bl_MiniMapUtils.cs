using UnityEngine;

public static class bl_MiniMapUtils
{
	public static Vector3 CalculateMiniMapPosition(Vector3 viewPoint, RectTransform maxAnchor)
	{
		float x = viewPoint.x;
		Vector2 sizeDelta = maxAnchor.sizeDelta;
		float num = x * sizeDelta.x;
		Vector2 sizeDelta2 = maxAnchor.sizeDelta;
		float x2 = num - sizeDelta2.x * 0.5f;
		float y = viewPoint.y;
		Vector2 sizeDelta3 = maxAnchor.sizeDelta;
		float num2 = y * sizeDelta3.y;
		Vector2 sizeDelta4 = maxAnchor.sizeDelta;
		viewPoint = new Vector2(x2, num2 - sizeDelta4.y * 0.5f);
		return viewPoint;
	}
}
