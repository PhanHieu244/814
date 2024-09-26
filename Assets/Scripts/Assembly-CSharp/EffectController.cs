using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EffectController : MonoBehaviour
{
	public int m_nNumOfEffects;

	public bool m_bLockNums;

	public List<EffectData> m_kEffectGenList = new List<EffectData>();

	private int m_nNowIndex;

	private void Awake()
	{
		for (int i = 0; i < m_kEffectGenList.Count; i++)
		{
			Invoke("GenEffect", m_kEffectGenList[i].m_fTimeSec);
		}
		Comp comparer = new Comp();
		m_kEffectGenList.Sort(comparer);
	}

	private void Update()
	{
		CheckTransfromUpdate();
	}

	private void GenEffect()
	{
		EffectData effectData = m_kEffectGenList[m_nNowIndex];
		if (effectData != null)
		{
			if (effectData.m_goEffect != null)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(effectData.m_goEffect);
				gameObject.transform.parent = base.transform;
				gameObject.name = m_nNowIndex.ToString();
				UpdateEffectTransformByIndex(m_nNowIndex);
				UPdateRenderLayerByIndex(m_nNowIndex);
			}
			m_nNowIndex++;
		}
	}

	private void CheckTransfromUpdate()
	{
		IEnumerator enumerator = base.transform.GetEnumerator();
		try
		{
			while (enumerator.MoveNext())
			{
				Transform transform = (Transform)enumerator.Current;
				int index = int.Parse(transform.name);
				EffectData effectData = m_kEffectGenList[index];
				if (effectData == null)
				{
					break;
				}
				if (transform.position != effectData.m_goPos)
				{
					effectData.m_goPos = transform.position;
				}
				if (transform.localRotation.eulerAngles != effectData.m_goRotation)
				{
					effectData.m_goRotation = transform.localRotation.eulerAngles;
				}
				if (transform.localScale != effectData.m_goScale)
				{
					effectData.m_goScale = transform.localScale;
				}
			}
		}
		finally
		{
			IDisposable disposable;
			if ((disposable = (enumerator as IDisposable)) != null)
			{
				disposable.Dispose();
			}
		}
	}

	public void UpdateEffectTransformByIndex(int nIndex)
	{
		Transform transform = base.transform.Find(nIndex.ToString());
		if (!(transform == null))
		{
			EffectData effectData = m_kEffectGenList[nIndex];
			if (effectData != null)
			{
				transform.position = effectData.m_goPos;
				Quaternion localRotation = default(Quaternion);
				localRotation.eulerAngles = effectData.m_goRotation;
				transform.localRotation = localRotation;
				transform.localScale = effectData.m_goScale;
			}
		}
	}

	public ParticleSystem CheckHasParticleSystem(int nIndex)
	{
		Transform transform = base.transform.Find(nIndex.ToString());
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject.GetComponent<ParticleSystem>();
	}

	public RenderEffect CheckHasRenderEffectScript(int nIndex)
	{
		Transform transform = base.transform.Find(nIndex.ToString());
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject.GetComponent<RenderEffect>();
	}

	public void UPdateRenderLayerByIndex(int nIndex)
	{
		Transform transform = base.transform.Find(nIndex.ToString());
		if (!(transform == null))
		{
			EffectData effectData = m_kEffectGenList[nIndex];
			if (effectData != null)
			{
				Renderer component = transform.gameObject.GetComponent<Renderer>();
				component.sortingLayerID = effectData.m_SortingLayerID;
				component.sortingOrder = effectData.m_SortingOrder;
			}
		}
	}
}
