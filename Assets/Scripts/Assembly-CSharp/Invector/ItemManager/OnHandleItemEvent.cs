using System;
using UnityEngine.Events;

namespace Invector.ItemManager
{
	[Serializable]
	public class OnHandleItemEvent : UnityEvent<vItem>
	{
	}
}
