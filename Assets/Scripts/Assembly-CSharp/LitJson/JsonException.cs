using System;

namespace LitJson
{
	public class JsonException : Exception
	{
		public JsonException()
		{
		}

		internal JsonException(ParserToken token)
			: base($"Invalid token '{token}' in input string")
		{
		}

		internal JsonException(ParserToken token, Exception inner)
			: base($"Invalid token '{token}' in input string", inner)
		{
		}

		internal JsonException(int c)
			: base($"Invalid character '{(char)c}' in input string")
		{
		}

		internal JsonException(int c, Exception inner)
			: base($"Invalid character '{(char)c}' in input string", inner)
		{
		}

		public JsonException(string message)
			: base(message)
		{
		}

		public JsonException(string message, Exception inner)
			: base(message, inner)
		{
		}
	}
}
