using UnityEngine;
using UnityEngine.EventSystems;

namespace Invector.ItemManager
{
	public class vItemWindowDisplay : MonoBehaviour
	{
		public vInventory inventory;

		public vItemWindow itemWindow;

		public vItemOptionWindow optionWindow;

		[HideInInspector]
		public vItemSlot currentSelectedSlot;

		[HideInInspector]
		public int amount;

		public void OnEnable()
		{
			if (inventory == null)
			{
				inventory = GetComponentInParent<vInventory>();
			}
			if ((bool)inventory && (bool)itemWindow)
			{
				itemWindow.CreateEquipmentWindow(inventory.items, OnSubmit, OnSelectSlot);
			}
		}

		public void OnSubmit(vItemSlot slot)
		{
			currentSelectedSlot = slot;
			if ((bool)slot.item)
			{
				RectTransform component = slot.GetComponent<RectTransform>();
				optionWindow.transform.position = component.position;
				optionWindow.gameObject.SetActive(value: true);
				optionWindow.EnableOptions(slot);
				currentSelectedSlot = slot;
			}
		}

		public void OnSelectSlot(vItemSlot slot)
		{
			currentSelectedSlot = slot;
		}

		public void DropItem()
		{
			if (amount <= 0)
			{
				return;
			}
			inventory.OnDropItem(currentSelectedSlot.item, amount);
			if (currentSelectedSlot.item.amount <= 0)
			{
				if (itemWindow.slots.Contains(currentSelectedSlot))
				{
					itemWindow.slots.Remove(currentSelectedSlot);
				}
				Object.Destroy(currentSelectedSlot.gameObject);
				if (itemWindow.slots.Count > 0)
				{
					SetSelectable(itemWindow.slots[0].gameObject);
				}
			}
		}

		public void LeaveItem()
		{
			if (amount <= 0)
			{
				return;
			}
			inventory.OnLeaveItem(currentSelectedSlot.item, amount);
			if (currentSelectedSlot.item.amount <= 0)
			{
				if (itemWindow.slots.Contains(currentSelectedSlot))
				{
					itemWindow.slots.Remove(currentSelectedSlot);
				}
				Object.Destroy(currentSelectedSlot.gameObject);
				if (itemWindow.slots.Count > 0)
				{
					SetSelectable(itemWindow.slots[0].gameObject);
				}
			}
		}

		public void UseItem()
		{
			currentSelectedSlot.item.amount--;
			inventory.OnUseItem(currentSelectedSlot.item);
			if (currentSelectedSlot.item.amount <= 0)
			{
				if (itemWindow.slots.Contains(currentSelectedSlot))
				{
					itemWindow.slots.Remove(currentSelectedSlot);
				}
				Object.Destroy(currentSelectedSlot.gameObject);
				if (itemWindow.slots.Count > 0)
				{
					SetSelectable(itemWindow.slots[0].gameObject);
				}
			}
		}

		public void SetOldSelectable()
		{
			try
			{
				if (currentSelectedSlot != null)
				{
					SetSelectable(currentSelectedSlot.gameObject);
				}
				else if (itemWindow.slots.Count > 0 && itemWindow.slots[0] != null)
				{
					SetSelectable(itemWindow.slots[0].gameObject);
				}
			}
			catch
			{
			}
		}

		private void SetSelectable(GameObject target)
		{
			try
			{
				PointerEventData eventData = new PointerEventData(EventSystem.current);
				ExecuteEvents.Execute(EventSystem.current.currentSelectedGameObject, eventData, ExecuteEvents.pointerExitHandler);
				EventSystem.current.SetSelectedGameObject(target, new BaseEventData(EventSystem.current));
				ExecuteEvents.Execute(target, eventData, ExecuteEvents.selectHandler);
			}
			catch
			{
			}
		}
	}
}
