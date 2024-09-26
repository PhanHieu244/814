using System;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class vPlayRandomClip : MonoBehaviour
{
	public AudioClip[] clips;

	public AudioSource audioSource;

	private void Start()
	{
		if (!audioSource)
		{
			audioSource = GetComponent<AudioSource>();
		}
		if ((bool)audioSource)
		{
			int num = 0;
			UnityEngine.Random.InitState(UnityEngine.Random.Range(0, DateTime.Now.Millisecond));
			num = UnityEngine.Random.Range(0, clips.Length - 1);
			if (clips.Length > 0)
			{
				audioSource.PlayOneShot(clips[num]);
			}
		}
	}
}
