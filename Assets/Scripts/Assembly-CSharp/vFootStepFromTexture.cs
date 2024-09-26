using System.Collections.Generic;
using UnityEngine;

public class vFootStepFromTexture : vFootPlantingPlayer
{
	public AnimationType animationType;

	public bool debugTextureName;

	private int surfaceIndex;

	private Terrain terrain;

	private TerrainCollider terrainCollider;

	private TerrainData terrainData;

	private Vector3 terrainPos;

	public vFootStepTrigger leftFootTrigger;

	public vFootStepTrigger rightFootTrigger;

	public Transform currentStep;

	public List<vFootStepTrigger> footStepTriggers;

	private void Start()
	{
		if (terrain == null)
		{
			terrain = Terrain.activeTerrain;
			if (terrain != null)
			{
				terrainData = terrain.terrainData;
				terrainPos = terrain.transform.position;
				terrainCollider = terrain.GetComponent<TerrainCollider>();
			}
		}
		Collider[] componentsInChildren = GetComponentsInChildren<Collider>();
		if (animationType == AnimationType.Humanoid)
		{
			if (leftFootTrigger == null && rightFootTrigger == null)
			{
				Debug.Log("Missing FootStep Sphere Trigger, please unfold the FootStep Component to create the triggers.");
				return;
			}
			leftFootTrigger.trigger.isTrigger = true;
			rightFootTrigger.trigger.isTrigger = true;
			Physics.IgnoreCollision(leftFootTrigger.trigger, rightFootTrigger.trigger);
			foreach (Collider collider in componentsInChildren)
			{
				if (collider.enabled && collider.gameObject != leftFootTrigger.gameObject)
				{
					Physics.IgnoreCollision(leftFootTrigger.trigger, collider);
				}
				if (collider.enabled && collider.gameObject != rightFootTrigger.gameObject)
				{
					Physics.IgnoreCollision(rightFootTrigger.trigger, collider);
				}
			}
			return;
		}
		for (int j = 0; j < componentsInChildren.Length; j++)
		{
			Collider collider2 = componentsInChildren[j];
			for (int k = 0; k < footStepTriggers.Count; k++)
			{
				vFootStepTrigger vFootStepTrigger = footStepTriggers[j];
				vFootStepTrigger.trigger.isTrigger = true;
				if (collider2.enabled && collider2.gameObject != vFootStepTrigger.gameObject)
				{
					Physics.IgnoreCollision(vFootStepTrigger.trigger, collider2);
				}
			}
		}
	}

	private float[] GetTextureMix(Vector3 WorldPos)
	{
		float num = WorldPos.x - terrainPos.x;
		Vector3 size = terrainData.size;
		int x = (int)(num / size.x * (float)terrainData.alphamapWidth);
		float num2 = WorldPos.z - terrainPos.z;
		Vector3 size2 = terrainData.size;
		int y = (int)(num2 / size2.z * (float)terrainData.alphamapHeight);
		if (!terrainCollider.bounds.Contains(WorldPos))
		{
			return new float[0];
		}
		float[,,] alphamaps = terrainData.GetAlphamaps(x, y, 1, 1);
		float[] array = new float[alphamaps.GetUpperBound(2) + 1];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = alphamaps[0, 0, i];
		}
		return array;
	}

	private int GetMainTexture(Vector3 WorldPos)
	{
		float[] textureMix = GetTextureMix(WorldPos);
		float num = 0f;
		int result = 0;
		for (int i = 0; i < textureMix.Length; i++)
		{
			if (textureMix[i] > num)
			{
				result = i;
				num = textureMix[i];
			}
		}
		return result;
	}

	public void StepOnTerrain(FootStepObject footStepObject)
	{
		if (!(currentStep != null) || !(currentStep == footStepObject.sender))
		{
			currentStep = footStepObject.sender;
			if ((bool)terrainData)
			{
				surfaceIndex = GetMainTexture(footStepObject.sender.position);
			}
			string message = footStepObject.name = ((!(terrainData != null) || terrainData.splatPrototypes.Length <= 0) ? string.Empty : terrainData.splatPrototypes[surfaceIndex].texture.name);
			PlayFootFallSound(footStepObject);
			if (debugTextureName)
			{
				Debug.Log(message);
			}
		}
	}

	public void StepOnMesh(FootStepObject footStepObject)
	{
		if (!(currentStep != null) || !(currentStep == footStepObject.sender))
		{
			currentStep = footStepObject.sender;
			PlayFootFallSound(footStepObject);
			if (debugTextureName)
			{
				Debug.Log(footStepObject.name);
			}
		}
	}
}
