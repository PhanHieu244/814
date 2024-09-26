using Invector.EventSystems;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace Invector
{
	public class v_AIController : v_AIAnimator, vIMeleeFighter
	{
		[Header("--- Iterations ---")]
		public float stateRoutineIteration = 0.15f;

		public float destinationRoutineIteration = 0.25f;

		public float findTargetIteration = 0.25f;

		public float smoothSpeed = 5f;

		[Header("--- On Change State Events ---")]
		public UnityEvent onIdle;

		[Header("--- On Change State Events ---")]
		public UnityEvent onChase;

		[Header("--- On Change State Events ---")]
		public UnityEvent onPatrol;

		protected AIStates oldState;

		protected virtual void Start()
		{
			Init();
			StartCoroutine(StateRoutine());
			StartCoroutine(FindTarget());
			StartCoroutine(DestinationBehaviour());
		}

		protected virtual void FixedUpdate()
		{
			ControlLocomotion();
			HealthRecovery();
		}

		protected void SetTarget()
		{
			if (currentHealth > 0f && sphereSensor != null)
			{
				if (target == null || sphereSensor.getFromDistance)
				{
					vCharacter targetvCharacter = sphereSensor.GetTargetvCharacter();
					if (targetvCharacter != null && targetvCharacter.currentHealth > 0f)
					{
						target = targetvCharacter.GetTransform;
					}
				}
				if (!CheckTargetIsAlive() || base.TargetDistance > distanceToLostTarget)
				{
					target = null;
				}
			}
			else if (currentHealth <= 0f)
			{
				destination = base.transform.position;
				target = null;
			}
		}

		private bool CheckTargetIsAlive()
		{
			if (target == null)
			{
				return false;
			}
			vCharacter component = target.GetComponent<vCharacter>();
			if (component == null)
			{
				return false;
			}
			if (component.currentHealth > 0f)
			{
				return true;
			}
			return false;
		}

		protected IEnumerator FindTarget()
		{
			while (true)
			{
				yield return new WaitForSeconds(findTargetIteration);
				SetTarget();
				CheckTarget();
			}
		}

		private void ControlLocomotion()
		{
			if ((AgentDone() && agent.updatePosition) || lockMovement)
			{
				agent.speed = 0f;
				combatMovement = Vector3.zero;
			}
			if (agent.isOnOffMeshLink)
			{
				float magnitude = agent.desiredVelocity.magnitude;
				UpdateAnimator((!AgentDone()) ? magnitude : 0f, base.direction);
				return;
			}
			Vector3 direction = (!agent.enabled) ? (destination - base.transform.position) : ((!agent.updatePosition) ? (agent.nextPosition - base.transform.position) : agent.desiredVelocity);
			if (base.OnStrafeArea)
			{
				Vector3 normalized = base.transform.InverseTransformDirection(direction).normalized;
				combatMovement = Vector3.Lerp(combatMovement, normalized, 2f * Time.deltaTime);
				UpdateAnimator((!AgentDone()) ? combatMovement.z : 0f, combatMovement.x);
			}
			else
			{
				float magnitude2 = direction.magnitude;
				combatMovement = Vector3.zero;
				UpdateAnimator((!AgentDone()) ? magnitude2 : 0f, 0f);
			}
		}

		private Vector3 AgentDirection()
		{
			Vector3 vector;
			if (AgentDone())
			{
				if (target != null && base.OnStrafeArea && canSeeTarget)
				{
					float x = destination.x;
					Vector3 position = base.transform.position;
					vector = new Vector3(x, position.y, destination.z) - base.transform.position;
				}
				else
				{
					vector = base.transform.forward;
				}
			}
			else
			{
				vector = agent.desiredVelocity;
			}
			Vector3 b = vector;
			fwd = Vector3.Lerp(fwd, b, 20f * Time.deltaTime);
			return fwd;
		}

		protected virtual IEnumerator DestinationBehaviour()
		{
			while (true)
			{
				yield return new WaitForSeconds(destinationRoutineIteration);
				CheckGroundDistance();
				if (agent.updatePosition)
				{
					UpdateDestination(destination);
				}
			}
		}

		protected virtual void UpdateDestination(Vector3 position)
		{
			if (agent.isOnNavMesh)
			{
				agent.SetDestination(position);
			}
			if (agent.enabled && agent.hasPath && drawAgentPath)
			{
				Debug.DrawLine(base.transform.position, position, Color.red, 0.5f);
				Vector3 start = base.transform.position;
				for (int i = 0; i < agent.path.corners.Length; i++)
				{
					Vector3 vector = agent.path.corners[i];
					Debug.DrawLine(start, vector, Color.green, 0.5f);
					start = vector;
				}
			}
		}

		protected void CheckIsOnNavMesh()
		{
			if (!agent.isOnNavMesh && agent.enabled && !base.ragdolled)
			{
				Debug.LogWarning("Missing NavMesh Bake, character will die - Please Bake your navmesh again!");
				currentHealth = 0f;
			}
		}

		protected IEnumerator StateRoutine()
		{
			while (base.enabled)
			{
				CheckIsOnNavMesh();
				CheckAutoCrouch();
				yield return new WaitForSeconds(stateRoutineIteration);
				if (lockMovement)
				{
					continue;
				}
				switch (currentState)
				{
				case AIStates.Idle:
					if (currentState != oldState)
					{
						onIdle.Invoke();
						oldState = currentState;
					}
					yield return StartCoroutine(Idle());
					break;
				case AIStates.Chase:
					if (currentState != oldState)
					{
						onChase.Invoke();
						oldState = currentState;
					}
					yield return StartCoroutine(Chase());
					break;
				case AIStates.PatrolSubPoints:
					if (currentState != oldState)
					{
						onPatrol.Invoke();
						oldState = currentState;
					}
					yield return StartCoroutine(PatrolSubPoints());
					break;
				case AIStates.PatrolWaypoints:
					if (currentState != oldState)
					{
						onPatrol.Invoke();
						oldState = currentState;
					}
					yield return StartCoroutine(PatrolWaypoints());
					break;
				}
			}
		}

		protected IEnumerator Idle()
		{
			while (currentHealth <= 0f)
			{
				yield return null;
			}
			if (canSeeTarget)
			{
				currentState = AIStates.Chase;
			}
			if (agent.enabled && Vector3.Distance(base.transform.position, startPosition) > agent.stoppingDistance && (!pathArea || pathArea.waypoints.Count <= 0))
			{
				currentState = AIStates.PatrolWaypoints;
			}
			else if ((bool)pathArea && pathArea.waypoints.Count > 0)
			{
				currentState = AIStates.PatrolWaypoints;
			}
			else
			{
				agent.speed = Mathf.Lerp(agent.speed, 0f, smoothSpeed * Time.deltaTime);
			}
		}

		protected IEnumerator Chase()
		{
			while (currentHealth <= 0f)
			{
				yield return null;
			}
			agent.speed = Mathf.Lerp(agent.speed, chaseSpeed, smoothSpeed * Time.deltaTime);
			agent.stoppingDistance = chaseStopDistance;
			if (!isBlocking && !tryingBlock)
			{
				StartCoroutine(CheckChanceToBlock(chanceToBlockInStrafe, lowerShield));
			}
			if (target == null || !agressiveAtFirstSight)
			{
				currentState = AIStates.Idle;
			}
			if (base.TargetDistance <= base.distanceToAttack && meleeManager != null && canAttack && !base.actions)
			{
				canAttack = false;
				yield return StartCoroutine(MeleeAttackRotine());
			}
			if (attackCount <= 0 && !inResetAttack && !isAttacking)
			{
				StartCoroutine(ResetAttackCount());
				yield return null;
			}
			if (base.OnStrafeArea && strafeSideways)
			{
				if (strafeSwapeFrequency <= 0f)
				{
					sideMovement = GetRandonSide();
					strafeSwapeFrequency = Random.Range(minStrafeSwape, maxStrafeSwape);
				}
				else
				{
					strafeSwapeFrequency -= Time.deltaTime;
				}
				fwdMovement = ((base.TargetDistance < base.distanceToAttack) ? (strafeBackward ? (-1) : 0) : ((base.TargetDistance > base.distanceToAttack) ? 1 : 0));
				Vector3 direction = base.transform.right * sideMovement + base.transform.forward * fwdMovement;
				Vector3 position = base.transform.position;
				float x = position.x;
				float y;
				if (target != null)
				{
					Vector3 position2 = target.position;
					y = position2.y;
				}
				else
				{
					Vector3 position3 = base.transform.position;
					y = position3.y;
				}
				Vector3 position4 = base.transform.position;
				Ray ray = new Ray(new Vector3(x, y, position4.z), direction);
				if (base.TargetDistance < strafeDistance - 0.5f)
				{
					destination = ((!base.OnStrafeArea) ? target.position : ray.GetPoint(agent.stoppingDistance + 0.5f));
				}
				else if (target != null)
				{
					destination = target.position;
				}
			}
			else if (!base.OnStrafeArea && target != null)
			{
				destination = target.position;
			}
			else
			{
				fwdMovement = ((base.TargetDistance < base.distanceToAttack) ? (strafeBackward ? (-1) : 0) : ((base.TargetDistance > base.distanceToAttack) ? 1 : 0));
				Ray ray2 = new Ray(base.transform.position, base.transform.forward * fwdMovement);
				if (base.TargetDistance < strafeDistance - 0.5f)
				{
					destination = ((fwdMovement == 0f) ? base.transform.position : ray2.GetPoint(agent.stoppingDistance + ((!(fwdMovement > 0f)) ? 1f : base.TargetDistance)));
				}
				else if (target != null)
				{
					destination = target.position;
				}
			}
		}

		protected IEnumerator PatrolSubPoints()
		{
			while (!agent.enabled)
			{
				yield return null;
			}
			if ((bool)targetWaypoint)
			{
				if (targetPatrolPoint == null || !targetPatrolPoint.isValid)
				{
					targetPatrolPoint = GetPatrolPoint(targetWaypoint);
				}
				else
				{
					agent.speed = Mathf.Lerp(agent.speed, (!agent.hasPath || !targetPatrolPoint.isValid) ? 0f : patrolSpeed, smoothSpeed * Time.deltaTime);
					agent.stoppingDistance = patrollingStopDistance;
					destination = ((!targetPatrolPoint.isValid) ? base.transform.position : targetPatrolPoint.position);
					if (Vector3.Distance(base.transform.position, destination) < targetPatrolPoint.areaRadius && targetPatrolPoint.CanEnter(base.transform) && !targetPatrolPoint.IsOnWay(base.transform))
					{
						targetPatrolPoint.Enter(base.transform);
						wait = targetPatrolPoint.timeToStay;
						visitedPatrolPoint.Add(targetPatrolPoint);
					}
					else if (Vector3.Distance(base.transform.position, destination) < targetPatrolPoint.areaRadius && (!targetPatrolPoint.CanEnter(base.transform) || !targetPatrolPoint.isValid))
					{
						targetPatrolPoint = GetPatrolPoint(targetWaypoint);
					}
					if (targetPatrolPoint != null && targetPatrolPoint.IsOnWay(base.transform) && Vector3.Distance(base.transform.position, destination) < distanceToChangeWaypoint)
					{
						if (wait <= 0f || !targetPatrolPoint.isValid)
						{
							wait = 0f;
							if (visitedPatrolPoint.Count == pathArea.GetValidSubPoints(targetWaypoint).Count)
							{
								currentState = AIStates.PatrolWaypoints;
								targetWaypoint.Exit(base.transform);
								targetPatrolPoint.Exit(base.transform);
								targetWaypoint = null;
								targetPatrolPoint = null;
								visitedPatrolPoint.Clear();
							}
							else
							{
								targetPatrolPoint.Exit(base.transform);
								targetPatrolPoint = GetPatrolPoint(targetWaypoint);
							}
						}
						else if (wait > 0f && agent.desiredVelocity.magnitude == 0f)
						{
							wait -= Time.deltaTime;
						}
					}
				}
			}
			if (canSeeTarget)
			{
				currentState = AIStates.Chase;
			}
		}

		protected IEnumerator PatrolWaypoints()
		{
			while (!agent.enabled)
			{
				yield return null;
			}
			if (pathArea != null && pathArea.waypoints.Count > 0)
			{
				if (targetWaypoint == null || !targetWaypoint.isValid)
				{
					targetWaypoint = GetWaypoint();
				}
				else
				{
					agent.speed = Mathf.Lerp(agent.speed, (!agent.hasPath || !targetWaypoint.isValid) ? 0f : patrolSpeed, smoothSpeed * Time.deltaTime);
					agent.stoppingDistance = patrollingStopDistance;
					destination = targetWaypoint.position;
					if (Vector3.Distance(base.transform.position, destination) < targetWaypoint.areaRadius && targetWaypoint.CanEnter(base.transform) && !targetWaypoint.IsOnWay(base.transform))
					{
						targetWaypoint.Enter(base.transform);
						wait = targetWaypoint.timeToStay;
					}
					else if (Vector3.Distance(base.transform.position, destination) < targetWaypoint.areaRadius && (!targetWaypoint.CanEnter(base.transform) || !targetWaypoint.isValid))
					{
						targetWaypoint = GetWaypoint();
					}
					if (targetWaypoint != null && targetWaypoint.IsOnWay(base.transform) && Vector3.Distance(base.transform.position, destination) < distanceToChangeWaypoint)
					{
						if (wait <= 0f || !targetWaypoint.isValid)
						{
							wait = 0f;
							if (targetWaypoint.subPoints.Count > 0)
							{
								currentState = AIStates.PatrolSubPoints;
							}
							else
							{
								targetWaypoint.Exit(base.transform);
								visitedPatrolPoint.Clear();
								targetWaypoint = GetWaypoint();
							}
						}
						else if (wait > 0f && agent.desiredVelocity.magnitude == 0f)
						{
							wait -= Time.deltaTime;
						}
					}
				}
			}
			else if (Vector3.Distance(base.transform.position, startPosition) > patrollingStopDistance)
			{
				agent.speed = Mathf.Lerp(agent.speed, patrolSpeed, smoothSpeed * Time.deltaTime);
				agent.stoppingDistance = patrollingStopDistance;
				destination = startPosition;
			}
			if (canSeeTarget)
			{
				currentState = AIStates.Chase;
			}
		}

		private vWaypoint GetWaypoint()
		{
			List<vWaypoint> validPoints = pathArea.GetValidPoints();
			if (randomWaypoints)
			{
				currentWaypoint = randomWaypoint.Next(validPoints.Count);
			}
			else
			{
				currentWaypoint++;
			}
			if (currentWaypoint >= validPoints.Count)
			{
				currentWaypoint = 0;
			}
			if (validPoints.Count == 0)
			{
				agent.Stop();
				return null;
			}
			if (visitedWaypoint.Count == validPoints.Count)
			{
				visitedWaypoint.Clear();
			}
			if (visitedWaypoint.Contains(validPoints[currentWaypoint]))
			{
				return null;
			}
			agent.Resume();
			return validPoints[currentWaypoint];
		}

		private vPoint GetPatrolPoint(vWaypoint waypoint)
		{
			List<vPoint> validSubPoints = pathArea.GetValidSubPoints(waypoint);
			if (waypoint.randomPatrolPoint)
			{
				currentPatrolPoint = randomPatrolPoint.Next(validSubPoints.Count);
			}
			else
			{
				currentPatrolPoint++;
			}
			if (currentPatrolPoint >= validSubPoints.Count)
			{
				currentPatrolPoint = 0;
			}
			if (validSubPoints.Count == 0)
			{
				agent.Stop();
				return null;
			}
			if (visitedPatrolPoint.Contains(validSubPoints[currentPatrolPoint]))
			{
				return null;
			}
			agent.Resume();
			return validSubPoints[currentPatrolPoint];
		}

		protected IEnumerator MeleeAttackRotine()
		{
			if (!isAttacking && !base.actions && attackCount > 0 && !lockMovement)
			{
				sideMovement = GetRandonSide();
				agent.stoppingDistance = base.distanceToAttack;
				attackCount--;
				MeleeAttack();
				yield return null;
			}
		}

		public void FinishAttack()
		{
			canAttack = true;
		}

		private IEnumerator ResetAttackCount()
		{
			inResetAttack = true;
			canAttack = false;
			float value2 = 0f;
			if (firstAttack)
			{
				firstAttack = false;
				value2 = firstAttackDelay;
			}
			else
			{
				value2 = Random.Range(minTimeToAttack, maxTimeToAttack);
			}
			yield return new WaitForSeconds(value2);
			attackCount = ((!randomAttackCount) ? maxAttackCount : Random.Range(1, maxAttackCount + 1));
			canAttack = true;
			inResetAttack = false;
		}

		public void OnEnableAttack()
		{
			isAttacking = true;
		}

		public void OnDisableAttack()
		{
			isAttacking = false;
			canAttack = true;
		}

		public void ResetAttackTriggers()
		{
			animator.ResetTrigger("WeakAttack");
		}

		public void BreakAttack(int breakAtkID)
		{
			ResetAttackCount();
			ResetAttackTriggers();
			OnRecoil(breakAtkID);
		}

		public void OnRecoil(int recoilID)
		{
			TriggerRecoil(recoilID);
		}

		public void OnReceiveAttack(Damage damage, vIMeleeFighter attacker)
		{
			StartCoroutine(CheckChanceToBlock(chanceToBlockAttack, 0f));
			Vector3 attackPoint = (attacker == null || !(attacker.Character() != null)) ? damage.hitPosition : attacker.Character().transform.position;
			if (!damage.ignoreDefense && isBlocking && meleeManager != null && meleeManager.CanBlockAttack(attackPoint))
			{
				int num = (meleeManager != null) ? meleeManager.GetDefenseRate() : 0;
				if (num > 0)
				{
					damage.ReduceDamage(num);
				}
				if (attacker != null && meleeManager != null && meleeManager.CanBreakAttack())
				{
					attacker.OnRecoil(meleeManager.GetDefenseRecoilID());
				}
				meleeManager.OnDefense();
			}
			if (!sphereSensor.passiveToDamage && damage.sender != null)
			{
				target = damage.sender;
				currentState = AIStates.Chase;
				sphereSensor.SetTagToDetect(damage.sender);
			}
			if (!passiveToDamage)
			{
				SetAgressive(value: true);
			}
			TakeDamage(damage, !isBlocking);
		}

		public vCharacter Character()
		{
			return this;
		}
	}
}
