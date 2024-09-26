using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Camera-Control/SmoothCameraAdvanced")]
internal class SmoothCameraAdvanced : MonoBehaviour
{
	public enum MovementType
	{
		Instant,
		LinearInterpolation,
		SphericalLinearInterpolation
	}

	private static SmoothCameraAdvanced instance;

	private Transform ourCameraTransform;

	[SerializeField]
	private Transform target;

	[SerializeField]
	public CameraBumper bumper;

	[SerializeField]
	private List<CameraControl> controls = new List<CameraControl>();

	[SerializeField]
	private Vector3 lookAtOffset;

	private Vector3 runtimeOffset = Vector3.zero;

	[SerializeField]
	private MovementType rotationType = MovementType.SphericalLinearInterpolation;

	[SerializeField]
	private MovementType translationType = MovementType.SphericalLinearInterpolation;

	[SerializeField]
	private LimitedFloat distance = new LimitedFloat(3f, 1f, 10f);

	[SerializeField]
	private LimitedFloat height = new LimitedFloat(1f, 1f, 5f);

	[SerializeField]
	private LimitedFloat panX = new LimitedFloat(0f, -1f, 1f);

	[SerializeField]
	private LimitedFloat panY = new LimitedFloat(0f, 0f, 2f);

	[SerializeField]
	private float damping = 5f;

	[SerializeField]
	private float rotationDamping = 10f;

	public static SmoothCameraAdvanced Instance
	{
		get
		{
			if (instance == null)
			{
				instance = (Object.FindObjectOfType(typeof(SmoothCameraAdvanced)) as SmoothCameraAdvanced);
			}
			if (instance == null && Camera.main != null)
			{
				instance = (Camera.main.gameObject.AddComponent(typeof(SmoothCameraAdvanced)) as SmoothCameraAdvanced);
			}
			return instance;
		}
	}

	private static Transform CameraTransform
	{
		get
		{
			if (Instance.ourCameraTransform == null)
			{
				Instance.ourCameraTransform = Instance.transform;
				Bumper.Ignores.Add(Instance.ourCameraTransform);
			}
			return Instance.ourCameraTransform;
		}
	}

	public static Transform Target
	{
		get
		{
			return Instance.target;
		}
		set
		{
			Bumper.Ignores.Remove(Instance.target);
			Instance.target = value;
			Bumper.Ignores.Add(Instance.target);
		}
	}

	public static CameraBumper Bumper
	{
		get
		{
			return Instance.bumper;
		}
		set
		{
			Instance.bumper = value;
		}
	}

	public static List<CameraControl> Controls
	{
		get
		{
			return Instance.controls;
		}
		set
		{
			Instance.controls = value;
		}
	}

	public static Vector3 LookAtOffset
	{
		get
		{
			return Instance.lookAtOffset;
		}
		set
		{
			Instance.lookAtOffset = value;
		}
	}

	private static Vector3 RuntimeOffset
	{
		get
		{
			return new Vector3(PanX.Current, PanY.Current, 0f);
		}
		set
		{
			PanX.Current = value.x;
		}
	}

	private static MovementType RotationType
	{
		get
		{
			return Instance.rotationType;
		}
		set
		{
			Instance.rotationType = value;
		}
	}

	public static MovementType TranslationType
	{
		get
		{
			return Instance.translationType;
		}
		set
		{
			Instance.translationType = value;
		}
	}

	public static LimitedFloat Distance
	{
		get
		{
			return Instance.distance;
		}
		set
		{
			Instance.distance = value;
		}
	}

	public static LimitedFloat Height
	{
		get
		{
			return Instance.height;
		}
		set
		{
			Instance.height = value;
		}
	}

	public static LimitedFloat PanX
	{
		get
		{
			return Instance.panX;
		}
		set
		{
			Instance.panX = value;
		}
	}

	public static LimitedFloat PanY
	{
		get
		{
			return Instance.panY;
		}
		set
		{
			Instance.panY = value;
		}
	}

