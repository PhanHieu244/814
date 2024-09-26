using System.Collections;
using System.Collections.Generic;

namespace LitJson
{
	internal class OrderedDictionaryEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private IEnumerator<KeyValuePair<string, JsonData>> enumerator;

		public object Current => Entry;

		public DictionaryEntry Entry
		{
			get
			{
				KeyValuePair<string, JsonData> current = enumerator.Current;
				return new DictionaryEntry(current.Key, current.Value);
			}
		}

		public object Key => enumerator.Current.Key;

		public object Value => enumerator.Current.Value;

		public OrderedDictionaryEnumerator(IEnumerator<KeyValuePair<string, JsonData>> enumerator)
		{
			this.enumerator = enumerator;
		}

		public bool MoveNext()
		{
			return enumerator.MoveNext();
		}

		public void Reset()
		{
			enumerator.Reset();
		}
	}
}
