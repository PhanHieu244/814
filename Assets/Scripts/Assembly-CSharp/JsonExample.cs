using LitJson;
using UnityEngine;

public class JsonExample : MonoBehaviour
{
	public class ExampleSerializedClass
	{
		public int myInt = 42;

		public string myString = "The quick brown fox jumped over the lazy dog.";

		public float myFloat = 3.14159f;

		public bool myBool;

		public Vector2 myVector2 = Vector2.one;

		public Vector3 myVector3 = Vector3.one * 3.14159f;

		public Vector4 myVector4 = Vector4.one * 6.28318f;

		public Quaternion myQuaternion = Quaternion.identity;

		public Color myColor = Color.red;

		public Color32 myColor32 = new Color32(85, 127, byte.MaxValue, byte.MaxValue);

		public Bounds myBounds = new Bounds(Vector3.zero, Vector3.one);

		public Rect myRect = new Rect(10f, 10f, 25f, 25f);

		public RectOffset myRectOffset = new RectOffset(5, 10, 15, 20);

		public int[] myIntArray = new int[5]
		{
			2,
			4,
			6,
			8,
			10
		};

		[JsonIgnore]
		public Transform myIgnoredTransform;
	}

	private const string savedJsonString = "{\n\t\t\"myInt\" : 42,\n\t\t\"myString\" : \"This value has changed!\",\n\t\t\"myFloat\"  : 6.28318,\n\t\t\"myBool\"   : true,\n\t\t\"myVector2\" : {\n\t\t\t\"x\" : 8.0,\n\t\t\t\"y\" : 8.0\n\t\t},\n\t\t\"myVector3\" : {\n\t\t\t\"x\" : 3.1415901184082,\n\t\t\t\"y\" : 3.1415901184082,\n\t\t\t\"z\" : 3.1415901184082\n\t\t},\n\t\t\"myVector4\" : {\n\t\t\t\"x\" : 6.28318023681641,\n\t\t\t\"y\" : 6.28318023681641,\n\t\t\t\"z\" : 6.28318023681641,\n\t\t\t\"w\" : 6.28318023681641\n\t\t},\n\t\t\"myQuaternion\" : {\n\t\t\t\"x\" : 1.0,\n\t\t\t\"y\" : 1.0,\n\t\t\t\"z\" : 1.0,\n\t\t\t\"w\" : 1.0\n\t\t},\n\t\t\"myColor\"      : {\n\t\t\t\"r\" : 0.0,\n\t\t\t\"g\" : 0.0,\n\t\t\t\"b\" : 0.0,\n\t\t\t\"a\" : 0.0\n\t\t},\n\t\t\"myColor32\"    : {\n\t\t\t\"r\" : 85,\n\t\t\t\"g\" : 127,\n\t\t\t\"b\" : 255,\n\t\t\t\"a\" : 0\n\t\t},\n\t\t\"myBounds\"     : {\n\t\t\t\"center\" : {\n\t\t\t\t\"x\" : 0.0,\n\t\t\t\t\"y\" : 0.0,\n\t\t\t\t\"z\" : 0.0\n\t\t\t},\n\t\t\t\"size\"   : {\n\t\t\t\t\"x\" : 1.0,\n\t\t\t\t\"y\" : 1.0,\n\t\t\t\t\"z\" : 1.0\n\t\t\t}\n\t\t},\n\t\t\"myRect\"       : {\n\t\t\t\"x\" : 10.0,\n\t\t\t\"y\" : 10.0,\n\t\t\t\"width\" : 25.0,\n\t\t\t\"height\" : 25.0\n\t\t},\n\t\t\"myRectOffset\" : {\n\t\t\t\"top\" : 15,\n\t\t\t\"left\" : 5,\n\t\t\t\"bottom\" : 20,\n\t\t\t\"right\"  : 10\n\t\t},\n\t\t\"myIntArray\"   : [\n\t\t\t   12,\n\t\t\t   14,\n\t\t\t   16,\n\t\t\t   18,\n\t\t\t   20\n\t\t\t   ]\n\t}";

	private void Start()
	{
		ExampleSerializedClass obj = new ExampleSerializedClass();
		JsonWriter jsonWriter = new JsonWriter();
		jsonWriter.PrettyPrint = true;
		JsonMapper.ToJson(obj, jsonWriter);
		string message = jsonWriter.ToString();
		Debug.Log(message);
		ExampleSerializedClass exampleSerializedClass = JsonMapper.ToObject<ExampleSerializedClass>("{\n\t\t\"myInt\" : 42,\n\t\t\"myString\" : \"This value has changed!\",\n\t\t\"myFloat\"  : 6.28318,\n\t\t\"myBool\"   : true,\n\t\t\"myVector2\" : {\n\t\t\t\"x\" : 8.0,\n\t\t\t\"y\" : 8.0\n\t\t},\n\t\t\"myVector3\" : {\n\t\t\t\"x\" : 3.1415901184082,\n\t\t\t\"y\" : 3.1415901184082,\n\t\t\t\"z\" : 3.1415901184082\n\t\t},\n\t\t\"myVector4\" : {\n\t\t\t\"x\" : 6.28318023681641,\n\t\t\t\"y\" : 6.28318023681641,\n\t\t\t\"z\" : 6.28318023681641,\n\t\t\t\"w\" : 6.28318023681641\n\t\t},\n\t\t\"myQuaternion\" : {\n\t\t\t\"x\" : 1.0,\n\t\t\t\"y\" : 1.0,\n\t\t\t\"z\" : 1.0,\n\t\t\t\"w\" : 1.0\n\t\t},\n\t\t\"myColor\"      : {\n\t\t\t\"r\" : 0.0,\n\t\t\t\"g\" : 0.0,\n\t\t\t\"b\" : 0.0,\n\t\t\t\"a\" : 0.0\n\t\t},\n\t\t\"myColor32\"    : {\n\t\t\t\"r\" : 85,\n\t\t\t\"g\" : 127,\n\t\t\t\"b\" : 255,\n\t\t\t\"a\" : 0\n\t\t},\n\t\t\"myBounds\"     : {\n\t\t\t\"center\" : {\n\t\t\t\t\"x\" : 0.0,\n\t\t\t\t\"y\" : 0.0,\n\t\t\t\t\"z\" : 0.0\n\t\t\t},\n\t\t\t\"size\"   : {\n\t\t\t\t\"x\" : 1.0,\n\t\t\t\t\"y\" : 1.0,\n\t\t\t\t\"z\" : 1.0\n\t\t\t}\n\t\t},\n\t\t\"myRect\"       : {\n\t\t\t\"x\" : 10.0,\n\t\t\t\"y\" : 10.0,\n\t\t\t\"width\" : 25.0,\n\t\t\t\"height\" : 25.0\n\t\t},\n\t\t\"myRectOffset\" : {\n\t\t\t\"top\" : 15,\n\t\t\t\"left\" : 5,\n\t\t\t\"bottom\" : 20,\n\t\t\t\"right\"  : 10\n\t\t},\n\t\t\"myIntArray\"   : [\n\t\t\t   12,\n\t\t\t   14,\n\t\t\t   16,\n\t\t\t   18,\n\t\t\t   20\n\t\t\t   ]\n\t}");
		Debug.Log(exampleSerializedClass.myString);
	}
}
