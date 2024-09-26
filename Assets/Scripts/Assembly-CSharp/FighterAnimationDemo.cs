using System.Collections;
using UnityEngine;

public class FighterAnimationDemo : MonoBehaviour
{
	private bool crouchBool;

	private bool blockBool;

	private bool dead;

	private bool InAir;

	public Animator animator;

	private Transform defaultCamTransform;

	private Vector3 resetPos;

	private Quaternion resetRot;

	private GameObject cam;

	private GameObject fighter;

	private void Start()
	{
		cam = GameObject.FindWithTag("MainCamera");
		defaultCamTransform = cam.transform;
		resetPos = defaultCamTransform.position;
		resetRot = defaultCamTransform.rotation;
		fighter = GameObject.FindWithTag("Player");
		fighter.transform.position = new Vector3(0f, 0f, 0f);
	}

	private IEnumerator COInAir(float toAnimWindow)
	{
		yield return new WaitForSeconds(toAnimWindow);
		InAir = true;
		animator.SetBool("InAir", value: true);
		yield return new WaitForSeconds(0.5f);
		InAir = false;
		animator.SetBool("InAir", value: false);
	}

	private void OnGUI()
	{
		if (GUI.RepeatButton(new Rect(815f, 535f, 100f, 30f), "Reset Scene"))
		{
			defaultCamTransform.position = resetPos;
			defaultCamTransform.rotation = resetRot;
			fighter.transform.position = new Vector3(0f, 0f, 0f);
			animator.Play("Idle");
		}
		if (!dead)
		{
			if (!blockBool && !crouchBool)
			{
				if (GUI.RepeatButton(new Rect(455f, 20f, 100f, 30f), "Run"))
				{
					animator.SetBool("Run", value: true);
				}
				else
				{
					animator.SetBool("Run", value: false);
				}
				if (GUI.RepeatButton(new Rect(25f, 20f, 100f, 30f), "Walk Forward"))
				{
					animator.SetBool("Walk Forward", value: true);
				}
				else
				{
					animator.SetBool("Walk Forward", value: false);
				}
				if (GUI.Button(new Rect(135f, 20f, 100f, 30f), "Dash Forward"))
				{
					animator.SetTrigger("DashForwardTrigger");
				}
				if (GUI.Button(new Rect(245f, 20f, 100f, 30f), "Intro1"))
				{
					animator.SetTrigger("Intro1Trigger");
				}
				if (GUI.Button(new Rect(345f, 20f, 100f, 30f), "Victory1"))
				{
					animator.SetTrigger("Victory1Trigger");
				}
				if (GUI.RepeatButton(new Rect(25f, 50f, 100f, 30f), "Walk Backward"))
				{
					animator.SetBool("Walk Backward", value: true);
				}
				else
				{
					animator.SetBool("Walk Backward", value: false);
				}
				if (GUI.Button(new Rect(135f, 50f, 100f, 30f), "Dash Backward"))
				{
					animator.SetTrigger("DashBackwardTrigger");
				}
				if (GUI.Button(new Rect(245f, 50f, 100f, 30f), "Intro2"))
				{
					animator.SetTrigger("Intro2Trigger");
				}
				if (GUI.Button(new Rect(345f, 50f, 100f, 30f), "Victory2"))
				{
					animator.SetTrigger("Victory2Trigger");
				}
				if (GUI.Button(new Rect(25f, 90f, 100f, 30f), "Uppercut"))
				{
					animator.SetTrigger("UppercutTrigger");
				}
				if (GUI.Button(new Rect(25f, 120f, 100f, 30f), "Punch"))
				{
					animator.SetTrigger("PunchTrigger");
				}
				if (GUI.Button(new Rect(25f, 150f, 100f, 30f), "Jab"))
				{
					animator.SetTrigger("JabTrigger");
				}
				if (GUI.Button(new Rect(25f, 180f, 100f, 30f), "Kick"))
				{
					animator.SetTrigger("KickTrigger");
				}
			}
			blockBool = GUI.Toggle(new Rect(25f, 215f, 100f, 30f), blockBool, "Block");
			if (blockBool)
			{
				animator.SetBool("Block", value: true);
			}
			else
			{
				animator.SetBool("Block", value: false);
			}
			crouchBool = GUI.Toggle(new Rect(140f, 215f, 100f, 30f), crouchBool, "Crouch");
			if (crouchBool)
			{
				animator.SetBool("Crouch", value: true);
			}
			else
			{
				animator.SetBool("Crouch", value: false);
			}
			if (blockBool)
			{
				if (!crouchBool)
				{
					if (GUI.Button(new Rect(30f, 240f, 100f, 30f), "BlockHitReact"))
					{
						animator.SetTrigger("BlockHitReactTrigger");
					}
				}
				else if (GUI.Button(new Rect(30f, 240f, 100f, 30f), "BlockHitReact"))
				{
					animator.SetTrigger("CrouchBlockHitReactTrigger");
				}
			}
			else if (GUI.Button(new Rect(30f, 240f, 100f, 30f), "Hit React"))
			{
				animator.SetTrigger("LightHitTrigger");
			}
			if (!blockBool)
			{
				if (GUI.Button(new Rect(30f, 270f, 100f, 30f), "Knockdown"))
				{
					animator.SetTrigger("KnockdownTrigger");
				}
				if (GUI.Button(new Rect(30f, 300f, 100f, 30f), "Choke"))
				{
					animator.SetTrigger("Choke");
				}
			}
			if (crouchBool)
			{
				if (GUI.Button(new Rect(135f, 300f, 100f, 30f), "Low Kick") && crouchBool)
				{
					animator.SetTrigger("LowKickTrigger");
				}
				if (GUI.Button(new Rect(135f, 240f, 100f, 30f), "Sweep") && crouchBool)
				{
					animator.SetTrigger("SweepTrigger");
				}
				if (GUI.Button(new Rect(135f, 270f, 100f, 30f), "Low Punch"))
				{
					animator.SetTrigger("LowPunchTrigger");
				}
			}
			if (!blockBool && !crouchBool)
			{
				if (GUI.Button(new Rect(30f, 340f, 100f, 30f), "Jump"))
				{
					animator.SetTrigger("JumpTrigger");
					StartCoroutine(COInAir(0.25f));
				}
				if (GUI.Button(new Rect(30f, 370f, 100f, 30f), "Jump Forward"))
				{
					animator.SetTrigger("JumpForwardTrigger");
					StartCoroutine(COInAir(0.25f));
				}
				if (InAir)
				{
					if (GUI.Button(new Rect(135f, 370f, 100f, 30f), "Jump Punch") && InAir)
					{
						animator.SetTrigger("HighPunchTrigger");
					}
					if (GUI.Button(new Rect(135f, 340f, 100f, 30f), "Jump Hit React") && InAir)
					{
						animator.SetTrigger("JumpHitReactTrigger");
					}
					if (GUI.Button(new Rect(135f, 400f, 100f, 30f), "Jump Kick") && InAir)
					{
						animator.SetTrigger("HighKickTrigger");
					}
				}
				if (GUI.Button(new Rect(30f, 400f, 100f, 30f), "Jump Backward"))
				{
					animator.SetTrigger("JumpBackwardTrigger");
					StartCoroutine(COInAir(0.25f));
				}
				if (GUI.Button(new Rect(30f, 440f, 100f, 30f), "RangeAttack1"))
				{
					animator.SetTrigger("RangeAttack1Trigger");
				}
				if (GUI.Button(new Rect(135f, 440f, 100f, 30f), "RangeAttack2"))
				{
					animator.SetTrigger("RangeAttack2Trigger");
				}
				if (GUI.Button(new Rect(30f, 470f, 100f, 30f), "MoveAttack1"))
				{
					animator.SetTrigger("MoveAttack1Trigger");
				}
				if (GUI.Button(new Rect(135f, 470f, 100f, 30f), "MoveAttack2"))
				{
					animator.SetTrigger("MoveAttack2Trigger");
				}
				if (GUI.Button(new Rect(30f, 500f, 100f, 30f), "SpecialAttack1"))
				{
					animator.SetTrigger("SpecialAttack1Trigger");
				}
				if (GUI.Button(new Rect(135f, 500f, 100f, 30f), "SpecialAttack2"))
				{
					animator.SetTrigger("SpecialAttack2Trigger");
				}
				if (GUI.Button(new Rect(30f, 540f, 100f, 30f), "Death"))
				{
					animator.SetTrigger("DeathTrigger");
					dead = true;
				}
			}
		}
		if (dead && GUI.Button(new Rect(135f, 540f, 100f, 30f), "Revive"))
		{
			animator.SetTrigger("ReviveTrigger");
			dead = false;
		}
	}
}
