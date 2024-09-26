using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;

namespace LitJson
{
	public class JsonData : IJsonWrapper, IEquatable<JsonData>, IList, IOrderedDictionary, IEnumerable, ICollection, IDictionary
	{
		private object val;

		private string json;

		private JsonType type;

		private IList<KeyValuePair<string, JsonData>> list;

		int ICollection.Count => Count;

		bool ICollection.IsSynchronized => EnsureCollection().IsSynchronized;

		object ICollection.SyncRoot => EnsureCollection().SyncRoot;

		bool IDictionary.IsFixedSize => EnsureDictionary().IsFixedSize;

		bool IDictionary.IsReadOnly => EnsureDictionary().IsReadOnly;

		ICollection IDictionary.Keys
		{
			get
			{
				EnsureDictionary();
				IList<string> list = new List<string>();
				foreach (KeyValuePair<string, JsonData> item in this.list)
				{
					list.Add(item.Key);
				}
				return (ICollection)list;
			}
		}

		ICollection IDictionary.Values
		{
			get
			{
				EnsureDictionary();
				IList<JsonData> list = new List<JsonData>();
				foreach (KeyValuePair<string, JsonData> item in this.list)
				{
					list.Add(item.Value);
				}
				return (ICollection)list;
			}
		}

		bool IList.IsFixedSize => EnsureList().IsFixedSize;

		bool IList.IsReadOnly => EnsureList().IsReadOnly;

		object IDictionary.this[object key]
		{
			get
			{
				return EnsureDictionary()[key];
			}
			set
			{
				if (!(key is string))
				{
					throw new ArgumentException("The key has to be a string");
				}
				JsonData value2 = ToJsonData(value);
				this[(string)key] = value2;
			}
		}

		object IOrderedDictionary.this[int idx]
		{
			get
			{
				EnsureDictionary();
				return list[idx].Value;
			}
			set
			{
				EnsureDictionary();
				JsonData value2 = ToJsonData(value);
				KeyValuePair<string, JsonData> keyValuePair = list[idx];
				GetObject()[keyValuePair.Key] = value2;
				KeyValuePair<string, JsonData> value3 = new KeyValuePair<string, JsonData>(keyValuePair.Key, value2);
				list[idx] = value3;
			}
		}

		object IList.this[int index]
		{
			get
			{
				return EnsureList()[index];
			}
			set
			{
				EnsureList();
				JsonData jsonData2 = this[index] = ToJsonData(value);
			}
		}

		public int Count => EnsureCollection().Count;

		public bool IsArray => type == JsonType.Array;

		public bool IsBoolean => type == JsonType.Boolean;

		public bool IsReal => type == JsonType.Real;

		public bool IsNatural => type == JsonType.Natural;

		public bool IsObject => type == JsonType.Object;

		public bool IsString => type == JsonType.String;

		public ICollection<string> Keys
		{
			get
			{
				EnsureDictionary();
				return GetObject().Keys;
			}
		}

		public JsonData this[string name]
		{
			get
			{
				EnsureDictionary();
				return GetObject()[name];
			}
			set
			{
				EnsureDictionary();
				KeyValuePair<string, JsonData> keyValuePair = new KeyValuePair<string, JsonData>(name, value);
				if (GetObject().ContainsKey(name))
				{
					for (int i = 0; i < list.Count; i++)
					{
						if (list[i].Key == name)
						{
							list[i] = keyValuePair;
							break;
						}
					}
				}
				else
				{
					list.Add(keyValuePair);
				}
				GetObject()[name] = value;
				json = null;
			}
		}

		public JsonData this[int index]
		{
			get
			{
				EnsureCollection();
				if (type == JsonType.Array)
				{
					return GetArray()[index];
				}
				return list[index].Value;
			}
			set
			{
				EnsureCollection();
				if (type == JsonType.Array)
				{
					GetArray()[index] = value;
				}
				else
				{
					KeyValuePair<string, JsonData> keyValuePair = list[index];
					KeyValuePair<string, JsonData> value2 = new KeyValuePair<string, JsonData>(keyValuePair.Key, value);
					list[index] = value2;
					GetObject()[keyValuePair.Key] = value;
				}
				json = null;
			}
		}

		public JsonData(bool boolean)
		{
			type = JsonType.Boolean;
			val = boolean;
		}

		public JsonData(double number)
		{
			type = JsonType.Real;
			val = number;
		}

		public JsonData(long number)
		{
			type = JsonType.Natural;
			val = number;
		}

		public JsonData(string str)
		{
			type = JsonType.String;
			val = str;
		}

