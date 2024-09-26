using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class Power_Handler : MonoBehaviour
{
	[Header("--- Auto Fill ---")]
	public GameObject player;

	public Animator anim;

	public GameObject particle_Obj_1;

	public GameObject particle_Obj_2;

	public GameObject particle_Obj_4;

	public static bool stamina_loss;

	[Header("--- Put from Project ---")]
	public GameObject Power_btn_1;

	public GameObject Power_btn_2;

	public GameObject Power_btn_3;

	public GameObject Power_btn_4;

	public GameObject particle_Prefab_1;

	public GameObject particle_Prefab_2;

	public GameObject particle_Prefab_3;

	public GameObject particle_Prefab_4;

	public GameObject p4_gun;

	public AudioSource sound_power_1;

	public AudioSource sound_power_2;

	public AudioSource sound_power_3;

	public AudioSource sound_power_4;

	public Vector3 P;

	public Vector3 R;

	public Vector3 Projectile_position;

	public Vector3 Projectile_Rotation;

	public GameObject Lazer_handler_img;

	public GameObject cracks_collider;

	public GameObject cracks;

	public GameObject[] Lazzer;

	private void Start()
	{
		if (PlayerPrefs.GetInt("CurrentLevel", 1) % 2 == 0)
		{
			Power_btn_1.SetActive(value: true);
		}
		else
		{
			Power_btn_2.SetActive(value: true);
		}
		StartCoroutine(weapon_Check());
	}

	private IEnumerator weapon_Check()
	{
		yield return new WaitForSeconds(0.5f);
		p4_gun = GameObject.FindGameObjectWithTag("gun");
		particle_Prefab_3 = GameObject.FindGameObjectWithTag("Lazer");
		Lazzer = GameObject.FindGameObjectsWithTag("lazzer");
		particle_Prefab_3.GetComponent<BoxCollider>().enabled = true;
		particle_Prefab_3.SetActive(value: false);
		p4_gun.SetActive(value: false);
	}

	private void Update()
	{
		if (player == null)
		{
			player = GameObject.FindGameObjectWithTag("Player");
		}
		if (anim == null)
		{
			anim = player.GetComponent<Animator>();
		}
		if (particle_Obj_1 == null)
		{
			particle_Obj_1 = GameObject.FindGameObjectWithTag("particle_Obj_1");
		}
		if (particle_Obj_2 == null)
		{
			particle_Obj_2 = GameObject.FindGameObjectWithTag("particle_Obj_2");
		}
		if (particle_Obj_4 == null)
		{
			particle_Obj_4 = GameObject.FindGameObjectWithTag("particle_Obj_4");
		}
		if (Lazer_handler_img.GetComponent<Image>().fillAmount == 1f)
		{
			Power_btn_3.GetComponent<Button>().interactable = true;
		}
	}

	public void Power1()
	{
		anim.Play("SpecialAttackPower");
		Power_btn_1.SetActive(value: false);
		StartCoroutine(power1_setting());
	}

	public void Power2()
	{
		anim.Play("KB_Projectile_3");
		StartCoroutine(power2_setting());
		Power_btn_2.SetActive(value: false);
	}

	public void Power3()
	{
		Power_btn_3.GetComponent<Button>().interactable = false;
		anim.Play("KB_EyeLasers");
		StartCoroutine(power3_setting());
		Lazer_handler_img.GetComponent<Image>().fillAmount = 0f;
		Lazer_handler_img.SetActive(value: false);
		Lazer_handler_img.SetActive(value: true);
	}

	public void Power4()
	{
		Power_btn_4.SetActive(value: false);
		anim.Play("KB_Gun");
		p4_gun.SetActive(value: true);
		StartCoroutine(power4_setting());
	}

	private IEnumerator power1_setting()
	{
		yield return new WaitForSeconds(0.5f);
		sound_power_1.Play();
		GameObject gameOBJ3 = Object.Instantiate(particle_Prefab_1, particle_Obj_1.transform.position, Quaternion.Euler(0f, 0f, 0f));
		Object.Destroy(gameOBJ3, 3f);
		GameObject gameOBJ2 = Object.Instantiate(cracks_collider, player.transform.position + new Vector3(0f, 0.02f, 0f), Quaternion.Euler(90f, 0f, 0f));
		Object.Destroy(gameOBJ2, 1f);
	}

	private IEnumerator power2_setting()
	{
		yield return new WaitForSeconds(0.5f);
		sound_power_2.Play();
		particle_Obj_2.transform.localPosition = Projectile_position;
		particle_Obj_2.transform.localRotation = Quaternion.Euler(Projectile_Rotation);
		particle_Obj_2.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
		GameObject gameOBJ0 = Object.Instantiate(particle_Prefab_2, particle_Obj_2.transform.position, Quaternion.Euler(0f, 0f, 0f));
		Object.Destroy(gameOBJ0, 3f);
	}

	private IEnumerator power3_setting()
	{
		yield return new WaitForSeconds(0.5f);
		sound_power_3.Play();
		yield return new WaitForSeconds(0.5f);
		particle_Prefab_3.SetActive(value: true);
		particle_Prefab_3.transform.localPosition = P;
		particle_Prefab_3.transform.localRotation = Quaternion.Euler(R);
		Lazzer[0].transform.localRotation = Quaternion.Euler(0f, 0f, 90f);
		Lazzer[1].transform.localRotation = Quaternion.Euler(0f, 0f, 90f);
		yield return new WaitForSeconds(1.5f);
		particle_Prefab_3.SetActive(value: false);
	}

	private IEnumerator power4_setting()
	{
		yield return new WaitForSeconds(0.5f);
		sound_power_4.Play();
		GameObject gameOBJ0 = Object.Instantiate(particle_Prefab_4, particle_Obj_4.transform.position, Quaternion.Euler(90f, 0f, 0f));
		Object.Destroy(gameOBJ0, 3f);
		yield return new WaitForSeconds(0.5f);
		p4_gun.SetActive(value: false);
		Power_btn_4.SetActive(value: true);
	}
}
