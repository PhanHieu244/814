using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
[RequireComponent(typeof(Rigidbody))]
public class vBoxTrigger : MonoBehaviour
{
	public List<string> tagsToIgnore = new List<string>
	{
		"Player"
	};

	public LayerMask mask = 1;

	public bool inCollision;

	private bool triggerStay;

	private bool inResetMove;

	private Rigidbody rgb;

	private void OnDrawGizmos()
	{
		Color color = new Color(1f, 0f, 0f, 0.5f);
		Color color2 = new Color(0f, 1f, 0f, 0.5f);
		Gizmos.matrix = Matrix4x4.TRS(base.transform.position, base.transform.rotation, base.transform.lossyScale);
		Gizmos.color = ((!inCollision || !Application.isPlaying) ? color2 : color);
		Gizmos.DrawCube(Vector3.zero, Vector3.one);
	}

	private void Start()
	{
		inCollision = false;
		base.gameObject.GetComponent<BoxCollider>().isTrigger = true;
		rgb = base.gameObject.GetComponent<Rigidbody>();
		rgb.isKinematic = true;
		rgb.useGravity = false;
		rgb.constraints = RigidbodyConstraints.FreezeAll;
	}

	private void Update()
	{
		if (rgb != null && rgb.IsSleeping())
		{
			rgb.WakeUp();
		}
	}

	private void OnTriggerStay(Collider Other)
	{
		if (!tagsToIgnore.Contains(Other.gameObject.tag) && IsInLayerMask(Other.gameObject, mask))
		{
			inCollision = true;
			triggerStay = true;
		}
	}

	private void OnTriggerExit(Collider Other)
	{
		if (!tagsToIgnore.Contains(Other.gameObject.tag) && IsInLayerMask(Other.gameObject, mask))
		{
			triggerStay = false;
			if (!inResetMove)
			{
				inResetMove = true;
				StartCoroutine(ResetMove());
			}
		}
	}

	private IEnumerator ResetMove()
	{
		yield return new WaitForSeconds(0.2f);
		if (!triggerStay)
		{
			inCollision = false;
		}
		inResetMove = false;
	}

	private bool IsInLayerMask(GameObject obj, LayerMask mask)
	{
		return (mask.value & (1 << obj.layer)) > 0;
	}
}
