using Invector.CharacterController;
using UnityEngine;

public class vCollectMeleeControl : MonoBehaviour
{
	[HideInInspector]
	public vMeleeManager meleeManager;

	[Header("Handlers")]
	public vHandler rightHandler = new vHandler();

	public vHandler leftHandler = new vHandler();

	[Header("Unequip Inputs")]
	public GenericInput unequipRightInput;

	public GenericInput unequipLeftInput;

	[HideInInspector]
	public GameObject leftWeapon;

	[HideInInspector]
	public GameObject rightWeapon;

	public vControlDisplayWeaponStandalone controlDisplayPrefab;

	protected vControlDisplayWeaponStandalone currentDisplay;

	protected virtual void Start()
	{
		meleeManager = GetComponent<vMeleeManager>();
		if ((bool)controlDisplayPrefab)
		{
			currentDisplay = Object.Instantiate(controlDisplayPrefab);
		}
	}

	protected virtual void Update()
	{
		UnequipWeaponHandle();
	}

	public virtual void HandleCollectableInput(vCollectableStandalone collectableStandAlone)
	{
		if (!meleeManager || !(collectableStandAlone != null) || !(collectableStandAlone.weapon != null))
		{
			return;
		}
		vMeleeWeapon component = collectableStandAlone.weapon.GetComponent<vMeleeWeapon>();
		if (!component)
		{
			return;
		}
		if (component.meleeType != 0)
		{
			Transform equipPoint = GetEquipPoint(rightHandler, collectableStandAlone.targetEquipPoint);
			if (!equipPoint)
			{
				return;
			}
			collectableStandAlone.weapon.transform.SetParent(equipPoint);
			collectableStandAlone.weapon.transform.localPosition = Vector3.zero;
			collectableStandAlone.weapon.transform.localEulerAngles = Vector3.zero;
			if ((bool)rightWeapon && rightWeapon != component.gameObject)
			{
				RemoveRightWeapon();
			}
			meleeManager.SetRightWeapon(component);
			collectableStandAlone.OnEquip.Invoke();
			rightWeapon = component.gameObject;
			UpdateRightDisplay(collectableStandAlone);
		}
		if (component.meleeType == MeleeType.OnlyAttack || component.meleeType == MeleeType.AttackAndDefense)
		{
			return;
		}
		Transform equipPoint2 = GetEquipPoint(leftHandler, collectableStandAlone.targetEquipPoint);
		if ((bool)equipPoint2)
		{
			collectableStandAlone.weapon.transform.SetParent(equipPoint2);
			collectableStandAlone.weapon.transform.localPosition = Vector3.zero;
			collectableStandAlone.weapon.transform.localEulerAngles = Vector3.zero;
			if ((bool)leftWeapon && leftWeapon != component.gameObject)
			{
				RemoveLeftWeapon();
			}
			meleeManager.SetLeftWeapon(component);
			collectableStandAlone.OnEquip.Invoke();
			leftWeapon = component.gameObject;
			UpdateLeftDisplay(collectableStandAlone);
		}
	}

	protected virtual Transform GetEquipPoint(vHandler point, string name)
	{
		Transform result = point.defaultHandler;
		Transform transform = point.customHandlers.Find((Transform _p) => _p.name.Equals(name));
		if ((bool)transform)
		{
			result = transform;
		}
		return result;
	}

	protected virtual void UnequipWeaponHandle()
	{
		if ((bool)rightWeapon && unequipRightInput.GetButtonDown())
		{
			RemoveRightWeapon();
		}
		if ((bool)leftWeapon && unequipLeftInput.GetButtonDown())
		{
			RemoveLeftWeapon();
		}
	}

	protected virtual void RemoveLeftWeapon()
	{
		if ((bool)leftWeapon)
		{
			leftWeapon.transform.parent = null;
			vCollectableStandalone componentInChildren = leftWeapon.GetComponentInChildren<vCollectableStandalone>();
			if ((bool)componentInChildren)
			{
				componentInChildren.OnDrop.Invoke();
			}
		}
		if ((bool)meleeManager)
		{
			meleeManager.leftWeapon = null;
		}
		UpdateLeftDisplay();
	}

	protected virtual void RemoveRightWeapon()
	{
		if ((bool)rightWeapon)
		{
			rightWeapon.transform.parent = null;
			vCollectableStandalone componentInChildren = rightWeapon.GetComponentInChildren<vCollectableStandalone>();
			if ((bool)componentInChildren)
			{
				componentInChildren.OnDrop.Invoke();
			}
		}
		if ((bool)meleeManager)
		{
			meleeManager.rightWeapon = null;
		}
		UpdateRightDisplay();
	}

	protected virtual void UpdateLeftDisplay(vCollectableStandalone collectable = null)
	{
		if ((bool)currentDisplay)
		{
			if ((bool)collectable)
			{
				currentDisplay.SetLeftWeaponIcon(collectable.weaponIcon);
				currentDisplay.SetLeftWeaponText(collectable.weaponText);
			}
			else
			{
				currentDisplay.RemoveLeftWeaponIcon();
				currentDisplay.RemoveLeftWeaponText();
			}
		}
	}

	protected virtual void UpdateRightDisplay(vCollectableStandalone collectable = null)
	{
		if ((bool)currentDisplay)
		{
			if ((bool)collectable)
			{
				currentDisplay.SetRightWeaponIcon(collectable.weaponIcon);
				currentDisplay.SetRightWeaponText(collectable.weaponText);
			}
			else
			{
				currentDisplay.RemoveRightWeaponIcon();
				currentDisplay.RemoveRightWeaponText();
			}
		}
	}
}
