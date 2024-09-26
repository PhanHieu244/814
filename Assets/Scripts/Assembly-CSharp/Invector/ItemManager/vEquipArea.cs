using System.Collections.Generic;
using UnityEngine;

namespace Invector.ItemManager
{
	public class vEquipArea : MonoBehaviour
	{
		public delegate void OnPickUpItem(vEquipArea area, vItemSlot slot);

		public OnPickUpItem onPickUpItemCallBack;

		public vInventory inventory;

		public InventoryWindow rootWindow;

		public vItemWindow itemPicker;

		public List<vEquipSlot> equipSlots;

		public string equipPointName;

		public OnChangeEquipmentEvent onEquipItem;

		public OnChangeEquipmentEvent onUnequipItem;

		[HideInInspector]
		public vEquipSlot currentSelectedSlot;

		private int indexOfEquipedItem;

		public vItem lastEquipedItem;

		public vItem currentEquipedItem
		{
			get
			{
				List<vEquipSlot> validSlots = ValidSlots;
				return validSlots[indexOfEquipedItem].item;
			}
		}

		public List<vEquipSlot> ValidSlots => equipSlots.FindAll((vEquipSlot slot) => slot.isValid);

		private void Start()
		{
			inventory = GetComponentInParent<vInventory>();
			if (equipSlots.Count == 0)
			{
				vEquipSlot[] componentsInChildren = GetComponentsInChildren<vEquipSlot>();
				equipSlots = componentsInChildren.vToList();
			}
			rootWindow = GetComponentInParent<InventoryWindow>();
			foreach (vEquipSlot equipSlot in equipSlots)
			{
				equipSlot.onSubmitSlotCallBack = OnSubmitSlot;
				equipSlot.onSelectSlotCallBack = OnSelectSlot;
				equipSlot.onDeselectSlotCallBack = OnDeselect;
				equipSlot.amountText.text = string.Empty;
			}
		}

		public void OnSubmitSlot(vItemSlot slot)
		{
			if (itemPicker != null)
			{
				currentSelectedSlot = (slot as vEquipSlot);
				itemPicker.gameObject.SetActive(value: true);
				itemPicker.CreateEquipmentWindow(inventory.items, currentSelectedSlot.itemType, slot.item, OnPickItem);
			}
		}

		public void RemoveItem(vEquipSlot slot)
		{
			if ((bool)slot)
			{
				vItem item = slot.item;
				slot.RemoveItem();
				onUnequipItem.Invoke(this, item);
			}
		}

		public void RemoveItem(vItem item)
		{
			vEquipSlot vEquipSlot = ValidSlots.Find((vEquipSlot _slot) => _slot.item == item);
			if ((bool)vEquipSlot)
			{
				vEquipSlot.RemoveItem();
				onUnequipItem.Invoke(this, item);
			}
		}

		public void RemoveItem()
		{
			if ((bool)currentSelectedSlot)
			{
				vItem item = currentSelectedSlot.item;
				currentSelectedSlot.RemoveItem();
				onUnequipItem.Invoke(this, item);
			}
		}

		public void RemoveCurrentItem()
		{
			if ((bool)currentEquipedItem)
			{
				lastEquipedItem = currentEquipedItem;
				ValidSlots[indexOfEquipedItem].RemoveItem();
				onUnequipItem.Invoke(this, lastEquipedItem);
			}
		}

		public void OnSelectSlot(vItemSlot slot)
		{
			currentSelectedSlot = (slot as vEquipSlot);
		}

		public void OnDeselect(vItemSlot slot)
		{
			currentSelectedSlot = null;
		}

		public void OnPickItem(vItemSlot slot)
		{
			if (currentSelectedSlot.item != null && slot.item != currentSelectedSlot.item)
			{
				currentSelectedSlot.item.isInEquipArea = false;
				onUnequipItem.Invoke(this, currentSelectedSlot.item);
			}
			if (slot.item != currentSelectedSlot.item)
			{
				if (onPickUpItemCallBack != null && (bool)slot)
				{
					onPickUpItemCallBack(this, slot);
				}
				if (currentSelectedSlot.item != null && currentSelectedSlot.item != slot.item)
				{
					lastEquipedItem = slot.item;
				}
				currentSelectedSlot.AddItem(slot.item);
				onEquipItem.Invoke(this, slot.item);
			}
			itemPicker.gameObject.SetActive(value: false);
		}

		public void NextEquipSlot()
		{
			if (equipSlots != null && equipSlots.Count != 0)
			{
				lastEquipedItem = currentEquipedItem;
				List<vEquipSlot> validSlots = ValidSlots;
				if (indexOfEquipedItem + 1 < validSlots.Count)
				{
					indexOfEquipedItem++;
				}
				else
				{
					indexOfEquipedItem = 0;
				}
				onEquipItem.Invoke(this, currentEquipedItem);
				onUnequipItem.Invoke(this, lastEquipedItem);
			}
		}

		public void PreviousEquipSlot()
		{
			if (equipSlots != null && equipSlots.Count != 0)
			{
				lastEquipedItem = currentEquipedItem;
				List<vEquipSlot> validSlots = ValidSlots;
				if (indexOfEquipedItem - 1 >= 0)
				{
					indexOfEquipedItem--;
				}
				else
				{
					indexOfEquipedItem = validSlots.Count - 1;
				}
				onEquipItem.Invoke(this, currentEquipedItem);
				onUnequipItem.Invoke(this, lastEquipedItem);
			}
		}

		public void SetEquipSlot(int index)
		{
			if (equipSlots != null && equipSlots.Count != 0 && index < equipSlots.Count && equipSlots[index].item != currentEquipedItem)
			{
				lastEquipedItem = currentEquipedItem;
				indexOfEquipedItem = index;
				onEquipItem.Invoke(this, currentEquipedItem);
				onUnequipItem.Invoke(this, lastEquipedItem);
			}
		}

		public bool ContainsItem(vItem item)
		{
			return ValidSlots.Find((vEquipSlot slot) => slot.item == item) != null;
		}

		public void EquiItemToSlot(vItem item, vEquipSlot slot = null)
		{
			if (slot == null && indexOfEquipedItem < equipSlots.Count)
			{
				currentSelectedSlot = equipSlots[indexOfEquipedItem];
			}
			else if (equipSlots.Contains(currentSelectedSlot))
			{
				currentSelectedSlot = slot;
			}
			if (!currentSelectedSlot)
			{
				return;
			}
			if (item != currentSelectedSlot.item && currentSelectedSlot.item != null)
			{
				onUnequipItem.Invoke(this, currentSelectedSlot.item);
			}
			if (currentSelectedSlot.item != item)
			{
				if (onPickUpItemCallBack != null && (bool)slot)
				{
					onPickUpItemCallBack(this, slot);
				}
				if (currentSelectedSlot.item != item)
				{
					lastEquipedItem = slot.item;
				}
				currentSelectedSlot.AddItem(item);
				onEquipItem.Invoke(this, item);
				if (currentSelectedSlot.item != null)
				{
					currentSelectedSlot.item.isInEquipArea = false;
				}
			}
		}
	}
}
