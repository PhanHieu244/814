using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;

namespace LitJson
{
	public class JsonMapper
	{
		private static readonly int maxNestingDepth;

		private static readonly IFormatProvider datetimeFormat;

		private static readonly IDictionary<Type, ExporterFunc> baseExportTable;

		private static readonly IDictionary<Type, ExporterFunc> customExportTable;

		private static readonly IDictionary<Type, IDictionary<Type, ImporterFunc>> baseImportTable;

		private static readonly IDictionary<Type, IDictionary<Type, ImporterFunc>> customImportTable;

		private static readonly IDictionary<Type, FactoryFunc> customFactoryTable;

		private static readonly IDictionary<Type, ArrayMetadata> arrayMetadata;

		private static readonly IDictionary<Type, IDictionary<Type, MethodInfo>> convOps;

		private static readonly IDictionary<Type, ObjectMetadata> objectMetadata;

		static JsonMapper()
		{
			maxNestingDepth = 100;
			datetimeFormat = DateTimeFormatInfo.InvariantInfo;
			arrayMetadata = new Dictionary<Type, ArrayMetadata>();
			objectMetadata = new Dictionary<Type, ObjectMetadata>();
			convOps = new Dictionary<Type, IDictionary<Type, MethodInfo>>();
			baseExportTable = new Dictionary<Type, ExporterFunc>();
			customExportTable = new Dictionary<Type, ExporterFunc>();
			baseImportTable = new Dictionary<Type, IDictionary<Type, ImporterFunc>>();
			customImportTable = new Dictionary<Type, IDictionary<Type, ImporterFunc>>();
			customFactoryTable = new Dictionary<Type, FactoryFunc>();
			RegisterBaseExporters();
			RegisterBaseImporters();
		}

		private static ArrayMetadata AddArrayMetadata(Type type)
		{
			if (JsonMapper.arrayMetadata.ContainsKey(type))
			{
				return JsonMapper.arrayMetadata[type];
			}
			ArrayMetadata arrayMetadata = default(ArrayMetadata);
			arrayMetadata.IsArray = type.IsArray;
			if (type.GetInterface("System.Collections.IList") != null)
			{
				arrayMetadata.IsList = true;
			}
			PropertyInfo[] properties = type.GetProperties();
			foreach (PropertyInfo propertyInfo in properties)
			{
				if (!(propertyInfo.Name != "Item"))
				{
					ParameterInfo[] indexParameters = propertyInfo.GetIndexParameters();
					if (indexParameters.Length == 1 && indexParameters[0].ParameterType == typeof(int))
					{
						arrayMetadata.ElementType = propertyInfo.PropertyType;
					}
				}
			}
			JsonMapper.arrayMetadata[type] = arrayMetadata;
			return arrayMetadata;
		}

