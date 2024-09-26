using System;

namespace LitJson
{
	[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
	public class JsonIgnore : Attribute
	{
		public JsonIgnoreWhen Usage
		{
			get;
			private set;
		}

		public JsonIgnore()
		{
			Usage = (JsonIgnoreWhen.Serializing | JsonIgnoreWhen.Deserializing);
		}

		public JsonIgnore(JsonIgnoreWhen usage)
		{
			Usage = usage;
		}
	}
}
