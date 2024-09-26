using Invector.CharacterController;
using UnityEngine;
using UnityEngine.Events;

[RequireComponent(typeof(SphereCollider))]
public class vCollectableStandalone : vTriggerAction
{
	public string targetEquipPoint;

	public GameObject weapon;

	public Sprite weaponIcon;

	public string weaponText;

	public UnityEvent OnEquip;

	public UnityEvent OnDrop;

	private vCollectMeleeControl manager;

	protected override void Start()
	{
		base.Start();
		base.gameObject.tag = "Action";
		base.gameObject.layer = LayerMask.NameToLayer("Action");
		GetComponent<Collider>().isTrigger = true;
	}

	public override void DoAction(vThirdPersonController cc)
	{
		manager = cc.GetComponent<vCollectMeleeControl>();
		if (manager != null)
		{
			manager.HandleCollectableInput(this);
		}
	}
}
