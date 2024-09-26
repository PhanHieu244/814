using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class bl_IconItem : MonoBehaviour
{
	[Separator("SETTINGS")]
	public float DestroyIn = 5f;

	[Separator("REFERENCES")]
	public Image TargetGrapihc;

	public Sprite DeathIcon;

	public Text InfoText;

	private CanvasGroup m_CanvasGroup;

	private Animator Anim;

	private float delay = 0.1f;

	private bool open;

	private void Awake()
	{
		if (GetComponent<CanvasGroup>() != null)
		{
			m_CanvasGroup = GetComponent<CanvasGroup>();
		}
		else
		{
			m_CanvasGroup = base.gameObject.AddComponent<CanvasGroup>();
		}
		if (GetComponent<Animator>() != null)
		{
			Anim = GetComponent<Animator>();
		}
		if (Anim != null)
		{
			Anim.enabled = false;
		}
		m_CanvasGroup.ignoreParentGroups = true;
		m_CanvasGroup.alpha = 0f;
	}

	public void DestroyIcon(bool inmediate)
	{
		if (inmediate)
		{
			Object.Destroy(base.gameObject);
			return;
		}
		TargetGrapihc.sprite = DeathIcon;
		Object.Destroy(base.gameObject, DestroyIn);
	}

	public void DestroyIcon(bool inmediate, Sprite death)
	{
		if (inmediate)
		{
			Object.Destroy(base.gameObject);
			return;
		}
		TargetGrapihc.sprite = death;
		Object.Destroy(base.gameObject, DestroyIn);
	}

	public void GetInfoItem(string info)
	{
		if (!(InfoText == null))
		{
			InfoText.text = info;
		}
	}

	private IEnumerator FadeIcon()
	{
		yield return new WaitForSeconds(delay);
		while (m_CanvasGroup.alpha < 1f)
		{
			m_CanvasGroup.alpha += Time.deltaTime * 2f;
			yield return null;
		}
		if (Anim != null)
		{
			Anim.enabled = true;
		}
	}

	public void InfoItem()
	{
		open = !open;
		Animator component = GetComponent<Animator>();
		if (open)
		{
			component.SetBool("Open", value: true);
		}
		else
		{
			component.SetBool("Open", value: false);
		}
	}

	public void DelayStart(float v)
	{
		delay = v;
		StartCoroutine(FadeIcon());
	}
}
