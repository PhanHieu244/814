using System;
using System.Collections.Generic;

namespace LitJson
{
	internal struct ObjectMetadata
	{
		private Type elemType;

		public IDictionary<string, PropertyMetadata> Properties
		{
			get;
			set;
		}

		public bool IsDictionary
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
