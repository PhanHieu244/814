using UnityEngine;

public class TankAlwaysForward : MonoBehaviour
{
	public Material TrailMaterial;

	public float Speed;

	public float TrailSpeed;

	private void FixedUpdate()
	{
		base.transform.position = base.transform.position + base.transform.forward * Speed;
		Material trailMaterial = TrailMaterial;
		Vector2 mainTextureOffset = TrailMaterial.mainTextureOffset;
		float x = mainTextureOffset.x + TrailSpeed;
		Vector2 mainTextureOffset2 = TrailMaterial.mainTextureOffset;
		trailMaterial.mainTextureOffset = new Vector2(x, mainTextureOffset2.y);
	}
}
