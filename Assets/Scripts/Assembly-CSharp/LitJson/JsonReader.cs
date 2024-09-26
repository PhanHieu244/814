using System;
using System.Collections.Generic;
using System.IO;

namespace LitJson
{
	public class JsonReader
	{
		private static readonly IDictionary<int, IDictionary<int, int[]>> parseTable;

		private Stack<int> automationStack;

		private Lexer lexer;

		private TextReader reader;

		private int currentInput;

		private int currentSymbol;

		private bool parserInString;

		private bool parserReturn;

		private bool readStarted;

		private bool readerIsOwned;

		public bool AllowComments
		{
			get
			{
				return lexer.AllowComments;
			}
			set
			{
				lexer.AllowComments = value;
			}
		}

		public bool AllowSingleQuotedStrings
		{
			get
			{
				return lexer.AllowSingleQuotedStrings;
			}
			set
			{
				lexer.AllowSingleQuotedStrings = value;
			}
		}

		public bool SkipNonMembers
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

		public bool EndOfInput
		{
			get;
			private set;
		}

		public bool EndOfJson
		{
			get;
			private set;
		}

		public JsonToken Token
		{
			get;
			private set;
		}

		public object Value
		{
			get;
			private set;
		}

		public JsonReader(string json)
			: this(new StringReader(json), owned: true)
		{
		}

		public JsonReader(TextReader reader)
			: this(reader, owned: false)
		{
		}

		private JsonReader(TextReader reader, bool owned)
		{
			if (reader == null)
			{
				throw new ArgumentNullException("reader");
			}
			parserInString = false;
			parserReturn = false;
			readStarted = false;
			automationStack = new Stack<int>();
			automationStack.Push(65553);
			automationStack.Push(65543);
			lexer = new Lexer(reader);
			EndOfInput = false;
			EndOfJson = false;
			SkipNonMembers = true;
			this.reader = reader;
			readerIsOwned = owned;
			TypeHinting = false;
			HintTypeName = "__type__";
			HintValueName = "__value__";
		}

		static JsonReader()
		{
			parseTable = new Dictionary<int, IDictionary<int, int[]>>();
			TableAddRow(ParserToken.Array);
			TableAddCol(ParserToken.Array, 91, 91, 65549);
			TableAddRow(ParserToken.ArrayPrime);
			TableAddCol(ParserToken.ArrayPrime, 34, 65550, 65551, 93);
			TableAddCol(ParserToken.ArrayPrime, 91, 65550, 65551, 93);
			TableAddCol(ParserToken.ArrayPrime, 93, 93);
			TableAddCol(ParserToken.ArrayPrime, 123, 65550, 65551, 93);
			TableAddCol(ParserToken.ArrayPrime, 65537, 65550, 65551, 93);
			TableAddCol(ParserToken.ArrayPrime, 65538, 65550, 65551, 93);
			TableAddCol(ParserToken.ArrayPrime, 65539, 65550, 65551, 93);
			TableAddCol(ParserToken.ArrayPrime, 65540, 65550, 65551, 93);
			TableAddRow(ParserToken.Object);
			TableAddCol(ParserToken.Object, 123, 123, 65545);
			TableAddRow(ParserToken.ObjectPrime);
			TableAddCol(ParserToken.ObjectPrime, 34, 65546, 65547, 125);
			TableAddCol(ParserToken.ObjectPrime, 125, 125);
			TableAddRow(ParserToken.Pair);
			TableAddCol(ParserToken.Pair, 34, 65552, 58, 65550);
			TableAddRow(ParserToken.PairRest);
			TableAddCol(ParserToken.PairRest, 44, 44, 65546, 65547);
			TableAddCol(ParserToken.PairRest, 125, 65554);
			TableAddRow(ParserToken.String);
			TableAddCol(ParserToken.String, 34, 34, 65541, 34);
			TableAddRow(ParserToken.Text);
			TableAddCol(ParserToken.Text, 91, 65548);
			TableAddCol(ParserToken.Text, 123, 65544);
			TableAddRow(ParserToken.Value);
			TableAddCol(ParserToken.Value, 34, 65552);
			TableAddCol(ParserToken.Value, 91, 65548);
			TableAddCol(ParserToken.Value, 123, 65544);
			TableAddCol(ParserToken.Value, 65537, 65537);
			TableAddCol(ParserToken.Value, 65538, 65538);
			TableAddCol(ParserToken.Value, 65539, 65539);
			TableAddCol(ParserToken.Value, 65540, 65540);
			TableAddRow(ParserToken.ValueRest);
			TableAddCol(ParserToken.ValueRest, 44, 44, 65550, 65551);
			TableAddCol(ParserToken.ValueRest, 93, 65554);
		}

