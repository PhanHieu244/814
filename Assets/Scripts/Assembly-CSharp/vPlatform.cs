using Invector;
using UnityEngine;

public class vPlatform : MonoBehaviour
{
	public float speed = 1f;

	public float timeToStayInPoints = 2f;

	public int startIndex;

	public Transform[] points;

	[HideInInspector]
	public bool canMove;

	private Vector3 oldEuler;

	private int index;

	private bool invert;

	private float currentTime;

	private float dist;

	private float currentDist;

	private Transform targetTransform;

	private void OnDrawGizmos()
	{
		if (points == null || points.Length == 0 || startIndex >= points.Length)
		{
			return;
		}
		Transform transform = points[0];
		Gizmos.color = new Color(0f, 1f, 0f, 0.5f);
		if (!Application.isPlaying)
		{
			base.transform.position = points[startIndex].position;
			base.transform.eulerAngles = points[startIndex].eulerAngles;
		}
		Transform[] array = points;
		foreach (Transform transform2 in array)
		{
			if (transform2 != null && transform2 != transform)
			{
				Gizmos.DrawLine(transform.position, transform2.position);
				transform = transform2;
			}
		}
		Transform[] array2 = points;
		foreach (Transform transform3 in array2)
		{
			Matrix4x4 matrix4x2 = Gizmos.matrix = Matrix4x4.TRS(transform3.position, transform3.rotation, base.transform.lossyScale);
			Gizmos.DrawCube(Vector3.zero, Vector3.one);
		}
	}

	private void Start()
	{
		if (points.Length != 0 && startIndex < points.Length && points.Length >= 2)
		{
			base.transform.position = points[startIndex].position;
			base.transform.eulerAngles = points[startIndex].eulerAngles;
			oldEuler = base.transform.eulerAngles;
			int num = startIndex;
			if (startIndex + 1 < points.Length)
			{
				num++;
			}
			else if (startIndex - 1 > 0)
			{
				num--;
				invert = true;
			}
			dist = Vector3.Distance(base.transform.position, points[num].position);
			targetTransform = points[num];
			index = num;
			canMove = true;
		}
	}

	private void FixedUpdate()
	{
		if (points.Length == 0 && !canMove)
		{
			return;
		}
		currentDist = Vector3.Distance(base.transform.position, targetTransform.position);
		if (currentTime <= 0f)
		{
			float d = Mathf.Clamp((100f - 100f * currentDist / dist) * 0.01f, 0f, 1f);
			base.transform.position = Vector3.MoveTowards(base.transform.position, targetTransform.position, speed * Time.deltaTime);
			if (oldEuler != base.transform.eulerAngles)
			{
				base.transform.eulerAngles = oldEuler + (targetTransform.eulerAngles - oldEuler) * d;
			}
		}
		else
		{
			currentTime -= Time.fixedDeltaTime;
		}
		if (!(currentDist < 0.02f))
		{
			return;
		}
		if (!invert)
		{
			if (index + 1 < points.Length)
			{
				index++;
			}
			else
			{
				invert = true;
			}
		}
		else if (index - 1 >= 0)
		{
			index--;
		}
		else
		{
			invert = false;
		}
		dist = Vector3.Distance(targetTransform.position, points[index].position);
		targetTransform = points[index];
		oldEuler = base.transform.eulerAngles;
		currentTime = timeToStayInPoints;
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.transform.parent != base.transform && other.transform.tag == "Player" && other.GetComponent<vCharacter>() != null)
		{
			other.transform.parent = base.transform;
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.transform.parent == base.transform && other.transform.tag == "Player")
		{
			other.transform.parent = null;
		}
	}
}
