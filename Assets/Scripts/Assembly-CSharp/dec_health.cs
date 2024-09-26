using Invector;
using UnityEngine;

public class dec_health : MonoBehaviour
{
	public v_AIController E_control;

	public Animator anim;

	private void Start()
	{
		E_control = (GetComponentInParent(typeof(v_AIController)) as v_AIController);
		anim = GetComponentInParent<Animator>();
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider coll)
	{
		if ((coll.gameObject.tag == "E_Plane") | (coll.gameObject.tag == "Lazer"))
		{
			E_control.currentHealth -= 50f;
		}
	}
}