		private static ObjectMetadata AddObjectMetadata(Type type)
		{
			if (JsonMapper.objectMetadata.ContainsKey(type))
			{
				return JsonMapper.objectMetadata[type];
			}
			ObjectMetadata objectMetadata = default(ObjectMetadata);
			if (type.GetInterface("System.Collections.IDictionary") != null)
			{
				objectMetadata.IsDictionary = true;
			}
			objectMetadata.Properties = new Dictionary<string, PropertyMetadata>();
			HashSet<string> hashSet = new HashSet<string>();
			object[] customAttributes = type.GetCustomAttributes(typeof(JsonIgnoreMember), inherit: true);
			object[] array = customAttributes;
			for (int i = 0; i < array.Length; i++)
			{
				JsonIgnoreMember jsonIgnoreMember = (JsonIgnoreMember)array[i];
				hashSet.UnionWith(jsonIgnoreMember.Members);
			}
			BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;
			PropertyInfo[] properties = type.GetProperties(bindingAttr);
			foreach (PropertyInfo propertyInfo in properties)
			{
				if (propertyInfo.Name == "Item")
				{
					ParameterInfo[] indexParameters = propertyInfo.GetIndexParameters();
					if (indexParameters.Length == 1 && indexParameters[0].ParameterType == typeof(string))
					{
						objectMetadata.ElementType = propertyInfo.PropertyType;
					}
				}
				else
				{
					if ((propertyInfo.GetGetMethod() == null || !propertyInfo.GetGetMethod().IsPublic) && (propertyInfo.GetSetMethod() == null || !propertyInfo.GetSetMethod().IsPublic) && propertyInfo.GetCustomAttributes(typeof(JsonInclude), inherit: true).Count() == 0)
					{
						continue;
					}
					PropertyMetadata value = default(PropertyMetadata);
					value.Info = propertyInfo;
					value.Type = propertyInfo.PropertyType;
					object[] array2 = propertyInfo.GetCustomAttributes(typeof(JsonIgnore), inherit: true).ToArray();
					if (array2.Length > 0)
					{
						value.Ignore = ((JsonIgnore)array2[0]).Usage;
					}
					else if (hashSet.Contains(propertyInfo.Name))
					{
						value.Ignore = (JsonIgnoreWhen.Serializing | JsonIgnoreWhen.Deserializing);
					}
					object[] array3 = propertyInfo.GetCustomAttributes(typeof(JsonAlias), inherit: true).ToArray();
					if (array3.Length > 0)
					{
						JsonAlias jsonAlias = (JsonAlias)array3[0];
						if (jsonAlias.Alias == propertyInfo.Name)
						{
							throw new JsonException($"Alias name '{propertyInfo.Name}' must be different from the property it represents for type '{type}'");
						}
						if (objectMetadata.Properties.ContainsKey(jsonAlias.Alias))
						{
							throw new JsonException($"'{type}' already contains the property or alias name '{jsonAlias.Alias}'");
						}
						value.Alias = jsonAlias.Alias;
						if (jsonAlias.AcceptOriginal)
						{
							objectMetadata.Properties.Add(propertyInfo.Name, value);
						}
					}
					if (value.Alias != null)
					{
						objectMetadata.Properties.Add(value.Alias, value);
						continue;
					}
					if (objectMetadata.Properties.ContainsKey(propertyInfo.Name))
					{
						throw new JsonException($"'{type}' already contains the property or alias name '{propertyInfo.Name}'");
					}
					objectMetadata.Properties.Add(propertyInfo.Name, value);
				}
			}
			BindingFlags bindingAttr2 = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;
			FieldInfo[] fields = type.GetFields(bindingAttr2);
			foreach (FieldInfo fieldInfo in fields)
			{
				if (!fieldInfo.IsPublic && fieldInfo.GetCustomAttributes(typeof(JsonInclude), inherit: true).Count() == 0)
				{
					continue;
				}
				PropertyMetadata value2 = default(PropertyMetadata);
				value2.Info = fieldInfo;
				value2.IsField = true;
				value2.Type = fieldInfo.FieldType;
				object[] array4 = fieldInfo.GetCustomAttributes(typeof(JsonIgnore), inherit: true).ToArray();
				if (array4.Length > 0)
				{
					value2.Ignore = ((JsonIgnore)array4[0]).Usage;
				}
				else if (hashSet.Contains(fieldInfo.Name))
				{
					value2.Ignore = (JsonIgnoreWhen.Serializing | JsonIgnoreWhen.Deserializing);
				}
				object[] array5 = fieldInfo.GetCustomAttributes(typeof(JsonAlias), inherit: true).ToArray();
				if (array5.Length > 0)
				{
					JsonAlias jsonAlias2 = (JsonAlias)array5[0];
					if (jsonAlias2.Alias == fieldInfo.Name)
					{
						throw new JsonException($"Alias name '{fieldInfo.Name}' must be different from the field it represents for type '{type}'");
					}
					if (objectMetadata.Properties.ContainsKey(jsonAlias2.Alias))
					{
						throw new JsonException($"'{type}' already contains the field or alias name '{jsonAlias2.Alias}'");
					}
					value2.Alias = jsonAlias2.Alias;
					if (jsonAlias2.AcceptOriginal)
					{
						objectMetadata.Properties.Add(fieldInfo.Name, value2);
					}
				}
				if (value2.Alias != null)
				{
					objectMetadata.Properties.Add(value2.Alias, value2);
					continue;
				}
				if (objectMetadata.Properties.ContainsKey(fieldInfo.Name))
				{
					throw new JsonException($"'{type}' already contains the field or alias name '{fieldInfo.Name}'");
				}
				objectMetadata.Properties.Add(fieldInfo.Name, value2);
			}
			JsonMapper.objectMetadata.Add(type, objectMetadata);
			return objectMetadata;
		}

