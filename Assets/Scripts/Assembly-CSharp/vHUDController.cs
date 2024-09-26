using Invector.CharacterController;
using UnityEngine;
using UnityEngine.UI;

public class vHUDController : MonoBehaviour
{
	[Header("Health/Stamina")]
	public Slider healthSlider;

	public Slider staminaSlider;

	[Header("DamageHUD")]
	public Image damageImage;

	public float flashSpeed = 5f;

	public Color flashColour = new Color(1f, 0f, 0f, 0.1f);

	[HideInInspector]
	public bool damaged;

	[HideInInspector]
	public bool showInteractiveText = true;

	[Header("Interactable Text-Icon")]
	public Text interactableText;

	public Image interactableIcon;

	public Sprite joystickButton;

	public Sprite keyboardButton;

	public float actionTextDelay = 1f;

	private float currentActionTextTime;

	private vTriggerAction currentTriggerAction;

	private vTriggerLadderAction currentTriggerLadderAction;

	[Header("Controls Display")]
	[HideInInspector]
	public bool controllerInput;

	public Image displayControls;

	public Sprite joystickControls;

	public Sprite keyboardControls;

	[Header("Debug Window")]
	public GameObject debugPanel;

	[HideInInspector]
	public Text debugText;

	[Header("Text with FadeIn/Out")]
	public Text fadeText;

	private float textDuration;

	private float fadeDuration;

	private float durationTimer;

	private float timer;

	private Color startColor;

	private Color endColor;

	private bool fade;

	private static vHUDController _instance;

