using UnityEngine;

public class vFisherYatesRandom
{
	private int[] randomIndices;

	private int randomIndex;

	private int prevValue = -1;

	public int Next(int len)
	{
		if (len <= 1)
		{
			return 0;
		}
		if (randomIndices == null || randomIndices.Length != len)
		{
			randomIndices = new int[len];
			for (int i = 0; i < randomIndices.Length; i++)
			{
				randomIndices[i] = i;
			}
		}
		if (randomIndex == 0)
		{
			int num = 0;
			do
			{
				for (int j = 0; j < len - 1; j++)
				{
					int num2 = Random.Range(j, len);
					if (num2 != j)
					{
						int num3 = randomIndices[j];
						randomIndices[j] = randomIndices[num2];
						randomIndices[num2] = num3;
					}
				}
			}
			while (prevValue == randomIndices[0] && ++num < 10);
		}
		int result = randomIndices[randomIndex];
		if (++randomIndex >= randomIndices.Length)
		{
			randomIndex = 0;
		}
		prevValue = result;
		return result;
	}
}
