using UnityEngine;

public class DontDestroyOnload : MonoBehaviour
{
	private void Awake()
	{
		Object.DontDestroyOnLoad(base.transform.gameObject);
	}
}
