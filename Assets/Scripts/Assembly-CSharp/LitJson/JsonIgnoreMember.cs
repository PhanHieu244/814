using System;
using System.Collections.Generic;

namespace LitJson
{
	[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct, AllowMultiple = true)]
	public class JsonIgnoreMember : Attribute
	{
		public HashSet<string> Members
		{
			get;
			private set;
		}

		public JsonIgnoreMember(params string[] members)
			: this((ICollection<string>)members)
		{
		}

		public JsonIgnoreMember(ICollection<string> members)
		{
			Members = new HashSet<string>(members);
		}
	}
}
