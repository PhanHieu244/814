using UnityEngine;

public class bl_MMExampleManager : MonoBehaviour
{
	public int MapID = 2;

	public const string MMName = "MMManagerExample";

	public GameObject[] Maps;

	private bool Rotation = true;

	public bl_MiniMap GetActiveMiniMap => Maps[MapID].GetComponentInChildren<bl_MiniMap>();

	private void Awake()
	{
		MapID = PlayerPrefs.GetInt("MMExampleMapID", 0);
		ApplyMap();
	}

	private void ApplyMap()
	{
		for (int i = 0; i < Maps.Length; i++)
		{
			Maps[i].SetActive(value: false);
		}
		Maps[MapID].SetActive(value: true);
	}

	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.R))
		{
			ChangeRotation();
		}
	}

	private void ChangeRotation()
	{
		Rotation = !Rotation;
		Maps[MapID].GetComponentInChildren<bl_MiniMap>().RotationMap(Rotation);
	}

	public void ChangeMap(int i)
	{
		PlayerPrefs.SetInt("MMExampleMapID", i);
		Application.LoadLevel(Application.loadedLevel);
	}
}
