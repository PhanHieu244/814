using UnityEngine;

namespace Invector
{
	public class Increase_Health : MonoBehaviour
	{
		public static bool increasehealth;

		private void Start()
		{
		}

		private void Update()
		{
		}

		private void OnTriggerEnter(Collider other)
		{
			if (other.gameObject.CompareTag("Player"))
			{
				increasehealth = true;
				Object.Destroy(base.gameObject);
			}
		}
	}
}
