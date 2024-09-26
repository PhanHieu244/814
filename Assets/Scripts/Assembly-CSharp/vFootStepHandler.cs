using UnityEngine;

public class vFootStepHandler : MonoBehaviour
{
	public enum StepHandleType
	{
		materialName,
		textureName
	}

	[Tooltip("Use this to select a specific material or texture if your mesh has multiple materials, the footstep will play only the selected index.")]
	[SerializeField]
	private int materialIndex;

	public StepHandleType stepHandleType;

	public int material_ID => materialIndex;
}
