using System;
using System.Collections;
using System.Collections.Specialized;

namespace LitJson
{
	public class JsonMockWrapper : IJsonWrapper, IList, IOrderedDictionary, IEnumerable, ICollection, IDictionary
	{
		bool IList.IsFixedSize => true;

		bool IList.IsReadOnly => true;

		object IList.this[int index]
		{
			get
			{
				return null;
			}
			set
			{
			}
		}

		int ICollection.Count => 0;

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => null;

		bool IDictionary.IsFixedSize => true;

		bool IDictionary.IsReadOnly => true;

		ICollection IDictionary.Keys => null;

		ICollection IDictionary.Values => null;

		object IDictionary.this[object key]
		{
			get
			{
				return null;
			}
			set
			{
			}
		}

		object IOrderedDictionary.this[int idx]
		{
			get
			{
				return null;
			}
			set
			{
			}
		}

		public bool IsArray => false;

		public bool IsBoolean => false;

		public bool IsReal => false;

		public bool IsNatural => false;

		public bool IsObject => false;

		public bool IsString => false;

		public bool GetBoolean()
		{
			return false;
		}

		public double GetReal()
		{
			return 0.0;
		}

		public long GetNatural()
		{
			return 0L;
		}

		public JsonType GetJsonType()
		{
			return JsonType.None;
		}

		public string GetString()
		{
			return string.Empty;
		}

		public void SetBoolean(bool val)
		{
		}

		public void SetReal(double val)
		{
		}

		public void SetNatural(long val)
		{
		}

		public void SetJsonType(JsonType type)
		{
		}

		public void SetString(string val)
		{
		}

		public string ToJson()
		{
			return string.Empty;
		}

		public void ToJson(JsonWriter writer)
		{
		}

		int IList.Add(object value)
		{
			return 0;
		}

		void IList.Clear()
		{
		}

		bool IList.Contains(object value)
		{
			return false;
		}

		int IList.IndexOf(object value)
		{
			return -1;
		}

		void IList.Insert(int i, object v)
		{
		}

		void IList.Remove(object value)
		{
		}

		void IList.RemoveAt(int index)
		{
		}

		void ICollection.CopyTo(Array array, int index)
		{
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return null;
		}

		void IDictionary.Add(object k, object v)
		{
		}

		void IDictionary.Clear()
		{
		}

		bool IDictionary.Contains(object key)
		{
			return false;
		}

		void IDictionary.Remove(object key)
		{
		}

		IDictionaryEnumerator IDictionary.GetEnumerator()
		{
			return null;
		}

		IDictionaryEnumerator IOrderedDictionary.GetEnumerator()
		{
			return null;
		}

		void IOrderedDictionary.Insert(int i, object k, object v)
		{
		}

		void IOrderedDictionary.RemoveAt(int i)
		{
		}
	}
}
