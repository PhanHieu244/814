using PigeonCoopToolkit.Effects.Trails;
using System.Collections.Generic;
using UnityEngine;

public class MouseFollower : MonoBehaviour
{
	public List<TrailRenderer_Base> Trails;

	private void Start()
	{
	}

	private void Update()
	{
		if (Input.GetMouseButton(0))
		{
			Trails.ForEach(delegate(TrailRenderer_Base a)
			{
				a.Emit = true;
			});
			Transform transform = base.transform;
			Camera main = Camera.main;
			Vector3 mousePosition = Input.mousePosition;
			float x = mousePosition.x;
			Vector3 mousePosition2 = Input.mousePosition;
			transform.position = main.ScreenToWorldPoint(new Vector3(x, mousePosition2.y, Camera.main.nearClipPlane + 0.01f));
		}
		else
		{
			Trails.ForEach(delegate(TrailRenderer_Base a)
			{
				a.Emit = false;
			});
		}
	}
}
