using UnityEngine;
using UnityEngine.SceneManagement;

namespace Invector.CharacterController
{
	public class vThirdPersonInput : MonoBehaviour
	{
		public delegate void OnEnableCursor(Vector3 position);

		public delegate void OnDisableCursor();

		public enum GameplayInputStyle
		{
			ClickAndMove,
			DirectionalInput
		}

		public GameplayInputStyle gameplayInputStyle = GameplayInputStyle.DirectionalInput;

		public LayerMask clickMoveLayer = 1;

		public bool inverseInputDirection;

		public bool lockInput;

		public bool lockCamera;

		[Header("Default Inputs")]
		public GenericInput horizontalInput = new GenericInput("Horizontal", "LeftAnalogHorizontal", "Horizontal");

		public GenericInput verticallInput = new GenericInput("Vertical", "LeftAnalogVertical", "Vertical");

		public GenericInput jumpInput = new GenericInput("Space", "X", "X");

		public GenericInput rollInput = new GenericInput("Q", "B", "B");

		public GenericInput strafeInput = new GenericInput("Tab", "RightStickClick", "RightStickClick");

		public GenericInput sprintInput = new GenericInput("LeftShift", "LeftStickClick", "LeftStickClick");

		public GenericInput crouchInput = new GenericInput("C", "Y", "Y");

		public GenericInput actionInput = new GenericInput("E", "A", "A");

		public GenericInput cancelInput = new GenericInput("Backspace", "B", "B");

		public GenericInput flyInput = new GenericInput("X", "X", "X");

		public GenericInput flyUpInput = new GenericInput("Space", "X", "X");

		public GenericInput flyDownInput = new GenericInput("LeftShift", "X", "X");

		[Header("Camera Settings")]
		public GenericInput rotateCameraXInput = new GenericInput("Mouse X", "RightAnalogHorizontal", "Mouse X");

		public GenericInput rotateCameraYInput = new GenericInput("Mouse Y", "RightAnalogVertical", "Mouse Y");

		public GenericInput cameraZoomInput = new GenericInput("Mouse ScrollWheel", string.Empty, string.Empty);

		protected vThirdPersonCamera tpCamera;

		[HideInInspector]
		public string customCameraState;

		[HideInInspector]
		public string customlookAtPoint;

		[HideInInspector]
		public bool changeCameraState;

		[HideInInspector]
		public bool smoothCameraState;

		[HideInInspector]
		public bool keepDirection;

		public OnEnableCursor onEnableCursor;

		public OnDisableCursor onDisableCursor;

		private Vector3 cursorPoint;

		protected vThirdPersonController cc;

		[HideInInspector]
		public vHUDController hud;

		protected Vector2 oldInput;

		protected InputDevice inputDevice => vInput.instance.inputDevice;

		protected virtual void Start()
		{
			cc = GetComponent<vThirdPersonController>();
			if (vThirdPersonController.instance == cc || vThirdPersonController.instance == null)
			{
				SceneManager.sceneLoaded += OnLevelFinishedLoading;
				CharacterInit();
			}
		}

		private void OnLevelFinishedLoading(Scene scene, LoadSceneMode mode)
		{
			try
			{
				CharacterInit();
			}
			catch
			{
				SceneManager.sceneLoaded -= OnLevelFinishedLoading;
			}
		}

		protected virtual void CharacterInit()
		{
			if (cc != null)
			{
				cc.Init();
			}
			tpCamera = Object.FindObjectOfType<vThirdPersonCamera>();
			if ((bool)tpCamera)
			{
				tpCamera.SetMainTarget(base.transform);
			}
			cursorPoint = base.transform.position;
			hud = vHUDController.instance;
			if (hud != null)
			{
				hud.Init(cc);
			}
		}

		protected virtual void LateUpdate()
		{
			if (!(cc == null))
			{
				if (lockInput)
				{
					cc.input = Vector3.zero;
				}
				else if (Time.timeScale != 0f)
				{
					InputHandle();
					UpdateCameraStates();
				}
			}
		}

