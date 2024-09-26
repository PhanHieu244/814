using Invector.CharacterController;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class vMoveSetSpeed : MonoBehaviour
{
	[Serializable]
	public class vMoveSetControlSpeed
	{
		public int moveset;

		public float walkSpeed = 1.5f;

		public float runningSpeed = 1.5f;

		public float sprintSpeed = 1.5f;

		public float crouchSpeed = 1.5f;
	}

	private vThirdPersonMotor cc;

	private vMoveSetControlSpeed defaultFree = new vMoveSetControlSpeed();

	private vMoveSetControlSpeed defaultStrafe = new vMoveSetControlSpeed();

	public List<vMoveSetControlSpeed> listFree;

	public List<vMoveSetControlSpeed> listStrafe;

	private int currentMoveSet;

	private void Start()
	{
		cc = GetComponent<vThirdPersonMotor>();
		defaultFree.walkSpeed = cc.freeWalkSpeed;
		defaultFree.runningSpeed = cc.freeRunningSpeed;
		defaultFree.sprintSpeed = cc.freeSprintSpeed;
		defaultStrafe.walkSpeed = cc.strafeWalkSpeed;
		defaultStrafe.runningSpeed = cc.strafeRunningSpeed;
		defaultStrafe.sprintSpeed = cc.strafeRunningSpeed;
		StartCoroutine(UpdateMoveSetSpeed());
	}

	private IEnumerator UpdateMoveSetSpeed()
	{
		while (true)
		{
			yield return new WaitForSeconds(0.1f);
			ChangeSpeed();
		}
	}

	private void ChangeSpeed()
	{
		currentMoveSet = (int)Mathf.Round(cc.animator.GetFloat("MoveSet_ID"));
		if (cc.isStrafing)
		{
			vMoveSetControlSpeed vMoveSetControlSpeed = listStrafe.Find((vMoveSetControlSpeed l) => l.moveset == currentMoveSet);
			if (vMoveSetControlSpeed != null)
			{
				cc.strafeWalkSpeed = vMoveSetControlSpeed.walkSpeed;
				cc.strafeRunningSpeed = vMoveSetControlSpeed.runningSpeed;
				cc.strafeSprintSpeed = vMoveSetControlSpeed.sprintSpeed;
				cc.strafeCrouchSpeed = vMoveSetControlSpeed.crouchSpeed;
			}
			else
			{
				cc.strafeWalkSpeed = defaultStrafe.walkSpeed;
				cc.strafeRunningSpeed = defaultStrafe.runningSpeed;
				cc.strafeRunningSpeed = defaultStrafe.sprintSpeed;
				cc.strafeCrouchSpeed = defaultStrafe.crouchSpeed;
			}
		}
		else
		{
			vMoveSetControlSpeed vMoveSetControlSpeed2 = listFree.Find((vMoveSetControlSpeed l) => l.moveset == currentMoveSet);
			if (vMoveSetControlSpeed2 != null)
			{
				cc.freeWalkSpeed = vMoveSetControlSpeed2.walkSpeed;
				cc.freeRunningSpeed = vMoveSetControlSpeed2.runningSpeed;
				cc.freeSprintSpeed = vMoveSetControlSpeed2.sprintSpeed;
				cc.freeCrouchSpeed = vMoveSetControlSpeed2.crouchSpeed;
			}
			else
			{
				cc.freeWalkSpeed = defaultFree.walkSpeed;
				cc.freeRunningSpeed = defaultFree.runningSpeed;
				cc.freeSprintSpeed = defaultFree.sprintSpeed;
				cc.freeCrouchSpeed = defaultFree.crouchSpeed;
			}
		}
	}
}
