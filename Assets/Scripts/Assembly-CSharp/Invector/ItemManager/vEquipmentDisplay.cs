namespace Invector.ItemManager
{
	public class vEquipmentDisplay : vItemSlot
	{
		public override void AddItem(vItem item)
		{
			if (base.item != item)
			{
				base.AddItem(item);
				if (item != null && item.amount > 1)
				{
					amountText.text = item.amount.ToString("00");
				}
				else
				{
					amountText.text = string.Empty;
				}
			}
		}
	}
}
