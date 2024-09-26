using Invector.CharacterController;
using Invector.EventSystems;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;

public class vBreakableObject : MonoBehaviour, vIDamageReceiver
{
	public Transform brokenObject;

	[Header("Break Object Settings")]
	[Tooltip("Break objet  OnTrigger with Player rolling")]
	public bool breakOnPlayerRoll = true;

	[Tooltip("Break objet  OnCollision with other object")]
	public bool breakOnCollision = true;

	[Tooltip("Rigidbody velocity to break OnCollision whit other object")]
	public float maxVelocityToBreak = 5f;

	public UnityEvent OnBroken;

	private bool isBroken;

	private Collider _collider;

	private Rigidbody _rigidBody;

	private void Start()
	{
		_collider = GetComponent<Collider>();
		_rigidBody = GetComponent<Rigidbody>();
	}

	public void TakeDamage(Damage damage, bool hitReaction)
	{
		if (!isBroken)
		{
			isBroken = true;
			StartCoroutine(BreakObjet());
		}
	}

	private IEnumerator BreakObjet()
	{
		if ((bool)_rigidBody)
		{
			Object.Destroy(_rigidBody);
		}
		if ((bool)_collider)
		{
			Object.Destroy(_collider);
		}
		yield return new WaitForEndOfFrame();
		brokenObject.transform.parent = null;
		brokenObject.gameObject.SetActive(value: true);
		OnBroken.Invoke();
		Object.Destroy(base.gameObject);
	}

	private void OnTriggerStay(Collider other)
	{
		if (breakOnPlayerRoll && other.gameObject.CompareTag("Player"))
		{
			vThirdPersonController component = other.gameObject.GetComponent<vThirdPersonController>();
			if ((bool)component && component.isRolling && !isBroken)
			{
				isBroken = true;
				StartCoroutine(BreakObjet());
			}
		}
	}

	private void OnCollisionEnter(Collision other)
	{
		if (breakOnCollision && (bool)_rigidBody && _rigidBody.velocity.magnitude > 5f && !isBroken)
		{
			isBroken = true;
			StartCoroutine(BreakObjet());
		}
	}
}
