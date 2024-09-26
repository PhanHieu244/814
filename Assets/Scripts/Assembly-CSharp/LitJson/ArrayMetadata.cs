using System;

namespace LitJson
{
	internal struct ArrayMetadata
	{
		private Type elemType;

		public bool IsArray
		{
			get;
			set;
		}

		public bool IsList
		{
			get;
			set;
		}

		public Type ElementType
		{
			get
			{
				if (elemType == null)
				{
					elemType = typeof(JsonData);
				}
				return elemType;
			}
			set
			{
				elemType = value;
			}
		}
	}
}
