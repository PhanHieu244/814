using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class vSimpleDoor : MonoBehaviour
{
	public Transform pivot;

	public bool autoOpen = true;

	public bool autoClose = true;

	public float angleOfOpen = 90f;

	public float angleToInvert = 30f;

	public float speedClose = 2f;

	public float speedOpen = 2f;

	[Tooltip("Usage just for autoOpenClose")]
	public float timeToClose = 1f;

	[Tooltip("Usage just for autoOpenClose")]
	public List<string> tagsToOpen = new List<string>
	{
		"Player"
	};

	[HideInInspector]
	public bool isOpen;

	[HideInInspector]
	public bool isInTransition;

	private Vector3 currentAngle;

	private float forwardDotVelocity;

	private bool invertAngle;

	private bool canOpen;

	public bool stop;

	public NavMeshObstacle navMeshObstacle;

	private void Start()
	{
		if (!pivot)
		{
			base.enabled = false;
		}
		navMeshObstacle = GetComponentInChildren<NavMeshObstacle>();
		if ((bool)navMeshObstacle)
		{
			navMeshObstacle.enabled = false;
			navMeshObstacle.carving = true;
		}
	}

	private void OnDrawGizmos()
	{
		if ((bool)pivot)
		{
			Gizmos.DrawSphere(base.transform.position, 0.1f);
			Gizmos.DrawLine(base.transform.position, pivot.position);
			Gizmos.DrawSphere(pivot.position, 0.1f);
		}
	}

	private IEnumerator _Open()
	{
		isInTransition = true;
		if ((bool)navMeshObstacle)
		{
			navMeshObstacle.enabled = true;
		}
		while (currentAngle.y != ((!invertAngle) ? angleOfOpen : (0f - angleOfOpen)))
		{
			yield return new WaitForEndOfFrame();
			if (invertAngle)
			{
				currentAngle.y -= 100f * speedOpen * Time.deltaTime;
				currentAngle.y = Mathf.Clamp(currentAngle.y, 0f - angleOfOpen, 0f);
			}
			else
			{
				currentAngle.y += 100f * speedOpen * Time.deltaTime;
				currentAngle.y = Mathf.Clamp(currentAngle.y, 0f, angleOfOpen);
			}
			pivot.localEulerAngles = currentAngle;
		}
		isInTransition = false;
		isOpen = true;
	}

	private IEnumerator _Close()
	{
		yield return new WaitForSeconds(timeToClose);
		isInTransition = true;
		while (currentAngle.y != 0f)
		{
			yield return new WaitForEndOfFrame();
			if (stop)
			{
				break;
			}
			if (invertAngle)
			{
				currentAngle.y += 100f * speedClose * Time.deltaTime;
				currentAngle.y = Mathf.Clamp(currentAngle.y, 0f - angleOfOpen, 0f);
			}
			else
			{
				currentAngle.y -= 100f * speedClose * Time.deltaTime;
				currentAngle.y = Mathf.Clamp(currentAngle.y, 0f, angleOfOpen);
			}
			pivot.localEulerAngles = currentAngle;
		}
		if (!stop)
		{
			isInTransition = false;
		}
		stop = false;
		isOpen = false;
		if ((bool)navMeshObstacle)
		{
			navMeshObstacle.enabled = false;
		}
	}

	private void OnTriggerStay(Collider collider)
	{
		if (autoOpen && !isOpen && tagsToOpen.Contains(collider.tag))
		{
			forwardDotVelocity = Mathf.Abs(Vector3.Angle(base.transform.forward, collider.transform.position - base.transform.position));
			if (forwardDotVelocity < 60f)
			{
				if (!isInTransition || (currentAngle.y > 0f - angleToInvert && currentAngle.y < angleToInvert))
				{
					invertAngle = false;
				}
				canOpen = true;
			}
			else if (forwardDotVelocity >= 60f && forwardDotVelocity < 120f)
			{
				canOpen = false;
			}
			else
			{
				if (!isInTransition || (currentAngle.y > 0f - angleToInvert && currentAngle.y < angleToInvert))
				{
					invertAngle = true;
				}
				canOpen = true;
			}
			if (canOpen && !isOpen)
			{
				StartCoroutine(_Open());
			}
		}
		else if (isInTransition && isOpen && tagsToOpen.Contains(collider.tag))
		{
			stop = true;
			isOpen = false;
		}
	}

	private void OnTriggerExit(Collider collider)
	{
		if (autoClose && isOpen && tagsToOpen.Contains(collider.tag))
		{
			StartCoroutine(_Close());
		}
	}
}
