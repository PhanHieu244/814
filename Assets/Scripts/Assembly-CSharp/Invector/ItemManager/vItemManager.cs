using Invector.CharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Invector.ItemManager
{
	public class vItemManager : MonoBehaviour
	{
		public vInventory inventoryPrefab;

		[HideInInspector]
		public vInventory inventory;

		public vItemListData itemListData;

		public bool dropItemsWhenDead;

		[Header("---Items Filter---")]
		public List<vItemType> itemsFilter = new List<vItemType>
		{
			vItemType.Consumable
		};

		[SerializeField]
		public List<ItemReference> startItems = new List<ItemReference>();

		public List<vItem> items;

		public OnHandleItemEvent onUseItem;

		public OnHandleItemEvent onAddItem;

		public OnChangeItemAmount onLeaveItem;

		public OnChangeItemAmount onDropItem;

		public OnOpenCloseInventory onOpenCloseInventory;

		public OnChangeEquipmentEvent onEquipItem;

		public OnChangeEquipmentEvent onUnequipItem;

		[SerializeField]
		public List<EquipPoint> equipPoints;

		[SerializeField]
		public List<ApplyAttributeEvent> applyAttributeEvents;

		[HideInInspector]
		public bool inEquip;

		private float equipTimer;

		private Animator animator;

		private static vItemManager instance;

		private void Start()
		{
			if (instance != null)
			{
				return;
			}
			inventory = Object.FindObjectOfType<vInventory>();
			instance = this;
			if (!inventory && (bool)inventoryPrefab)
			{
				inventory = Object.Instantiate(inventoryPrefab);
			}
			if ((bool)inventory)
			{
				inventory.GetItemsHandler = GetItems;
				inventory.onEquipItem.AddListener(EquipItem);
				inventory.onUnequipItem.AddListener(UnequipItem);
				inventory.onDropItem.AddListener(DropItem);
				inventory.onLeaveItem.AddListener(LeaveItem);
				inventory.onUseItem.AddListener(UseItem);
				inventory.onOpenCloseInventory.AddListener(OnOpenCloseInventory);
			}
			if (dropItemsWhenDead)
			{
				vCharacter component = GetComponent<vCharacter>();
				if ((bool)component)
				{
					component.onDead.AddListener(DropAllItens);
				}
			}
			items = new List<vItem>();
			if ((bool)itemListData)
			{
				for (int i = 0; i < startItems.Count; i++)
				{
					AddItem(startItems[i]);
				}
			}
			animator = GetComponent<Animator>();
			vMeleeCombatInput component2 = GetComponent<vMeleeCombatInput>();
			if ((bool)component2)
			{
				component2.onUpdateInput.AddListener(UpdateInput);
			}
		}

		public List<vItem> GetItems()
		{
			return items;
		}

		public void AddItem(ItemReference itemReference)
		{
			if (itemReference == null || !(itemListData != null) || itemListData.items.Count <= 0)
			{
				return;
			}
			vItem item = itemListData.items.Find((vItem t) => t.id.Equals(itemReference.id));
			if (!item)
			{
				return;
			}
			List<vItem> list = items.FindAll((vItem i) => i.stackable && i.id == item.id && i.amount < i.maxStack);
			if (list.Count == 0)
			{
				vItem vItem = Object.Instantiate(item);
				vItem.name = vItem.name.Replace("(Clone)", string.Empty);
				if (itemReference.attributes != null && vItem.attributes != null && item.attributes.Count == itemReference.attributes.Count)
				{
					vItem.attributes = new List<vItemAttribute>(itemReference.attributes);
				}
				vItem.amount = 0;
				for (int j = 0; j < item.maxStack; j++)
				{
					if (vItem.amount >= vItem.maxStack)
					{
						break;
					}
					if (itemReference.amount <= 0)
					{
						break;
					}
					vItem.amount++;
					itemReference.amount--;
				}
				items.Add(vItem);
				onAddItem.Invoke(vItem);
				if (itemReference.amount > 0)
				{
					AddItem(itemReference);
				}
				return;
			}
			int index = items.IndexOf(list[0]);
			for (int k = 0; k < items[index].maxStack; k++)
			{
				if (items[index].amount >= items[index].maxStack)
				{
					break;
				}
				if (itemReference.amount <= 0)
				{
					break;
				}
				items[index].amount++;
				itemReference.amount--;
			}
			if (itemReference.amount > 0)
			{
				AddItem(itemReference);
			}
		}

		public void UseItem(vItem item)
		{
			if ((bool)item)
			{
				onUseItem.Invoke(item);
				if (item.attributes != null && item.attributes.Count > 0 && applyAttributeEvents.Count > 0)
				{
					foreach (ApplyAttributeEvent attributeEvent in applyAttributeEvents)
					{
						List<vItemAttribute> list = item.attributes.FindAll((vItemAttribute a) => a.name.Equals(attributeEvent.attribute));
						foreach (vItemAttribute item2 in list)
						{
							attributeEvent.onApplyAttribute.Invoke(item2.value);
						}
					}
				}
				if (item.amount <= 0 && items.Contains(item))
				{
					items.Remove(item);
				}
			}
		}

		public void LeaveItem(vItem item, int amount)
		{
			onLeaveItem.Invoke(item, amount);
			item.amount -= amount;
			if (item.amount > 0 || !items.Contains(item))
			{
				return;
			}
			if (item.type != 0)
			{
				EquipPoint equipPoint = equipPoints.Find((EquipPoint ep) => ep.equipmentReference.item == item || (ep.area != null && (bool)ep.area.ValidSlots.Find((vEquipSlot slot) => slot.item == item)));
				if (equipPoint != null && (bool)equipPoint.area)
				{
					equipPoint.area.RemoveItem(item);
				}
			}
			items.Remove(item);
			Object.Destroy(item);
		}

		public void DropItem(vItem item, int amount)
		{
			item.amount -= amount;
			if (item.dropObject != null)
			{
				GameObject gameObject = Object.Instantiate(item.dropObject, base.transform.position, base.transform.rotation);
				vItemCollection component = gameObject.GetComponent<vItemCollection>();
				if (component != null)
				{
					component.items.Clear();
					ItemReference itemReference = new ItemReference(item.id);
					itemReference.amount = amount;
					itemReference.attributes = new List<vItemAttribute>(item.attributes);
					component.items.Add(itemReference);
				}
			}
			onDropItem.Invoke(item, amount);
			if (item.amount > 0 || !items.Contains(item))
			{
				return;
			}
			if (item.type != 0)
			{
				EquipPoint equipPoint = equipPoints.Find((EquipPoint ep) => ep.equipmentReference.item == item || (ep.area != null && (bool)ep.area.ValidSlots.Find((vEquipSlot slot) => slot.item == item)));
				if (equipPoint != null && (bool)equipPoint.area)
				{
					equipPoint.area.RemoveItem(item);
				}
			}
			items.Remove(item);
			Object.Destroy(item);
		}

		public void DropAllItens(GameObject target = null)
		{
			if (target != null && target != base.gameObject)
			{
				return;
			}
			List<ItemReference> list = new List<ItemReference>();
			int i;
			for (i = 0; i < items.Count; i++)
			{
				if (list.Find((ItemReference _item) => _item.id == items[i].id) != null)
				{
					continue;
				}
				List<vItem> sameItens = items.FindAll((vItem _item) => _item.id == items[i].id);
				ItemReference itemReference = new ItemReference(items[i].id);
				for (int a = 0; a < sameItens.Count; a++)
				{
					if (sameItens[a].type != 0)
					{
						EquipPoint equipPoint = equipPoints.Find((EquipPoint ep) => ep.equipmentReference.item == sameItens[a]);
						if (equipPoint != null && equipPoint.equipmentReference.equipedObject != null)
						{
							UnequipItem(equipPoint.area, equipPoint.equipmentReference.item);
						}
					}
					itemReference.amount += sameItens[a].amount;
					Object.Destroy(sameItens[a]);
				}
				list.Add(itemReference);
				if (equipPoints != null)
				{
					EquipPoint equipPoint2 = equipPoints.Find((EquipPoint e) => e.equipmentReference != null && e.equipmentReference.item != null && e.equipmentReference.item.id == itemReference.id && e.equipmentReference.equipedObject != null);
					if (equipPoint2 != null)
					{
						Object.Destroy(equipPoint2.equipmentReference.equipedObject);
						equipPoint2.equipmentReference = null;
					}
				}
				if ((bool)items[i].dropObject)
				{
					GameObject gameObject = Object.Instantiate(items[i].dropObject, base.transform.position, base.transform.rotation);
					vItemCollection component = gameObject.GetComponent<vItemCollection>();
					if (component != null)
					{
						component.items.Clear();
						component.items.Add(itemReference);
					}
				}
			}
			items.Clear();
		}

		public bool ContainItem(int id)
		{
			return items.Exists((vItem i) => i.id == id);
		}

		public bool ContainItem(int id, int amount)
		{
			vItem x = items.Find((vItem i) => i.id == id && i.amount >= amount);
			return x != null;
		}

		public bool ContainItems(int id, int count)
		{
			List<vItem> list = items.FindAll((vItem i) => i.id == id);
			return list != null && list.Count >= count;
		}

		public vItem GetItem(int id)
		{
			return items.Find((vItem i) => i.id == id);
		}

		public List<vItem> GetItems(int id)
		{
			return items.FindAll((vItem i) => i.id == id);
		}

		public bool IsItemEquipped(int id)
		{
			return equipPoints.Exists((EquipPoint ep) => ep.equipmentReference != null && ep.equipmentReference.item != null && ep.equipmentReference.item.id.Equals(id));
		}

		public bool IsItemEquippedOnSpecificEquipPoint(string equipPointName, int id)
		{
			return equipPoints.Exists((EquipPoint ep) => ep.equipPointName.Equals(equipPointName) && ep.equipmentReference != null && ep.equipmentReference.item != null && ep.equipmentReference.item.id.Equals(id));
		}

		public void EquipItem(vEquipArea equipArea, vItem item)
		{
			onEquipItem.Invoke(equipArea, item);
			if (item != equipArea.currentEquipedItem)
			{
				return;
			}
			EquipPoint equipPoint = equipPoints.Find((EquipPoint ep) => ep.equipPointName == equipArea.equipPointName);
			if (equipPoint == null || !(item != null) || !(equipPoint.equipmentReference.item != item))
			{
				return;
			}
			equipTimer = item.equipDelayTime;
			if (item.type != 0)
			{
				if (!inventory.isOpen)
				{
					animator.SetInteger("EquipItemID", (!equipArea.equipPointName.Contains("Right")) ? (-item.EquipID) : item.EquipID);
					animator.SetTrigger("EquipItem");
				}
				equipPoint.area = equipArea;
				StartCoroutine(EquipItemRoutine(equipPoint, item));
			}
		}

		public void UnequipItem(vEquipArea equipArea, vItem item)
		{
			onUnequipItem.Invoke(equipArea, item);
			EquipPoint equipPoint = equipPoints.Find((EquipPoint ep) => ep.equipPointName == equipArea.equipPointName && ep.equipmentReference.item != null && ep.equipmentReference.item == item);
			if (equipPoint == null || !(item != null))
			{
				return;
			}
			equipTimer = item.equipDelayTime;
			if (item.type != 0)
			{
				if (!inventory.isOpen && !inEquip)
				{
					animator.SetInteger("EquipItemID", (!equipArea.equipPointName.Contains("Right")) ? (-item.EquipID) : item.EquipID);
					animator.SetTrigger("EquipItem");
				}
				StartCoroutine(UnequipItemRoutine(equipPoint, item));
			}
		}

		private IEnumerator EquipItemRoutine(EquipPoint equipPoint, vItem item)
		{
			if (inEquip)
			{
				yield break;
			}
			inventory.canEquip = false;
			inEquip = true;
			if (!inventory.isOpen)
			{
				while (equipTimer > 0f)
				{
					equipTimer -= Time.deltaTime;
					if (item == null)
					{
						break;
					}
					yield return new WaitForEndOfFrame();
				}
			}
			if (equipPoint != null)
			{
				if ((bool)item.originalObject)
				{
					if (equipPoint.equipmentReference != null && equipPoint.equipmentReference.equipedObject != null)
					{
						equipPoint.equipmentReference.equipedObject.GetComponent<vIEquipment>()?.OnUnequip(equipPoint.equipmentReference.item);
						Object.Destroy(equipPoint.equipmentReference.equipedObject);
					}
					Transform transform = equipPoint.handler.customHandlers.Find((Transform p) => p.name == item.customEquipPoint);
					Transform transform2 = (!(transform != null)) ? equipPoint.handler.defaultHandler : transform;
					GameObject gameObject = Object.Instantiate(item.originalObject, transform2.position, transform2.rotation);
					gameObject.transform.parent = transform2;
					if (equipPoint.equipPointName.Contains("Left"))
					{
						Vector3 localScale = gameObject.transform.localScale;
						localScale.x *= -1f;
						gameObject.transform.localScale = localScale;
					}
					equipPoint.equipmentReference.item = item;
					equipPoint.equipmentReference.equipedObject = gameObject;
					gameObject.GetComponent<vIEquipment>()?.OnEquip(item);
					equipPoint.onInstantiateEquiment.Invoke(gameObject);
				}
				else if (equipPoint.equipmentReference != null && equipPoint.equipmentReference.equipedObject != null)
				{
					equipPoint.equipmentReference.equipedObject.GetComponent<vIEquipment>()?.OnUnequip(equipPoint.equipmentReference.item);
					Object.Destroy(equipPoint.equipmentReference.equipedObject);
					equipPoint.equipmentReference.item = null;
				}
			}
			inEquip = false;
			inventory.canEquip = true;
			if (equipPoint != null)
			{
				CheckTwoHandItem(equipPoint, item);
			}
		}

		private void CheckTwoHandItem(EquipPoint equipPoint, vItem item)
		{
			if (!(item == null))
			{
				EquipPoint equipPoint2 = equipPoints.Find((EquipPoint ePoint) => ePoint.area != null && ePoint.equipPointName.Equals("LeftArm") && ePoint.area.currentEquipedItem != null);
				if (equipPoint.equipPointName.Equals("LeftArm"))
				{
					equipPoint2 = equipPoints.Find((EquipPoint ePoint) => ePoint.area != null && ePoint.equipPointName.Equals("RightArm") && ePoint.area.currentEquipedItem != null);
				}
				else if (!equipPoint.equipPointName.Equals("RightArm"))
				{
					return;
				}
				if (equipPoint2 != null && (item.twoHandWeapon || equipPoint2.area.currentEquipedItem.twoHandWeapon))
				{
					equipPoint2.area.RemoveCurrentItem();
				}
			}
		}

		private IEnumerator UnequipItemRoutine(EquipPoint equipPoint, vItem item)
		{
			if (inEquip)
			{
				yield break;
			}
			inventory.canEquip = false;
			inEquip = true;
			if (equipPoint != null && equipPoint.equipmentReference != null && equipPoint.equipmentReference.equipedObject != null)
			{
				equipPoint.equipmentReference.equipedObject.GetComponent<vIEquipment>()?.OnUnequip(item);
				if (!inventory.isOpen)
				{
					while (equipTimer > 0f)
					{
						equipTimer -= Time.deltaTime;
						yield return new WaitForEndOfFrame();
					}
				}
				Object.Destroy(equipPoint.equipmentReference.equipedObject);
				equipPoint.equipmentReference.item = null;
			}
			inEquip = false;
			inventory.canEquip = true;
		}

		private void OnOpenCloseInventory(bool value)
		{
			if (value)
			{
				animator.SetTrigger("ResetState");
			}
			onOpenCloseInventory.Invoke(value);
		}

		public void SetEquipmmentToArea(vItem item, string equipPointName)
		{
			if ((bool)inventory)
			{
				inventory.changeEquipmentControllers.Find((ChangeEquipmentControl c) => c.equipArea != null && c.equipArea.equipPointName.Equals(equipPointName))?.equipArea.EquiItemToSlot(item);
			}
		}

		public void UpdateInput(vMeleeCombatInput tpInput)
		{
			inventory.lockInput = tpInput.lockInventory;
			tpInput.lockInputByItemManager = (inventory.isOpen || inEquip);
		}
	}
}
