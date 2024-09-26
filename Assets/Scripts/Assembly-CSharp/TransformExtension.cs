using System;
using System.Collections;
using UnityEngine;

public static class TransformExtension
{
	public static Transform FindChildByRecursive(this Transform aParent, string aName)
	{
		Transform transform = aParent.Find(aName);
		if (transform != null)
		{
			return transform;
		}
		IEnumerator enumerator = aParent.GetEnumerator();
		try
		{
			while (enumerator.MoveNext())
			{
				Transform aParent2 = (Transform)enumerator.Current;
				transform = aParent2.FindChildByRecursive(aName);
				if (transform != null)
				{
					return transform;
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
		return null;
	}
}
