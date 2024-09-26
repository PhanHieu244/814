using LitJson.Extensions;
using System;
using UnityEngine;

namespace LitJson
{
	public static class UnityTypeBindings
	{
		private static bool registerd;

		static UnityTypeBindings()
		{
			Register();
		}

		public static void Register()
		{
			if (!registerd)
			{
				registerd = true;
				JsonMapper.RegisterExporter(delegate(Type v, JsonWriter w)
				{
					w.Write(v.FullName);
				});
				JsonMapper.RegisterImporter((string s) => Type.GetType(s));
				Action<Vector2, JsonWriter> writeVector4 = delegate(Vector2 v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("x", v.x);
					w.WriteProperty("y", v.y);
					w.WriteObjectEnd();
				};
				JsonMapper.RegisterExporter(delegate(Vector2 v, JsonWriter w)
				{
					writeVector4(v, w);
				});
				Action<Vector3, JsonWriter> writeVector3 = delegate(Vector3 v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("x", v.x);
					w.WriteProperty("y", v.y);
					w.WriteProperty("z", v.z);
					w.WriteObjectEnd();
				};
				JsonMapper.RegisterExporter(delegate(Vector3 v, JsonWriter w)
				{
					writeVector3(v, w);
				});
				JsonMapper.RegisterExporter(delegate(Vector4 v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("x", v.x);
					w.WriteProperty("y", v.y);
					w.WriteProperty("z", v.z);
					w.WriteProperty("w", v.w);
					w.WriteObjectEnd();
				});
				JsonMapper.RegisterExporter(delegate(Quaternion v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("x", v.x);
					w.WriteProperty("y", v.y);
					w.WriteProperty("z", v.z);
					w.WriteProperty("w", v.w);
					w.WriteObjectEnd();
				});
				JsonMapper.RegisterExporter(delegate(Color v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("r", v.r);
					w.WriteProperty("g", v.g);
					w.WriteProperty("b", v.b);
					w.WriteProperty("a", v.a);
					w.WriteObjectEnd();
				});
				JsonMapper.RegisterExporter(delegate(Color32 v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("r", (int)v.r);
					w.WriteProperty("g", (int)v.g);
					w.WriteProperty("b", (int)v.b);
					w.WriteProperty("a", (int)v.a);
					w.WriteObjectEnd();
				});
				JsonMapper.RegisterExporter(delegate(Bounds v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WritePropertyName("center");
					writeVector3(v.center, w);
					w.WritePropertyName("size");
					writeVector3(v.size, w);
					w.WriteObjectEnd();
				});
				JsonMapper.RegisterExporter(delegate(Rect v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("x", v.x);
					w.WriteProperty("y", v.y);
					w.WriteProperty("width", v.width);
					w.WriteProperty("height", v.height);
					w.WriteObjectEnd();
				});
				JsonMapper.RegisterExporter(delegate(RectOffset v, JsonWriter w)
				{
					w.WriteObjectStart();
					w.WriteProperty("top", v.top);
					w.WriteProperty("left", v.left);
					w.WriteProperty("bottom", v.bottom);
					w.WriteProperty("right", v.right);
					w.WriteObjectEnd();
				});
			}
		}
	}
}
