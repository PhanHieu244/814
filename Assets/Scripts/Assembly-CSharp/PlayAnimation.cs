using System.Collections;
using UnityEngine;

public class PlayAnimation : MonoBehaviour
{
	public string AnimationName;

	private void Start()
	{
		base.gameObject.GetComponent<Animator>().Play(AnimationName);
		StartCoroutine(lougee());
	}

	private IEnumerator lougee()
	{
		yield return new WaitForSeconds(5f);
		base.gameObject.GetComponent<Animator>().Play(AnimationName);
		StartCoroutine(lougee());
	}

	private void Update()
	{
	}
}