	public static vHUDController instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = Object.FindObjectOfType<vHUDController>();
			}
			return _instance;
		}
	}

	private void Start()
	{
		HideActionText();
		InitFadeText();
		if (debugPanel != null)
		{
			debugText = debugPanel.GetComponentInChildren<Text>();
		}
	}

	public void Init(vThirdPersonController cc)
	{
		cc.onDead.AddListener(OnDead);
		cc.onReceiveDamage.AddListener(EnableDamageSprite);
		damageImage.color = new Color(0f, 0f, 0f, 0f);
	}

	private void OnDead(GameObject arg0)
	{
		FadeText("You are Dead!", 2f, 0.5f);
	}

	public virtual void UpdateHUD(vThirdPersonController cc)
	{
		UpdateDebugWindow(cc);
		UpdateSliders(cc);
		ChangeInputDisplay();
		ShowDamageSprite();
		FadeEffect();
		CheckActionTrigger(cc);
		CheckLadderActionTrigger(cc);
	}

	public void ShowText(string message)
	{
		FadeText(message, 2f, 0.5f);
	}

	private void CheckActionTrigger(vThirdPersonController cc)
	{
		if (cc.ladderAction != null)
		{
			return;
		}
		if ((cc.triggerAction != null && currentActionTextTime <= 0f && !showInteractiveText) || (cc.triggerAction != null && cc.triggerAction != currentTriggerAction))
		{
			if (!cc.actions)
			{
				currentTriggerAction = cc.triggerAction;
				if (cc.triggerAction.CanUse())
				{
					currentActionTextTime = actionTextDelay;
					if (!cc.triggerAction.autoAction)
					{
						ShowActionText(cc.triggerAction.message, showIcon: true);
					}
				}
				else if (!cc.triggerAction.autoAction)
				{
					ShowActionText("Can't " + cc.triggerAction.message, showIcon: false);
				}
			}
			else
			{
				HideActionText();
			}
		}
		else if (cc.triggerAction == null)
		{
			currentTriggerAction = null;
			currentActionTextTime -= Time.deltaTime;
			HideActionText();
		}
	}

	private void CheckLadderActionTrigger(vThirdPersonController cc)
	{
		if (cc.triggerAction != null)
		{
			return;
		}
		if ((cc.ladderAction != null && currentActionTextTime <= 0f && !showInteractiveText) || (cc.ladderAction != null && cc.ladderAction != currentTriggerLadderAction))
		{
			if (!cc.isUsingLadder)
			{
				currentTriggerLadderAction = cc.ladderAction;
				currentActionTextTime = actionTextDelay;
				if (!cc.ladderAction.autoAction)
				{
					ShowActionText(cc.ladderAction.enterMessage, showIcon: true);
				}
			}
			else
			{
				HideActionText();
			}
		}
		else if (cc.ladderAction == null || cc.isUsingLadder)
		{
			currentTriggerLadderAction = null;
			currentActionTextTime -= Time.deltaTime;
			HideActionText();
		}
	}

	private void UpdateSliders(vThirdPersonController cc)
	{
		if (cc.maxHealth != healthSlider.maxValue)
		{
			healthSlider.maxValue = Mathf.Lerp(healthSlider.maxValue, cc.maxHealth, 2f * Time.fixedDeltaTime);
			healthSlider.onValueChanged.Invoke(healthSlider.value);
		}
		healthSlider.value = Mathf.Lerp(healthSlider.value, cc.currentHealth, 2f * Time.fixedDeltaTime);
		if (cc.maxStamina != staminaSlider.maxValue)
		{
			staminaSlider.maxValue = Mathf.Lerp(staminaSlider.maxValue, cc.maxStamina, 2f * Time.fixedDeltaTime);
			staminaSlider.onValueChanged.Invoke(staminaSlider.value);
		}
		staminaSlider.value = cc.currentStamina;
	}

	public void ShowDamageSprite()
	{
		if (damaged)
		{
			damaged = false;
			if (damageImage != null)
			{
				damageImage.color = flashColour;
			}
		}
		else if (damageImage != null)
		{
			damageImage.color = Color.Lerp(damageImage.color, Color.clear, flashSpeed * Time.deltaTime);
		}
	}

	public void EnableDamageSprite(Damage damage)
	{
		if (damageImage != null)
		{
			damageImage.enabled = true;
		}
		damaged = true;
	}

	private void UpdateDebugWindow(vThirdPersonController cc)
	{
		if (cc.debugWindow)
		{
			if (debugPanel != null && !debugPanel.activeSelf)
			{
				debugPanel.SetActive(value: true);
			}
			if ((bool)debugText)
			{
				debugText.text = cc.DebugInfo(string.Empty);
			}
		}
		else if (debugPanel != null && debugPanel.activeSelf)
		{
			debugPanel.SetActive(value: false);
		}
	}

	public void ShowActionText(string name, bool showIcon)
	{
		showInteractiveText = true;
		if (controllerInput)
		{
			interactableIcon.sprite = joystickButton;
		}
		else
		{
			interactableIcon.sprite = keyboardButton;
		}
		if (showIcon)
		{
			interactableIcon.enabled = true;
		}
		else
		{
			interactableIcon.enabled = false;
		}
		interactableText.enabled = true;
		interactableText.text = name;
	}

	public void HideActionText()
	{
		showInteractiveText = false;
		interactableIcon.enabled = false;
		interactableText.enabled = false;
		interactableText.text = string.Empty;
	}

	private void ChangeInputDisplay()
	{
		displayControls.enabled = false;
	}

	private void InitFadeText()
	{
		if (fadeText != null)
		{
			startColor = fadeText.color;
			endColor.a = 0f;
			fadeText.color = endColor;
		}
		else
		{
			Debug.Log("Please assign a Text object on the field Fade Text");
		}
	}

	private void FadeEffect()
	{
		if (!(fadeText != null))
		{
			return;
		}
		if (fade)
		{
			fadeText.color = Color.Lerp(endColor, startColor, timer);
			if (timer < 1f)
			{
				timer += Time.deltaTime / fadeDuration;
			}
			Color color = fadeText.color;
			if (color.a >= 1f)
			{
				fade = false;
				timer = 0f;
			}
			return;
		}
		Color color2 = fadeText.color;
		if (color2.a >= 1f)
		{
			durationTimer += Time.deltaTime;
		}
		if (durationTimer >= textDuration)
		{
			fadeText.color = Color.Lerp(startColor, endColor, timer);
			if (timer < 1f)
			{
				timer += Time.deltaTime / fadeDuration;
			}
		}
	}

	public void FadeText(string textToFade, float textTime, float fadeTime)
	{
		if (fadeText != null && !fade)
		{
			fadeText.text = textToFade;
			textDuration = textTime;
			fadeDuration = fadeTime;
			durationTimer = 0f;
			timer = 0f;
			fade = true;
		}
	}
}