		public JsonData(object obj)
		{
			if (obj is bool)
			{
				type = JsonType.Boolean;
			}
			else if (obj is double)
			{
				type = JsonType.Real;
			}
			else if (obj is long)
			{
				type = JsonType.Natural;
			}
			else if (obj is string)
			{
				type = JsonType.String;
			}
			else if (obj is sbyte)
			{
				type = JsonType.Natural;
				obj = (long)(sbyte)obj;
			}
			else if (obj is byte)
			{
				type = JsonType.Natural;
				obj = (long)(int)(byte)obj;
			}
			else if (obj is short)
			{
				type = JsonType.Natural;
				obj = (long)(short)obj;
			}
			else if (obj is ushort)
			{
				type = JsonType.Natural;
				obj = (long)(int)(ushort)obj;
			}
			else if (obj is int)
			{
				type = JsonType.Natural;
				obj = (long)(int)obj;
			}
			else if (obj is uint)
			{
				type = JsonType.Natural;
				obj = (long)(uint)obj;
			}
			else if (obj is ulong)
			{
				type = JsonType.Natural;
				obj = (long)(ulong)obj;
			}
			else if (obj is float)
			{
				type = JsonType.Real;
				obj = (double)(float)obj;
			}
			else
			{
				if (!(obj is decimal))
				{
					throw new ArgumentException("Unable to wrap " + obj + " of type " + obj?.GetType() + " with JsonData");
				}
				type = JsonType.Real;
				obj = (double)(decimal)obj;
			}
			val = obj;
		}

		public JsonData()
		{
		}

		public JsonData(sbyte number)
			: this((long)number)
		{
		}

		public JsonData(byte number)
			: this((long)(int)number)
		{
		}

		public JsonData(short number)
			: this((long)number)
		{
		}

		public JsonData(ushort number)
			: this((long)(int)number)
		{
		}

		public JsonData(int number)
			: this((long)number)
		{
		}

		public JsonData(uint number)
			: this((long)number)
		{
		}

		public JsonData(ulong number)
			: this((long)number)
		{
		}

		public JsonData(float number)
			: this((double)number)
		{
		}

		public JsonData(decimal number)
			: this((double)number)
		{
		}

		public static implicit operator JsonData(bool data)
		{
			return new JsonData(data);
		}

		public static implicit operator JsonData(double data)
		{
			return new JsonData(data);
		}

		public static implicit operator JsonData(long data)
		{
			return new JsonData(data);
		}

		public static implicit operator JsonData(string data)
		{
			return new JsonData(data);
		}

