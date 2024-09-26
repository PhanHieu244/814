using System;
using System.Reflection;
using System.Runtime.InteropServices;

namespace LitJson
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct PropertyMetadata
	{
		public Type Type
		{
			get;
			set;
		}

		public MemberInfo Info
		{
			get;
			set;
		}

		public JsonIgnoreWhen Ignore
		{
			get;
			set;
		}

		public string Alias
		{
			get;
			set;
		}

		public bool IsField
		{
			get;
			set;
		}

		public bool Include
		{
			get;
			set;
		}
	}
}
