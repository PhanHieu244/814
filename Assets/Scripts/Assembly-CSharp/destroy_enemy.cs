using Invector;
using UnityEngine;

public class destroy_enemy : MonoBehaviour
{
	public v_AIController E_control;

	public Animator anim;

	private void Start()
	{
		E_control = (GetComponentInParent(typeof(v_AIController)) as v_AIController);
		anim = GetComponent<Animator>();
	}

	private void Update()
	{
	}

	private void LateUpdate()
	{
		if (E_control.currentHealth <= 0f)
		{
			Object.Destroy(base.gameObject, 5f);
		}
	}
}