		protected virtual void FixedUpdate()
		{
			cc.AirControl();
			cc.FlyAirControl();
			CameraInput();
		}

		protected virtual void Update()
		{
			cc.UpdateMotor();
			cc.UpdateAnimator();
			UpdateHUD();
		}

		protected virtual void InputHandle()
		{
			ExitGameInput();
			if (!cc.lockMovement && !cc.ragdolled)
			{
				MoveCharacter();
				SprintInput();
				CrouchInput();
				StrafeInput();
				JumpInput();
				FlyInput();
				RollInput();
				ActionInput();
				EnterLadderInput();
				ExitLadderInput();
			}
		}

		public void LockInput(bool value)
		{
			lockInput = value;
		}

		public void ShowCursor(bool value)
		{
			Cursor.visible = value;
		}

		protected virtual void MoveCharacter()
		{
			if (gameplayInputStyle == GameplayInputStyle.ClickAndMove)
			{
				cc.rotateByWorld = true;
				ClickAndMove();
			}
			else
			{
				ControllerInput();
			}
		}

		protected virtual void ControllerInput()
		{
			cc.input.x = horizontalInput.GetAxis();
			cc.input.y = verticallInput.GetAxis();
			if (!keepDirection)
			{
				oldInput = cc.input;
			}
		}

		protected virtual void StrafeInput()
		{
			if (strafeInput.GetButtonDown())
			{
				cc.Strafe();
			}
		}

		protected virtual void SprintInput()
		{
			if (sprintInput.GetButtonDown())
			{
				cc.Sprint(value: true);
			}
			else
			{
				cc.Sprint(value: false);
			}
		}

		protected virtual void CrouchInput()
		{
			if (crouchInput.GetButtonDown())
			{
				cc.Crouch();
			}
		}

		protected virtual void JumpInput()
		{
			if (jumpInput.GetButtonDown())
			{
				cc.Jump();
			}
		}

		protected virtual void FlyInput()
		{
			if (flyInput.GetButtonDown())
			{
				cc.Fly();
			}
			if (flyUpInput.GetButton())
			{
				cc.ChangeFlyDirection(1);
			}
			else if (flyDownInput.GetButton())
			{
				cc.ChangeFlyDirection(-1);
			}
			else
			{
				cc.ChangeFlyDirection(0);
			}
		}

		protected virtual void RollInput()
		{
			if (rollInput.GetButtonDown())
			{
				cc.Roll();
			}
		}

		protected virtual void ActionInput()
		{
			if (!(cc.triggerAction == null) && !cc.doingCustomAction && !cc.animator.IsInTransition(0) && actionInput.GetButtonDown())
			{
				cc.TriggerAction(cc.triggerAction);
				hud.HideActionText();
			}
		}

		protected virtual void EnterLadderInput()
		{
			if (!(cc.ladderAction == null) && !cc.isUsingLadder && actionInput.GetButtonDown())
			{
				cc.TriggerEnterLadder(cc.ladderAction);
			}
		}

		protected virtual void ExitLadderInput()
		{
			if (!cc.isUsingLadder)
			{
				return;
			}
			if (cc.ladderAction == null)
			{
				if (cc.baseLayerInfo.IsName("ClimbLadder") && cancelInput.GetButtonDown())
				{
					cc.ExitLadder(0, immediateExit: true);
				}
				return;
			}
			string exitAnimation = cc.ladderAction.exitAnimation;
			if (exitAnimation == "ExitLadderBottom")
			{
				if ((cancelInput.GetButtonDown() || cc.speed <= -0.05f) && !cc.exitingLadder)
				{
					cc.ExitLadder(2);
				}
			}
			else if (exitAnimation == "ExitLadderTop" && cc.baseLayerInfo.IsName("ClimbLadder") && cc.speed >= 0.05f && !cc.exitingLadder)
			{
				cc.ExitLadder(1);
			}
		}

