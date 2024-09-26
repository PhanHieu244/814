using UnityEngine;

public class vHitEffects : MonoBehaviour
{
	public GameObject audioSource;

	public AudioClip[] hitSounds;

	public AudioClip[] recoilSounds;

	public GameObject[] recoilParticles;

	public AudioClip[] defSounds;

	private void Start()
	{
		vMeleeWeapon component = GetComponent<vMeleeWeapon>();
		if ((bool)component)
		{
			component.onDamageHit.AddListener(PlayHitEffects);
			component.onRecoilHit.AddListener(PlayRecoilEffects);
			component.onDefense.AddListener(PlayDefenseEffects);
		}
	}

	public void PlayHitEffects(HitInfo hitInfo)
	{
		if (audioSource != null && hitSounds.Length > 0)
		{
			AudioClip clip = hitSounds[Random.Range(0, hitSounds.Length)];
			GameObject gameObject = Object.Instantiate(audioSource, base.transform.position, base.transform.rotation);
			gameObject.GetComponent<AudioSource>().PlayOneShot(clip);
		}
	}

	public void PlayRecoilEffects(HitInfo hitInfo)
	{
		if (audioSource != null && recoilSounds.Length > 0)
		{
			AudioClip clip = recoilSounds[Random.Range(0, recoilSounds.Length)];
			GameObject gameObject = Object.Instantiate(audioSource, base.transform.position, base.transform.rotation);
			gameObject.GetComponent<AudioSource>().PlayOneShot(clip);
		}
		if (recoilParticles.Length > 0)
		{
			GameObject gameObject2 = recoilParticles[Random.Range(0, recoilParticles.Length)];
			Vector3 position = base.transform.position;
			float x = position.x;
			float y = hitInfo.hitPoint.y;
			Vector3 position2 = base.transform.position;
			Quaternion rotation = Quaternion.LookRotation(new Vector3(x, y, position2.z) - hitInfo.hitPoint);
			if (gameObject2 != null)
			{
				Object.Instantiate(gameObject2, hitInfo.hitPoint, rotation);
			}
		}
	}

	public void PlayDefenseEffects()
	{
		if (audioSource != null && defSounds.Length > 0)
		{
			AudioClip clip = defSounds[Random.Range(0, defSounds.Length)];
			GameObject gameObject = Object.Instantiate(audioSource, base.transform.position, base.transform.rotation);
			gameObject.GetComponent<AudioSource>().PlayOneShot(clip);
		}
	}
}
