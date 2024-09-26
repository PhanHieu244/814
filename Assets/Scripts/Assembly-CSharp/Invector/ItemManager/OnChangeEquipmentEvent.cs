using System;
using UnityEngine.Events;

namespace Invector.ItemManager
{
	[Serializable]
	public class OnChangeEquipmentEvent : UnityEvent<vEquipArea, vItem>
	{
	}
}
