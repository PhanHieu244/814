using UnityEngine;

public class vPickupItem : MonoBehaviour
{
	private AudioSource _audioSource;

	public AudioClip _audioClip;

	public GameObject _particle;

	private void Start()
	{
		_audioSource = GetComponent<AudioSource>();
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.tag.Equals("Player") && !_audioSource.isPlaying)
		{
			Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
			Renderer[] array = componentsInChildren;
			foreach (Renderer renderer in array)
			{
				renderer.enabled = false;
			}
			_audioSource.PlayOneShot(_audioClip);
			Object.Destroy(base.gameObject, _audioClip.length);
		}
	}
}