		private static void TableAddCol(ParserToken row, int col, params int[] symbols)
		{
			parseTable[(int)row].Add(col, symbols);
		}

		private static void TableAddRow(ParserToken rule)
		{
			parseTable.Add((int)rule, new Dictionary<int, int[]>());
		}

		private void ProcessNumber(string number)
		{
			if ((number.IndexOf('.') != -1 || number.IndexOf('e') != -1 || number.IndexOf('E') != -1) && double.TryParse(number, out double result))
			{
				Token = JsonToken.Real;
				Value = result;
				return;
			}
			if (long.TryParse(number, out long result2))
			{
				Token = JsonToken.Natural;
				Value = result2;
				return;
			}
			if (ulong.TryParse(number, out ulong result3))
			{
				Token = JsonToken.Natural;
				Value = result3;
				return;
			}
			if (decimal.TryParse(number, out decimal result4))
			{
				Token = JsonToken.Real;
				Value = result4;
				return;
			}
			Token = JsonToken.Natural;
			Value = 0;
			throw new JsonException($"Failed to parse number '{number}'");
		}

		private void ProcessSymbol()
		{
			if (currentSymbol == 91)
			{
				Token = JsonToken.ArrayStart;
				parserReturn = true;
			}
			else if (currentSymbol == 93)
			{
				Token = JsonToken.ArrayEnd;
				parserReturn = true;
			}
			else if (currentSymbol == 123)
			{
				Token = JsonToken.ObjectStart;
				parserReturn = true;
			}
			else if (currentSymbol == 125)
			{
				Token = JsonToken.ObjectEnd;
				parserReturn = true;
			}
			else if (currentSymbol == 34)
			{
				if (parserInString)
				{
					parserInString = false;
					parserReturn = true;
					return;
				}
				if (Token == JsonToken.None)
				{
					Token = JsonToken.String;
				}
				parserInString = true;
			}
			else if (currentSymbol == 65541)
			{
				Value = lexer.StringValue;
			}
			else if (currentSymbol == 65539)
			{
				Token = JsonToken.Boolean;
				Value = false;
				parserReturn = true;
			}
			else if (currentSymbol == 65540)
			{
				Token = JsonToken.Null;
				parserReturn = true;
			}
			else if (currentSymbol == 65537)
			{
				ProcessNumber(lexer.StringValue);
				parserReturn = true;
			}
			else if (currentSymbol == 65546)
			{
				Token = JsonToken.PropertyName;
			}
			else if (currentSymbol == 65538)
			{
				Token = JsonToken.Boolean;
				Value = true;
				parserReturn = true;
			}
		}

		private bool ReadToken()
		{
			if (EndOfInput)
			{
				return false;
			}
			lexer.NextToken();
			if (lexer.EndOfInput)
			{
				Close();
				return false;
			}
			currentInput = lexer.Token;
			return true;
		}

		public void Close()
		{
			if (!EndOfInput)
			{
				EndOfInput = true;
				EndOfJson = true;
				if (readerIsOwned)
				{
					reader.Close();
				}
				reader = null;
			}
		}

		public bool Read()
		{
			if (EndOfInput)
			{
				return false;
			}
			if (EndOfJson)
			{
				EndOfJson = false;
				automationStack.Clear();
				automationStack.Push(65553);
				automationStack.Push(65543);
			}
			parserInString = false;
			parserReturn = false;
			Token = JsonToken.None;
			Value = null;
			if (!readStarted)
			{
				readStarted = true;
				if (!ReadToken())
				{
					return false;
				}
			}
			while (true)
			{
				if (parserReturn)
				{
					if (automationStack.Peek() == 65553)
					{
						EndOfJson = true;
					}
					return true;
				}
				currentSymbol = automationStack.Pop();
				ProcessSymbol();
				if (currentSymbol == currentInput)
				{
					if (!ReadToken())
					{
						break;
					}
					continue;
				}
				int[] array;
				try
				{
					array = parseTable[currentSymbol][currentInput];
				}
				catch (KeyNotFoundException inner)
				{
					throw new JsonException((ParserToken)currentInput, inner);
				}
				if (array[0] != 65554)
				{
					for (int num = array.Length - 1; num >= 0; num--)
					{
						automationStack.Push(array[num]);
					}
				}
			}
			if (automationStack.Peek() != 65553)
			{
				throw new JsonException("Input doesn't evaluate to proper JSON text");
			}
			if (parserReturn)
			{
				return true;
			}
			return false;
		}
	}
}
