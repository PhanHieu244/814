using UnityEngine;

namespace Invector
{
	public static class LockOnHelper
	{
		public static Vector2 GetScreenPointOffBoundsCenter(this Transform target, Canvas canvas, Camera cam, float _heightOffset)
		{
			Bounds bounds = target.GetComponent<Collider>().bounds;
			Vector3 center = bounds.center;
			float num = Vector3.Distance(bounds.min, bounds.max);
			Vector3 position = center + new Vector3(0f, num * _heightOffset, 0f);
			RectTransform rectTransform = canvas.transform as RectTransform;
			Vector2 vector = cam.WorldToViewportPoint(position);
			float x = vector.x;
			Vector2 sizeDelta = rectTransform.sizeDelta;
			float num2 = x * sizeDelta.x;
			Vector2 sizeDelta2 = rectTransform.sizeDelta;
			float x2 = num2 - sizeDelta2.x * 0.5f;
			float y = vector.y;
			Vector2 sizeDelta3 = rectTransform.sizeDelta;
			float num3 = y * sizeDelta3.y;
			Vector2 sizeDelta4 = rectTransform.sizeDelta;
			Vector2 result = new Vector2(x2, num3 - sizeDelta4.y * 0.5f);
			return result;
		}

		public static Vector3 GetPointOffBoundsCenter(this Transform target, float _heightOffset)
		{
			Bounds bounds = target.GetComponent<Collider>().bounds;
			Vector3 center = bounds.center;
			float num = Vector3.Distance(bounds.min, bounds.max);
			return center + new Vector3(0f, num * _heightOffset, 0f);
		}
	}
}
