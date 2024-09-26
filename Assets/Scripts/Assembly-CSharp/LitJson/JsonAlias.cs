using System;

namespace LitJson
{
	[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
	public class JsonAlias : Attribute
	{
		public string Alias
		{
			get;
			private set;
		}

		public bool AcceptOriginal
		{
			get;
			private set;
		}

		public JsonAlias(string aliasName, bool acceptOriginalName = false)
		{
			Alias = aliasName;
			AcceptOriginal = acceptOriginalName;
		}
	}
}
