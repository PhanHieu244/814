using System;
using UnityEngine;

namespace Invector.ItemManager
{
	[Serializable]
	public class EquipPoint
	{
		[SerializeField]
		public string equipPointName;

		public EquipmentReference equipmentReference = new EquipmentReference();

		[HideInInspector]
		public vEquipArea area;

		public vHandler handler = new vHandler();

		public OnInstantiateItemObjectEvent onInstantiateEquiment = new OnInstantiateItemObjectEvent();
	}
}