		private static object CreateInstance(Type type)
		{
			if (customFactoryTable.TryGetValue(type, out FactoryFunc value))
			{
				return value();
			}
			BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
			type.GetConstructor(bindingAttr, null, new Type[0], null)?.Invoke(null);
			return Activator.CreateInstance(type);
		}

		private static MethodInfo GetConvOp(Type t1, Type t2)
		{
			if (!convOps.ContainsKey(t1))
			{
				convOps.Add(t1, new Dictionary<Type, MethodInfo>());
			}
			if (convOps[t1].ContainsKey(t2))
			{
				return convOps[t1][t2];
			}
			MethodInfo method = t1.GetMethod("op_Implicit", new Type[1]
			{
				t2
			});
			convOps[t1][t2] = method;
			return method;
		}

		private static ImporterFunc GetImporter(Type jsonType, Type valueType)
		{
			if (customImportTable.ContainsKey(jsonType) && customImportTable[jsonType].ContainsKey(valueType))
			{
				return customImportTable[jsonType][valueType];
			}
			if (baseImportTable.ContainsKey(jsonType) && baseImportTable[jsonType].ContainsKey(valueType))
			{
				return baseImportTable[jsonType][valueType];
			}
			return null;
		}

		private static ExporterFunc GetExporter(Type valueType)
		{
			if (customExportTable.ContainsKey(valueType))
			{
				return customExportTable[valueType];
			}
			if (baseExportTable.ContainsKey(valueType))
			{
				return baseExportTable[valueType];
			}
			return null;
		}

