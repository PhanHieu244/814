using System;
using UnityEngine;

namespace Invector.ItemManager
{
	[Serializable]
	public class ApplyAttributeEvent
	{
		[SerializeField]
		public vItemAttributes attribute;

		[SerializeField]
		public OnApplyAttribute onApplyAttribute;
	}
}
