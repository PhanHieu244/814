using System;
using UnityEngine;
using UnityEngine.UI;

public class vGridLayoutExpand : MonoBehaviour
{
	private GridLayoutGroup grid;

	public int count;

	private RectTransform rect;

	private float multiple;

	private float oldMultiple;

	private void Start()
	{
		grid = GetComponent<GridLayoutGroup>();
		rect = GetComponent<RectTransform>();
	}

	private void OnDrawGizmos()
	{
		if (!Application.isPlaying)
		{
			grid = GetComponent<GridLayoutGroup>();
			rect = GetComponent<RectTransform>();
			UpdateBottomSize();
		}
	}

	private void UpdateBottomSize()
	{
		double value = (double)rect.childCount / (double)count;
		multiple = (float)Math.Round(value, MidpointRounding.AwayFromZero) + 1f;
		if (multiple != oldMultiple)
		{
			Vector2 offsetMin = rect.offsetMin;
			Vector2 cellSize = grid.cellSize;
			float y = cellSize.y;
			Vector2 spacing = grid.spacing;
			float num = offsetMin.y = (y + spacing.y) * (0f - multiple);
			rect.offsetMin = offsetMin;
			oldMultiple = multiple;
		}
	}

	private void Update()
	{
		UpdateBottomSize();
	}
}
