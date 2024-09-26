using System;
using System.Collections.Generic;
using UnityEngine;

namespace Invector.ItemManager
{
	[Serializable]
	public class vItem : ScriptableObject
	{
		[HideInInspector]
		public int id;

		[HideInInspector]
		public string description = "Item Description";

		[HideInInspector]
		public vItemType type;

		[HideInInspector]
		public Sprite icon;

		[HideInInspector]
		public bool stackable = true;

		[HideInInspector]
		public int maxStack;

		[HideInInspector]
		public int amount;

		[HideInInspector]
		public GameObject originalObject;

		[HideInInspector]
		public GameObject dropObject;

		[HideInInspector]
		public List<vItemAttribute> attributes = new List<vItemAttribute>();

		[HideInInspector]
		public bool isInEquipArea;

		public bool twoHandWeapon;

		[Header("Equipable Settings")]
		public int EquipID;

		public string customEquipPoint = "defaultPoint";

		public float equipDelayTime = 0.5f;

		public Texture2D iconTexture
		{
			get
			{
				if (!icon)
				{
					return null;
				}
				try
				{
					if (icon.rect.width != (float)icon.texture.width || icon.rect.height != (float)icon.texture.height)
					{
						Texture2D texture2D = new Texture2D((int)icon.textureRect.width, (int)icon.textureRect.height);
						texture2D.name = icon.name;
						Color[] pixels = icon.texture.GetPixels((int)icon.textureRect.x, (int)icon.textureRect.y, (int)icon.textureRect.width, (int)icon.textureRect.height);
						texture2D.SetPixels(pixels);
						texture2D.Apply();
						return texture2D;
					}
					return icon.texture;
				}
				catch
				{
					return icon.texture;
				}
			}
		}

		public vItemAttribute GetItemAttribute(string name)
		{
			if (attributes != null)
			{
				return attributes.Find((vItemAttribute attribute) => attribute.name.Equals(name));
			}
			return null;
		}
	}
}
