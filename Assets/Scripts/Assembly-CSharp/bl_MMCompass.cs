using UnityEngine;

public class bl_MMCompass : MonoBehaviour
{
	[Tooltip("This target can be null, this will be take the same target of minimap")]
	public Transform Target;

	[Space(7f)]
	public RectTransform CompassRoot;

	public RectTransform North;

	public RectTransform South;

	public RectTransform East;

	public RectTransform West;

	[HideInInspector]
	public int Grade;

	private int Opposite;

	private Transform t;

	private Transform m_Transform
	{
		get
		{
			if (t == null)
			{
				t = GetComponent<Transform>();
			}
			return t;
		}
	}

	private void Start()
	{
		if (Target == null && GetComponent<bl_MiniMap>() != null)
		{
			Target = GetComponent<bl_MiniMap>().Target;
		}
	}

	private void Update()
	{
		if (Target != null)
		{
			Vector3 eulerAngles = Target.eulerAngles;
			Opposite = (int)Mathf.Abs(eulerAngles.y);
		}
		else
		{
			Vector3 eulerAngles2 = m_Transform.eulerAngles;
			Opposite = (int)Mathf.Abs(eulerAngles2.y);
		}
		if (Opposite > 360)
		{
			Opposite %= 360;
		}
		Grade = Opposite;
		if (Grade > 180)
		{
			Grade -= 360;
		}
		RectTransform north = North;
		Vector2 sizeDelta = CompassRoot.sizeDelta;
		float num = sizeDelta.x * 0.5f - (float)(Grade * 2);
		Vector2 sizeDelta2 = CompassRoot.sizeDelta;
		north.anchoredPosition = new Vector2(num - sizeDelta2.x * 0.5f, 0f);
		RectTransform south = South;
		Vector2 sizeDelta3 = CompassRoot.sizeDelta;
		float num2 = sizeDelta3.x * 0.5f - (float)(Opposite * 2) + 360f;
		Vector2 sizeDelta4 = CompassRoot.sizeDelta;
		south.anchoredPosition = new Vector2(num2 - sizeDelta4.x * 0.5f, 0f);
		RectTransform east = East;
		Vector2 sizeDelta5 = CompassRoot.sizeDelta;
		float num3 = sizeDelta5.x * 0.5f - (float)(Grade * 2) + 180f;
		Vector2 sizeDelta6 = CompassRoot.sizeDelta;
		east.anchoredPosition = new Vector2(num3 - sizeDelta6.x * 0.5f, 0f);
		RectTransform west = West;
		Vector2 sizeDelta7 = CompassRoot.sizeDelta;
		float num4 = sizeDelta7.x * 0.5f - (float)(Opposite * 2) + 540f;
		Vector2 sizeDelta8 = CompassRoot.sizeDelta;
		west.anchoredPosition = new Vector2(num4 - sizeDelta8.x * 0.5f, 0f);
	}
}
