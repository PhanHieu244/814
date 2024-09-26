using UnityEngine;

public class DebuffOnEnemyFromCollision : MonoBehaviour
{
	public EffectSettings EffectSettings;

	public GameObject Effect;

	private void Start()
	{
		EffectSettings.CollisionEnter += EffectSettings_CollisionEnter;
	}

	private void EffectSettings_CollisionEnter(object sender, CollisionInfo e)
	{
		if (!(Effect == null))
		{
			Collider[] array = Physics.OverlapSphere(base.transform.position, EffectSettings.EffectRadius, EffectSettings.LayerMask);
			Collider[] array2 = array;
			foreach (Collider collider in array2)
			{
				Transform transform = collider.transform;
				Renderer componentInChildren = transform.GetComponentInChildren<Renderer>();
				GameObject gameObject = Object.Instantiate(Effect);
				gameObject.transform.parent = componentInChildren.transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.GetComponent<AddMaterialOnHit>().UpdateMaterial(collider.transform);
			}
		}
	}

	private void Update()
	{
	}
}
