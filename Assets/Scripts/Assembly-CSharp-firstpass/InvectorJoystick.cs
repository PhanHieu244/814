using UnityEngine;
using UnityEngine.EventSystems;
using UnityStandardAssets.CrossPlatformInput;

public class InvectorJoystick : MonoBehaviour, IPointerDownHandler, IPointerUpHandler, IDragHandler, IEventSystemHandler
{
	public enum AxisOption
	{
		Both,
		OnlyHorizontal,
		OnlyVertical
	}

	public int MovementRange = 100;

	public AxisOption axesToUse;

	public string horizontalAxisName = "Horizontal";

	public string verticalAxisName = "Vertical";

	private Vector3 m_StartPos;

	private bool m_UseX;

	private bool m_UseY;

	private CrossPlatformInputManager.VirtualAxis m_HorizontalVirtualAxis;

	private CrossPlatformInputManager.VirtualAxis m_VerticalVirtualAxis;

	private void Start()
	{
		m_StartPos = base.transform.position;
		CreateVirtualAxes();
	}

	private void UpdateVirtualAxes(Vector3 value)
	{
		Vector3 vector = m_StartPos - value;
		vector.y = 0f - vector.y;
		vector /= (float)MovementRange;
		if (m_UseX)
		{
			m_HorizontalVirtualAxis.Update(0f - vector.x);
		}
		if (m_UseY)
		{
			m_VerticalVirtualAxis.Update(vector.y);
		}
	}

	private void CreateVirtualAxes()
	{
		m_UseX = (axesToUse == AxisOption.Both || axesToUse == AxisOption.OnlyHorizontal);
		m_UseY = (axesToUse == AxisOption.Both || axesToUse == AxisOption.OnlyVertical);
		if (m_UseX)
		{
			m_HorizontalVirtualAxis = new CrossPlatformInputManager.VirtualAxis(horizontalAxisName);
			CrossPlatformInputManager.RegisterVirtualAxis(m_HorizontalVirtualAxis);
		}
		if (m_UseY)
		{
			m_VerticalVirtualAxis = new CrossPlatformInputManager.VirtualAxis(verticalAxisName);
			CrossPlatformInputManager.RegisterVirtualAxis(m_VerticalVirtualAxis);
		}
	}

	public void OnDrag(PointerEventData data)
	{
		Vector3 zero = Vector3.zero;
		if (m_UseX)
		{
			Vector2 position = data.position;
			int num = (int)(position.x - m_StartPos.x);
			zero.x = num;
		}
		if (m_UseY)
		{
			Vector2 position2 = data.position;
			int num2 = (int)(position2.y - m_StartPos.y);
			zero.y = num2;
		}
		base.transform.position = Vector3.ClampMagnitude(new Vector3(zero.x, zero.y, zero.z), MovementRange) + m_StartPos;
		UpdateVirtualAxes(base.transform.position);
	}

	public void OnPointerUp(PointerEventData data)
	{
		base.transform.position = m_StartPos;
		UpdateVirtualAxes(m_StartPos);
	}

	public void OnPointerDown(PointerEventData data)
	{
	}

	private void OnDisable()
	{
		if (m_UseX)
		{
			m_HorizontalVirtualAxis.Remove();
		}
		if (m_UseY)
		{
			m_VerticalVirtualAxis.Remove();
		}
	}
}
