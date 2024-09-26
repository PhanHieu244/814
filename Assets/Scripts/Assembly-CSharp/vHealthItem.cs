using Invector.CharacterController;
using UnityEngine;

public class vHealthItem : MonoBehaviour
{
	[Tooltip("How much health will be recovery")]
	public float value;

	private void OnTriggerEnter(Collider other)
	{
		if (!other.gameObject.tag.Equals("Player"))
		{
			return;
		}
		vThirdPersonController component = other.GetComponent<vThirdPersonController>();
		if (component != null)
		{
			float num = component.currentHealth + value;
			if (component.currentHealth < component.maxHealth)
			{
				component.currentHealth = Mathf.Clamp(num, 0f, component.maxHealth);
				Object.Destroy(base.gameObject);
			}
			else
			{
				vThirdPersonInput component2 = other.GetComponent<vThirdPersonInput>();
				component2.hud.ShowText("Health is Full");
			}
		}
	}
}
