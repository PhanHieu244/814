using System;
using UnityEngine;

public class MyGUI3_1 : MonoBehaviour
{
	public enum GuiStat
	{
		Ball,
		BallRotate,
		BallRotatex4,
		Bottom,
		Middle,
		MiddleWithoutRobot,
		Top,
		TopTarget
	}

	public int CurrentPrefabNomber;

	public float UpdateInterval = 0.5f;

	public Light DirLight;

	public GameObject Target;

	public GameObject TopPosition;

	public GameObject MiddlePosition;

	public Vector3 defaultRobotPos;

	public GameObject BottomPosition;

	public GameObject Plane1;

	public GameObject Plane2;

	public Material[] PlaneMaterials;

	public GuiStat[] GuiStats;

	public GameObject[] Prefabs;

	private float oldLightIntensity;

	private Color oldAmbientColor;

	private GameObject currentGo;

	private bool isDay;

	private bool isHomingMove;

	private bool isDefaultPlaneTexture;

	private int current;

	private Animator anim;

	private float prefabSpeed = 4f;

	private EffectSettings effectSettings;

	private bool isReadyEffect;

	private Quaternion defaultRobotRotation;

	private float accum;

	private int frames;

	private float timeleft;

	private float fps;

	private GUIStyle guiStyleHeader = new GUIStyle();

	private void Start()
	{
		oldAmbientColor = RenderSettings.ambientLight;
		oldLightIntensity = DirLight.intensity;
		anim = Target.GetComponent<Animator>();
		guiStyleHeader.fontSize = 14;
		guiStyleHeader.normal.textColor = new Color(1f, 1f, 1f);
		EffectSettings component = Prefabs[current].GetComponent<EffectSettings>();
		if (component != null)
		{
			prefabSpeed = component.MoveSpeed;
		}
		current = CurrentPrefabNomber;
		InstanceCurrent(GuiStats[CurrentPrefabNomber]);
	}

	private void InstanceEffect(Vector3 pos)
	{
		currentGo = UnityEngine.Object.Instantiate(Prefabs[current], pos, Prefabs[current].transform.rotation);
		effectSettings = currentGo.GetComponent<EffectSettings>();
		effectSettings.Target = GetTargetObject(GuiStats[current]);
		if (isHomingMove)
		{
			effectSettings.IsHomingMove = isHomingMove;
		}
		prefabSpeed = effectSettings.MoveSpeed;
		effectSettings.EffectDeactivated += effectSettings_EffectDeactivated;
		if (GuiStats[current] == GuiStat.Middle)
		{
			currentGo.transform.parent = GetTargetObject(GuiStat.Middle).transform;
			currentGo.transform.position = GetInstancePosition(GuiStat.Middle);
		}
		else
		{
			currentGo.transform.parent = base.transform;
		}
		effectSettings.CollisionEnter += delegate(object n, CollisionInfo e)
		{
			if (e.Hit.transform != null)
			{
				Debug.Log(e.Hit.transform.name);
			}
		};
	}

	private GameObject GetTargetObject(GuiStat stat)
	{
		switch (stat)
		{
		case GuiStat.Ball:
			return Target;
		case GuiStat.BallRotate:
			return Target;
		case GuiStat.Bottom:
			return BottomPosition;
		case GuiStat.Top:
			return TopPosition;
		case GuiStat.TopTarget:
			return BottomPosition;
		case GuiStat.Middle:
			MiddlePosition.transform.localPosition = defaultRobotPos;
			MiddlePosition.transform.localRotation = Quaternion.Euler(0f, 180f, 0f);
			return MiddlePosition;
		case GuiStat.MiddleWithoutRobot:
			return MiddlePosition.transform.parent.gameObject;
		default:
			return base.gameObject;
		}
	}

	private void effectSettings_EffectDeactivated(object sender, EventArgs e)
	{
		if (GuiStats[current] != GuiStat.Middle)
		{
			currentGo.transform.position = GetInstancePosition(GuiStats[current]);
		}
		isReadyEffect = true;
	}

