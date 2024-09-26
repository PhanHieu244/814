using System.Collections.Generic;

public static class MeleeHelper
{
	public static List<T> vToList<T>(this T[] array)
	{
		List<T> list = new List<T>();
		if (array == null || array.Length == 0)
		{
			return list;
		}
		for (int i = 0; i < array.Length; i++)
		{
			list.Add(array[i]);
		}
		return list;
	}

	public static T[] vToArray<T>(this List<T> list)
	{
		T[] array = new T[list.Count];
		if (list == null || list.Count == 0)
		{
			return array;
		}
		for (int i = 0; i < list.Count; i++)
		{
			array[i] = list[i];
		}
		return array;
	}
}