		protected virtual void ExitGameInput()
		{
			if (Input.GetKeyDown(KeyCode.Escape))
			{
				if (!Cursor.visible)
				{
					Cursor.visible = true;
				}
				else
				{
					Application.Quit();
				}
			}
		}

		protected virtual void OnTriggerStay(Collider other)
		{
			cc.CheckTriggers(other);
		}

		protected virtual void OnTriggerExit(Collider other)
		{
			cc.CheckTriggerExit(other);
		}

		protected virtual void ClickAndMove()
		{
			bool flag = NearPoint(cursorPoint, base.transform.position);
			Vector3 vector = (!flag) ? (cursorPoint - base.transform.position).normalized : (base.transform.forward * 0.2f);
			if (Input.GetMouseButton(0) && Physics.Raycast(tpCamera.GetComponent<Camera>().ScreenPointToRay(Input.mousePosition), out RaycastHit hitInfo, float.PositiveInfinity, clickMoveLayer))
			{
				if (onEnableCursor != null)
				{
					onEnableCursor(hitInfo.point);
				}
				cursorPoint = hitInfo.point;
			}
			if (!flag)
			{
				cc.input = new Vector2(vector.x, vector.z);
				return;
			}
			if (onDisableCursor != null)
			{
				onDisableCursor();
			}
			cc.input = Vector2.Lerp(cc.input, Vector3.zero, 20f * Time.deltaTime);
		}

		protected virtual bool NearPoint(Vector3 a, Vector3 b)
		{
			float x = a.x;
			Vector3 position = base.transform.position;
			Vector3 a2 = new Vector3(x, position.y, a.z);
			float x2 = b.x;
			Vector3 position2 = base.transform.position;
			Vector3 b2 = new Vector3(x2, position2.y, b.z);
			return Vector3.Distance(a2, b2) <= 0.5f;
		}

		protected virtual void CameraInput()
		{
			if (!(tpCamera == null) && !lockCamera)
			{
				float axis = rotateCameraYInput.GetAxis();
				float axis2 = rotateCameraXInput.GetAxis();
				float axis3 = cameraZoomInput.GetAxis();
				tpCamera.RotateCamera(axis2, axis);
				tpCamera.Zoom(axis3);
				if (!keepDirection)
				{
					cc.UpdateTargetDirection((!(tpCamera != null)) ? null : tpCamera.transform);
				}
				RotateWithCamera((!(tpCamera != null)) ? null : tpCamera.transform);
				if (keepDirection && Vector2.Distance(cc.input, oldInput) > 0.2f)
				{
					keepDirection = false;
				}
			}
		}

		protected virtual void UpdateCameraStates()
		{
			if (tpCamera == null)
			{
				tpCamera = Object.FindObjectOfType<vThirdPersonCamera>();
				if (tpCamera == null)
				{
					return;
				}
				if ((bool)tpCamera)
				{
					tpCamera.SetMainTarget(base.transform);
					tpCamera.Init();
				}
			}
			if (changeCameraState && !cc.isStrafing)
			{
				tpCamera.ChangeState(customCameraState, customlookAtPoint, smoothCameraState);
			}
			else if (cc.isCrouching)
			{
				tpCamera.ChangeState("Crouch", hasSmooth: true);
			}
			else if (cc.isStrafing)
			{
				tpCamera.ChangeState("Strafing", hasSmooth: true);
			}
			else
			{
				tpCamera.ChangeState("Default", hasSmooth: true);
			}
		}

		protected virtual void RotateWithCamera(Transform cameraTransform)
		{
			if (cc.isStrafing && !cc.actions && !cc.lockMovement)
			{
				if (tpCamera != null && (bool)tpCamera.lockTarget)
				{
					cc.RotateToTarget(tpCamera.lockTarget);
				}
				else if (cc.input != Vector2.zero)
				{
					cc.RotateWithAnotherTransform(cameraTransform);
				}
			}
		}

		public virtual void UpdateHUD()
		{
			if (!(hud == null))
			{
				hud.UpdateHUD(cc);
			}
		}
	}
}
