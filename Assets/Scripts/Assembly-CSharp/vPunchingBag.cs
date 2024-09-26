using Invector;
using UnityEngine;

public class vPunchingBag : MonoBehaviour
{
	public Rigidbody _rigidbody;

	public float forceMultipler = 0.5f;

	public SpringJoint joint;

	public vCharacter character;

	private void Start()
	{
		_rigidbody = GetComponent<Rigidbody>();
		character = GetComponent<vCharacter>();
		character.onReceiveDamage.AddListener(TakeDamage);
	}

	public void TakeDamage(Damage damage)
	{
		Vector3 hitPosition = damage.hitPosition;
		Vector3 position = base.transform.position;
		position.y = hitPosition.y;
		Vector3 a = position - hitPosition;
		if (character != null && joint != null && character.currentHealth < 0f)
		{
			joint.connectedBody = null;
			MonoBehaviour[] componentsInChildren = character.gameObject.GetComponentsInChildren<MonoBehaviour>();
			foreach (MonoBehaviour monoBehaviour in componentsInChildren)
			{
				if (monoBehaviour != this)
				{
					Object.Destroy(monoBehaviour);
				}
			}
		}
		if (_rigidbody != null)
		{
			_rigidbody.AddForce(a * ((float)damage.value * forceMultipler), ForceMode.Impulse);
		}
	}
}
