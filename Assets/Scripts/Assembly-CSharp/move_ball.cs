using UnityEngine;

public class move_ball : MonoBehaviour
{
	public GameObject player;

	public GameObject explosion;

	private void Start()
	{
	}

	private void Update()
	{
		if (player == null)
		{
			player = GameObject.FindGameObjectWithTag("particle_Obj_2");
		}
		if (explosion == null)
		{
			explosion = GameObject.FindGameObjectWithTag("explode");
			explosion.SetActive(value: false);
		}
		base.gameObject.transform.rotation = player.transform.rotation;
		Rigidbody component = GetComponent<Rigidbody>();
		Vector3 forward = player.transform.forward;
		float x = forward.x;
		Vector3 forward2 = player.transform.forward;
		float y = forward2.y;
		Vector3 forward3 = player.transform.forward;
		component.AddForce(new Vector3(x, y, forward3.z) * 50f);
	}

	private void OnCollisionEnter(Collision col)
	{
		MonoBehaviour.print("lou");
		explosion.SetActive(value: true);
	}
}