		private static object ReadValue(Type instType, JsonReader reader)
		{
			reader.Read();
			if (reader.Token == JsonToken.ArrayEnd)
			{
				return null;
			}
			Type underlyingType = Nullable.GetUnderlyingType(instType);
			Type type = underlyingType ?? instType;
			if (reader.Token == JsonToken.Null)
			{
				if (instType.IsClass || underlyingType != null)
				{
					return null;
				}
				throw new JsonException($"Can't assign null to an instance of type {instType}");
			}
			if (reader.Token == JsonToken.Real || reader.Token == JsonToken.Natural || reader.Token == JsonToken.String || reader.Token == JsonToken.Boolean)
			{
				Type type2 = reader.Value.GetType();
				if (type.IsAssignableFrom(type2))
				{
					return reader.Value;
				}
				ImporterFunc importer = GetImporter(type2, type);
				if (importer != null)
				{
					return importer(reader.Value);
				}
				if (type.IsEnum)
				{
					return Enum.ToObject(type, reader.Value);
				}
				MethodInfo convOp = GetConvOp(type, type2);
				if (convOp != null)
				{
					return convOp.Invoke(null, new object[1]
					{
						reader.Value
					});
				}
				throw new JsonException($"Can't assign value '{reader.Value}' (type {type2}) to type {instType}");
			}
			object obj = null;
			if (reader.Token == JsonToken.ArrayStart)
			{
				ImporterFunc importer2 = GetImporter(typeof(JsonData), instType);
				if (importer2 != null)
				{
					instType = typeof(JsonData);
				}
				AddArrayMetadata(instType);
				ArrayMetadata arrayMetadata = JsonMapper.arrayMetadata[instType];
				if (!arrayMetadata.IsArray && !arrayMetadata.IsList)
				{
					throw new JsonException($"Type {instType} can't act as an array");
				}
				IList list;
				Type elementType;
				if (!arrayMetadata.IsArray)
				{
					list = (IList)CreateInstance(instType);
					elementType = arrayMetadata.ElementType;
				}
				else
				{
					list = new List<object>();
					elementType = instType.GetElementType();
				}
				while (true)
				{
					object obj2 = ReadValue(elementType, reader);
					if (obj2 == null && reader.Token == JsonToken.ArrayEnd)
					{
						break;
					}
					list.Add(obj2);
				}
				if (arrayMetadata.IsArray)
				{
					int count = list.Count;
					obj = Array.CreateInstance(elementType, count);
					for (int i = 0; i < count; i++)
					{
						((Array)obj).SetValue(list[i], i);
					}
				}
				else
				{
					obj = list;
				}
				if (importer2 != null)
				{
					obj = importer2(obj);
				}
			}
			else if (reader.Token == JsonToken.ObjectStart)
			{
				bool flag = false;
				string text = null;
				reader.Read();
				if (reader.Token == JsonToken.ObjectEnd)
				{
					flag = true;
				}
				else
				{
					text = (string)reader.Value;
					if (reader.TypeHinting && text == reader.HintTypeName)
					{
						reader.Read();
						string typeName = (string)reader.Value;
						reader.Read();
						if ((string)reader.Value == reader.HintValueName)
						{
							type = Type.GetType(typeName);
							object result = ReadValue(type, reader);
							reader.Read();
							if (reader.Token != JsonToken.ObjectEnd)
							{
								throw new JsonException($"Invalid type hinting object, has too many properties: {reader.Token}...");
							}
							return result;
						}
						throw new JsonException($"Expected \"{reader.HintValueName}\" property for type hinting but instead got \"{reader.Value}\"");
					}
				}
				ImporterFunc importer3 = GetImporter(typeof(JsonData), type);
				if (importer3 != null)
				{
					type = typeof(JsonData);
				}
				ObjectMetadata objectMetadata = AddObjectMetadata(type);
				obj = CreateInstance(type);
				bool flag2 = true;
				while (!flag)
				{
					if (flag2)
					{
						flag2 = false;
					}
					else
					{
						reader.Read();
						if (reader.Token == JsonToken.ObjectEnd)
						{
							break;
						}
						text = (string)reader.Value;
					}
					if (objectMetadata.Properties.TryGetValue(text, out PropertyMetadata value))
					{
						if ((value.Ignore & JsonIgnoreWhen.Deserializing) > JsonIgnoreWhen.Never)
						{
							ReadSkip(reader);
							continue;
						}
						if (value.IsField)
						{
							((FieldInfo)value.Info).SetValue(obj, ReadValue(value.Type, reader));
							continue;
						}
						PropertyInfo propertyInfo = (PropertyInfo)value.Info;
						if (propertyInfo.CanWrite)
						{
							propertyInfo.SetValue(obj, ReadValue(value.Type, reader), null);
						}
						else
						{
							ReadValue(value.Type, reader);
						}
					}
					else if (!objectMetadata.IsDictionary)
					{
						if (!reader.SkipNonMembers)
						{
							throw new JsonException($"The type {instType} doesn't have the property '{text}'");
						}
						ReadSkip(reader);
					}
					else
					{
						((IDictionary)obj).Add(text, ReadValue(objectMetadata.ElementType, reader));
					}
				}
				if (importer3 != null)
				{
					obj = importer3(obj);
				}
			}
			return obj;
		}

		private static IJsonWrapper ReadValue(WrapperFactory factory, JsonReader reader)
		{
			reader.Read();
			if (reader.Token == JsonToken.ArrayEnd || reader.Token == JsonToken.Null)
			{
				return null;
			}
			IJsonWrapper jsonWrapper = factory();
			if (reader.Token == JsonToken.String)
			{
				jsonWrapper.SetString((string)reader.Value);
				return jsonWrapper;
			}
			if (reader.Token == JsonToken.Real)
			{
				jsonWrapper.SetReal((double)reader.Value);
				return jsonWrapper;
			}
			if (reader.Token == JsonToken.Natural)
			{
				jsonWrapper.SetNatural((long)reader.Value);
				return jsonWrapper;
			}
			if (reader.Token == JsonToken.Boolean)
			{
				jsonWrapper.SetBoolean((bool)reader.Value);
				return jsonWrapper;
			}
			if (reader.Token == JsonToken.ArrayStart)
			{
				jsonWrapper.SetJsonType(JsonType.Array);
				while (true)
				{
					IJsonWrapper jsonWrapper2 = ReadValue(factory, reader);
					if (jsonWrapper2 == null && reader.Token == JsonToken.ArrayEnd)
					{
						break;
					}
					jsonWrapper.Add(jsonWrapper2);
				}
			}
			else if (reader.Token == JsonToken.ObjectStart)
			{
				jsonWrapper.SetJsonType(JsonType.Object);
				while (true)
				{
					reader.Read();
					if (reader.Token == JsonToken.ObjectEnd)
					{
						break;
					}
					string key = (string)reader.Value;
					jsonWrapper[key] = ReadValue(factory, reader);
				}
			}
			return jsonWrapper;
		}

