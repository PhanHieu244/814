using System;
using System.Collections.Generic;

namespace Invector.ItemManager
{
	[Serializable]
	public class ItemReference
	{
		public int id;

		public int amount;

		public List<vItemAttribute> attributes;

		public bool changeAttributes;

		public ItemReference(int id)
		{
			this.id = id;
		}
	}
}
