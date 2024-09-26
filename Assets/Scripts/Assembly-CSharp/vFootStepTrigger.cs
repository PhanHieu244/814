using UnityEngine;

public class vFootStepTrigger : MonoBehaviour
{
	protected Collider _trigger;

	protected vFootStepFromTexture _fT;

	public Collider trigger
	{
		get
		{
			if (_trigger == null)
			{
				_trigger = GetComponent<Collider>();
			}
			return _trigger;
		}
	}

	private void Start()
	{
		_fT = GetComponentInParent<vFootStepFromTexture>();
		if (_fT == null)
		{
			Debug.Log(base.gameObject.name + " can't find the FootStepFromTexture");
			base.gameObject.SetActive(value: false);
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (_fT == null)
		{
			return;
		}
		if (other.GetComponent<Terrain>() != null)
		{
			_fT.StepOnTerrain(new FootStepObject(base.transform, other.transform, string.Empty));
			return;
		}
		vFootStepHandler component = other.GetComponent<vFootStepHandler>();
		Renderer component2 = other.GetComponent<Renderer>();
		if (!(component2 != null) || !(component2.material != null))
		{
			return;
		}
		int num = 0;
		string name = string.Empty;
		if (component != null && component.material_ID > 0)
		{
			num = component.material_ID;
		}
		if ((bool)component)
		{
			switch (component.stepHandleType)
			{
			case vFootStepHandler.StepHandleType.materialName:
				name = component2.materials[num].name;
				break;
			case vFootStepHandler.StepHandleType.textureName:
				name = component2.materials[num].mainTexture.name;
				break;
			}
		}
		else
		{
			name = component2.materials[num].name;
		}
		_fT.StepOnMesh(new FootStepObject(base.transform, other.transform, name));
	}
}
