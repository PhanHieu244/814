using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace LitJson
{
	public class JsonWriter
	{
		private static readonly NumberFormatInfo numberFormat;

		private WriterContext context;

		private Stack<WriterContext> ctxStack;

		private bool hasReachedEnd;

		private char[] hexSeq;

		private int indentation;

		private int indentValue;

		private StringBuilder stringBuilder;

		public int IndentValue
		{
			get
			{
				return indentValue;
			}
			set
			{
				indentation = indentation / indentValue * value;
				indentValue = value;
			}
		}

		public bool PrettyPrint
		{
			get;
			set;
		}

		public bool Validate
		{
			get;
			set;
		}

		public bool TypeHinting
		{
			get;
			set;
		}

		public string HintTypeName
		{
			get;
			set;
		}

		public string HintValueName
		{
			get;
			set;
		}

		public TextWriter TextWriter
		{
			get;
			private set;
		}

		static JsonWriter()
		{
			numberFormat = NumberFormatInfo.InvariantInfo;
		}

		public JsonWriter()
		{
			stringBuilder = new StringBuilder();
			TextWriter = new StringWriter(stringBuilder);
			Init();
		}

		public JsonWriter(StringBuilder sb)
			: this(new StringWriter(sb))
		{
		}

		public JsonWriter(TextWriter writer)
		{
			if (writer == null)
			{
				throw new ArgumentNullException("writer");
			}
			TextWriter = writer;
			Init();
		}

		private void DoValidation(Condition cond)
		{
			if (!context.ExpectingValue)
			{
				context.Count++;
			}
			if (!Validate)
			{
				return;
			}
			if (hasReachedEnd)
			{
				throw new JsonException("A complete JSON symbol has already been written");
			}
			switch (cond)
			{
			case Condition.InArray:
				if (!context.InArray)
				{
					throw new JsonException("Can't close an array here");
				}
				break;
			case Condition.InObject:
				if (!context.InObject || context.ExpectingValue)
				{
					throw new JsonException("Can't close an object here");
				}
				break;
			case Condition.NotAProperty:
				if (context.InObject && !context.ExpectingValue)
				{
					throw new JsonException("Expected a property in obj? " + context.InObject + " expect val? " + context.ExpectingValue + " <" + stringBuilder.ToString() + ">");
				}
				break;
			case Condition.Property:
				if (!context.InObject || context.ExpectingValue)
				{
					throw new JsonException("Can't add a property here");
				}
				break;
			case Condition.Value:
				if (!context.InArray && (!context.InObject || !context.ExpectingValue))
				{
					throw new JsonException("Can't add a value here");
				}
				break;
			}
		}

		private void Init()
		{
			hasReachedEnd = false;
			hexSeq = new char[4];
			indentation = 0;
			indentValue = 4;
			PrettyPrint = false;
			Validate = true;
			TypeHinting = false;
			HintTypeName = "__type__";
			HintValueName = "__value__";
			ctxStack = new Stack<WriterContext>();
			context = new WriterContext();
			ctxStack.Push(context);
		}

		private static void IntToHex(int n, char[] hex)
		{
			for (int i = 0; i < 4; i++)
			{
				int num = n % 16;
				if (num < 10)
				{
					hex[3 - i] = (char)(48 + num);
				}
				else
				{
					hex[3 - i] = (char)(65 + (num - 10));
				}
				n >>= 4;
			}
		}

		private void Indent()
		{
			if (PrettyPrint)
			{
				indentation += indentValue;
			}
		}

		private void Put(string str)
		{
			if (PrettyPrint && !context.ExpectingValue)
			{
				for (int i = 0; i < indentation; i++)
				{
					TextWriter.Write(' ');
				}
			}
			TextWriter.Write(str);
		}

		private void PutNewline(bool addComma = true)
		{
			if (addComma && !context.ExpectingValue && context.Count > 1)
			{
				TextWriter.Write(',');
			}
			if (PrettyPrint && !context.ExpectingValue)
			{
				TextWriter.Write(Environment.NewLine);
			}
		}

		private void PutString(string str)
		{
			Put(string.Empty);
			TextWriter.Write('"');
			int length = str.Length;
			for (int i = 0; i < length; i++)
			{
				switch (str[i])
				{
				case '\n':
					TextWriter.Write("\\n");
					continue;
				case '\r':
					TextWriter.Write("\\r");
					continue;
				case '\t':
					TextWriter.Write("\\t");
					continue;
				case '"':
				case '\\':
					TextWriter.Write('\\');
					TextWriter.Write(str[i]);
					continue;
				case '\f':
					TextWriter.Write("\\f");
					continue;
				case '\b':
					TextWriter.Write("\\b");
					continue;
				}
				if (str[i] >= ' ' && str[i] <= '~')
				{
					TextWriter.Write(str[i]);
					continue;
				}
				IntToHex(str[i], hexSeq);
				TextWriter.Write("\\u");
				TextWriter.Write(hexSeq);
			}
			TextWriter.Write('"');
		}

		private void Unindent()
		{
			if (PrettyPrint)
			{
				indentation -= indentValue;
			}
		}

		public override string ToString()
		{
			if (stringBuilder == null)
			{
				return string.Empty;
			}
			return stringBuilder.ToString();
		}

		public void Reset()
		{
			hasReachedEnd = false;
			ctxStack.Clear();
			context = new WriterContext();
			ctxStack.Push(context);
			if (stringBuilder != null)
			{
				stringBuilder.Remove(0, stringBuilder.Length);
			}
		}

		public void Write(bool boolean)
		{
			DoValidation(Condition.Value);
			PutNewline();
			Put((!boolean) ? "false" : "true");
			context.ExpectingValue = false;
		}

		public void Write(double number)
		{
			DoValidation(Condition.Value);
			PutNewline();
			string text = number.ToString("R", numberFormat);
			Put(text);
			if (text.IndexOf('.') == -1 && text.IndexOf('E') == -1)
			{
				TextWriter.Write(".0");
			}
			context.ExpectingValue = false;
		}

		public void Write(decimal number)
		{
			DoValidation(Condition.Value);
			PutNewline();
			Put(Convert.ToString(number, numberFormat));
			context.ExpectingValue = false;
		}

		public void Write(long number)
		{
			DoValidation(Condition.Value);
			PutNewline();
			Put(Convert.ToString(number, numberFormat));
			context.ExpectingValue = false;
		}

		public void Write(ulong number)
		{
			DoValidation(Condition.Value);
			PutNewline();
			Put(Convert.ToString(number, numberFormat));
			context.ExpectingValue = false;
		}

		public void Write(string str)
		{
			DoValidation(Condition.Value);
			PutNewline();
			if (str == null)
			{
				Put("null");
			}
			else
			{
				PutString(str);
			}
			context.ExpectingValue = false;
		}

		public void WriteArrayEnd()
		{
			DoValidation(Condition.InArray);
			PutNewline(addComma: false);
			ctxStack.Pop();
			if (ctxStack.Count == 1)
			{
				hasReachedEnd = true;
			}
			else
			{
				context = ctxStack.Peek();
				context.ExpectingValue = false;
			}
			Unindent();
			Put("]");
		}

		public void WriteArrayStart()
		{
			DoValidation(Condition.NotAProperty);
			PutNewline();
			Put("[");
			context = new WriterContext();
			context.InArray = true;
			ctxStack.Push(context);
			Indent();
		}

		public void WriteObjectEnd()
		{
			DoValidation(Condition.InObject);
			PutNewline(addComma: false);
			ctxStack.Pop();
			if (ctxStack.Count == 1)
			{
				hasReachedEnd = true;
			}
			else
			{
				context = ctxStack.Peek();
				context.ExpectingValue = false;
			}
			Unindent();
			Put("}");
		}

		public void WriteObjectStart()
		{
			DoValidation(Condition.NotAProperty);
			PutNewline();
			Put("{");
			context = new WriterContext();
			context.InObject = true;
			ctxStack.Push(context);
			Indent();
		}

		public void WritePropertyName(string name)
		{
			DoValidation(Condition.Property);
			PutNewline();
			PutString(name);
			if (PrettyPrint)
			{
				if (name.Length > context.Padding)
				{
					context.Padding = name.Length;
				}
				for (int num = context.Padding - name.Length; num >= 0; num--)
				{
					TextWriter.Write(' ');
				}
				TextWriter.Write(": ");
			}
			else
			{
				TextWriter.Write(':');
			}
			context.ExpectingValue = true;
		}
	}
}
