using System.Collections;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

namespace Invector
{
	public class v_AICompanion : v_AIController
	{
		public enum CompanionState
		{
			None,
			Follow,
			MoveTo,
			Stay
		}

		[Header("--- Companion ---")]
		public string companionTag = "Player";

		public float companionMaxDistance = 10f;

		[Range(0f, 1.5f)]
		public float followSpeed = 1f;

		public float followStopDistance = 2f;

		[Range(0f, 1.5f)]
		public float moveToSpeed = 1f;

		public float moveToStopDistance = 0.5f;

		public Transform moveToTarget;

		public CompanionState companionState = CompanionState.Follow;

		public Transform companion;

		public bool debug = true;

		public Text debugUIText;

		private float companionDistance => (!(companion != null)) ? 0f : Vector3.Distance(base.transform.position, companion.transform.position);

		private bool nearOfCompanion => (companion != null && companion.gameObject.activeSelf && companionDistance < companionMaxDistance) || companion == null || !companion.gameObject.activeSelf;

		protected override float maxSpeed
		{
			get
			{
				if (companionState != 0)
				{
					return (companionState == CompanionState.Follow) ? followSpeed : ((companionState != CompanionState.MoveTo) ? 0f : moveToSpeed);
				}
				return base.maxSpeed;
			}
		}

		protected virtual void LateUpdate()
		{
			CompanionInputs();
		}

		private void CompanionInputs()
		{
			if (Input.GetKeyDown(KeyCode.Alpha1))
			{
				companionState = CompanionState.Stay;
				agressiveAtFirstSight = false;
			}
			if (Input.GetKeyDown(KeyCode.Alpha2))
			{
				companionState = CompanionState.Follow;
				agressiveAtFirstSight = false;
			}
			if (Input.GetKeyDown(KeyCode.Alpha3))
			{
				agressiveAtFirstSight = !agressiveAtFirstSight;
			}
			if (Input.GetKeyDown(KeyCode.Alpha4) && moveToTarget != null)
			{
				SetMoveTo(moveToTarget);
				companionState = CompanionState.MoveTo;
				agressiveAtFirstSight = false;
			}
		}

		public void SetMoveTo(Transform _target)
		{
			companionState = CompanionState.MoveTo;
			moveToTarget = _target;
		}

		protected override void Start()
		{
			try
			{
				GameObject gameObject = GameObject.FindGameObjectWithTag(companionTag);
				if (gameObject != null)
				{
					companion = gameObject.transform;
				}
				else
				{
					companionState = CompanionState.None;
					Debug.LogWarning("Cant find the " + companionTag);
				}
			}
			catch (UnityException ex)
			{
				companionState = CompanionState.None;
				Debug.LogWarning("AICompanion Cant find the " + companionTag);
				Debug.LogWarning("AICompanion " + ex.Message);
			}
			Init();
			agent.enabled = true;
			StartCoroutine(CompanionStateRoutine());
			StartCoroutine(FindTarget());
			StartCoroutine(DestinationBehaviour());
		}

		protected IEnumerator CompanionStateRoutine()
		{
			while (base.enabled)
			{
				yield return new WaitForEndOfFrame();
				StringBuilder debugString = new StringBuilder();
				debugString.AppendLine("----DEBUG----");
				debugString.AppendLine("Agressive : " + agressiveAtFirstSight);
				CheckIsOnNavMesh();
				CheckAutoCrouch();
				SetTarget();
				switch (companionState)
				{
				case CompanionState.Follow:
					if (canSeeTarget && nearOfCompanion)
					{
						yield return StartCoroutine(Chase());
					}
					else
					{
						yield return StartCoroutine(FollowCompanion());
					}
					debugString.AppendLine((!canSeeTarget || !nearOfCompanion) ? "Follow" : "Chase/Follow");
					break;
				case CompanionState.MoveTo:
					if (canSeeTarget)
					{
						yield return StartCoroutine(Chase());
					}
					else
					{
						yield return StartCoroutine(MoveTo());
					}
					debugString.AppendLine((!canSeeTarget) ? "MoveTo" : "Chase/MoveTo");
					break;
				case CompanionState.Stay:
					if (canSeeTarget)
					{
						yield return StartCoroutine(Chase());
					}
					else
					{
						yield return StartCoroutine(Stay());
					}
					debugString.AppendLine((!canSeeTarget) ? "Stay" : "Chase/Stay");
					break;
				case CompanionState.None:
					debugString.AppendLine("None : using normal AI routine");
					switch (currentState)
					{
					case AIStates.Idle:
						debugString.AppendLine("idle");
						yield return StartCoroutine(Idle());
						break;
					case AIStates.Chase:
						yield return StartCoroutine(Chase());
						break;
					case AIStates.PatrolSubPoints:
						yield return StartCoroutine(PatrolSubPoints());
						break;
					case AIStates.PatrolWaypoints:
						yield return StartCoroutine(PatrolWaypoints());
						break;
					}
					break;
				}
				if (debugUIText != null && debug)
				{
					debugUIText.text = debugString.ToString();
				}
			}
		}

		protected IEnumerator Stay()
		{
			if (companion != null)
			{
				agent.speed = Mathf.Lerp(agent.speed, 0f, 2f * Time.deltaTime);
			}
			else
			{
				yield return StartCoroutine(Idle());
			}
		}

		protected override void SetAgressive(bool value)
		{
			if (companionState != CompanionState.Follow)
			{
				base.SetAgressive(value);
			}
		}

		private IEnumerator FollowCompanion()
		{
			while (!agent.enabled || currentHealth <= 0f)
			{
				yield return null;
			}
			if (companion != null && companion.gameObject.activeSelf)
			{
				agent.speed = Mathf.Lerp(agent.speed, followSpeed, 10f * Time.deltaTime);
				agent.stoppingDistance = followStopDistance;
				UpdateDestination(companion.position);
			}
			else
			{
				agent.speed = Mathf.Lerp(agent.speed, moveToSpeed, 10f * Time.deltaTime);
				agent.stoppingDistance = moveToStopDistance;
				UpdateDestination(startPosition);
			}
		}

		private IEnumerator MoveTo()
		{
			while (!agent.enabled || currentHealth <= 0f)
			{
				yield return null;
			}
			agent.speed = Mathf.Lerp(agent.speed, moveToSpeed, 2f * Time.deltaTime);
			agent.stoppingDistance = moveToStopDistance;
			UpdateDestination(moveToTarget.position);
			if (canSeeTarget && nearOfCompanion)
			{
				currentState = AIStates.Chase;
			}
		}
	}
}
