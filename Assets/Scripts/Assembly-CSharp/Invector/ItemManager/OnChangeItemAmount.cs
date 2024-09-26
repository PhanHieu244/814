using System;
using UnityEngine.Events;

namespace Invector.ItemManager
{
	[Serializable]
	public class OnChangeItemAmount : UnityEvent<vItem, int>
	{
	}
}
