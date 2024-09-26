namespace LitJson
{
	internal class FsmContext
	{
		public Lexer L;

		public bool Return;

		public int NextState;

		public int StateStack;
	}
}
