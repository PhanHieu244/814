using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Invector.ItemManager
{
	public class vWeaponHolderManager : MonoBehaviour
	{
		public vWeaponHolder[] holders = new vWeaponHolder[0];

		[HideInInspector]
		public bool inEquip;

		[HideInInspector]
		public vItemManager itemManager;

		public Dictionary<string, List<vWeaponHolder>> holderAreas = new Dictionary<string, List<vWeaponHolder>>();

		private float timer;

		private void OnDrawGizmosSelected()
		{
			holders = GetComponentsInChildren<vWeaponHolder>(includeInactive: true);
		}

		private void Start()
		{
			itemManager = GetComponent<vItemManager>();
			if (!itemManager)
			{
				return;
			}
			itemManager.onEquipItem.AddListener(EquipWeapon);
			itemManager.onUnequipItem.AddListener(UnequipWeapon);
			holders = GetComponentsInChildren<vWeaponHolder>(includeInactive: true);
			if (holders == null)
			{
				return;
			}
			vWeaponHolder[] array = holders;
			foreach (vWeaponHolder vWeaponHolder in array)
			{
				if (!holderAreas.ContainsKey(vWeaponHolder.equipPointName))
				{
					holderAreas.Add(vWeaponHolder.equipPointName, new List<vWeaponHolder>());
					holderAreas[vWeaponHolder.equipPointName].Add(vWeaponHolder);
				}
				else
				{
					holderAreas[vWeaponHolder.equipPointName].Add(vWeaponHolder);
				}
				vWeaponHolder.SetActiveHolder(active: false);
				vWeaponHolder.SetActiveWeapon(active: false);
			}
		}

		public void EquipWeapon(vEquipArea equipArea, vItem item)
		{
			List<vEquipSlot> itemInArea = equipArea.ValidSlots;
			if (itemInArea == null || itemInArea.Count <= 0 || !holderAreas.ContainsKey(equipArea.equipPointName))
			{
				return;
			}
			for (int i = 0; i < itemInArea.Count; i++)
			{
				if (itemInArea[i].item != null)
				{
					vWeaponHolder vWeaponHolder = holderAreas[equipArea.equipPointName].Find((vWeaponHolder h) => itemInArea[i].item.id == h.itemID && equipArea.currentEquipedItem != item && equipArea.currentEquipedItem != itemInArea[i]);
					if ((bool)vWeaponHolder)
					{
						vWeaponHolder.SetActiveHolder(active: true);
						vWeaponHolder.SetActiveWeapon(active: true);
					}
				}
				if (equipArea.currentEquipedItem != null)
				{
					vWeaponHolder vWeaponHolder2 = holderAreas[equipArea.equipPointName].Find((vWeaponHolder h) => h.itemID == equipArea.currentEquipedItem.id);
					if ((bool)vWeaponHolder2)
					{
						vWeaponHolder2.equipDelayTime = equipArea.currentEquipedItem.equipDelayTime;
						StartCoroutine(ActiveHolder(vWeaponHolder2, activeWeapon: false, itemManager.inventory != null && itemManager.inventory.isOpen));
					}
				}
				if (equipArea.lastEquipedItem != null && equipArea.lastEquipedItem != equipArea.currentEquipedItem)
				{
					vWeaponHolder vWeaponHolder3 = holderAreas[equipArea.equipPointName].Find((vWeaponHolder h) => h.itemID == equipArea.lastEquipedItem.id);
					if ((bool)vWeaponHolder3)
					{
						vWeaponHolder3.equipDelayTime = equipArea.lastEquipedItem.equipDelayTime;
						StartCoroutine(ActiveHolder(vWeaponHolder3, activeWeapon: true, itemManager.inventory != null && itemManager.inventory.isOpen));
					}
				}
			}
		}

		public void UnequipWeapon(vEquipArea equipArea, vItem item)
		{
			if (holders.Length != 0 && !(item == null) && itemManager.inventory != null && holderAreas.ContainsKey(equipArea.equipPointName))
			{
				vWeaponHolder vWeaponHolder = holderAreas[equipArea.equipPointName].Find((vWeaponHolder h) => item.id == h.itemID);
				if ((bool)vWeaponHolder)
				{
					bool activeHolder = equipArea.ValidSlots.Find((vEquipSlot slot) => slot.item == item) != null;
					vWeaponHolder.SetActiveHolder(activeHolder);
					vWeaponHolder.SetActiveWeapon(active: false);
				}
			}
		}

		private IEnumerator ActiveHolder(vWeaponHolder holder, bool activeWeapon, bool immediat = false)
		{
			if (!immediat)
			{
				inEquip = true;
			}
			timer = holder.equipDelayTime;
			holder.SetActiveHolder(active: true);
			if (!activeWeapon)
			{
				holder.SetActiveWeapon(active: true);
			}
			while (timer > 0f && !immediat)
			{
				yield return new WaitForEndOfFrame();
				timer -= Time.deltaTime;
			}
			holder.SetActiveWeapon(activeWeapon);
			inEquip = false;
		}
	}
}
