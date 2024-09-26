using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class bl_MiniMap : MonoBehaviour
{
	[Serializable]
	public enum RenderType
	{
		RealTime,
		Picture
	}

	[Serializable]
	public enum RenderMode
	{
		Mode2D,
		Mode3D
	}

	[Separator("General Settings")]
	public GameObject m_Target;

	public string LevelName;

	[Tooltip("Keycode to toggle map size mode (world and mini map)")]
	public KeyCode ToogleKey = KeyCode.E;

	public Camera MMCamera;

	public RenderType m_Type = RenderType.Picture;

	public RenderMode m_Mode;

	[Separator("UI")]
	public Canvas m_Canvas;

	public RectTransform MMUIRoot;

	public Image PlayerIcon;

	[SerializeField]
	private GameObject ItemPrefab;

	public Dictionary<string, Transform> ItemsList = new Dictionary<string, Transform>();

	[Separator("Height")]
	[Tooltip("How much should we move for each small movement on the mouse wheel?")]
	public int scrollSensitivity = 3;

	[Tooltip("Maximum heights that the camera can reach.")]
	public float maxHeight = 80f;

	[Tooltip("Minimum heights that the camera can reach.")]
	public float minHeight = 5f;

	public KeyCode IncreaseHeightKey = KeyCode.KeypadPlus;

	public KeyCode DecreaseHeightKey = KeyCode.KeypadMinus;

	private float height = 30f;

	[Range(1f, 15f)]
	[Tooltip("Smooth speed to height change.")]
	public float LerpHeight = 8f;

	[Separator("Rotation")]
	[Tooltip("Compass rotation for circle maps, rotate icons around pivot.")]
	public bool useCompassRotation;

	[Range(25f, 500f)]
	[Tooltip("Size of Compass rotation diametre.")]
	public float CompassSize = 175f;

	[Tooltip("Should the minimap rotate with the player?")]
	public bool DynamicRotation = true;

	[Tooltip("this work only is dynamic rotation.")]
	public bool SmoothRotation = true;

	[Range(1f, 15f)]
	public float LerpRotation = 8f;

	[Separator("Animations")]
	public bool ShowLevelName = true;

	public bool ShowPanelInfo = true;

	[Range(0.1f, 5f)]
	public float HitEffectSpeed = 1.5f;

	[SerializeField]
	private Animator BottonAnimator;

	[SerializeField]
	private Animator PanelInfoAnimator;

	[SerializeField]
	private Animator HitEffectAnimator;

	[Separator("Map Rect")]
	[Tooltip("Position for World Map.")]
	public Vector3 FullMapPosition = Vector2.zero;

	[Tooltip("Rotation for World Map.")]
	public Vector3 FullMapRotation = Vector3.zero;

	[Tooltip("Size of World Map.")]
	public Vector2 FullMapSize = Vector2.zero;

	private Vector3 MiniMapPosition = Vector2.zero;

	private Vector3 MiniMapRotation = Vector3.zero;

	private Vector2 MiniMapSize = Vector2.zero;

	[Space(5f)]
	[Tooltip("Smooth Speed for MiniMap World Map transition.")]
	public float LerpTransition = 7f;

	[Space(5f)]
	[InspectorButton("GetFullMapSize")]
	public string GetWorldRect = string.Empty;

	[Separator("Picture Mode Settings")]
	[Tooltip("Texture for MiniMap renderer, you can take a snaphot from map.")]
	public Texture MapTexture;

	public Color TintColor = new Color(1f, 1f, 1f, 0.9f);

	public Color SpecularColor = new Color(1f, 1f, 1f, 0.9f);

	public Color EmessiveColor = new Color(0f, 0f, 0f, 0.9f);

	[Range(0.1f, 4f)]
	public float EmissionAmount = 1f;

	[SerializeField]
	private Material ReferenceMat;

	[Space(3f)]
	public GameObject MapPlane;

	public RectTransform WorldSpace;

	public static bool isFullScreen;

	public static Camera MiniMapCamera;

	public static RectTransform MapUIRoot;

	public const string MiniMapLayer = "MiniMap";

	private bool DefaultRotationMode;

	private Vector3 DeafultMapRot = Vector3.zero;

	private bool DefaultRotationCircle;

	private const string MMHeightKey = "MinimapCameraHeight";

	private Transform t;

	private bl_MaskHelper _maskHelper;

	public Transform Target
	{
		get
		{
			if (m_Target != null)
			{
				return m_Target.GetComponent<Transform>();
			}
			return GetComponent<Transform>();
		}
	}

	public Vector3 TargetPosition
	{
		get
		{
			Vector3 result = Vector3.zero;
			if (m_Target != null)
			{
				result = m_Target.transform.position;
			}
			return result;
		}
	}

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

	private bl_MaskHelper m_maskHelper
	{
		get
		{
			if (_maskHelper == null)
			{
				_maskHelper = base.transform.root.GetComponentInChildren<bl_MaskHelper>();
			}
			return _maskHelper;
		}
	}

	private void Awake()
	{
		GetMiniMapSize();
		MiniMapCamera = MMCamera;
		MapUIRoot = MMUIRoot;
		DefaultRotationMode = DynamicRotation;
		DeafultMapRot = m_Transform.eulerAngles;
		DefaultRotationCircle = useCompassRotation;
		if (m_Type == RenderType.Picture)
		{
			CreateMapPlane();
		}
		if (m_Mode == RenderMode.Mode3D)
		{
			ConfigureCamera3D();
		}
		height = PlayerPrefs.GetFloat("MinimapCameraHeight", height);
	}

	private void CreateMapPlane()
	{
		string a = LayerMask.LayerToName(10);
		if (a != "MiniMap")
		{
			Debug.LogError("MiniMap has not defined in Layer Mask list, please added this in place No. 10");
			MMUIRoot.gameObject.SetActive(value: false);
			base.enabled = false;
		}
		if (MapTexture == null)
		{
			Debug.LogError("Map Texture has not been allocated.");
			return;
		}
		Vector3 localPosition = WorldSpace.localPosition;
		Vector3 vector = WorldSpace.sizeDelta;
		MMCamera.cullingMask = 1024;
		GameObject gameObject = UnityEngine.Object.Instantiate(MapPlane);
		gameObject.transform.localPosition = localPosition;
		gameObject.transform.localScale = new Vector3(vector.x, 10f, vector.y) / 10f;
		gameObject.GetComponent<Renderer>().material = CreateMaterial();
	}

	public void ConfigureCamera3D()
	{
		Camera camera = (!(Camera.main != null)) ? Camera.current : Camera.main;
		if (camera == null)
		{
			Debug.LogWarning("Not to have found a camera to configure,please assign this.");
			return;
		}
		m_Canvas.worldCamera = camera;
		camera.nearClipPlane = 0.015f;
		m_Canvas.planeDistance = 0.1f;
	}

	private void Update()
	{
		m_Target = GameObject.FindGameObjectWithTag("follow_this");
		if (!(MMCamera == null))
		{
			Inputs();
			PositionControll();
			RotationControll();
			MapSize();
		}
	}

	private void PositionControll()
	{
		Vector3 position = m_Transform.position;
		Vector3 position2 = Target.position;
		position.x = position2.x;
		Vector3 position3 = Target.position;
		position.z = position3.z;
		if (Target != null)
		{
			Vector3 viewPoint = MMCamera.WorldToViewportPoint(TargetPosition);
			PlayerIcon.rectTransform.anchoredPosition = bl_MiniMapUtils.CalculateMiniMapPosition(viewPoint, MapUIRoot);
		}
		float num = maxHeight + minHeight / 2f;
		Vector3 position4 = Target.position;
		position.y = num + position4.y * 2f;
		m_Transform.position = Vector3.Lerp(m_Transform.position, position, Time.deltaTime * 10f);
	}

	private void RotationControll()
	{
		RectTransform component = PlayerIcon.GetComponent<RectTransform>();
		if (DynamicRotation)
		{
			Vector3 eulerAngles = m_Transform.eulerAngles;
			Vector3 eulerAngles2 = Target.eulerAngles;
			eulerAngles.y = eulerAngles2.y;
			if (SmoothRotation)
			{
				if (m_Mode == RenderMode.Mode2D)
				{
					component.rotation = Quaternion.identity;
				}
				else
				{
					component.localRotation = Quaternion.identity;
				}
				Vector3 eulerAngles3 = m_Transform.eulerAngles;
				if (eulerAngles3.y != eulerAngles.y)
				{
					float y = eulerAngles.y;
					Vector3 eulerAngles4 = m_Transform.eulerAngles;
					float num = y - eulerAngles4.y;
					if (num > 180f || num < -180f)
					{
						m_Transform.eulerAngles = eulerAngles;
					}
				}
				m_Transform.eulerAngles = Vector3.Lerp(base.transform.eulerAngles, eulerAngles, Time.deltaTime * LerpRotation);
			}
			else
			{
				m_Transform.eulerAngles = eulerAngles;
			}
		}
		else
		{
			m_Transform.eulerAngles = DeafultMapRot;
			if (m_Mode == RenderMode.Mode2D)
			{
				Vector3 zero = Vector3.zero;
				Vector3 eulerAngles5 = Target.eulerAngles;
				zero.z = 0f - eulerAngles5.y;
				component.eulerAngles = zero;
			}
			else
			{
				Vector3 localEulerAngles = Target.localEulerAngles;
				Vector3 zero2 = Vector3.zero;
				zero2.z = 0f - localEulerAngles.y;
				component.localEulerAngles = zero2;
			}
		}
	}

	private void Inputs()
	{
		if (Input.GetKeyDown(ToogleKey))
		{
			ToggleSize();
		}
		if (Input.GetKeyDown(DecreaseHeightKey) && height < maxHeight)
		{
			ChangeHeight(b: true);
		}
		if (Input.GetKeyDown(IncreaseHeightKey) && height > minHeight)
		{
			ChangeHeight(b: false);
		}
	}

	private void MapSize()
	{
		RectTransform mMUIRoot = MMUIRoot;
		if (isFullScreen)
		{
			if (DynamicRotation)
			{
				DynamicRotation = false;
				ResetMapRotation();
			}
			mMUIRoot.sizeDelta = Vector2.Lerp(mMUIRoot.sizeDelta, FullMapSize, Time.deltaTime * LerpTransition);
			mMUIRoot.anchoredPosition = Vector3.Lerp(mMUIRoot.anchoredPosition, FullMapPosition, Time.deltaTime * LerpTransition);
			mMUIRoot.localEulerAngles = Vector3.Lerp(mMUIRoot.localEulerAngles, FullMapRotation, Time.deltaTime * LerpTransition);
		}
		else
		{
			if (DynamicRotation != DefaultRotationMode)
			{
				DynamicRotation = DefaultRotationMode;
			}
			mMUIRoot.sizeDelta = Vector2.Lerp(mMUIRoot.sizeDelta, MiniMapSize, Time.deltaTime * LerpTransition);
			mMUIRoot.anchoredPosition = Vector3.Lerp(mMUIRoot.anchoredPosition, MiniMapPosition, Time.deltaTime * LerpTransition);
			mMUIRoot.localEulerAngles = Vector3.Lerp(mMUIRoot.localEulerAngles, MiniMapRotation, Time.deltaTime * LerpTransition);
		}
		MMCamera.orthographicSize = Mathf.Lerp(MMCamera.orthographicSize, height, Time.deltaTime * LerpHeight);
	}

	private void ToggleSize()
	{
		isFullScreen = !isFullScreen;
		if (isFullScreen)
		{
			height = maxHeight;
			useCompassRotation = false;
			if ((bool)m_maskHelper)
			{
				m_maskHelper.OnChange(full: true);
			}
		}
		else
		{
			height = PlayerPrefs.GetFloat("MinimapCameraHeight", height);
			if (useCompassRotation != DefaultRotationCircle)
			{
				useCompassRotation = DefaultRotationCircle;
			}
			if ((bool)m_maskHelper)
			{
				m_maskHelper.OnChange();
			}
		}
		int value = isFullScreen ? 1 : 2;
		if (BottonAnimator != null && ShowLevelName)
		{
			if (!BottonAnimator.gameObject.activeSelf)
			{
				BottonAnimator.gameObject.SetActive(value: true);
			}
			if (BottonAnimator.transform.GetComponentInChildren<Text>() != null)
			{
				BottonAnimator.transform.GetComponentInChildren<Text>().text = LevelName;
			}
			BottonAnimator.SetInteger("state", value);
		}
		else if (BottonAnimator != null)
		{
			BottonAnimator.gameObject.SetActive(value: false);
		}
		if (PanelInfoAnimator != null && ShowPanelInfo)
		{
			if (!PanelInfoAnimator.gameObject.activeSelf)
			{
				PanelInfoAnimator.gameObject.SetActive(value: true);
			}
			PanelInfoAnimator.SetInteger("show", value);
		}
		else if (PanelInfoAnimator != null)
		{
			PanelInfoAnimator.gameObject.SetActive(value: false);
		}
	}

	public void ChangeHeight(bool b)
	{
		if (b)
		{
			if (height + (float)scrollSensitivity <= maxHeight)
			{
				height += scrollSensitivity;
			}
			else
			{
				height = maxHeight;
			}
		}
		else if (height - (float)scrollSensitivity >= minHeight)
		{
			height -= scrollSensitivity;
		}
		else
		{
			height = minHeight;
		}
		PlayerPrefs.SetFloat("MinimapCameraHeight", height);
	}

	public void DoHitEffect()
	{
		if (HitEffectAnimator == null)
		{
			Debug.LogWarning("Please assign Hit animator for play effect!");
			return;
		}
		HitEffectAnimator.speed = HitEffectSpeed;
		HitEffectAnimator.Play("HitEffect", 0, 0f);
	}

	public Material CreateMaterial()
	{
		Material material = new Material(ReferenceMat);
		material.mainTexture = MapTexture;
		material.SetTexture("_EmissionMap", MapTexture);
		material.SetFloat("_EmissionScaleUI", EmissionAmount);
		material.SetColor("_EmissionColor", EmessiveColor);
		material.SetColor("_SpecColor", SpecularColor);
		return material;
	}

	public void CreateNewItem(bl_MMItemInfo item)
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(ItemPrefab, item.Position, Quaternion.identity);
		bl_MiniMapItem component = gameObject.GetComponent<bl_MiniMapItem>();
		if (item.Target != null)
		{
			component.Target = item.Target;
		}
		component.Size = item.Size;
		component.IconColor = item.Color;
		component.isInteractable = item.Interactable;
		component.m_Effect = item.Effect;
		if (item.Sprite != null)
		{
			component.Icon = item.Sprite;
		}
	}

	private void ResetMapRotation()
	{
		m_Transform.eulerAngles = new Vector3(90f, 0f, 0f);
	}

	public void RotationMap(bool mode)
	{
		if (!isFullScreen)
		{
			DynamicRotation = mode;
			DefaultRotationMode = DynamicRotation;
		}
	}

	public void ChangeMapSize(bool fullscreen)
	{
		isFullScreen = fullscreen;
	}

	private void GetMiniMapSize()
	{
		MiniMapSize = MMUIRoot.sizeDelta;
		MiniMapPosition = MMUIRoot.anchoredPosition;
		MiniMapRotation = MMUIRoot.eulerAngles;
	}

	[ContextMenu("GetFullMapRect")]
	private void GetFullMapSize()
	{
		FullMapSize = MMUIRoot.sizeDelta;
		FullMapPosition = MMUIRoot.anchoredPosition;
		FullMapRotation = MMUIRoot.eulerAngles;
	}
}
