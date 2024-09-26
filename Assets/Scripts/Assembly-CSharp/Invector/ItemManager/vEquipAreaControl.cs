using System.Collections.Generic;
using UnityEngine;

namespace Invector.ItemManager
{
	public class vEquipAreaControl : MonoBehaviour
	{
		[HideInInspector]
		public List<vEquipArea> equipAreas;

		private void Start()
		{
			equipAreas = GetComponentsInChildren<vEquipArea>().vToList();
			foreach (vEquipArea equipArea in equipAreas)
			{
				equipArea.onPickUpItemCallBack = OnPickUpItemCallBack;
			}
			vInventory componentInParent = GetComponentInParent<vInventory>();
			if ((bool)componentInParent)
			{
				componentInParent.onOpenCloseInventory.AddListener(OnOpen);
			}
		}

		public void OnOpen(bool value)
		{
		}

		public void OnPickUpItemCallBack(vEquipArea area, vItemSlot slot)
		{
			for (int i = 0; i < equipAreas.Count; i++)
			{
				List<vEquipSlot> list = equipAreas[i].equipSlots.FindAll((vEquipSlot _slot) => _slot.item != null && _slot.item == slot.item);
				for (int j = 0; j < list.Count; j++)
				{
					equipAreas[i].onUnequipItem.Invoke(equipAreas[i], list[j].item);
					equipAreas[i].RemoveItem(list[j]);
				}
			}
			CheckTwoHandItem(area, slot);
		}

		private void CheckTwoHandItem(vEquipArea area, vItemSlot slot)
		{
			if (!(slot.item == null))
			{
				vEquipArea vEquipArea = equipAreas.Find((vEquipArea _area) => _area != null && area.equipPointName.Equals("LeftArm") && _area.currentEquipedItem != null);
				if (area.equipPointName.Equals("LeftArm"))
				{
					vEquipArea = equipAreas.Find((vEquipArea _area) => _area != null && area.equipPointName.Equals("RightArm") && _area.currentEquipedItem != null);
				}
				else if (!area.equipPointName.Equals("RightArm"))
				{
					return;
				}
				if (vEquipArea != null && (slot.item.twoHandWeapon || vEquipArea.currentEquipedItem.twoHandWeapon))
				{
					vEquipArea.onUnequipItem.Invoke(vEquipArea, slot.item);
					vEquipArea.RemoveItem(slot as vEquipSlot);
				}
			}
		}
	}
}
