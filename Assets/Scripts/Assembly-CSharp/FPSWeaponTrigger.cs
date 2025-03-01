using PigeonCoopToolkit.Effects.Trails;
using UnityEngine;

public class FPSWeaponTrigger : MonoBehaviour
{
	public Transform ShellEjectionTransform;

	public float EjectionForce;

	public Rigidbody Shell;

	public Transform Muzzle;

	public GameObject Bullet;

	public float SmokeAfter;

	public float SmokeMax;

	public float SmokeIncrement;

	public SmokePlume MuzzlePlume;

	public GameObject MuzzleFlashObject;

	private float _smoke;

	private void Update()
	{
		MuzzlePlume.Emit = (_smoke > SmokeAfter);
		_smoke -= Time.deltaTime;
		if (_smoke > SmokeMax)
		{
			_smoke = SmokeMax;
		}
		if (_smoke < 0f)
		{
			_smoke = 0f;
		}
	}

	public void Fire()
	{
		MuzzleFlashObject.SetActive(value: true);
		Invoke("LightsOff", 0.05f);
		_smoke += SmokeIncrement;
		Rigidbody component = Object.Instantiate(Shell.gameObject, ShellEjectionTransform.position, ShellEjectionTransform.rotation).GetComponent<Rigidbody>();
		component.velocity = ShellEjectionTransform.right * EjectionForce + Random.onUnitSphere * 0.25f;
		component.angularVelocity = Random.onUnitSphere * EjectionForce;
		Object.Instantiate(Bullet, Muzzle.transform.position, Muzzle.rotation);
	}

	private void LightsOff()
	{
		MuzzleFlashObject.SetActive(value: false);
	}
}
