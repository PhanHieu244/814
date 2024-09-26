using UnityEngine;

namespace Invector.EventSystems
{
	public static class vIMeeleFighterHelper
	{
		public static bool IsAMeleeFighter(this GameObject receiver)
		{
			return receiver.GetComponent<vIMeleeFighter>() != null;
		}

		public static vIMeleeFighter GetMeleeFighter(this GameObject receiver)
		{
			return receiver.GetComponent<vIMeleeFighter>();
		}
	}
}