	public static float Damping
	{
		get
		{
			return Instance.damping;
		}
		set
		{
			Instance.damping = value;
		}
	}

	public static float RotationDamping
	{
		get
		{
			return Instance.rotationDamping;
		}
		set
		{
			Instance.rotationDamping = value;
		}
	}

	private void Reset()
	{
		Controls.Add(new CameraControl(TargetEnum.Distance, MouseCodeEnum.ScrollWheel, 2f));
		Controls.Add(new CameraControl(TargetEnum.Height, MouseCodeEnum.ScrollWheel, 1f));
		Controls.Add(new CameraControl(TargetEnum.PanY, MouseCodeEnum.ScrollWheel, 0.5f));
		Controls.Add(new CameraControl(TargetEnum.PanX, KeyCode.LeftArrow, -1f));
		Controls.Add(new CameraControl(TargetEnum.PanX, KeyCode.RightArrow, 1f));
	}

	private void Awake()
	{
		if ((bool)target)
		{
			FocusOn(target);
		}
	}

	public void Update()
	{
		UpdateControls();
		UpdateCameraPosition();
	}

	private void UpdateControls()
	{
		foreach (CameraControl control in controls)
		{
			if (control.Value != 0f)
			{
				switch (control.Target)
				{
				case TargetEnum.Distance:
					Distance += control.Value;
					break;
				case TargetEnum.Height:
					Height += control.Value;
					break;
				case TargetEnum.PanX:
					PanX += control.Value;
					break;
				case TargetEnum.PanY:
					PanY += control.Value;
					break;
				}
			}
		}
	}

	private void UpdateCameraPosition()
	{
		Vector3 vector = target.TransformPoint(PanX.Current, height.Current, 0f - distance.Current);
		if (vector != CameraTransform.position)
		{
			vector = Bumper.UpdatePosition(target, CameraTransform, vector, Time.deltaTime * damping);
			switch (translationType)
			{
			case MovementType.Instant:
				CameraTransform.position = vector;
				break;
			case MovementType.LinearInterpolation:
				CameraTransform.position = Vector3.Lerp(CameraTransform.position, vector, Time.deltaTime * damping);
				break;
			case MovementType.SphericalLinearInterpolation:
				CameraTransform.position = Vector3.Slerp(CameraTransform.position, vector, Time.deltaTime * damping);
				break;
			}
			Vector3 a = target.TransformPoint(lookAtOffset + RuntimeOffset);
			Quaternion b = Quaternion.LookRotation(a - CameraTransform.position, target.up);
			switch (rotationType)
			{
			case MovementType.Instant:
				CameraTransform.rotation = Quaternion.LookRotation(a - CameraTransform.position, target.up);
				break;
			case MovementType.LinearInterpolation:
				CameraTransform.rotation = Quaternion.Lerp(CameraTransform.rotation, b, Time.deltaTime * rotationDamping);
				break;
			case MovementType.SphericalLinearInterpolation:
				CameraTransform.rotation = Quaternion.Slerp(CameraTransform.rotation, b, Time.deltaTime * rotationDamping);
				break;
			}
		}
	}

	public static void FocusOn(Transform argTarget)
	{
		Target = argTarget;
		CameraTransform.parent = Target;
		PropsUnityObject propsUnityObject = Target.GetComponent(typeof(PropsUnityObject)) as PropsUnityObject;
		if ((bool)propsUnityObject)
		{
			Vector3 size = propsUnityObject.Renderer.bounds.size;
			float y = size.y;
			LookAtOffset = Vector3.up * y;
			Height.Current = y + 0.5f;
			Distance.Current = y + 1f;
			PanY.Current = 0f;
			PanX.Current = 0f;
		}
	}

	public static void ResetPosition()
	{
		PropsUnityObject propsUnityObject = Target.GetComponent(typeof(PropsUnityObject)) as PropsUnityObject;
		Vector3 size = propsUnityObject.Renderer.bounds.size;
		float y = size.y;
		LookAtOffset = Vector3.up * y;
		PanX.Current = 0f;
	}
}