		private static void ReadSkip(JsonReader reader)
		{
			ToWrapper(() => new JsonMockWrapper(), reader);
		}

		private static void RegisterBaseExporters()
		{
			baseExportTable[typeof(sbyte)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToInt64((sbyte)obj));
			};
			baseExportTable[typeof(byte)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToInt64((byte)obj));
			};
			baseExportTable[typeof(char)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToString((char)obj));
			};
			baseExportTable[typeof(short)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToInt64((short)obj));
			};
			baseExportTable[typeof(ushort)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToInt64((ushort)obj));
			};
			baseExportTable[typeof(int)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToInt64((int)obj));
			};
			baseExportTable[typeof(uint)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToInt64((uint)obj));
			};
			baseExportTable[typeof(ulong)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToUInt64((ulong)obj));
			};
			baseExportTable[typeof(float)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToDouble((float)obj));
			};
			baseExportTable[typeof(decimal)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToDecimal((decimal)obj));
			};
			baseExportTable[typeof(DateTime)] = delegate(object obj, JsonWriter writer)
			{
				writer.Write(Convert.ToString((DateTime)obj, datetimeFormat));
			};
		}

		private static void RegisterBaseImporters()
		{
			RegisterImporter(baseImportTable, typeof(long), typeof(sbyte), (object input) => Convert.ToSByte((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(byte), (object input) => Convert.ToByte((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(short), (object input) => Convert.ToInt16((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(ushort), (object input) => Convert.ToUInt16((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(int), (object input) => Convert.ToInt32((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(uint), (object input) => Convert.ToUInt32((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(ulong), (object input) => Convert.ToUInt64((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(float), (object input) => Convert.ToSingle((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(double), (object input) => Convert.ToDouble((long)input));
			RegisterImporter(baseImportTable, typeof(long), typeof(decimal), (object input) => Convert.ToDecimal((long)input));
			RegisterImporter(baseImportTable, typeof(double), typeof(float), (object input) => Convert.ToSingle((double)input));
			RegisterImporter(baseImportTable, typeof(double), typeof(decimal), (object input) => Convert.ToDecimal((double)input));
			RegisterImporter(baseImportTable, typeof(string), typeof(char), (object input) => Convert.ToChar((string)input));
			RegisterImporter(baseImportTable, typeof(string), typeof(DateTime), (object input) => Convert.ToDateTime((string)input, datetimeFormat));
		}

		private static void RegisterImporter(IDictionary<Type, IDictionary<Type, ImporterFunc>> table, Type jsonType, Type valueType, ImporterFunc importer)
		{
			if (!table.ContainsKey(jsonType))
			{
				table.Add(jsonType, new Dictionary<Type, ImporterFunc>());
			}
			table[jsonType][valueType] = importer;
		}

		private static void WriteValue(object obj, JsonWriter writer, bool privateWriter, int depth)
		{
			if (depth > maxNestingDepth)
			{
				throw new JsonException($"Max allowed object depth reached while trying to export from type {obj.GetType()}");
			}
			if (obj == null)
			{
				writer.Write(null);
				return;
			}
			if (obj is IJsonWrapper)
			{
				if (privateWriter)
				{
					writer.TextWriter.Write(((IJsonWrapper)obj).ToJson());
				}
				else
				{
					((IJsonWrapper)obj).ToJson(writer);
				}
				return;
			}
			if (obj is string)
			{
				writer.Write((string)obj);
				return;
			}
			if (obj is double)
			{
				writer.Write((double)obj);
				return;
			}
			if (obj is long)
			{
				writer.Write((long)obj);
				return;
			}
			if (obj is bool)
			{
				writer.Write((bool)obj);
				return;
			}
			if (obj is Array)
			{
				writer.WriteArrayStart();
				Array array = (Array)obj;
				Type elementType = array.GetType().GetElementType();
				IEnumerator enumerator = array.GetEnumerator();
				try
				{
					while (enumerator.MoveNext())
					{
						object current = enumerator.Current;
						if (writer.TypeHinting && ((current != null) & (current.GetType() != elementType)))
						{
							writer.WriteObjectStart();
							writer.WritePropertyName(writer.HintTypeName);
							writer.Write(current.GetType().FullName);
							writer.WritePropertyName(writer.HintValueName);
							WriteValue(current, writer, privateWriter, depth + 1);
							writer.WriteObjectEnd();
						}
						else
						{
							WriteValue(current, writer, privateWriter, depth + 1);
						}
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
				return;
			}
			if (obj is IList)
			{
				writer.WriteArrayStart();
				IList list = (IList)obj;
				Type type = typeof(object);
				if (list.GetType().GetGenericArguments().Length > 0)
				{
					type = list.GetType().GetGenericArguments()[0];
				}
				IEnumerator enumerator2 = list.GetEnumerator();
				try
				{
					while (enumerator2.MoveNext())
					{
						object current2 = enumerator2.Current;
						if (writer.TypeHinting && current2 != null && current2.GetType() != type)
						{
							writer.WriteObjectStart();
							writer.WritePropertyName(writer.HintTypeName);
							writer.Write(current2.GetType().AssemblyQualifiedName);
							writer.WritePropertyName(writer.HintValueName);
							WriteValue(current2, writer, privateWriter, depth + 1);
							writer.WriteObjectEnd();
						}
						else
						{
							WriteValue(current2, writer, privateWriter, depth + 1);
						}
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
				writer.WriteArrayEnd();
				return;
			}
			if (obj is IDictionary)
			{
				writer.WriteObjectStart();
				IDictionary dictionary = (IDictionary)obj;
				Type type2 = typeof(object);
				if (dictionary.GetType().GetGenericArguments().Length > 1)
				{
					type2 = dictionary.GetType().GetGenericArguments()[1];
				}
				IDictionaryEnumerator enumerator3 = dictionary.GetEnumerator();
				try
				{
					while (enumerator3.MoveNext())
					{
						DictionaryEntry dictionaryEntry = (DictionaryEntry)enumerator3.Current;
						writer.WritePropertyName((string)dictionaryEntry.Key);
						if (writer.TypeHinting && dictionaryEntry.Value != null && dictionaryEntry.Value.GetType() != type2)
						{
							writer.WriteObjectStart();
							writer.WritePropertyName(writer.HintTypeName);
							writer.Write(dictionaryEntry.Value.GetType().AssemblyQualifiedName);
							writer.WritePropertyName(writer.HintValueName);
							WriteValue(dictionaryEntry.Value, writer, privateWriter, depth + 1);
							writer.WriteObjectEnd();
						}
						else
						{
							WriteValue(dictionaryEntry.Value, writer, privateWriter, depth + 1);
						}
					}
				}
				finally
				{
					IDisposable disposable3;
					if ((disposable3 = (enumerator3 as IDisposable)) != null)
					{
						disposable3.Dispose();
					}
				}
				writer.WriteObjectEnd();
				return;
			}
			Type type3 = obj.GetType();
			ExporterFunc exporter = GetExporter(type3);
			if (exporter != null)
			{
				exporter(obj, writer);
			}
			else if (obj is Enum)
			{
				Type underlyingType = Enum.GetUnderlyingType(type3);
				if (underlyingType == typeof(long))
				{
					writer.Write((long)obj);
				}
				else
				{
					GetExporter(underlyingType)?.Invoke(obj, writer);
				}
			}
			else
			{
				ObjectMetadata objectMetadata = AddObjectMetadata(type3);
				writer.WriteObjectStart();
				foreach (string key in objectMetadata.Properties.Keys)
				{
					PropertyMetadata propertyMetadata = objectMetadata.Properties[key];
					if ((propertyMetadata.Alias == null || !(key != propertyMetadata.Info.Name) || !objectMetadata.Properties.ContainsKey(propertyMetadata.Info.Name)) && (propertyMetadata.Ignore & JsonIgnoreWhen.Serializing) <= JsonIgnoreWhen.Never)
					{
						if (propertyMetadata.IsField)
						{
							FieldInfo fieldInfo = (FieldInfo)propertyMetadata.Info;
							if (propertyMetadata.Alias != null)
							{
								writer.WritePropertyName(propertyMetadata.Alias);
							}
							else
							{
								writer.WritePropertyName(fieldInfo.Name);
							}
							object value = fieldInfo.GetValue(obj);
							if (writer.TypeHinting && value != null && fieldInfo.FieldType != value.GetType())
							{
								writer.WriteObjectStart();
								writer.WritePropertyName(writer.HintTypeName);
								writer.Write(value.GetType().AssemblyQualifiedName);
								writer.WritePropertyName(writer.HintValueName);
								WriteValue(value, writer, privateWriter, depth + 1);
								writer.WriteObjectEnd();
							}
							else
							{
								WriteValue(value, writer, privateWriter, depth + 1);
							}
						}
						else
						{
							PropertyInfo propertyInfo = (PropertyInfo)propertyMetadata.Info;
							if (propertyInfo.CanRead)
							{
								if (propertyMetadata.Alias != null)
								{
									writer.WritePropertyName(propertyMetadata.Alias);
								}
								else
								{
									writer.WritePropertyName(propertyInfo.Name);
								}
								object value2 = propertyInfo.GetValue(obj, null);
								if (writer.TypeHinting && value2 != null && propertyInfo.PropertyType != value2.GetType())
								{
									writer.WriteObjectStart();
									writer.WritePropertyName(writer.HintTypeName);
									writer.Write(value2.GetType().AssemblyQualifiedName);
									writer.WritePropertyName(writer.HintValueName);
									WriteValue(value2, writer, privateWriter, depth + 1);
									writer.WriteObjectEnd();
								}
								else
								{
									WriteValue(value2, writer, privateWriter, depth + 1);
								}
							}
						}
					}
				}
				writer.WriteObjectEnd();
			}
		}

		public static string ToJson(object obj)
		{
			JsonWriter jsonWriter = new JsonWriter();
			WriteValue(obj, jsonWriter, privateWriter: true, 0);
			return jsonWriter.ToString();
		}

		public static void ToJson(object obj, JsonWriter writer)
		{
			WriteValue(obj, writer, privateWriter: false, 0);
		}

		public static JsonData ToObject(JsonReader reader)
		{
			return (JsonData)ToWrapper(() => new JsonData(), reader);
		}

		public static JsonData ToObject(TextReader reader)
		{
			JsonReader reader2 = new JsonReader(reader);
			return (JsonData)ToWrapper(() => new JsonData(), reader2);
		}

		public static JsonData ToObject(string json)
		{
			return (JsonData)ToWrapper(() => new JsonData(), json);
		}

		public static T ToObject<T>(JsonReader reader)
		{
			return (T)ReadValue(typeof(T), reader);
		}

		public static T ToObject<T>(TextReader reader)
		{
			JsonReader reader2 = new JsonReader(reader);
			return (T)ReadValue(typeof(T), reader2);
		}

		public static T ToObject<T>(string json)
		{
			JsonReader reader = new JsonReader(json);
			return (T)ReadValue(typeof(T), reader);
		}

		public static IJsonWrapper ToWrapper(WrapperFactory factory, JsonReader reader)
		{
			return ReadValue(factory, reader);
		}

		public static IJsonWrapper ToWrapper(WrapperFactory factory, string json)
		{
			JsonReader reader = new JsonReader(json);
			return ReadValue(factory, reader);
		}

		public static void RegisterExporter<T>(ExporterFunc<T> exporter)
		{
			ExporterFunc value = delegate(object obj, JsonWriter writer)
			{
				exporter((T)obj, writer);
			};
			customExportTable[typeof(T)] = value;
		}

		public static void RegisterImporter<TJson, TValue>(ImporterFunc<TJson, TValue> importer)
		{
			ImporterFunc importer2 = (object input) => importer((TJson)input);
			RegisterImporter(customImportTable, typeof(TJson), typeof(TValue), importer2);
		}

		public static void RegisterFactory<T>(FactoryFunc<T> factory)
		{
			FactoryFunc value = () => factory();
			customFactoryTable[typeof(T)] = value;
		}

		public static void UnregisterFactories()
		{
			customFactoryTable.Clear();
		}

		public static void UnregisterExporters()
		{
			customExportTable.Clear();
		}

		public static void UnregisterImporters()
		{
			customImportTable.Clear();
		}
	}
}
