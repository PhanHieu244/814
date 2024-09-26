namespace Invector.EventSystems
{
	public interface vIMeleeFighter
	{
		void OnEnableAttack();

		void OnDisableAttack();

		void ResetAttackTriggers();

		void BreakAttack(int breakAtkID);

		void OnRecoil(int recoilID);

		void OnReceiveAttack(Damage damage, vIMeleeFighter attacker);

		vCharacter Character();
	}
}
