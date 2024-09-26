using UnityEngine;

public class level_setting : MonoBehaviour
{
	public int enemies;

	public GameObject Player;

	public GameObject Position;

	public static int enemies_count;

	public static float missiontime;

	public float mission_time;

	private void Start()
	{
		Player = GameObject.FindGameObjectWithTag("Player");
		Player.transform.position = Position.transform.position;
		Player.transform.rotation = Position.transform.rotation;
		enemies_count = enemies;
		missiontime = mission_time;
	}

	private void Update()
	{
		if (Player == null)
		{
			Player = GameObject.FindGameObjectWithTag("Player");
		}
	}
}
