using Invector.CharacterController;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace Invector
{
	public class vGameController : MonoBehaviour
	{
		[Serializable]
		public class OnRealoadGame : UnityEvent
		{
		}

		public GameObject[] Players;

		public GameObject player22;

		public Animator anim;

		public GameObject[] level;

		public GameObject canvas_failed;

		public GameObject canvas_MC;

		public GameObject canvas_Pause;

		public Text Score;

		public Text Score_Gain;

		public Text Score_failed;

		public Text Timer;

		public GameObject rate_pannel;

		public GameObject Instruction_Pannel;

		public GameObject mobile_control;

		public static bool time_run;

		public static bool failed;

		private float interval = 240f;

		private float sec;

		public static bool Mission;

		public GameObject pause_bttn;

		public GameObject shoot_btn;

		public GameObject Fly;

		public GameObject Sprint;

		public GameObject power1;

		public GameObject power2;

		public GameObject particles;

		public AudioSource win_sound;

		public AudioSource fail_sound;

		public AudioSource background_sound;

		[Tooltip("Assign here the locomotion (empty transform) to spawn the Player")]
		public Transform spawnPoint;

		[Tooltip("Assign the Character Prefab to instantiate at the SpawnPoint, leave unassign to Restart the Scene")]
		public GameObject playerPrefab;

		[Tooltip("Time to wait until the scene restart or the player will be spawned again")]
		public float respawnTimer = 4f;

		[Tooltip("Check if you want to leave your dead body at the place you died")]
		public bool destroyBodyAfterDead;

		[HideInInspector]
		public OnRealoadGame OnReloadGame = new OnRealoadGame();

		[HideInInspector]
		public GameObject currentPlayer;

		private vThirdPersonController currentController;

		public static vGameController instance;

		private GameObject oldPlayer;

		public static bool key;

		private void Start()
		{
			key = false;
			failed = false;
			Mission = false;
			Players[PlayerPrefs.GetInt("CurrentItemInPlay")].SetActive(value: true);
			player22 = Players[PlayerPrefs.GetInt("CurrentItemInPlay")];
			v_AIMotor.enemyscore = 0;
			v_AIMotor.kill = 0;
			level[PlayerPrefs.GetInt("CurrentLevel", 1) - 1].SetActive(value: true);
			Score.text = PlayerPrefs.GetInt("Score").ToString();
			Instruction_Pannel.SetActive(value: true);
			mobile_control.SetActive(value: false);
			GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = false;
			GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = false;
			anim = player22.GetComponent<Animator>();
			SceneManager.sceneLoaded += OnLevelFinishedLoading;
			vThirdPersonController vThirdPersonController = UnityEngine.Object.FindObjectOfType<vThirdPersonController>();
			if ((bool)vThirdPersonController)
			{
				currentPlayer = vThirdPersonController.gameObject;
				currentController = vThirdPersonController;
				vThirdPersonController.onDead.AddListener(OnCharacterDead);
			}
			else if (currentPlayer == null && playerPrefab != null && spawnPoint != null)
			{
				Spawn(spawnPoint);
			}
		}

		private IEnumerator dead(float a = 0f)
		{
			fail_sound.Play();
			yield return new WaitForSeconds(a);
			//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
			canvas_failed.SetActive(value: true);
			Mission = true;
			GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = false;
			GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = false;
			mobile_control.SetActive(value: false);
			pause_bttn.SetActive(value: false);
			power1.SetActive(value: false);
			power2.SetActive(value: false);
			shoot_btn.SetActive(value: false);
			Sprint.SetActive(value: false);
			Fly.SetActive(value: false);
			v_AIMotor.kill = 0;
			Score_failed.text = v_AIMotor.enemy_kill.ToString();
		}

		public void OnCharacterDead(GameObject _gameObject)
		{
			StartCoroutine(dead(3f));
		}

		public void Spawn(Transform _spawnPoint)
		{
			if (playerPrefab != null)
			{
				if (oldPlayer != null && destroyBodyAfterDead)
				{
					UnityEngine.Object.Destroy(oldPlayer);
				}
				else if (oldPlayer != null)
				{
					DestroyPlayerComponents(oldPlayer);
				}
				currentPlayer = UnityEngine.Object.Instantiate(playerPrefab, spawnPoint.position, spawnPoint.rotation);
				currentController = currentPlayer.GetComponent<vThirdPersonController>();
				currentController.onDead.AddListener(OnCharacterDead);
				OnReloadGame.Invoke();
			}
		}

		public string convertToHHMMSS(float seconds)
		{
			if (time_run)
			{
				level_setting.missiontime -= Time.deltaTime;
			}
			sec = Mathf.FloorToInt(level_setting.missiontime);
			float num = seconds % 60f;
			float num2 = Mathf.Floor(seconds % 3600f / 60f);
			float num3 = Mathf.Floor(seconds / 3600f);
			string str = (num3 != 0f) ? (doubleDigitFormat((uint)num3) + ":") : string.Empty;
			string str2 = (!(num2 > 0f)) ? "00" : doubleDigitFormat((uint)num2);
			string str3 = (!(num > 0f)) ? ":00" : (":" + doubleDigitFormat((uint)num));
			return str + str2 + str3;
		}

		private string doubleDigitFormat(uint value)
		{
			if (value > 9)
			{
				return value.ToString();
			}
			return "0" + value.ToString();
		}

		private void LateUpdate()
		{
			if (level_setting.missiontime <= 0f && !failed)
			{
				failed = true;
				Timer.text = "00:00";
				StartCoroutine(dead());
			}
		}

		private void Update()
		{
			Timer.text = convertToHHMMSS(level_setting.missiontime);
			switch (PlayerPrefs.GetInt("CurrentLevel", 1))
			{
			case 1:
				Level1();
				break;
			case 2:
				Level2();
				break;
			case 3:
				Level3();
				break;
			case 4:
				Level4();
				break;
			case 5:
				Level5();
				break;
			case 6:
				Level6();
				break;
			case 7:
				Level7();
				break;
			case 8:
				Level8();
				break;
			case 9:
				Level9();
				break;
			case 10:
				Level10();
				break;
			case 11:
				Level11();
				break;
			case 12:
				Level12();
				break;
			case 13:
				Level13();
				break;
			case 14:
				Level14();
				break;
			case 15:
				Level15();
				break;
			case 16:
				Level16();
				break;
			case 17:
				Level17();
				break;
			case 18:
				Level18();
				break;
			case 19:
				Level19();
				break;
			case 20:
				Level20();
				break;
			}
		}

		public void home()
		{
		//	GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowAd();
			Time.timeScale = 1f;
			//BannerAd.showBanner = false;
			SceneManager.LoadScene("MainMenu");
		}

		public void exit()
		{
			Time.timeScale = 1f;
			Application.Quit();
		}

		public void pause()
		{
			canvas_Pause.SetActive(value: true);
			Time.timeScale = 1E-05f;
		}

		public void Restart()
		{
			//GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowAd();
			Time.timeScale = 1f;
			canvas_Pause.SetActive(value: false);
			SceneManager.LoadScene("Loading");
		}

		public void resume()
		{
			//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
			Time.timeScale = 1f;
			canvas_Pause.SetActive(value: false);
		}

		public void rate()
		{
			canvas_failed.SetActive(value: false);
			canvas_Pause.SetActive(value: false);
			rate_pannel.SetActive(value: true);
		}

		public void Rate_now()
		{
			PlayerPrefs.SetInt("rated", 1);
			
		}

		public void Rate_later()
		{
			rate_pannel.SetActive(value: false);
			canvas_failed.SetActive(value: false);
			canvas_Pause.SetActive(value: false);
		}

		public void mission_complete()
		{
			//GameObject.Find("AdsManager").GetComponent<AdmobAds>().onclick();
			win_sound.Play();
			anim.Play("Victory11");
			time_run = false;
		}

		public void Next_Level()
		{
			//GameObject.Find("AdsManager").GetComponent<unityAdManager>().ShowAd();
			LevelManager.LevelCompleted();
			v_AIMotor.kill = 0;
			SceneManager.LoadScene("LevelManager");
		}

		private IEnumerator MC()
		{
			Mission = true;
			GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = false;
			GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = false;
			mobile_control.SetActive(value: false);
			pause_bttn.SetActive(value: false);
			power1.SetActive(value: false);
			power2.SetActive(value: false);
			Sprint.SetActive(value: false);
			Fly.SetActive(value: false);
			yield return new WaitForSeconds(2f);
			mission_complete();
			yield return new WaitForSeconds(2f);
			particles.SetActive(value: true);
			yield return new WaitForSeconds(2f);
			canvas_MC.SetActive(value: true);
			shoot_btn.SetActive(value: false);
		}

		public void Level1()
		{
			if (v_AIMotor.kill == level_setting.enemies_count && key)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level2()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level3()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				MonoBehaviour.print("LevelComplete");
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level4()
		{
			if (v_AIMotor.kill == level_setting.enemies_count && key)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level5()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level6()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level7()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level8()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level9()
		{
			if (v_AIMotor.kill == level_setting.enemies_count && key)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level10()
		{
			if (v_AIMotor.kill == level_setting.enemies_count && key)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level11()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level12()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level13()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level14()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level15()
		{
			if (v_AIMotor.kill == level_setting.enemies_count && key)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level16()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level17()
		{
			if (v_AIMotor.kill == level_setting.enemies_count && key)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level18()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level19()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Level20()
		{
			if (v_AIMotor.kill == level_setting.enemies_count)
			{
				StartCoroutine(MC());
				Score.text = PlayerPrefs.GetInt("Score").ToString();
				Score_Gain.text = v_AIMotor.enemyscore.ToString();
				v_AIMotor.kill = 0;
			}
		}

		public void Continue()
		{
			background_sound.Play();
			Instruction_Pannel.SetActive(value: false);
			mobile_control.SetActive(value: true);
			time_run = true;
			GameObject.FindGameObjectWithTag("joy1").GetComponent<Image>().enabled = true;
			GameObject.FindGameObjectWithTag("joy2").GetComponent<Image>().enabled = true;
		}

		public IEnumerator Spawn()
		{
			yield return new WaitForSeconds(respawnTimer);
			if (playerPrefab != null && spawnPoint != null)
			{
				if (oldPlayer != null && destroyBodyAfterDead)
				{
					UnityEngine.Object.Destroy(oldPlayer);
				}
				else
				{
					DestroyPlayerComponents(oldPlayer);
				}
				yield return new WaitForEndOfFrame();
				currentPlayer = UnityEngine.Object.Instantiate(playerPrefab, spawnPoint.position, spawnPoint.rotation);
				currentController = currentPlayer.GetComponent<vThirdPersonController>();
				currentController.onDead.AddListener(OnCharacterDead);
				OnReloadGame.Invoke();
			}
		}

		private void OnLevelFinishedLoading(Scene scene, LoadSceneMode mode)
		{
			if (!(currentController.currentHealth > 0f))
			{
				OnReloadGame.Invoke();
				vThirdPersonController vThirdPersonController = UnityEngine.Object.FindObjectOfType<vThirdPersonController>();
				if ((bool)vThirdPersonController)
				{
					currentPlayer = vThirdPersonController.gameObject;
					currentController = vThirdPersonController;
					vThirdPersonController.onDead.AddListener(OnCharacterDead);
				}
				else if (currentPlayer == null && playerPrefab != null && spawnPoint != null)
				{
					Spawn(spawnPoint);
				}
			}
		}

		public void ResetScene()
		{
			DestroyPlayerComponents(oldPlayer);
			SceneManager.LoadScene(SceneManager.GetActiveScene().name);
			if ((bool)oldPlayer && destroyBodyAfterDead)
			{
				UnityEngine.Object.Destroy(oldPlayer);
			}
		}

		private void DestroyPlayerComponents(GameObject target)
		{
			if ((bool)target)
			{
				MonoBehaviour[] componentsInChildren = target.GetComponentsInChildren<MonoBehaviour>();
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					UnityEngine.Object.Destroy(componentsInChildren[i]);
				}
				Collider component = target.GetComponent<Collider>();
				if (component != null)
				{
					UnityEngine.Object.Destroy(component);
				}
				Rigidbody component2 = target.GetComponent<Rigidbody>();
				if (component2 != null)
				{
					UnityEngine.Object.Destroy(component2);
				}
				Animator component3 = target.GetComponent<Animator>();
				if (component3 != null)
				{
					UnityEngine.Object.Destroy(component3);
				}
			}
		}
	}
}
