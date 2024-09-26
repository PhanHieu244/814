using Invector.CharacterController;
using System;

namespace Invector.ItemManager
{
	[Serializable]
	public class ChangeEquipmentControl
	{
		public GenericInput useItemInput = new GenericInput("U", "Start", "Start");

		public GenericInput previousItemInput = new GenericInput("LeftArrow", "D - Pad Horizontal", "D-Pad Horizontal");

		public GenericInput nextItemInput = new GenericInput("RightArrow", "D - Pad Horizontal", "D-Pad Horizontal");

		public vEquipArea equipArea;

		public vEquipmentDisplay display;
	}
}
