using UnityEngine;

[ExecuteInEditMode]
public class CameraTarget : MonoBehaviour
{
	public Transform m_TargetOffset;

	private void LateUpdate()
	{
		base.transform.LookAt(m_TargetOffset);
	}
}
