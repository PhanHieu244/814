using UnityEngine;
using UnityEngine.AI;

public class Patrolligpoints : MonoBehaviour
{
	public GameObject civilian;

	public Animator civil_animator;

	public GameObject[] waypoints;

	public int number;

	public float speed = 1f;

	public bool Stop;

	public bool sequenced;

	public int StoppingDistance;

	private void Start()
	{
		civilian = base.gameObject;
		civil_animator = civilian.GetComponent<Animator>();
		if (sequenced)
		{
			if (waypoints.Length != 0)
			{
				GetComponent<NavMeshAgent>().SetDestination(waypoints[number].transform.position);
				GetComponent<NavMeshAgent>().speed = speed;
			}
		}
		else
		{
			number = Random.Range(0, waypoints.Length);
			GetComponent<NavMeshAgent>().SetDestination(waypoints[number].transform.position);
			GetComponent<NavMeshAgent>().speed = speed;
		}
	}

	private void Update()
	{
		if (!Stop)
		{
			if (sequenced)
			{
				if (Vector3.Distance(base.gameObject.transform.position, waypoints[number].transform.position) < (float)StoppingDistance && waypoints.Length != 0)
				{
					if (number + 1 == waypoints.Length)
					{
						GetComponent<NavMeshAgent>().Stop();
						civil_animator.Play("Idle");
						Object.Destroy(civilian, 0.1f);
						number = -1;
					}
					number++;
					if (civilian != null && number < waypoints.Length)
					{
						GetComponent<NavMeshAgent>().SetDestination(waypoints[number].transform.position);
						GetComponent<NavMeshAgent>().speed = speed;
					}
				}
			}
			else if (Vector3.Distance(base.gameObject.transform.position, waypoints[number].transform.position) < (float)StoppingDistance && waypoints.Length != 0)
			{
				number = Random.Range(0, waypoints.Length);
				GetComponent<NavMeshAgent>().SetDestination(waypoints[number].transform.position);
				GetComponent<NavMeshAgent>().speed = speed;
			}
		}
		else
		{
			GetComponent<NavMeshAgent>().Stop();
		}
	}

	private void OnCollisionEnter(Collision col)
	{
		if (col.gameObject.tag == "E_Plane")
		{
			GetComponent<NavMeshAgent>().Stop();
			civil_animator.Play("KB_HighKO_Air");
			Object.Destroy(civilian, 2.5f);
		}
	}
}