		public static explicit operator bool(JsonData data)
		{
			if (data.IsBoolean)
			{
				return data.GetBoolean();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a boolean");
		}

		public static explicit operator float(JsonData data)
		{
			if (data.IsReal)
			{
				return (float)data.GetReal();
			}
			if (data.IsNatural)
			{
				return data.GetNatural();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator double(JsonData data)
		{
			if (data.IsReal)
			{
				return data.GetReal();
			}
			if (data.IsNatural)
			{
				return data.GetNatural();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator decimal(JsonData data)
		{
			if (data.IsReal)
			{
				return (decimal)data.GetReal();
			}
			if (data.IsNatural)
			{
				return data.GetNatural();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator sbyte(JsonData data)
		{
			if (data.IsNatural)
			{
				return (sbyte)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (sbyte)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator byte(JsonData data)
		{
			if (data.IsNatural)
			{
				return (byte)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (byte)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator short(JsonData data)
		{
			if (data.IsNatural)
			{
				return (short)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (short)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator ushort(JsonData data)
		{
			if (data.IsNatural)
			{
				return (ushort)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (ushort)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator int(JsonData data)
		{
			if (data.IsNatural)
			{
				return (int)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (int)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator uint(JsonData data)
		{
			if (data.IsNatural)
			{
				return (uint)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (uint)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator long(JsonData data)
		{
			if (data.IsNatural)
			{
				return data.GetNatural();
			}
			if (data.IsReal)
			{
				return (long)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator ulong(JsonData data)
		{
			if (data.IsNatural)
			{
				return (ulong)data.GetNatural();
			}
			if (data.IsReal)
			{
				return (ulong)data.GetReal();
			}
			throw new InvalidCastException("Instance of JsonData doesn't hold a real or natural number");
		}

		public static explicit operator string(JsonData data)
		{
			return (data.val != null) ? data.val.ToString() : null;
		}

		void ICollection.CopyTo(Array array, int index)
		{
			EnsureCollection().CopyTo(array, index);
		}

		void IDictionary.Add(object key, object value)
		{
			JsonData value2 = ToJsonData(value);
			EnsureDictionary().Add(key, value2);
			KeyValuePair<string, JsonData> item = new KeyValuePair<string, JsonData>((string)key, value2);
			list.Add(item);
			json = null;
		}

		void IDictionary.Clear()
		{
			EnsureDictionary().Clear();
			list.Clear();
			json = null;
		}

		bool IDictionary.Contains(object key)
		{
			return EnsureDictionary().Contains(key);
		}

		IDictionaryEnumerator IDictionary.GetEnumerator()
		{
			return ((IOrderedDictionary)this).GetEnumerator();
		}

		void IDictionary.Remove(object key)
		{
			EnsureDictionary().Remove(key);
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].Key == (string)key)
				{
					list.RemoveAt(i);
					break;
				}
			}
			json = null;
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return EnsureCollection().GetEnumerator();
		}

		public bool GetBoolean()
		{
			if (IsBoolean)
			{
				return (bool)val;
			}
			throw new InvalidOperationException("JsonData instance doesn't hold a boolean");
		}

		public double GetReal()
		{
			if (IsReal)
			{
				return (double)val;
			}
			throw new InvalidOperationException("JsonData instance doesn't hold a real number");
		}

		public long GetNatural()
		{
			if (IsNatural)
			{
				try
				{
					return (long)val;
				}
				catch
				{
					throw new InvalidCastException("expected long but got " + val.GetType() + " from " + val);
				}
			}
			throw new InvalidOperationException("JsonData instance doesn't hold a natural number");
		}

		public string GetString()
		{
			if (IsString)
			{
				return (string)val;
			}
			throw new InvalidOperationException("JsonData instance doesn't hold a string");
		}

		private IDictionary<string, JsonData> GetObject()
		{
			if (IsObject)
			{
				return (IDictionary<string, JsonData>)val;
			}
			throw new InvalidOperationException("JsonData instance doesn't hold an object");
		}

		private IList<JsonData> GetArray()
		{
			if (IsArray)
			{
				return (IList<JsonData>)val;
			}
			throw new InvalidOperationException("JsonData instance doesn't hold an array");
		}

		public void SetBoolean(bool val)
		{
			type = JsonType.Boolean;
			this.val = val;
			json = null;
		}

		public void SetReal(double val)
		{
			type = JsonType.Real;
			this.val = val;
			json = null;
		}

		public void SetNatural(long val)
		{
			type = JsonType.Natural;
			this.val = val;
			json = null;
		}

		public void SetString(string val)
		{
			type = JsonType.String;
			this.val = val;
			json = null;
		}

		void IJsonWrapper.ToJson(JsonWriter writer)
		{
			ToJson(writer);
		}

		int IList.Add(object value)
		{
			return Add(value);
		}

		void IList.Clear()
		{
			EnsureList().Clear();
			json = null;
		}

		bool IList.Contains(object value)
		{
			return EnsureList().Contains(value);
		}

		int IList.IndexOf(object value)
		{
			return EnsureList().IndexOf(value);
		}

		void IList.Insert(int index, object value)
		{
			EnsureList().Insert(index, value);
			json = null;
		}

		void IList.Remove(object value)
		{
			EnsureList().Remove(value);
			json = null;
		}

		void IList.RemoveAt(int index)
		{
			EnsureList().RemoveAt(index);
			json = null;
		}

		IDictionaryEnumerator IOrderedDictionary.GetEnumerator()
		{
			EnsureDictionary();
			return new OrderedDictionaryEnumerator(list.GetEnumerator());
		}

		void IOrderedDictionary.Insert(int idx, object key, object value)
		{
			string text = (string)key;
			JsonData value2 = this[text] = ToJsonData(value);
			KeyValuePair<string, JsonData> item = new KeyValuePair<string, JsonData>(text, value2);
			list.Insert(idx, item);
		}

		void IOrderedDictionary.RemoveAt(int idx)
		{
			EnsureDictionary();
			GetObject().Remove(list[idx].Key);
			list.RemoveAt(idx);
		}

		private ICollection EnsureCollection()
		{
			if (IsArray || IsObject)
			{
				return (ICollection)val;
			}
			throw new InvalidOperationException("The JsonData instance has to be initialized first");
		}

		private IDictionary EnsureDictionary()
		{
			if (IsObject)
			{
				return (IDictionary)val;
			}
			if (type != 0)
			{
				throw new InvalidOperationException("Instance of JsonData is not a dictionary");
			}
			type = JsonType.Object;
			val = new Dictionary<string, JsonData>();
			list = new List<KeyValuePair<string, JsonData>>();
			return (IDictionary)val;
		}

		private IList EnsureList()
		{
			if (IsArray)
			{
				return (IList)val;
			}
			if (type != 0)
			{
				throw new InvalidOperationException("Instance of JsonData is not a list");
			}
			type = JsonType.Array;
			val = new List<JsonData>();
			return (IList)val;
		}

		private JsonData ToJsonData(object obj)
		{
			if (obj == null)
			{
				return null;
			}
			if (obj is JsonData)
			{
				return (JsonData)obj;
			}
			return new JsonData(obj);
		}

		private static void WriteJson(IJsonWrapper obj, JsonWriter writer)
		{
			if (obj == null)
			{
				writer.Write(null);
			}
			else if (obj.IsString)
			{
				writer.Write(obj.GetString());
			}
			else if (obj.IsBoolean)
			{
				writer.Write(obj.GetBoolean());
			}
			else if (obj.IsReal)
			{
				writer.Write(obj.GetReal());
			}
			else if (obj.IsNatural)
			{
				writer.Write(obj.GetNatural());
			}
			else if (obj.IsArray)
			{
				writer.WriteArrayStart();
				IEnumerator enumerator = ((IEnumerable)obj).GetEnumerator();
				try
				{
					while (enumerator.MoveNext())
					{
						object current = enumerator.Current;
						WriteJson((JsonData)current, writer);
					}
				}
				finally
				{
					IDisposable disposable;
					if ((disposable = (enumerator as IDisposable)) != null)
					{
						disposable.Dispose();
					}
				}
				writer.WriteArrayEnd();
			}
			else if (obj.IsObject)
			{
				writer.WriteObjectStart();
				IDictionaryEnumerator enumerator2 = ((IDictionary)obj).GetEnumerator();
				try
				{
					while (enumerator2.MoveNext())
					{
						DictionaryEntry dictionaryEntry = (DictionaryEntry)enumerator2.Current;
						writer.WritePropertyName((string)dictionaryEntry.Key);
						WriteJson((JsonData)dictionaryEntry.Value, writer);
					}
				}
				finally
				{
					IDisposable disposable2;
					if ((disposable2 = (enumerator2 as IDisposable)) != null)
					{
						disposable2.Dispose();
					}
				}
				writer.WriteObjectEnd();
			}
		}

		public int Add(object value)
		{
			JsonData value2 = ToJsonData(value);
			json = null;
			return EnsureList().Add(value2);
		}

		public void Clear()
		{
			if (IsObject)
			{
				((IDictionary)this).Clear();
			}
			else if (IsArray)
			{
				((IList)this).Clear();
			}
		}

		public bool Equals(JsonData data)
		{
			return Equals((object)data);
		}

		public override bool Equals(object obj)
		{
			if (obj == null)
			{
				return false;
			}
			if (!(obj is JsonData))
			{
				return false;
			}
			JsonData jsonData = (JsonData)obj;
			if (type != jsonData.type)
			{
				return false;
			}
			switch (type)
			{
			case JsonType.None:
				return true;
			case JsonType.Object:
				return GetObject().Equals(jsonData.GetObject());
			case JsonType.Array:
				return GetArray().Equals(jsonData.GetArray());
			case JsonType.String:
				return GetString().Equals(jsonData.GetString());
			case JsonType.Natural:
				return GetNatural().Equals(jsonData.GetNatural());
			case JsonType.Real:
				return GetReal().Equals(jsonData.GetReal());
			case JsonType.Boolean:
				return GetBoolean().Equals(jsonData.GetBoolean());
			default:
				return false;
			}
		}

		public override int GetHashCode()
		{
			if (val == null)
			{
				return 0;
			}
			return val.GetHashCode();
		}

		public JsonType GetJsonType()
		{
			return type;
		}

		public void SetJsonType(JsonType type)
		{
			if (this.type != type)
			{
				switch (type)
				{
				case JsonType.Object:
					val = new Dictionary<string, JsonData>();
					list = new List<KeyValuePair<string, JsonData>>();
					break;
				case JsonType.Array:
					val = new List<JsonData>();
					break;
				case JsonType.String:
					val = null;
					break;
				case JsonType.Natural:
					val = 0L;
					break;
				case JsonType.Real:
					val = 0.0;
					break;
				case JsonType.Boolean:
					val = false;
					break;
				}
				this.type = type;
			}
		}

		public string ToJson()
		{
			if (json != null)
			{
				return json;
			}
			StringWriter stringWriter = new StringWriter();
			JsonWriter jsonWriter = new JsonWriter(stringWriter);
			jsonWriter.Validate = false;
			WriteJson(this, jsonWriter);
			json = stringWriter.ToString();
			return json;
		}

		public void ToJson(JsonWriter writer)
		{
			bool validate = writer.Validate;
			writer.Validate = false;
			WriteJson(this, writer);
			writer.Validate = validate;
		}

		public override string ToString()
		{
			switch (type)
			{
			case JsonType.Array:
				return "JsonData array";
			case JsonType.Object:
				return "JsonData object";
			case JsonType.None:
				return "Uninitialized JsonData";
			default:
				return (val != null) ? val.ToString() : "null";
			}
		}
	}
}
