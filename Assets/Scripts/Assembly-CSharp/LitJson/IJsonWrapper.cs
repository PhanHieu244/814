using System.Collections;
using System.Collections.Specialized;

namespace LitJson
{
	public interface IJsonWrapper : IList, IOrderedDictionary, IEnumerable, ICollection, IDictionary
	{
		bool IsObject
		{
			get;
		}

		bool IsArray
		{
			get;
		}

		bool IsString
		{
			get;
		}

		bool IsNatural
		{
			get;
		}

		bool IsReal
		{
			get;
		}

		bool IsBoolean
		{
			get;
		}

		JsonType GetJsonType();

		string GetString();

		long GetNatural();

		double GetReal();

		bool GetBoolean();

		void SetJsonType(JsonType type);

		void SetString(string val);

		void SetNatural(long val);

		void SetReal(double val);

		void SetBoolean(bool val);

		string ToJson();

		void ToJson(JsonWriter writer);
	}
}
