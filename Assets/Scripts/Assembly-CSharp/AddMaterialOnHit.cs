using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class AddMaterialOnHit : MonoBehaviour
{
	public float RemoveAfterTime = 5f;

	public bool RemoveWhenDisable;

	public EffectSettings EffectSettings;

	public Material Material;

	public bool UsePointMatrixTransform;

	public Vector3 TransformScale = Vector3.one;

	private FadeInOutShaderColor[] fadeInOutShaderColor;

	private FadeInOutShaderFloat[] fadeInOutShaderFloat;

	private UVTextureAnimator uvTextureAnimator;

	private Renderer renderParent;

	private Material instanceMat;

	private int materialQueue = -1;

	private bool waitRemove;

	private float timeToDelete;

	private void Update()
	{
		if (EffectSettings == null)
		{
			return;
		}
		if (EffectSettings.IsVisible)
		{
			timeToDelete = 0f;
			return;
		}
		timeToDelete += Time.deltaTime;
		if (timeToDelete > RemoveAfterTime)
		{
			Object.Destroy(base.gameObject);
		}
	}

	public void UpdateMaterial(RaycastHit hit)
	{
		Transform transform = hit.transform;
		if (!(transform != null))
		{
			return;
		}
		if (!RemoveWhenDisable)
		{
			Object.Destroy(base.gameObject, RemoveAfterTime);
		}
		this.fadeInOutShaderColor = GetComponents<FadeInOutShaderColor>();
		this.fadeInOutShaderFloat = GetComponents<FadeInOutShaderFloat>();
		uvTextureAnimator = GetComponent<UVTextureAnimator>();
		renderParent = base.transform.parent.GetComponent<Renderer>();
		Material[] sharedMaterials = renderParent.sharedMaterials;
		int num = sharedMaterials.Length + 1;
		Material[] array = new Material[num];
		sharedMaterials.CopyTo(array, 0);
		renderParent.material = Material;
		instanceMat = renderParent.material;
		array[num - 1] = instanceMat;
		renderParent.sharedMaterials = array;
		if (UsePointMatrixTransform)
		{
			Matrix4x4 value = Matrix4x4.TRS(hit.transform.InverseTransformPoint(hit.point), Quaternion.Euler(180f, 180f, 0f), TransformScale);
			instanceMat.SetMatrix("_DecalMatr", value);
		}
		if (materialQueue != -1)
		{
			instanceMat.renderQueue = materialQueue;
		}
		if (this.fadeInOutShaderColor != null)
		{
			FadeInOutShaderColor[] array2 = this.fadeInOutShaderColor;
			foreach (FadeInOutShaderColor fadeInOutShaderColor in array2)
			{
				fadeInOutShaderColor.UpdateMaterial(instanceMat);
			}
		}
		if (this.fadeInOutShaderFloat != null)
		{
			FadeInOutShaderFloat[] array3 = this.fadeInOutShaderFloat;
			foreach (FadeInOutShaderFloat fadeInOutShaderFloat in array3)
			{
				fadeInOutShaderFloat.UpdateMaterial(instanceMat);
			}
		}
		if (uvTextureAnimator != null)
		{
			uvTextureAnimator.SetInstanceMaterial(instanceMat, hit.textureCoord);
		}
	}

	public void UpdateMaterial(Transform transformTarget)
	{
		if (!(transformTarget != null))
		{
			return;
		}
		if (!RemoveWhenDisable)
		{
			Object.Destroy(base.gameObject, RemoveAfterTime);
		}
		this.fadeInOutShaderColor = GetComponents<FadeInOutShaderColor>();
		this.fadeInOutShaderFloat = GetComponents<FadeInOutShaderFloat>();
		uvTextureAnimator = GetComponent<UVTextureAnimator>();
		renderParent = base.transform.parent.GetComponent<Renderer>();
		Material[] sharedMaterials = renderParent.sharedMaterials;
		int num = sharedMaterials.Length + 1;
		Material[] array = new Material[num];
		sharedMaterials.CopyTo(array, 0);
		renderParent.material = Material;
		instanceMat = renderParent.material;
		array[num - 1] = instanceMat;
		renderParent.sharedMaterials = array;
		if (materialQueue != -1)
		{
			instanceMat.renderQueue = materialQueue;
		}
		if (this.fadeInOutShaderColor != null)
		{
			FadeInOutShaderColor[] array2 = this.fadeInOutShaderColor;
			foreach (FadeInOutShaderColor fadeInOutShaderColor in array2)
			{
				fadeInOutShaderColor.UpdateMaterial(instanceMat);
			}
		}
		if (this.fadeInOutShaderFloat != null)
		{
			FadeInOutShaderFloat[] array3 = this.fadeInOutShaderFloat;
			foreach (FadeInOutShaderFloat fadeInOutShaderFloat in array3)
			{
				fadeInOutShaderFloat.UpdateMaterial(instanceMat);
			}
		}
		if (uvTextureAnimator != null)
		{
			uvTextureAnimator.SetInstanceMaterial(instanceMat, Vector2.zero);
		}
	}

	public void SetMaterialQueue(int matlQueue)
	{
		materialQueue = matlQueue;
	}

	public int GetDefaultMaterialQueue()
	{
		return instanceMat.renderQueue;
	}

	private void OnDestroy()
	{
		if (!(renderParent == null))
		{
			List<Material> list = renderParent.sharedMaterials.ToList();
			list.Remove(instanceMat);
			renderParent.sharedMaterials = list.ToArray();
		}
	}
}
