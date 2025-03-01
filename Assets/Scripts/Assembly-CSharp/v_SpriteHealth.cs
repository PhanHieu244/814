using Invector;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class v_SpriteHealth : MonoBehaviour
{
	public vCharacter iChar;

	public Slider healthSlider;

	public Slider damageDelay;

	public float smoothDamageDelay;

	public Text damageCounter;

	public float damageCounterTimer = 1.5f;

	private bool inDelay;

	private float damage;

	private float currentSmoothDamage;

	private void Start()
	{
		iChar = base.transform.GetComponentInParent<vCharacter>();
		if (iChar == null)
		{
			Debug.LogWarning("The character must have a ICharacter Interface");
			Object.Destroy(base.gameObject);
		}
		healthSlider.maxValue = iChar.maxHealth;
		healthSlider.value = healthSlider.maxValue;
		damageDelay.maxValue = iChar.maxHealth;
		damageDelay.value = healthSlider.maxValue;
		damageCounter.text = string.Empty;
	}

	private void Update()
	{
		SpriteBehaviour();
	}

	private void SpriteBehaviour()
	{
		if (Camera.main != null)
		{
			base.transform.LookAt(Camera.main.transform.position, Vector3.up);
		}
		if (iChar == null || iChar.currentHealth <= 0f)
		{
			Object.Destroy(base.gameObject);
		}
		healthSlider.value = iChar.currentHealth;
	}

	public void Damage(float value)
	{
		try
		{
			healthSlider.value -= value;
			damage += value;
			damageCounter.text = damage.ToString("00");
			if (!inDelay)
			{
				StartCoroutine(DamageDelay());
			}
		}
		catch
		{
			Object.Destroy(this);
		}
	}

	private IEnumerator DamageDelay()
	{
		inDelay = true;
		while (damageDelay.value > healthSlider.value)
		{
			damageDelay.value -= smoothDamageDelay;
			yield return null;
		}
		inDelay = false;
		damage = 0f;
		yield return new WaitForSeconds(damageCounterTimer);
		damageCounter.text = string.Empty;
	}
}