	private void OnGUI()
	{
		if (GUI.Button(new Rect(10f, 15f, 105f, 30f), "Previous Effect"))
		{
			ChangeCurrent(-1);
		}
		if (GUI.Button(new Rect(130f, 15f, 105f, 30f), "Next Effect"))
		{
			ChangeCurrent(1);
		}
		if (Prefabs[current] != null)
		{
			GUI.Label(new Rect(300f, 15f, 100f, 20f), "Prefab name is \"" + Prefabs[current].name + "\"  \r\nHold any mouse button that would move the camera", guiStyleHeader);
		}
		if (GUI.Button(new Rect(10f, 60f, 225f, 30f), "Day/Night"))
		{
			DirLight.intensity = (isDay ? oldLightIntensity : 0f);
			RenderSettings.ambientLight = (isDay ? oldAmbientColor : new Color(0.1f, 0.1f, 0.1f));
			isDay = !isDay;
		}
		if (GUI.Button(new Rect(10f, 105f, 225f, 30f), "Change environment"))
		{
			if (isDefaultPlaneTexture)
			{
				Plane1.GetComponent<Renderer>().material = PlaneMaterials[0];
				Plane2.GetComponent<Renderer>().material = PlaneMaterials[0];
			}
			else
			{
				Plane1.GetComponent<Renderer>().material = PlaneMaterials[1];
				Plane2.GetComponent<Renderer>().material = PlaneMaterials[2];
			}
			isDefaultPlaneTexture = !isDefaultPlaneTexture;
		}
		if (current <= 40)
		{
			GUI.Label(new Rect(10f, 152f, 225f, 30f), "Ball Speed " + (int)prefabSpeed + "m", guiStyleHeader);
			prefabSpeed = GUI.HorizontalSlider(new Rect(115f, 155f, 120f, 30f), prefabSpeed, 1f, 30f);
			isHomingMove = GUI.Toggle(new Rect(10f, 190f, 150f, 30f), isHomingMove, " Is Homing Move");
			effectSettings.MoveSpeed = prefabSpeed;
		}
	}

	private void Update()
	{
		anim.enabled = isHomingMove;
		timeleft -= Time.deltaTime;
		accum += Time.timeScale / Time.deltaTime;
		frames++;
		if ((double)timeleft <= 0.0)
		{
			fps = accum / (float)frames;
			timeleft = UpdateInterval;
			accum = 0f;
			frames = 0;
		}
		if (isReadyEffect)
		{
			isReadyEffect = false;
			currentGo.SetActive(value: true);
		}
		if (GuiStats[current] == GuiStat.BallRotate)
		{
			currentGo.transform.localRotation = Quaternion.Euler(0f, Mathf.PingPong(Time.time * 5f, 60f) - 50f, 0f);
		}
		if (GuiStats[current] == GuiStat.BallRotatex4)
		{
			currentGo.transform.localRotation = Quaternion.Euler(0f, Mathf.PingPong(Time.time * 30f, 100f) - 70f, 0f);
		}
	}

	private void InstanceCurrent(GuiStat stat)
	{
		switch (stat)
		{
		case GuiStat.Ball:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(base.transform.position);
			break;
		case GuiStat.BallRotate:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(base.transform.position);
			break;
		case GuiStat.BallRotatex4:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(base.transform.position);
			break;
		case GuiStat.Bottom:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(BottomPosition.transform.position);
			break;
		case GuiStat.Top:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(TopPosition.transform.position);
			break;
		case GuiStat.TopTarget:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(TopPosition.transform.position);
			break;
		case GuiStat.Middle:
			MiddlePosition.SetActive(value: true);
			InstanceEffect(MiddlePosition.transform.parent.transform.position);
			break;
		case GuiStat.MiddleWithoutRobot:
			MiddlePosition.SetActive(value: false);
			InstanceEffect(MiddlePosition.transform.position);
			break;
		}
	}

	private Vector3 GetInstancePosition(GuiStat stat)
	{
		switch (stat)
		{
		case GuiStat.Ball:
			return base.transform.position;
		case GuiStat.BallRotate:
			return base.transform.position;
		case GuiStat.BallRotatex4:
			return base.transform.position;
		case GuiStat.Bottom:
			return BottomPosition.transform.position;
		case GuiStat.Top:
			return TopPosition.transform.position;
		case GuiStat.TopTarget:
			return TopPosition.transform.position;
		case GuiStat.MiddleWithoutRobot:
			return MiddlePosition.transform.parent.transform.position;
		case GuiStat.Middle:
			return MiddlePosition.transform.parent.transform.position;
		default:
			return base.transform.position;
		}
	}

	private void ChangeCurrent(int delta)
	{
		UnityEngine.Object.Destroy(currentGo);
		CancelInvoke("InstanceDefaulBall");
		current += delta;
		if (current > Prefabs.Length - 1)
		{
			current = 0;
		}
		else if (current < 0)
		{
			current = Prefabs.Length - 1;
		}
		if (effectSettings != null)
		{
			effectSettings.EffectDeactivated -= effectSettings_EffectDeactivated;
		}
		MiddlePosition.SetActive(GuiStats[current] == GuiStat.Middle);
		InstanceEffect(GetInstancePosition(GuiStats[current]));
	}
}
