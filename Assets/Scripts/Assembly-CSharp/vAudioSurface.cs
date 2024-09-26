using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class vAudioSurface : ScriptableObject
{
	public AudioSource audioSource;

	public AudioMixerGroup audioMixerGroup;

	public List<string> TextureOrMaterialNames;

	public List<AudioClip> audioClips;

	public GameObject particleObject;

	private vFisherYatesRandom randomSource = new vFisherYatesRandom();

	public vAudioSurface()
	{
		audioClips = new List<AudioClip>();
		TextureOrMaterialNames = new List<string>();
	}

	public void PlayRandomClip(FootStepObject footStepObject)
	{
		if (audioClips != null && audioClips.Count != 0)
		{
			if (randomSource == null)
			{
				randomSource = new vFisherYatesRandom();
			}
			GameObject gameObject = null;
			if (audioSource != null)
			{
				gameObject = Object.Instantiate(audioSource.gameObject, footStepObject.sender.position, Quaternion.identity);
			}
			else
			{
				gameObject = new GameObject("audioObject");
				gameObject.transform.position = footStepObject.sender.position;
			}
			vAudioSurfaceControl vAudioSurfaceControl = gameObject.AddComponent<vAudioSurfaceControl>();
			if (audioMixerGroup != null)
			{
				vAudioSurfaceControl.outputAudioMixerGroup = audioMixerGroup;
			}
			int index = randomSource.Next(audioClips.Count);
			if ((bool)particleObject)
			{
				GameObject gameObject2 = Object.Instantiate(particleObject, footStepObject.sender.position, footStepObject.sender.rotation);
				gameObject2.SendMessage("StepMark", footStepObject, SendMessageOptions.DontRequireReceiver);
			}
			vAudioSurfaceControl.PlayOneShot(audioClips[index]);
		}
	}
}
