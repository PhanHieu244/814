using System;
using System.IO;
using System.Runtime.CompilerServices;
using System.Text;

namespace LitJson
{
	internal class Lexer
	{
		private delegate bool StateHandler(FsmContext ctx);

		private static int[] returnTable;

		private static StateHandler[] handlerTable;

		private int inputBuffer;

		private int inputChar;

		private int state;

		private int unichar;

		private FsmContext context;

		private TextReader reader;

		private StringBuilder stringBuffer;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache0;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache1;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache2;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache3;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache4;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache5;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache6;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache7;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache8;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache9;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cacheA;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cacheB;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cacheC;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cacheD;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cacheE;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cacheF;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache10;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache11;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache12;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache13;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache14;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache15;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache16;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache17;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache18;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache19;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache1A;

		[CompilerGenerated]
		private static StateHandler _003C_003Ef__mg_0024cache1B;

		public bool AllowComments
		{
			get;
			set;
		}

		public bool AllowSingleQuotedStrings
		{
			get;
			set;
		}

		public bool EndOfInput
		{
			get;
			private set;
		}

		public int Token
		{
			get;
			private set;
		}

		public string StringValue
		{
			get;
			private set;
		}

		static Lexer()
		{
			PopulateFsmTables();
		}

		public Lexer(TextReader reader)
		{
			AllowComments = true;
			AllowSingleQuotedStrings = true;
			inputBuffer = 0;
			stringBuffer = new StringBuilder(128);
			state = 1;
			EndOfInput = false;
			this.reader = reader;
			context = new FsmContext();
			context.L = this;
		}

		private static int HexValue(int digit)
		{
			switch (digit)
			{
			case 65:
			case 97:
				return 10;
			case 66:
			case 98:
				return 11;
			case 67:
			case 99:
				return 12;
			case 68:
			case 100:
				return 13;
			case 69:
			case 101:
				return 14;
			case 70:
			case 102:
				return 15;
			default:
				return digit - 48;
			}
		}

		private static void PopulateFsmTables()
		{
			handlerTable = new StateHandler[28]
			{
				State1,
				State2,
				State3,
				State4,
				State5,
				State6,
				State7,
				State8,
				State9,
				State10,
				State11,
				State12,
				State13,
				State14,
				State15,
				State16,
				State17,
				State18,
				State19,
				State20,
				State21,
				State22,
				State23,
				State24,
				State25,
				State26,
				State27,
				State28
			};
			returnTable = new int[28]
			{
				65542,
				0,
				65537,
				65537,
				0,
				65537,
				0,
				65537,
				0,
				0,
				65538,
				0,
				0,
				0,
				65539,
				0,
				0,
				65540,
				65541,
				65542,
				0,
				0,
				65541,
				65542,
				0,
				0,
				0,
				0
			};
		}

		private static char ProcessEscChar(int escChar)
		{
			switch (escChar)
			{
			case 34:
			case 39:
			case 47:
			case 92:
				return Convert.ToChar(escChar);
			case 110:
				return '\n';
			case 116:
				return '\t';
			case 114:
				return '\r';
			case 98:
				return '\b';
			case 102:
				return '\f';
			default:
				return '?';
			}
		}

