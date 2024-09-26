using UnityEngine;

public class vAnimateUV : MonoBehaviour
{
	public Vector2 speed;

	public Renderer _renderer;

	private Vector2 offSet;

	private void Update()
	{
		offSet.x += speed.x * Time.deltaTime;
		offSet.y += speed.y * Time.deltaTime;
		_renderer.material.SetTextureOffset("_MainTex", offSet);
	}
}
