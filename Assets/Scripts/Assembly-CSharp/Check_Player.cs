using UnityEngine;

public class Check_Player : MonoBehaviour
{
	public GameObject[] Players;

	private void Start()
	{
		Players[PlayerPrefs.GetInt("CurrentItemInPlay")].SetActive(value: true);
	}

	private void Update()
	{
	}
}
