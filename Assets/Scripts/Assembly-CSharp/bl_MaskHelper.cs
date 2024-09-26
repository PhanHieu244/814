using UnityEngine;
using UnityEngine.UI;

public class bl_MaskHelper : MonoBehaviour
{
	public Sprite MiniMapMask;

	public Sprite WorldMapMask;

	[Space(5f)]
	public Image Background;

	public Sprite MiniMapBackGround;

	public Sprite WorldMapBackGround;

	private Image _image;

	private Image m_image
	{
		get
		{
			if (_image == null)
			{
				_image = GetComponent<Image>();
			}
			return _image;
		}
	}

	private void Start()
	{
		m_image.sprite = MiniMapMask;
	}

	public void OnChange(bool full = false)
	{
		if (full)
		{
			m_image.sprite = WorldMapMask;
			if (Background != null)
			{
				Background.sprite = WorldMapBackGround;
			}
		}
		else
		{
			m_image.sprite = MiniMapMask;
			if (Background != null)
			{
				Background.sprite = MiniMapBackGround;
			}
		}
	}
}
