using UnityEngine;

public class vLookTarget : MonoBehaviour
{
	public enum VisibleCheckType
	{
		None,
		SingleCast,
		BoxCast
	}

	[Header("Set this to assign a different point to look")]
	public Transform lookPointTarget;

	[Header("Area to check if is visible")]
	public Vector3 centerArea = Vector3.zero;

	public Vector3 sizeArea = Vector3.one;

	public bool useLimitToDetect = true;

	public float minDistanceToDetect = 2f;

	public VisibleCheckType visibleCheckType;

	[Tooltip("use this to turn the object undetectable")]
	public bool HideObject;

	public Vector3 lookPoint
	{
		get
		{
			if ((bool)lookPointTarget)
			{
				return lookPointTarget.position;
			}
			return base.transform.TransformPoint(centerArea);
		}
	}

	private void OnDrawGizmosSelected()
	{
		DrawBox();
	}

	private void Start()
	{
		int layer = LayerMask.NameToLayer("HeadTrack");
		base.gameObject.layer = layer;
	}

	private void DrawBox()
	{
		Gizmos.color = new Color(1f, 0f, 0f, 1f);
		Gizmos.DrawSphere(lookPoint, 0.05f);
		if (visibleCheckType == VisibleCheckType.BoxCast)
		{
			Vector3 lossyScale = base.transform.lossyScale;
			float x = lossyScale.x * sizeArea.x;
			Vector3 lossyScale2 = base.transform.lossyScale;
			float y = lossyScale2.y * sizeArea.y;
			Vector3 lossyScale3 = base.transform.lossyScale;
			float z = lossyScale3.z * sizeArea.z;
			Vector3 lossyScale4 = base.transform.lossyScale;
			float x2 = lossyScale4.x * centerArea.x;
			Vector3 lossyScale5 = base.transform.lossyScale;
			float y2 = lossyScale5.y * centerArea.y;
			Vector3 lossyScale6 = base.transform.lossyScale;
			float z2 = lossyScale6.z * centerArea.z;
			Matrix4x4 matrix4x2 = Gizmos.matrix = Matrix4x4.TRS(base.transform.position + new Vector3(x2, y2, z2), base.transform.rotation, new Vector3(x, y, z) * 2f);
			Gizmos.color = new Color(0f, 1f, 0f, 0.2f);
			Gizmos.DrawCube(Vector3.zero, Vector3.one);
			Gizmos.color = new Color(0f, 1f, 0f, 1f);
			Gizmos.DrawWireCube(Vector3.zero, Vector3.one);
		}
		else if (visibleCheckType == VisibleCheckType.SingleCast)
		{
			Vector3 center = base.transform.TransformPoint(centerArea);
			Gizmos.color = new Color(0f, 1f, 0f, 1f);
			Gizmos.DrawSphere(center, 0.05f);
		}
	}
}
