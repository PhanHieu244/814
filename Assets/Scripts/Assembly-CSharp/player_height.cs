using UnityEngine;

public class player_height : MonoBehaviour
{
	public GameObject player;

	public GameObject map_obj;

	private void Start()
	{
		player = GameObject.FindGameObjectWithTag("Player");
	}

	private void Update()
	{
		if (player == null)
		{
			player = GameObject.FindGameObjectWithTag("Player");
		}
		if (map_obj == null)
		{
			map_obj = GameObject.FindGameObjectWithTag("follow_this");
		}
		if (map_obj != null)
		{
			map_obj.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
		}
	}

	private void LateUpdate()
	{
		Vector3 position = player.transform.position;
		if (position.y > 100f)
		{
			Transform transform = player.transform;
			Vector3 position2 = player.transform.position;
			float x = position2.x;
			Vector3 position3 = player.transform.position;
			transform.position = new Vector3(x, 100f, position3.z);
		}
	}
}
