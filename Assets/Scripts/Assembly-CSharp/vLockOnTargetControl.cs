using Invector;
using UnityEngine;

public class vLockOnTargetControl : vLockOnTarget
{
	[Tooltip("Create a Image inside the UI and assign here")]
	public RectTransform aimImage;

	[Tooltip("Assign the UI here")]
	public Canvas aimCanvas;

	[Tooltip("True: Hide the sprite when not Lock On, False: Always show the Sprite")]
	public bool hideSprite;

	private bool inTarget;

	private void Start()
	{
		Init();
	}

	private void Update()
	{
		CheckForCharacterAlive();
		UpdateAimImage();
	}

	private void CheckForCharacterAlive()
	{
		if (((bool)currentTarget && !isCharacterAlive() && inTarget) || (inTarget && !isCharacterAlive()))
		{
			ResetLockOn();
			inTarget = false;
			UpdateLockOn(value: true);
			if (currentTarget == null)
			{
				SendMessage("ClearTargetLockOn", SendMessageOptions.DontRequireReceiver);
			}
		}
	}

	public void StopLockOn()
	{
		inTarget = false;
		ResetLockOn();
	}

	public override void UpdateLockOn(bool value)
	{
		base.UpdateLockOn(value);
		if (!inTarget && (bool)currentTarget)
		{
			inTarget = true;
			SetTarget();
		}
		else if (inTarget && !currentTarget)
		{
			inTarget = false;
			SendMessage("ClearTargetLockOn", SendMessageOptions.DontRequireReceiver);
		}
	}

	public override void SetTarget()
	{
		SendMessage("SetTargetLockOn", currentTarget.transform, SendMessageOptions.DontRequireReceiver);
	}

	public override void ChangeTarget(int value)
	{
		base.ChangeTarget(value);
	}

	private void UpdateAimImage()
	{
		if (hideSprite)
		{
			if ((bool)currentTarget && !aimImage.transform.gameObject.activeSelf && isCharacterAlive())
			{
				aimImage.transform.gameObject.SetActive(value: true);
			}
			else if (!currentTarget && aimImage.transform.gameObject.activeSelf)
			{
				aimImage.transform.gameObject.SetActive(value: false);
			}
			else if (aimImage.transform.gameObject.activeSelf && !isCharacterAlive())
			{
				aimImage.transform.gameObject.SetActive(value: false);
			}
		}
		if ((bool)currentTarget && (bool)aimImage && (bool)aimCanvas)
		{
			aimImage.anchoredPosition = currentTarget.GetScreenPointOffBoundsCenter(aimCanvas, cam, spriteHeight);
		}
		else if ((bool)aimCanvas)
		{
			aimImage.anchoredPosition = Vector2.zero;
		}
	}
}
