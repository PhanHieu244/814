using System;

namespace UnityEngine
{
	[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = true)]
	public class vButtomAttribute : PropertyAttribute
	{
		public readonly string label;

		public readonly string function;

		public readonly int id;

		public vButtomAttribute(string label, string function, int id)
		{
			this.label = label;
			this.function = function;
			this.id = id;
		}
	}
}
