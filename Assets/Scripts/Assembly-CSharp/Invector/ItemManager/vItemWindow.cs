using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Invector.ItemManager
{
	public class vItemWindow : MonoBehaviour
	{
		public vItemSlot slotPrefab;

		public RectTransform contentWindow;

		public Text itemtext;

		private OnSubmitSlot onSubmitSlot;

		private OnSelectSlot onSelectSlot;

		public OnCompleteSlotList onCompleteSlotListCallBack;

		public List<vItemSlot> slots;

		private vItem currentItem;

		private StringBuilder text;

		public void CreateEquipmentWindow(List<vItem> items, OnSubmitSlot onPickUpItemCallBack = null, OnSelectSlot onSelectSlotCallBack = null, bool destroyAdictionSlots = true)
		{
			if (items.Count == 0)
			{
				if ((bool)itemtext)
				{
					itemtext.text = string.Empty;
				}
				if (slots.Count > 0 && destroyAdictionSlots)
				{
					for (int i = 0; i < slots.Count; i++)
					{
						Object.Destroy(slots[i].gameObject);
					}
					slots.Clear();
				}
				return;
			}
			bool flag = false;
			onSubmitSlot = onPickUpItemCallBack;
			onSelectSlot = onSelectSlotCallBack;
			if (slots == null)
			{
				slots = new List<vItemSlot>();
			}
			int count = slots.Count;
			if (count < items.Count)
			{
				for (int j = count; j < items.Count; j++)
				{
					vItemSlot item = Object.Instantiate(slotPrefab);
					slots.Add(item);
				}
			}
			else if (count > items.Count)
			{
				for (int num = count - 1; num > items.Count - 1; num--)
				{
					Object.Destroy(slots[slots.Count - 1].gameObject);
					slots.RemoveAt(slots.Count - 1);
				}
			}
			count = slots.Count;
			for (int k = 0; k < items.Count; k++)
			{
				vItemSlot vItemSlot = null;
				if (k < items.Count)
				{
					vItemSlot = slots[k];
					vItemSlot.AddItem(items[k]);
					vItemSlot.CheckItem(items[k].isInEquipArea);
					vItemSlot.onSubmitSlotCallBack = OnSubmit;
					vItemSlot.onSelectSlotCallBack = OnSelect;
					RectTransform component = vItemSlot.GetComponent<RectTransform>();
					component.SetParent(contentWindow);
					component.localPosition = Vector3.zero;
					component.localScale = Vector3.one;
					if (currentItem != null && currentItem == items[k])
					{
						flag = true;
						SetSelectable(vItemSlot.gameObject);
					}
				}
			}
			if (slots.Count > 0 && !flag)
			{
				StartCoroutine(SetSelectableHandle(slots[0].gameObject));
			}
			if (onCompleteSlotListCallBack != null)
			{
				onCompleteSlotListCallBack(slots);
			}
		}

		public void CreateEquipmentWindow(List<vItem> items, List<vItemType> type, vItem currentItem = null, OnSubmitSlot onPickUpItemCallback = null, OnSelectSlot onSelectSlotCallBack = null)
		{
			this.currentItem = currentItem;
			List<vItem> items2 = items.FindAll((vItem item) => type.Contains(item.type));
			CreateEquipmentWindow(items2, onPickUpItemCallback);
		}

		private IEnumerator SetSelectableHandle(GameObject target)
		{
			if (base.enabled)
			{
				yield return new WaitForEndOfFrame();
				SetSelectable(target);
			}
		}

		private void SetSelectable(GameObject target)
		{
			PointerEventData eventData = new PointerEventData(EventSystem.current);
			ExecuteEvents.Execute(EventSystem.current.currentSelectedGameObject, eventData, ExecuteEvents.pointerExitHandler);
			EventSystem.current.SetSelectedGameObject(target, new BaseEventData(EventSystem.current));
			ExecuteEvents.Execute(target, eventData, ExecuteEvents.selectHandler);
		}

		public void OnSubmit(vItemSlot slot)
		{
			if (onSubmitSlot != null)
			{
				onSubmitSlot(slot);
			}
		}

		public void OnSelect(vItemSlot slot)
		{
			if (itemtext != null)
			{
				if (slot.item == null)
				{
					itemtext.text = string.Empty;
				}
				else
				{
					text = new StringBuilder();
					text.Append(slot.item.name + "\n");
					text.AppendLine(slot.item.description);
					if (slot.item.attributes != null)
					{
						for (int i = 0; i < slot.item.attributes.Count; i++)
						{
							string str = InsertSpaceBeforeUpperCAse(slot.item.attributes[i].name.ToString());
							text.AppendLine(str + " : " + slot.item.attributes[i].value.ToString());
						}
					}
					itemtext.text = text.ToString();
				}
			}
			if (onSelectSlot != null)
			{
				onSelectSlot(slot);
			}
		}

		public string InsertSpaceBeforeUpperCAse(string input)
		{
			string text = string.Empty;
			foreach (char c in input)
			{
				if (char.IsUpper(c) && !string.IsNullOrEmpty(text))
				{
					text += " ";
				}
				text += c;
			}
			return text;
		}

		public void OnCancel()
		{
		}
	}
}
