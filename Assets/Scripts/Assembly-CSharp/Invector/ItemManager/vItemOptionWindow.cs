using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Invector.ItemManager
{
	public class vItemOptionWindow : MonoBehaviour
	{
		public Button useItemButton;

		public List<vItemType> itemsCanBeUsed = new List<vItemType>
		{
			vItemType.Consumable
		};

		public void EnableOptions(vItemSlot slot)
		{
			if (!(slot == null) && !(slot.item == null))
			{
				useItemButton.interactable = itemsCanBeUsed.Contains(slot.item.type);
			}
		}
	}
}
