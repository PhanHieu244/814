using Invector;
using UnityEngine;
using UnityEngine.Events;

public class vOnDeadTrigger : MonoBehaviour
{
	public UnityEvent OnDead;

	private void Start()
	{
		vCharacter component = GetComponent<vCharacter>();
		if ((bool)component)
		{
			component.onDead.AddListener(OnDeadHandle);
		}
	}

	public void OnDeadHandle(GameObject target)
	{
		OnDead.Invoke();
	}
}
