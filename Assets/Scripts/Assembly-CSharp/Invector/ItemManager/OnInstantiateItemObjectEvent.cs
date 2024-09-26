using System;
using UnityEngine;
using UnityEngine.Events;

namespace Invector.ItemManager
{
	[Serializable]
	public class OnInstantiateItemObjectEvent : UnityEvent<GameObject>
	{
	}
}
