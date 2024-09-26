using System;
using UnityEngine;

namespace Invector.ItemManager
{
	[Serializable]
	public class vEquipProperties
	{
		public vItem targetItem;

		public GameObject sender;

		public Transform targetEquipPoint;
	}
}
