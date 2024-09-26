using UnityEngine;

public class story_can_enem_contr : MonoBehaviour
{
	public GameObject story_canvas;

	public static bool active_enemies;

	public static bool continuehogya;

	private void Start()
	{
		active_enemies = false;
		continuehogya = false;
	}

	private void Update()
	{
	}

	public void story_continue()
	{
		story_canvas.SetActive(value: false);
		continuehogya = true;
		active_enemies = true;
	}
}
