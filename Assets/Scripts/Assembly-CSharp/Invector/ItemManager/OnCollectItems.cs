using System;
using UnityEngine;
using UnityEngine.Events;

namespace Invector.ItemManager
{
	[Serializable]
	public class OnCollectItems : UnityEvent<GameObject>
	{
	}
}
