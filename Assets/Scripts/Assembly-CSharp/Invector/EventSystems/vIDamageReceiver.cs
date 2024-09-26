namespace Invector.EventSystems
{
	public interface vIDamageReceiver
	{
		void TakeDamage(Damage damage, bool hitReaction = true);
	}
}