		private static bool State1(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar == 32 || (ctx.L.inputChar >= 9 && ctx.L.inputChar <= 13))
				{
					continue;
				}
				if (ctx.L.inputChar >= 49 && ctx.L.inputChar <= 57)
				{
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					ctx.NextState = 3;
					return true;
				}
				switch (ctx.L.inputChar)
				{
				case 34:
					ctx.NextState = 19;
					ctx.Return = true;
					return true;
				case 44:
				case 58:
				case 91:
				case 93:
				case 123:
				case 125:
					ctx.NextState = 1;
					ctx.Return = true;
					return true;
				case 45:
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					ctx.NextState = 2;
					return true;
				case 48:
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					ctx.NextState = 4;
					return true;
				case 102:
					ctx.NextState = 12;
					return true;
				case 110:
					ctx.NextState = 16;
					return true;
				case 116:
					ctx.NextState = 9;
					return true;
				case 39:
					if (!ctx.L.AllowSingleQuotedStrings)
					{
						return false;
					}
					ctx.L.inputChar = 34;
					ctx.NextState = 23;
					ctx.Return = true;
					return true;
				case 47:
					if (!ctx.L.AllowComments)
					{
						return false;
					}
					ctx.NextState = 25;
					return true;
				default:
					return false;
				}
			}
			return true;
		}

		private static bool State2(FsmContext ctx)
		{
			ctx.L.GetChar();
			if (ctx.L.inputChar >= 49 && ctx.L.inputChar <= 57)
			{
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 3;
				return true;
			}
			int num = ctx.L.inputChar;
			if (num == 48)
			{
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 4;
				return true;
			}
			return false;
		}

		private static bool State3(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar >= 48 && ctx.L.inputChar <= 57)
				{
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					continue;
				}
				if (ctx.L.inputChar == 32 || (ctx.L.inputChar >= 9 && ctx.L.inputChar <= 13))
				{
					ctx.Return = true;
					ctx.NextState = 1;
					return true;
				}
				switch (ctx.L.inputChar)
				{
				case 44:
				case 93:
				case 125:
					ctx.L.UngetChar();
					ctx.Return = true;
					ctx.NextState = 1;
					return true;
				case 46:
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					ctx.NextState = 5;
					return true;
				case 69:
				case 101:
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					ctx.NextState = 7;
					return true;
				default:
					return false;
				}
			}
			return true;
		}

		private static bool State4(FsmContext ctx)
		{
			ctx.L.GetChar();
			if (ctx.L.inputChar == 32 || (ctx.L.inputChar >= 9 && ctx.L.inputChar <= 13))
			{
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			}
			switch (ctx.L.inputChar)
			{
			case 44:
			case 93:
			case 125:
				ctx.L.UngetChar();
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			case 46:
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 5;
				return true;
			case 69:
			case 101:
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 7;
				return true;
			default:
				return false;
			}
		}

		private static bool State5(FsmContext ctx)
		{
			ctx.L.GetChar();
			if (ctx.L.inputChar >= 48 && ctx.L.inputChar <= 57)
			{
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 6;
				return true;
			}
			return false;
		}

		private static bool State6(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar >= 48 && ctx.L.inputChar <= 57)
				{
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					continue;
				}
				if (ctx.L.inputChar == 32 || (ctx.L.inputChar >= 9 && ctx.L.inputChar <= 13))
				{
					ctx.Return = true;
					ctx.NextState = 1;
					return true;
				}
				switch (ctx.L.inputChar)
				{
				case 44:
				case 93:
				case 125:
					ctx.L.UngetChar();
					ctx.Return = true;
					ctx.NextState = 1;
					return true;
				case 69:
				case 101:
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					ctx.NextState = 7;
					return true;
				default:
					return false;
				}
			}
			return true;
		}

		private static bool State7(FsmContext ctx)
		{
			ctx.L.GetChar();
			if (ctx.L.inputChar >= 48 && ctx.L.inputChar <= 57)
			{
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 8;
				return true;
			}
			int num = ctx.L.inputChar;
			if (num == 43 || num == 45)
			{
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
				ctx.NextState = 8;
				return true;
			}
			return false;
		}

		private static bool State8(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar >= 48 && ctx.L.inputChar <= 57)
				{
					ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
					continue;
				}
				if (ctx.L.inputChar == 32 || (ctx.L.inputChar >= 9 && ctx.L.inputChar <= 13))
				{
					ctx.Return = true;
					ctx.NextState = 1;
					return true;
				}
				int num = ctx.L.inputChar;
				if (num == 44 || num == 93 || num == 125)
				{
					ctx.L.UngetChar();
					ctx.Return = true;
					ctx.NextState = 1;
					return true;
				}
				return false;
			}
			return true;
		}

		private static bool State9(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 114)
			{
				ctx.NextState = 10;
				return true;
			}
			return false;
		}

		private static bool State10(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 117)
			{
				ctx.NextState = 11;
				return true;
			}
			return false;
		}

		private static bool State11(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 101)
			{
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			}
			return false;
		}

		private static bool State12(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 97)
			{
				ctx.NextState = 13;
				return true;
			}
			return false;
		}

		private static bool State13(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 108)
			{
				ctx.NextState = 14;
				return true;
			}
			return false;
		}

		private static bool State14(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 115)
			{
				ctx.NextState = 15;
				return true;
			}
			return false;
		}

		private static bool State15(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 101)
			{
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			}
			return false;
		}

		private static bool State16(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 117)
			{
				ctx.NextState = 17;
				return true;
			}
			return false;
		}

		private static bool State17(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 108)
			{
				ctx.NextState = 18;
				return true;
			}
			return false;
		}

		private static bool State18(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 108)
			{
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			}
			return false;
		}

		private static bool State19(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				switch (ctx.L.inputChar)
				{
				case 34:
					ctx.L.UngetChar();
					ctx.Return = true;
					ctx.NextState = 20;
					return true;
				case 92:
					ctx.StateStack = 19;
					ctx.NextState = 21;
					return true;
				}
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
			}
			return true;
		}

		private static bool State20(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 34)
			{
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			}
			return false;
		}

		private static bool State21(FsmContext ctx)
		{
			ctx.L.GetChar();
			switch (ctx.L.inputChar)
			{
			case 117:
				ctx.NextState = 22;
				return true;
			case 34:
			case 39:
			case 47:
			case 92:
			case 98:
			case 102:
			case 110:
			case 114:
			case 116:
				ctx.L.stringBuffer.Append(ProcessEscChar(ctx.L.inputChar));
				ctx.NextState = ctx.StateStack;
				return true;
			default:
				return false;
			}
		}

		private static bool State22(FsmContext ctx)
		{
			int num = 0;
			int num2 = 4096;
			ctx.L.unichar = 0;
			while (ctx.L.GetChar())
			{
				if ((ctx.L.inputChar >= 48 && ctx.L.inputChar <= 57) || (ctx.L.inputChar >= 65 && ctx.L.inputChar <= 70) || (ctx.L.inputChar >= 97 && ctx.L.inputChar <= 102))
				{
					ctx.L.unichar += HexValue(ctx.L.inputChar) * num2;
					num++;
					num2 /= 16;
					if (num == 4)
					{
						ctx.L.stringBuffer.Append(Convert.ToChar(ctx.L.unichar));
						ctx.NextState = ctx.StateStack;
						return true;
					}
					continue;
				}
				return false;
			}
			return true;
		}

		private static bool State23(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				switch (ctx.L.inputChar)
				{
				case 39:
					ctx.L.UngetChar();
					ctx.Return = true;
					ctx.NextState = 24;
					return true;
				case 92:
					ctx.StateStack = 23;
					ctx.NextState = 21;
					return true;
				}
				ctx.L.stringBuffer.Append((char)ctx.L.inputChar);
			}
			return true;
		}

		private static bool State24(FsmContext ctx)
		{
			ctx.L.GetChar();
			int num = ctx.L.inputChar;
			if (num == 39)
			{
				ctx.L.inputChar = 34;
				ctx.Return = true;
				ctx.NextState = 1;
				return true;
			}
			return false;
		}

		private static bool State25(FsmContext ctx)
		{
			ctx.L.GetChar();
			switch (ctx.L.inputChar)
			{
			case 42:
				ctx.NextState = 27;
				return true;
			case 47:
				ctx.NextState = 26;
				return true;
			default:
				return false;
			}
		}

		private static bool State26(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar == 10)
				{
					ctx.NextState = 1;
					return true;
				}
			}
			return true;
		}

		private static bool State27(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar == 42)
				{
					ctx.NextState = 28;
					return true;
				}
			}
			return true;
		}

		private static bool State28(FsmContext ctx)
		{
			while (ctx.L.GetChar())
			{
				if (ctx.L.inputChar == 42)
				{
					continue;
				}
				if (ctx.L.inputChar == 47)
				{
					ctx.NextState = 1;
					return true;
				}
				ctx.NextState = 27;
				return true;
			}
			return true;
		}

		private bool GetChar()
		{
			if ((inputChar = NextChar()) != -1)
			{
				return true;
			}
			EndOfInput = true;
			return false;
		}

		private int NextChar()
		{
			if (inputBuffer != 0)
			{
				int result = inputBuffer;
				inputBuffer = 0;
				return result;
			}
			return reader.Read();
		}

		public bool NextToken()
		{
			context.Return = false;
			while (true)
			{
				StateHandler stateHandler = handlerTable[state - 1];
				if (!stateHandler(context))
				{
					throw new JsonException(inputChar);
				}
				if (EndOfInput)
				{
					return false;
				}
				if (context.Return)
				{
					break;
				}
				state = context.NextState;
			}
			StringValue = stringBuffer.ToString();
			stringBuffer.Remove(0, stringBuffer.Length);
			Token = returnTable[state - 1];
			if (Token == 65542)
			{
				Token = inputChar;
			}
			state = context.NextState;
			return true;
		}

		private void UngetChar()
		{
			inputBuffer = inputChar;
		}
	}
}
