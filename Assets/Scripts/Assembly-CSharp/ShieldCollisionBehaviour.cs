using UnityEngine;

public class ShieldCollisionBehaviour : MonoBehaviour
{
	public GameObject EffectOnHit;

	public GameObject ExplosionOnHit;

	public bool IsWaterInstance;

	public float ScaleWave = 0.89f;

	public bool CreateMechInstanceOnHit;

	public Vector3 AngleFix;

	public int currentQueue = 3001;

	public void ShieldCollisionEnter(CollisionInfo e)
	{
		if (!(e.Hit.transform != null))
		{
			return;
		}
		if (IsWaterInstance)
		{
			GameObject gameObject = Object.Instantiate(ExplosionOnHit);
			Transform transform = gameObject.transform;
			transform.parent = base.transform;
			Vector3 localScale = base.transform.localScale;
			float num = localScale.x * ScaleWave;
			transform.localScale = new Vector3(num, num, num);
			transform.localPosition = new Vector3(0f, 0.001f, 0f);
			transform.LookAt(e.Hit.point);
			return;
		}
		if (EffectOnHit != null)
		{
			if (!CreateMechInstanceOnHit)
			{
				Transform transform2 = e.Hit.transform;
				Renderer componentInChildren = transform2.GetComponentInChildren<Renderer>();
				GameObject gameObject2 = Object.Instantiate(EffectOnHit);
				gameObject2.transform.parent = componentInChildren.transform;
				gameObject2.transform.localPosition = Vector3.zero;
				AddMaterialOnHit component = gameObject2.GetComponent<AddMaterialOnHit>();
				component.SetMaterialQueue(currentQueue);
				component.UpdateMaterial(e.Hit);
			}
			else
			{
				GameObject gameObject3 = Object.Instantiate(EffectOnHit);
				Transform transform3 = gameObject3.transform;
				transform3.parent = GetComponent<Renderer>().transform;
				transform3.localPosition = Vector3.zero;
				transform3.localScale = base.transform.localScale * ScaleWave;
				transform3.LookAt(e.Hit.point);
				transform3.Rotate(AngleFix);
				gameObject3.GetComponent<Renderer>().material.renderQueue = currentQueue - 1000;
			}
		}
		if (currentQueue > 4000)
		{
			currentQueue = 3001;
		}
		else
		{
			currentQueue++;
		}
		if (ExplosionOnHit != null)
		{
			GameObject gameObject4 = Object.Instantiate(ExplosionOnHit, e.Hit.point, default(Quaternion));
			gameObject4.transform.parent = base.transform;
		}
	}

	private void Update()
	{
	}
}
