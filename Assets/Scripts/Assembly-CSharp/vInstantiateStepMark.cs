using UnityEngine;

public class vInstantiateStepMark : MonoBehaviour
{
	public GameObject stepMark;

	public LayerMask stepLayer;

	public float timeToDestroy = 5f;

	private void StepMark(FootStepObject footStep)
	{
		if (Physics.Raycast(base.transform.position + new Vector3(0f, 0.1f, 0f), -footStep.sender.up, out RaycastHit hitInfo, 1f, stepLayer))
		{
			Quaternion lhs = Quaternion.FromToRotation(footStep.sender.up, hitInfo.normal);
			if (stepMark != null)
			{
				GameObject obj = Object.Instantiate(stepMark, hitInfo.point, lhs * footStep.sender.rotation);
				Object.Destroy(obj, timeToDestroy);
			}
			else
			{
				Object.Destroy(base.gameObject, timeToDestroy);
			}
		}
	}
}
