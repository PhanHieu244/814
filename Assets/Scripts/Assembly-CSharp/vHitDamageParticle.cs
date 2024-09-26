using Invector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class vHitDamageParticle : MonoBehaviour
{
	public GameObject defaultHitEffect;

	public AudioClip hit_sound;

	public List<HitEffect> customHitEffects = new List<HitEffect>();

	private IEnumerator Start()
	{
		yield return new WaitForEndOfFrame();
		vCharacter character = GetComponent<vCharacter>();
		if (character != null)
		{
			character.onReceiveDamage.AddListener(OnReceiveDamage);
		}
	}

	public void OnReceiveDamage(Damage damage)
	{
		Vector3 position = base.transform.position;
		float x = position.x;
		float y = damage.hitPosition.y;
		Vector3 position2 = base.transform.position;
		Vector3 vector = new Vector3(x, y, position2.z) - damage.hitPosition;
		Quaternion rotation = (!(vector != Vector3.zero)) ? base.transform.rotation : Quaternion.LookRotation(vector);
		if (damage.value > 0)
		{
			Vector3 position3 = base.transform.position;
			float x2 = position3.x;
			float y2 = damage.hitPosition.y;
			Vector3 position4 = base.transform.position;
			TriggerHitParticle(new HittEffectInfo(new Vector3(x2, y2, position4.z), rotation, damage.attackName, damage.receiver));
		}
	}

	private void TriggerHitParticle(HittEffectInfo hitEffectInfo)
	{
		HitEffect hitEffect = customHitEffects.Find((HitEffect effect) => effect.hitName.Equals(hitEffectInfo.hitName));
		if (hitEffect != null)
		{
			if (hitEffect.hitPrefab != null && (bool)hitEffectInfo.receiver)
			{
				GameObject gameObject = Object.Instantiate(hitEffect.hitPrefab, hitEffectInfo.position, hitEffectInfo.rotation);
				if (hitEffect.attachInReceiver)
				{
					gameObject.transform.SetParent(hitEffectInfo.receiver);
				}
				AudioSource.PlayClipAtPoint(hit_sound, Camera.main.transform.position);
			}
		}
		else if (defaultHitEffect != null)
		{
			Object.Instantiate(defaultHitEffect, hitEffectInfo.position, hitEffectInfo.rotation);
		}
		AudioSource.PlayClipAtPoint(hit_sound, Camera.main.transform.position);
	}
}
