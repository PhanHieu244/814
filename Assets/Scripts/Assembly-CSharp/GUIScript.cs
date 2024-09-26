using UnityEngine;

public class GUIScript : MonoBehaviour
{
	public Animator animator;

	public Animator animator2;

	public Animator animator3;

	public Vector2 scrollPosition = Vector2.zero;

	public Vector2 scrollPos2 = Vector2.zero;

	public bool idleStandbool = true;

	public bool idleReadybool;

	public bool idleMonsterbool;

	public bool idleFightbool;

	public bool weaponStandbool;

	public bool pistolReadybool;

	public bool weaponRun;

	public bool oneHandSwordIdle;

	public bool bowIdle;

	public bool motorbikeIdle;

	public bool rollerBlade;

	public bool skateboard;

	public bool climbing;

	public bool office;

	public bool swim;

	public bool wand;

	public bool cards;

	public bool breakdance;

	public bool katana;

	public bool soccer;

	public bool giant;

	public bool zombie;

	public bool iceHockey;

	public float LHandWeight;

	public Transform LHandPos1;

	public Transform LHandPos2;

	public Transform LHandPos3;

	private void OnGUI()
	{
		scrollPos2 = GUI.BeginScrollView(new Rect(10f, 10f, 120f, 285f), scrollPos2, new Rect(0f, 0f, 100f, 525f));
		if (GUI.Button(new Rect(0f, 0f, 100f, 20f), "Idle Stand"))
		{
			IdleStand();
		}
		if (GUI.Button(new Rect(0f, 25f, 100f, 20f), "Idle Ready"))
		{
			IdleReady();
		}
		if (GUI.Button(new Rect(0f, 50f, 100f, 20f), "Idle Monster"))
		{
			IdleMonster();
		}
		if (GUI.Button(new Rect(0f, 75f, 100f, 20f), "Weapon Stand"))
		{
			WeaponStand();
		}
		if (GUI.Button(new Rect(0f, 100f, 100f, 20f), "Pistol Ready"))
		{
			PistolReady();
		}
		if (GUI.Button(new Rect(0f, 125f, 100f, 20f), "1 Hand Sword"))
		{
			OneHandSwordIdle();
		}
		if (GUI.Button(new Rect(0f, 150f, 100f, 20f), "Bow"))
		{
			BowIdle();
		}
		if (GUI.Button(new Rect(0f, 175f, 100f, 20f), "Motorbike"))
		{
			MotorbikeIdle();
		}
		if (GUI.Button(new Rect(0f, 200f, 100f, 20f), "RollerBlade"))
		{
			RollerBladeStand();
		}
		if (GUI.Button(new Rect(0f, 225f, 100f, 20f), "Skateboard"))
		{
			SkateboardIdle();
		}
		if (GUI.Button(new Rect(0f, 250f, 100f, 20f), "Climbing"))
		{
			ClimbIdle();
		}
		if (GUI.Button(new Rect(0f, 275f, 100f, 20f), "Office"))
		{
			OfficeSitting();
		}
		if (GUI.Button(new Rect(0f, 300f, 100f, 20f), "Swimming"))
		{
			Swim();
		}
		if (GUI.Button(new Rect(0f, 325f, 100f, 20f), "Wand/Staff"))
		{
			WandStand();
		}
		if (GUI.Button(new Rect(0f, 350f, 100f, 20f), "Cards"))
		{
			DealerIdle();
		}
		if (GUI.Button(new Rect(0f, 375f, 100f, 20f), "Breakdancing"))
		{
			SixStep();
		}
		if (GUI.Button(new Rect(0f, 400f, 100f, 20f), "Katana"))
		{
			KatanaNinjaDraw();
		}
		if (GUI.Button(new Rect(0f, 425f, 100f, 20f), "Soccer"))
		{
			Soccer();
		}
		if (GUI.Button(new Rect(0f, 450f, 100f, 20f), "Giant"))
		{
			Giant();
		}
		if (GUI.Button(new Rect(0f, 475f, 100f, 20f), "Zombie"))
		{
			Zombie();
		}
		if (GUI.Button(new Rect(0f, 500f, 100f, 20f), "IceHockey"))
		{
			IceHockeyIdle();
		}
		GUI.EndScrollView();
		if (idleStandbool)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 150f, 285f), scrollPosition, new Rect(0f, 0f, 120f, 2600f));
			if (GUI.Button(new Rect(0f, 0f, 100f, 20f), "Idle Cheer"))
			{
				IdleCheer();
			}
			if (GUI.Button(new Rect(0f, 25f, 120f, 20f), "Idle Come Here"))
			{
				ComeHere();
			}
			if (GUI.Button(new Rect(0f, 50f, 120f, 20f), "Idle Keep Back"))
			{
				IdleKeepBack();
			}
			if (GUI.Button(new Rect(0f, 75f, 100f, 20f), "Idle Sad"))
			{
				IdleSad();
			}
			if (GUI.Button(new Rect(0f, 100f, 100f, 20f), "Idle Walk"))
			{
				IdleWalk();
			}
			if (GUI.Button(new Rect(0f, 125f, 120f, 20f), "Idle Strafe Right"))
			{
				IdleStrafeRight();
			}
			if (GUI.Button(new Rect(0f, 150f, 120f, 20f), "Idle Strafe Left"))
			{
				IdleStrafeLeft();
			}
			if (GUI.Button(new Rect(0f, 175f, 120f, 20f), "Strafe Run Left"))
			{
				StrafeRunLeft();
			}
			if (GUI.Button(new Rect(0f, 200f, 120f, 20f), "Strafe Run Right"))
			{
				StrafeRunRight();
			}
			if (GUI.Button(new Rect(0f, 225f, 120f, 20f), "Run Backward"))
			{
				RunBackward();
			}
			if (GUI.Button(new Rect(0f, 250f, 120f, 20f), "Run Back Left"))
			{
				RunBackLeft();
			}
			if (GUI.Button(new Rect(0f, 275f, 120f, 20f), "Run Back Right"))
			{
				RunBackRight();
			}
			if (GUI.Button(new Rect(0f, 300f, 120f, 20f), "Cowboy1HandDraw"))
			{
				Cowboy1HandDraw();
			}
			if (GUI.Button(new Rect(0f, 325f, 120f, 20f), "Crate Push"))
			{
				CratePush();
			}
			if (GUI.Button(new Rect(0f, 350f, 120f, 20f), "Crate Pull"))
			{
				CratePull();
			}
			if (GUI.Button(new Rect(0f, 375f, 120f, 20f), "Idle 90 Deg Turns"))
			{
				IdleTurns();
			}
			if (GUI.Button(new Rect(0f, 400f, 120f, 20f), "Idle Meditate"))
			{
				IdleMeditate();
			}
			if (GUI.Button(new Rect(0f, 425f, 120f, 20f), "Idle 180"))
			{
				Idle180();
			}
			if (GUI.Button(new Rect(0f, 450f, 120f, 20f), "Idle Button Press"))
			{
				IdleButtonPress();
			}
			if (GUI.Button(new Rect(0f, 475f, 120f, 20f), "Idle Typing"))
			{
				IdleTyping();
			}
			if (GUI.Button(new Rect(0f, 500f, 120f, 20f), "Idle Stun"))
			{
				IdleStun();
			}
			if (GUI.Button(new Rect(0f, 525f, 120f, 20f), "Wood Cut"))
			{
				WoodCut();
			}
			if (GUI.Button(new Rect(0f, 550f, 120f, 20f), "Worker Hammer"))
			{
				WorkerHammer();
			}
			if (GUI.Button(new Rect(0f, 575f, 120f, 20f), "Worker Hammer 2"))
			{
				WorkerHammer2();
			}
			if (GUI.Button(new Rect(0f, 600f, 120f, 20f), "Worker Pickaxe"))
			{
				WorkerPickaxe();
			}
			if (GUI.Button(new Rect(0f, 625f, 120f, 20f), "Worker Pickaxe 2"))
			{
				WorkerPickaxe2();
			}
			if (GUI.Button(new Rect(0f, 650f, 120f, 20f), "Worker Shovel"))
			{
				WorkerShovel();
			}
			if (GUI.Button(new Rect(0f, 675f, 120f, 20f), "Worker Shovel 2"))
			{
				WorkerShovel2();
			}
			if (GUI.Button(new Rect(0f, 700f, 120f, 20f), "Idle Spew"))
			{
				IdleSpew();
			}
			if (GUI.Button(new Rect(0f, 725f, 120f, 20f), "Idle Mouth Wipe"))
			{
				IdleMouthWipe();
			}
			if (GUI.Button(new Rect(0f, 750f, 120f, 20f), "Crawl Idle"))
			{
				CrawlIdle();
			}
			if (GUI.Button(new Rect(0f, 775f, 120f, 20f), "Crawl Locomotion"))
			{
				CrawlLocomotion();
			}
			if (GUI.Button(new Rect(0f, 800f, 120f, 20f), "Prone Idle"))
			{
				ProneIdle();
			}
			if (GUI.Button(new Rect(0f, 825f, 120f, 20f), "Prone Locomotion"))
			{
				ProneLocomotion();
			}
			if (GUI.Button(new Rect(0f, 850f, 120f, 20f), "Idle Feed Throw"))
			{
				IdleFeedThrow();
			}
			if (GUI.Button(new Rect(0f, 875f, 120f, 20f), "Idle Standing Jump"))
			{
				IdleStandingJump();
			}
			if (GUI.Button(new Rect(0f, 900f, 120f, 20f), "Yawn"))
			{
				Yawn();
			}
			if (GUI.Button(new Rect(0f, 925f, 120f, 20f), "Heel Click"))
			{
				HeelClick();
			}
			if (GUI.Button(new Rect(0f, 950f, 120f, 20f), "Vader Choke"))
			{
				VaderChoke();
			}
			if (GUI.Button(new Rect(0f, 975f, 120f, 20f), "Watering Can Idle"))
			{
				WateringCan();
			}
			if (GUI.Button(new Rect(0f, 1000f, 120f, 20f), "Watering Can Watering"))
			{
				WateringCanWatering();
			}
			if (GUI.Button(new Rect(0f, 1025f, 120f, 20f), "Up Hill Walk"))
			{
				UpHillWalk();
			}
			if (GUI.Button(new Rect(0f, 1050f, 120f, 20f), "UphillWalk Hand Grab"))
			{
				UpHillWalkHandGrab();
			}
			if (GUI.Button(new Rect(0f, 1075f, 120f, 20f), "Walk Dehydrated"))
			{
				WalkDehydrated();
			}
			if (GUI.Button(new Rect(0f, 1100f, 120f, 20f), "Idle Sand Cover"))
			{
				IdleSandCover();
			}
			if (GUI.Button(new Rect(0f, 1125f, 120f, 20f), "Battle Roar"))
			{
				BattleRoar();
			}
			if (GUI.Button(new Rect(0f, 1150f, 120f, 20f), "Channel Cast Directed"))
			{
				ChannelCastDirected();
			}
			if (GUI.Button(new Rect(0f, 1175f, 120f, 20f), "Channel Cast Omni"))
			{
				ChannelCastOmni();
			}
			if (GUI.Button(new Rect(0f, 1200f, 120f, 20f), "Fire Breath"))
			{
				FireBreath();
			}
			if (GUI.Button(new Rect(0f, 1225f, 120f, 20f), "Mutilate"))
			{
				Mutilate();
			}
			if (GUI.Button(new Rect(0f, 1250f, 120f, 20f), "Storm Strike"))
			{
				StormStrike();
			}
			if (GUI.Button(new Rect(0f, 1275f, 120f, 20f), "Walk Backward"))
			{
				WalkBackward();
			}
			if (GUI.Button(new Rect(0f, 1300f, 120f, 20f), "Flashlight"))
			{
				Flashlight();
			}
			if (GUI.Button(new Rect(0f, 1325f, 120f, 20f), "ApplePick"))
			{
				ApplePick();
			}
			if (GUI.Button(new Rect(0f, 1350f, 120f, 20f), "Arm Flex"))
			{
				ArmFlex();
			}
			if (GUI.Button(new Rect(0f, 1375f, 120f, 20f), "Arm Flex 2"))
			{
				ArmFlex2();
			}
			if (GUI.Button(new Rect(0f, 1400f, 120f, 20f), "Arm Flex 3"))
			{
				ArmFlex3();
			}
			if (GUI.Button(new Rect(0f, 1425f, 120f, 20f), "Arm Flex 4"))
			{
				ArmFlex4();
			}
			if (GUI.Button(new Rect(0f, 1450f, 120f, 20f), "Cheer Knees"))
			{
				CheerKnees();
			}
			if (GUI.Button(new Rect(0f, 1475f, 120f, 20f), "Cheer Jump"))
			{
				CheerJump();
			}
			if (GUI.Button(new Rect(0f, 1500f, 120f, 20f), "Elvis Legs"))
			{
				ElvisLegs();
			}
			if (GUI.Button(new Rect(0f, 1525f, 120f, 20f), "Face Palm"))
			{
				FacePalm();
			}
			if (GUI.Button(new Rect(0f, 1550f, 120f, 20f), "Fishing"))
			{
				Fishing();
			}
			if (GUI.Button(new Rect(0f, 1575f, 120f, 20f), "Fist Pump"))
			{
				FistPump();
			}
			if (GUI.Button(new Rect(0f, 1600f, 120f, 20f), "Fist Pump 2"))
			{
				FistPump2();
			}
			if (GUI.Button(new Rect(0f, 1625f, 120f, 20f), "Gesture Crowd Pump"))
			{
				GestureCrowdPump();
			}
			if (GUI.Button(new Rect(0f, 1650f, 120f, 20f), "Gesture Cut Throat"))
			{
				GestureCutThroat();
			}
			if (GUI.Button(new Rect(0f, 1675f, 120f, 20f), "Gesture Hand Up"))
			{
				GestureHandUp();
			}
			if (GUI.Button(new Rect(0f, 1700f, 120f, 20f), "Gesture No Fear"))
			{
				GestureNoFear();
			}
			if (GUI.Button(new Rect(0f, 1725f, 120f, 20f), "Gesture Wonderful"))
			{
				GestureWonderful();
			}
			if (GUI.Button(new Rect(0f, 1750f, 120f, 20f), "Gesture Chest Pump Salute"))
			{
				GestureChestPumpSalute();
			}
			if (GUI.Button(new Rect(0f, 1775f, 120f, 20f), "Idle Sad Hips"))
			{
				IdleSadHips();
			}
			if (GUI.Button(new Rect(0f, 1800f, 120f, 20f), "Karate Greet"))
			{
				KarateGreet();
			}
			if (GUI.Button(new Rect(0f, 1825f, 120f, 20f), "Look Up"))
			{
				LookUp();
			}
			if (GUI.Button(new Rect(0f, 1850f, 120f, 20f), "Reveling"))
			{
				Reveling();
			}
			if (GUI.Button(new Rect(0f, 1875f, 120f, 20f), "Roar"))
			{
				Roar();
			}
			if (GUI.Button(new Rect(0f, 1900f, 120f, 20f), "Pointing"))
			{
				Pointing();
			}
			if (GUI.Button(new Rect(0f, 1925f, 120f, 20f), "Russian Dance"))
			{
				RussianDance();
			}
			if (GUI.Button(new Rect(0f, 1950f, 120f, 20f), "Running Dance"))
			{
				RunningDance();
			}
			if (GUI.Button(new Rect(0f, 1975f, 120f, 20f), "Sat Night Fever"))
			{
				SatNightFever();
			}
			if (GUI.Button(new Rect(0f, 2025f, 120f, 20f), "Walk Injured"))
			{
				WalkInjured();
			}
			if (GUI.Button(new Rect(0f, 2050f, 120f, 20f), "Knees Idle"))
			{
				KneesIdle();
			}
			if (GUI.Button(new Rect(0f, 2075f, 120f, 20f), "BackPack Off"))
			{
				BackPackOff();
			}
			if (GUI.Button(new Rect(0f, 2100f, 120f, 20f), "BackPackSearch"))
			{
				BackPackSearch();
			}
			if (GUI.Button(new Rect(0f, 2125f, 120f, 20f), "Idle Eat"))
			{
				IdleEat();
			}
			if (GUI.Button(new Rect(0f, 2150f, 120f, 20f), "Idle Drink"))
			{
				IdleDrink();
			}
			if (GUI.Button(new Rect(0f, 2175f, 120f, 20f), "IdleBandage"))
			{
				IdleBandage();
			}
			if (GUI.Button(new Rect(0f, 2200f, 120f, 20f), "Loser"))
			{
				Loser();
			}
			if (GUI.Button(new Rect(0f, 2225f, 120f, 20f), "Handstand"))
			{
				Handstand();
			}
			if (GUI.Button(new Rect(0f, 2250f, 120f, 20f), "ArmFlex5"))
			{
				ArmFlex5();
			}
			if (GUI.Button(new Rect(0f, 2275f, 120f, 20f), "ArmFlex6"))
			{
				ArmFlex6();
			}
			if (GUI.Button(new Rect(0f, 2300f, 120f, 20f), "BackPackGrab"))
			{
				BackPackGrab();
			}
			if (GUI.Button(new Rect(0f, 2325f, 120f, 20f), "Whistle"))
			{
				Whistle();
			}
			if (GUI.Button(new Rect(0f, 2350f, 120f, 20f), "Suicide Head Shot"))
			{
				SuicideHeadShot();
			}
			if (GUI.Button(new Rect(0f, 2375f, 120f, 20f), "Sexy Dance"))
			{
				SexyDance();
			}
			if (GUI.Button(new Rect(0f, 2400f, 120f, 20f), "Sexy Dance 2"))
			{
				SexyDance2();
			}
			if (GUI.Button(new Rect(0f, 2425f, 120f, 20f), "Sexy Dance 3"))
			{
				SexyDance3();
			}
			if (GUI.Button(new Rect(0f, 2450f, 120f, 20f), "Wall Sit"))
			{
				WallSit();
			}
			if (GUI.Button(new Rect(0f, 2475f, 120f, 20f), "WoodSaw"))
			{
				WoodSaw();
			}
			if (GUI.Button(new Rect(0f, 2500f, 120f, 20f), "BlackSmithHammer"))
			{
				BlackSmithHammer();
			}
			if (GUI.Button(new Rect(0f, 2525f, 120f, 20f), "BlackSmithForge"))
			{
				BlackSmithForge();
			}
			if (GUI.Button(new Rect(0f, 2550f, 120f, 20f), "Smoking 1"))
			{
				Smoking1();
			}
			if (GUI.Button(new Rect(0f, 2575f, 120f, 20f), "Smoking 2"))
			{
				Smoking2();
			}
			GUI.EndScrollView();
		}
		else if (idleReadybool)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 975f));
			if (GUI.Button(new Rect(0f, 0f, 100f, 20f), "Ready Fight") && animator.GetFloat("Curve") == 0f)
			{
				IdleFight();
			}
			if (GUI.Button(new Rect(0f, 25f, 100f, 20f), "Ready Crouch"))
			{
				IdleReadyCrouch();
			}
			if (GUI.Button(new Rect(0f, 50f, 100f, 20f), "Crouch 180"))
			{
				Crouch180();
			}
			if (GUI.Button(new Rect(0f, 75f, 100f, 20f), "Crouch Walk"))
			{
				CrouchWalk();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Crouch Walk Backward"))
			{
				CrouchWalkBackward();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Crouch Strafe Left"))
			{
				CrouchStrafeLeft();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Crouch Strafe Right"))
			{
				CrouchStrafeRight();
			}
			if (GUI.Button(new Rect(0f, 175f, 100f, 20f), "Ready Look"))
			{
				IdleReadyLook();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "Wizard 1 Hand Throw"))
			{
				Wizard1HandThrow();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Wizard 2 Hand Throw"))
			{
				Wizard2HandThrow();
			}
			if (GUI.Button(new Rect(0f, 250f, 150f, 20f), "Wizard Block"))
			{
				WizardBlock();
			}
			if (GUI.Button(new Rect(0f, 275f, 150f, 20f), "Wizard Overhead"))
			{
				WizardOverhead();
			}
			if (GUI.Button(new Rect(0f, 300f, 150f, 20f), "Wizard Power Up"))
			{
				WizardPowerUp();
			}
			if (GUI.Button(new Rect(0f, 325f, 150f, 20f), "Wizard Eye Beam"))
			{
				WizardEyeBeam();
			}
			if (GUI.Button(new Rect(0f, 350f, 150f, 20f), "Wizard Neo Block"))
			{
				WizardNeoBlock();
			}
			if (GUI.Button(new Rect(0f, 375f, 150f, 20f), "Idle Dodge Left"))
			{
				IdleDodgeLeft();
			}
			if (GUI.Button(new Rect(0f, 400f, 150f, 20f), "Idle Dodge Right"))
			{
				IdleDodgeRight();
			}
			if (GUI.Button(new Rect(0f, 425f, 150f, 20f), "Idle Die"))
			{
				IdleDie();
			}
			if (GUI.Button(new Rect(0f, 450f, 150f, 20f), "Idle Run"))
			{
				IdleRun();
			}
			if (GUI.Button(new Rect(0f, 475f, 150f, 20f), "Run Jump"))
			{
				RunJump();
			}
			if (GUI.Button(new Rect(0f, 500f, 150f, 20f), "Run Dive"))
			{
				RunDive();
			}
			if (GUI.Button(new Rect(0f, 525f, 150f, 20f), "Idle Fly"))
			{
				IdleFly();
			}
			if (GUI.Button(new Rect(0f, 550f, 150f, 20f), "Fly Forward"))
			{
				FlyForward();
			}
			if (GUI.Button(new Rect(0f, 575f, 150f, 20f), "Fly Backward"))
			{
				FlyBackward();
			}
			if (GUI.Button(new Rect(0f, 600f, 150f, 20f), "Fly Left"))
			{
				FlyLeft();
			}
			if (GUI.Button(new Rect(0f, 625f, 150f, 20f), "Fly Right"))
			{
				FlyRight();
			}
			if (GUI.Button(new Rect(0f, 650f, 150f, 20f), "Fly Up"))
			{
				FlyUp();
			}
			if (GUI.Button(new Rect(0f, 675f, 150f, 20f), "Fly Down"))
			{
				FlyDown();
			}
			if (GUI.Button(new Rect(0f, 700f, 120f, 20f), "Running Slide"))
			{
				IdleSlide();
			}
			if (GUI.Button(new Rect(0f, 725f, 120f, 20f), "Idle Die 2"))
			{
				IdleDie2();
			}
			if (GUI.Button(new Rect(0f, 750f, 120f, 20f), "Loot"))
			{
				Loot();
			}
			if (GUI.Button(new Rect(0f, 775f, 120f, 20f), "SneakIdle"))
			{
				SneakIdle();
			}
			if (GUI.Button(new Rect(0f, 800f, 120f, 20f), "SneakForward"))
			{
				SneakForward();
			}
			if (GUI.Button(new Rect(0f, 825f, 120f, 20f), "SneakBackward"))
			{
				SneakBackward();
			}
			if (GUI.Button(new Rect(0f, 850f, 120f, 20f), "SneakLeft"))
			{
				SneakLeft();
			}
			if (GUI.Button(new Rect(0f, 875f, 120f, 20f), "SneakRight"))
			{
				SneakRight();
			}
			if (GUI.Button(new Rect(0f, 900f, 120f, 20f), "Wall Run Left"))
			{
				WallRunLeft();
			}
			if (GUI.Button(new Rect(0f, 925f, 120f, 20f), "Wall Run Right"))
			{
				WallRunRight();
			}
			if (GUI.Button(new Rect(0f, 950f, 120f, 20f), "Roll"))
			{
				Roll();
			}
			GUI.EndScrollView();
		}
		else if (idleFightbool)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 110f), scrollPosition, new Rect(0f, 0f, 150f, 175f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Back to Idle Ready"))
			{
				IdleReady();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Front Kick"))
			{
				FrontKick();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Face Hit"))
			{
				FaceHit();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "L Hand Punch"))
			{
				LHandPunch();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "R Hand Punch"))
			{
				RHandPunch();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "360 Death"))
			{
				SpinDeath();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "RoundHouse"))
			{
				RoundHouse();
			}
			GUI.EndScrollView();
		}
		else if (weaponStandbool)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 375f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Weapon Ready"))
			{
				WeaponReady();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Weapon Instant"))
			{
				WeaponInstant();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Weapon Fire"))
			{
				WeaponFire();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Weapon Ready Fire"))
			{
				WeaponReadyFire();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Weapon Reload"))
			{
				WeaponReload();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Shotgun Fire"))
			{
				ShotgunFire();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Shotgun Ready Fire"))
			{
				ShotgunReadyFire();
			}
			if (GUI.Button(new Rect(0f, 175f, 175f, 20f), "Shotgun Reload Chamber"))
			{
				ShotgunReloadChamber();
			}
			if (GUI.Button(new Rect(0f, 200f, 175f, 20f), "Shotgun Reload Magazine"))
			{
				ShotgunReloadMagazine();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Nade Throw"))
			{
				NadeThrow();
			}
			if (GUI.Button(new Rect(0f, 250f, 150f, 20f), "Weapon Run"))
			{
				WeaponRun();
			}
			if (GUI.Button(new Rect(0f, 275f, 150f, 20f), "Weapon Strafe Run Left"))
			{
				WeaponStrafeRunLeft();
			}
			if (GUI.Button(new Rect(0f, 300f, 150f, 20f), "Weapon Strafe Run Right"))
			{
				WeaponStrafeRunRight();
			}
			if (GUI.Button(new Rect(0f, 325f, 150f, 20f), "Weapon Run Backward"))
			{
				WeaponRunBackward();
			}
			if (GUI.Button(new Rect(0f, 350f, 150f, 20f), "Weapon Stab"))
			{
				WeaponStab();
			}
			GUI.EndScrollView();
		}
		else if (pistolReadybool)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 100f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Pistol Instant"))
			{
				PistolInstant();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Pistol Fire"))
			{
				PistolFire();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Pistol Reload"))
			{
				PistolReload();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Pistol Quick Stab"))
			{
				PistolLeftHandStab();
			}
			GUI.EndScrollView();
		}
		else if (oneHandSwordIdle)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 220f, 285f), scrollPosition, new Rect(0f, 0f, 200f, 525f));
			if (GUI.Button(new Rect(0f, 0f, 200f, 20f), "1 Hand Sword Ready"))
			{
				OneHandSwordReady();
			}
			if (GUI.Button(new Rect(0f, 25f, 200f, 20f), "1 Hand Sword Swing"))
			{
				OneHandSwordSwing();
			}
			if (GUI.Button(new Rect(0f, 50f, 200f, 20f), "1 Hand Sword Back Swing"))
			{
				OneHandSwordBackSwing();
			}
			if (GUI.Button(new Rect(0f, 75f, 200f, 20f), "1 Hand Sword Jab"))
			{
				OneHandSwordJab();
			}
			if (GUI.Button(new Rect(0f, 100f, 200f, 20f), "1 Hand Sword Block"))
			{
				OneHandSwordBlock();
			}
			if (GUI.Button(new Rect(0f, 125f, 200f, 20f), "1 Hand Sword Shield Bash"))
			{
				OneHandSwordShieldBash();
			}
			if (GUI.Button(new Rect(0f, 150f, 200f, 20f), "1 Hand Sword Charge Up"))
			{
				OneHandSwordChargeUp();
			}
			if (GUI.Button(new Rect(0f, 175f, 200f, 20f), "1 H Sword Charge Heavy Bash"))
			{
				OneHandSwordChargeHeavyBash();
			}
			if (GUI.Button(new Rect(0f, 200f, 200f, 20f), "1 Hand Sword Charge Swipe"))
			{
				OneHandSwordChargeSwipe();
			}
			if (GUI.Button(new Rect(0f, 225f, 200f, 20f), "1 Hand Sword Run"))
			{
				OneHandSwordRun();
			}
			if (GUI.Button(new Rect(0f, 250f, 200f, 20f), "1 Hand Sword Strafe Left"))
			{
				OneHandSwordStrafeLeft();
			}
			if (GUI.Button(new Rect(0f, 275f, 200f, 20f), "1 Hand Sword Strafe Right"))
			{
				OneHandSwordStrafeRight();
			}
			if (GUI.Button(new Rect(0f, 300f, 200f, 20f), "1 Hand Sword Roll Attack"))
			{
				OneHandSwordRollAttack();
			}
			if (GUI.Button(new Rect(0f, 325f, 200f, 20f), "1 Hand Heavy Swing"))
			{
				OneHandHeavySwing();
			}
			if (GUI.Button(new Rect(0f, 350f, 200f, 20f), "1 Hand Heavy Swing 2"))
			{
				OneHandHeavySwing2();
			}
			if (GUI.Button(new Rect(0f, 375f, 200f, 20f), "1 Hand Heavy Overhead"))
			{
				OneHandHeavyOverhead();
			}
			if (GUI.Button(new Rect(0f, 400f, 200f, 20f), "1 Hand Small Weapon Combo"))
			{
				OneHandSmallWeaponCombo();
			}
			if (GUI.Button(new Rect(0f, 425f, 200f, 20f), "1 Hand Sword Jab Combo"))
			{
				OneHandSwordJabCombo();
			}
			if (GUI.Button(new Rect(0f, 450f, 200f, 20f), "1 Hand Sword Jab Foot Push"))
			{
				OneHandSwordJabFootPush();
			}
			if (GUI.Button(new Rect(0f, 475f, 200f, 20f), "1 Hand Sword Jab ready strafe left"))
			{
				OneHSwordStrafeLeft();
			}
			if (GUI.Button(new Rect(0f, 500f, 200f, 20f), "1 Hand Sword Jab ready strafe right"))
			{
				OneHSwordStrafeRight();
			}
			GUI.EndScrollView();
		}
		else if (bowIdle)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 100f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Bow Idle"))
			{
				BowIdle();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Bow Ready"))
			{
				BowReady();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Bow Instant"))
			{
				BowInstant();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Bow Fire"))
			{
				BowFire();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Bow Ready2"))
			{
				BowReady2();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Bow Instant2"))
			{
				BowInstant2();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Bow Fire2"))
			{
				BowFire2();
			}
			GUI.EndScrollView();
		}
		else if (motorbikeIdle)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 650f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Airwalk"))
			{
				MotorbikeAirWalk();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Backward Sitting"))
			{
				MotorbikeBackwardSitting();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Backward Sitting Cheer"))
			{
				MotorbikeBackwardSittingCheer();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Backward Stand"))
			{
				MotorbikeBackwardStand();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Handlebar Sit"))
			{
				MotorbikeHandlebarSit();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Hand stand"))
			{
				MotorbikeHandstand();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Head stand"))
			{
				MotorbikeHeadstand();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "Heart Attack"))
			{
				MotorbikeHeartAttack();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "Look Back"))
			{
				MotorbikeLookBack();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Seat Stand"))
			{
				MotorbikeSeatStand();
			}
			if (GUI.Button(new Rect(0f, 250f, 150f, 20f), "Seat Stand Wheely"))
			{
				MotorbikeSeatStandWheely();
			}
			if (GUI.Button(new Rect(0f, 275f, 150f, 20f), "Wheely"))
			{
				MotorbikeWheely();
			}
			if (GUI.Button(new Rect(0f, 300f, 150f, 20f), "Wheely No Hands"))
			{
				MotorbikeWheelyNoHands();
			}
			if (GUI.Button(new Rect(0f, 325f, 150f, 20f), "Lasso"))
			{
				MotorbikeLasso();
			}
			if (GUI.Button(new Rect(0f, 350f, 150f, 20f), "Lasso Forward"))
			{
				MotorbikeLassoFwd();
			}
			if (GUI.Button(new Rect(0f, 375f, 150f, 20f), "Lasso Back"))
			{
				MotorbikeLassoBack();
			}
			if (GUI.Button(new Rect(0f, 400f, 150f, 20f), "Lasso Left"))
			{
				MotorbikeLassoLeft();
			}
			if (GUI.Button(new Rect(0f, 425f, 150f, 20f), "Lasso Right"))
			{
				MotorbikeLassoRight();
			}
			if (GUI.Button(new Rect(0f, 450f, 150f, 20f), "Shoot Back"))
			{
				MotorbikeShootBack();
			}
			if (GUI.Button(new Rect(0f, 475f, 150f, 20f), "Shoot Forward"))
			{
				MotorbikeShootFwd();
			}
			if (GUI.Button(new Rect(0f, 500f, 150f, 20f), "Shoot Left"))
			{
				MotorbikeShootLeft();
			}
			if (GUI.Button(new Rect(0f, 525f, 150f, 20f), "Shoot Right"))
			{
				MotorbikeShootRight();
			}
			if (GUI.Button(new Rect(0f, 550f, 150f, 20f), "Turn Left"))
			{
				MotorbikeTurnLeft();
			}
			if (GUI.Button(new Rect(0f, 575f, 150f, 20f), "Turn Right"))
			{
				MotorbikeTurnRight();
			}
			if (GUI.Button(new Rect(0f, 600f, 150f, 20f), "Special Flip"))
			{
				MotorbikeSpecialFlip();
			}
			if (GUI.Button(new Rect(0f, 625f, 150f, 20f), "Superman"))
			{
				MotorbikeSuperman();
			}
			GUI.EndScrollView();
		}
		else if (rollerBlade)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 275f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Roller Blade Roll"))
			{
				RollerBladeRoll();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Roller Blade Stop"))
			{
				RollerBladeStop();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Roller Blade Jump"))
			{
				RollerBladeJump();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Roller Crossover Right"))
			{
				RollerBladeCrossoverRight();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Roller Crossover Left"))
			{
				RollerBladeCrossoverLeft();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Roller Blade Back Flip"))
			{
				RollerBladeBackFlip();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Roller Blade Front Flip"))
			{
				RollerBladeFrontFlip();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "Roller Blade Skate Fwd"))
			{
				RollerBladeSkateFwd();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "Roller Blade Turn Left"))
			{
				RollerBladeTurnLeft();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Roller Blade Turn Right"))
			{
				RollerBladeTurnRight();
			}
			if (GUI.Button(new Rect(0f, 250f, 150f, 20f), "Roller Blade Grind Royale"))
			{
				RollerBladeGrindRoyale();
			}
			GUI.EndScrollView();
		}
		else if (skateboard)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 50f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Skateboard Idle"))
			{
				SkateboardIdle();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "SkateboardKickPush"))
			{
				SkateboardKickPush();
			}
			GUI.EndScrollView();
		}
		else if (climbing)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 100f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Climbing Idle"))
			{
				ClimbIdle();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Climb Up"))
			{
				ClimbUp();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Climb Left"))
			{
				ClimbLeft();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Climb Right"))
			{
				ClimbRight();
			}
			GUI.EndScrollView();
		}
		else if (office)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 300f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Sitting Idle"))
			{
				OfficeSitting();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Sitting Leg Cross"))
			{
				OfficeSittingLegCross();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Sitting 45 Degress leg"))
			{
				OfficeSitting45DegLeg();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Sitting 1 Leg Straight"))
			{
				OfficeSitting1LegStraight();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Sitting Eyes Rub"))
			{
				OfficeSittingEyesRub();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Sitting Hand Rest Finger Tap"))
			{
				OfficeSittingHandRestFingerTap();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Sitting Mouse Movement"))
			{
				OfficeSittingMouseMovement();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "Sitting Reading"))
			{
				OfficeSittingReading();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "Sitting Reading Lean Back"))
			{
				OfficeSittingReadingLeanBack();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Sitting Reading Page Flip"))
			{
				OfficeSittingReadingPageFlip();
			}
			if (GUI.Button(new Rect(0f, 250f, 150f, 20f), "Sitting Reading Coffee Sip"))
			{
				OfficeSittingReadingCoffeeSip();
			}
			if (GUI.Button(new Rect(0f, 275f, 120f, 20f), "Sewing"))
			{
				Sewing();
			}
			GUI.EndScrollView();
		}
		else if (swim)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 275f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Swim Idle"))
			{
				Swim();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Swim Freestyle"))
			{
				SwimFreestyle();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Swim Dog Paddle"))
			{
				SwimDogPaddle();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Scuba Swim"))
			{
				ScubaSwim();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Scuba OK"))
			{
				ScubaOK();
			}
			GUI.EndScrollView();
		}
		else if (wand)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 275f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Wand Stand"))
			{
				WandStand();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Wand Attack"))
			{
				WandAttack();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Wand Attack 2"))
			{
				WandAttack2();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Staff Stand"))
			{
				StaffStand();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Staff Attack"))
			{
				StaffAttack();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Staff Heal"))
			{
				StaffHeal();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Staff Power Up"))
			{
				StaffPowerUp();
			}
			GUI.EndScrollView();
		}
		else if (cards)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 125f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Dealer Idle"))
			{
				DealerIdle();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Dealer Shuffle"))
			{
				DealerShuffle();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Dealer Fan"))
			{
				DealerFan();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Card Player Idle"))
			{
				CardPlayerIdle();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Card Player Look"))
			{
				CardPlayerLook();
			}
			GUI.EndScrollView();
		}
		else if (breakdance)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 125f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Six Step"))
			{
				SixStep();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "2000"))
			{
				TwoThousand();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Deadman Float"))
			{
				DeadmanFloat();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Flares"))
			{
				Flares();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Criticals"))
			{
				Criticals();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Windmill"))
			{
				Windmill();
			}
			GUI.EndScrollView();
		}
		else if (katana)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 125f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Katana Ninja Draw"))
			{
				KatanaNinjaDraw();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Katana Ready"))
			{
				KatanaReady();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Katana Ready High"))
			{
				KatanaReadyHigh();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Katana Ready Low"))
			{
				KatanaReadyLow();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Katana Vertical Swing"))
			{
				KatanaVerticalSwing();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Katana 45Deg Swing"))
			{
				Katana45DegSwing();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Katana Horizontal Swing"))
			{
				KatanaHorizontalSwing();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "Katana Upper Block"))
			{
				KatanaUpperBlock();
			}
			GUI.EndScrollView();
		}
		else if (soccer)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 400f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Keeper Ready"))
			{
				SoccerKeeperReady();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Keeper Strafe Right"))
			{
				SoccerKeeperStrafeRight();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Keeper Strafe Left"))
			{
				SoccerKeeperStrafeLeft();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Keeper Jump"))
			{
				SoccerKeeperJump();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "Keeper Strafe Dive Far Left"))
			{
				SoccerKeeperStrafeDiveFarLeft();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "Keeper Strafe Dive Far Right"))
			{
				SoccerKeeperStrafeDiveFarRight();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Keeper Strafe Dive Close Left"))
			{
				SoccerKeeperStrafeDiveCloseLeft();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "Keeper Strafe Dive Close Right"))
			{
				SoccerKeeperStrafeDiveCloseRight();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "Soccer Throw"))
			{
				SoccerThrow();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Soccer Tackle"))
			{
				SoccerTackle();
			}
			if (GUI.Button(new Rect(0f, 250f, 150f, 20f), "Soccer Walk"))
			{
				SoccerWalk();
			}
			if (GUI.Button(new Rect(0f, 275f, 150f, 20f), "Soccer Start Kick"))
			{
				SoccerStartKick();
			}
			if (GUI.Button(new Rect(0f, 300f, 150f, 20f), "Soccer Sprint"))
			{
				SoccerSprint();
			}
			if (GUI.Button(new Rect(0f, 325f, 150f, 20f), "Soccer Run"))
			{
				SoccerRun();
			}
			if (GUI.Button(new Rect(0f, 350f, 150f, 20f), "Soccer Pass Heavy"))
			{
				SoccerPassHeavy();
			}
			if (GUI.Button(new Rect(0f, 375f, 150f, 20f), "Soccer Pass Light"))
			{
				SoccerPassLight();
			}
			GUI.EndScrollView();
		}
		else if (giant)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 275f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Giant 2 Hand Slam Idle"))
			{
				Giant2HandSlamIdle();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Giant 2 Hand Slam Swing"))
			{
				Giant2HandSlamSwing();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Giant 3 Hit Combo"))
			{
				Giant3HitCombo();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Giant 3 Hit Combo 2"))
			{
				Giant3HitCombo2();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "GiantGrabIdle"))
			{
				GiantGrabIdle();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "GiantGrabIdle2"))
			{
				GiantGrabIdle2();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "Giant Grab Throw"))
			{
				GiantGrabThrow();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "Giant Grab Throw 2"))
			{
				GiantGrabThrow2();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "Giant Eat"))
			{
				GiantEat();
			}
			if (GUI.Button(new Rect(0f, 225f, 150f, 20f), "Giant 2 Hand Grab/Throw"))
			{
				Giant2HandGrab();
			}
			GUI.EndScrollView();
		}
		else if (zombie)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 125f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "Zombie Idle"))
			{
				Zombie();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "Zombie Idle 2"))
			{
				ZombieIdle2();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "Zombie Walk"))
			{
				ZombieWalk();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "Zombie Crawl"))
			{
				ZombieCrawl();
			}
			GUI.EndScrollView();
		}
		else if (iceHockey)
		{
			scrollPosition = GUI.BeginScrollView(new Rect(150f, 10f, 180f, 285f), scrollPosition, new Rect(0f, 0f, 150f, 250f));
			if (GUI.Button(new Rect(0f, 0f, 150f, 20f), "IceHockey Idle"))
			{
				IceHockeyIdle();
			}
			if (GUI.Button(new Rect(0f, 25f, 150f, 20f), "IceHockey Deke Middle"))
			{
				IceHockeyDekeMiddle();
			}
			if (GUI.Button(new Rect(0f, 50f, 150f, 20f), "IceHockey Goalie Ready"))
			{
				IceHockeyGoalieReady();
			}
			if (GUI.Button(new Rect(0f, 75f, 150f, 20f), "IceHockey Pass Left"))
			{
				IceHockeyPassLeft();
			}
			if (GUI.Button(new Rect(0f, 100f, 150f, 20f), "IceHockey Pass Right"))
			{
				IceHockeyPassRight();
			}
			if (GUI.Button(new Rect(0f, 125f, 150f, 20f), "IceHockey Shot Left"))
			{
				IceHockeyShotLeft();
			}
			if (GUI.Button(new Rect(0f, 150f, 150f, 20f), "IceHockey Shot Right"))
			{
				IceHockeyShotRight();
			}
			if (GUI.Button(new Rect(0f, 175f, 150f, 20f), "IceHockey Goalie Save 2"))
			{
				IceHockeyGoalieSave1();
			}
			if (GUI.Button(new Rect(0f, 200f, 150f, 20f), "IceHockey Goalie Save 2"))
			{
				IceHockeyGoalieSave2();
			}
			GUI.EndScrollView();
		}
	}

	private void IceHockeyGoalieSave2()
	{
		IceHockeyGoalieReady();
		animator.SetTrigger("IceHockeyGoalieSave2");
		animator2.SetTrigger("IceHockeyGoalieSave2");
		animator3.SetTrigger("IceHockeyGoalieSave2");
	}

	private void IceHockeyGoalieSave1()
	{
		IceHockeyGoalieReady();
		animator.SetTrigger("IceHockeyGoalieSave1");
		animator2.SetTrigger("IceHockeyGoalieSave1");
		animator3.SetTrigger("IceHockeyGoalieSave1");
	}

	private void IceHockeyShotRight()
	{
		IceHockeyDekeMiddle();
		animator.SetTrigger("IceHockeyShotRight");
		animator2.SetTrigger("IceHockeyShotRight");
		animator3.SetTrigger("IceHockeyShotRight");
	}

	private void IceHockeyShotLeft()
	{
		IceHockeyDekeMiddle();
		animator.SetTrigger("IceHockeyShotLeft");
		animator2.SetTrigger("IceHockeyShotLeft");
		animator3.SetTrigger("IceHockeyShotLeft");
	}

	private void IceHockeyPassRight()
	{
		IceHockeyDekeMiddle();
		animator.SetTrigger("IceHockeyPassRight");
		animator2.SetTrigger("IceHockeyPassRight");
		animator3.SetTrigger("IceHockeyPassRight");
	}

	private void IceHockeyPassLeft()
	{
		IceHockeyDekeMiddle();
		animator.SetTrigger("IceHockeyPassLeft");
		animator2.SetTrigger("IceHockeyPassLeft");
		animator3.SetTrigger("IceHockeyPassLeft");
	}

	private void IceHockeyGoalieReady()
	{
		IceHockeyIdle();
		animator.SetBool("IceHockeyGoalieReady", value: true);
		animator2.SetBool("IceHockeyGoalieReady", value: true);
		animator3.SetBool("IceHockeyGoalieReady", value: true);
	}

	private void IceHockeyDekeMiddle()
	{
		IceHockeyIdle();
		animator.SetBool("IceHockeyDekeMiddle", value: true);
		animator2.SetBool("IceHockeyDekeMiddle", value: true);
		animator3.SetBool("IceHockeyDekeMiddle", value: true);
	}

	private void IceHockeyIdle()
	{
		Falses();
		iceHockey = true;
		animator.SetBool("IdleStand", value: true);
		animator2.SetBool("IdleStand", value: true);
		animator3.SetBool("IdleStand", value: true);
		animator.SetBool("IceHockeyIdle", value: true);
		animator2.SetBool("IceHockeyIdle", value: true);
		animator3.SetBool("IceHockeyIdle", value: true);
	}

	private void Smoking2()
	{
		IdleStand();
		animator.SetTrigger("Smoking2");
		animator2.SetTrigger("Smoking2");
		animator3.SetTrigger("Smoking2");
	}

	private void Smoking1()
	{
		IdleStand();
		animator.SetTrigger("Smoking1");
		animator2.SetTrigger("Smoking1");
		animator3.SetTrigger("Smoking1");
	}

	private void OneHSwordStrafeLeft()
	{
		OneHandSwordReady();
		animator.SetBool("1HandSwordStrafeLeft", value: true);
		animator2.SetBool("1HandSwordStrafeLeft", value: true);
		animator3.SetBool("1HandSwordStrafeLeft", value: true);
	}

	private void OneHSwordStrafeRight()
	{
		OneHandSwordReady();
		animator.SetBool("1HandSwordStrafeRight", value: true);
		animator2.SetBool("1HandSwordStrafeRight", value: true);
		animator3.SetBool("1HandSwordStrafeRight", value: true);
	}

	private void WeaponStab()
	{
		WeaponReady();
		animator.SetTrigger("WeaponStab");
		animator2.SetTrigger("WeaponStab");
		animator3.SetTrigger("WeaponStab");
	}

	private void Giant2HandGrab()
	{
		Giant();
		animator.SetTrigger("Giant2HandGrab");
		animator2.SetTrigger("Giant2HandGrab");
		animator3.SetTrigger("Giant2HandGrab");
	}

	private void ZombieCrawl()
	{
		ZombieWalk();
		animator.SetBool("ZombieCrawl", value: true);
		animator2.SetBool("ZombieCrawl", value: true);
		animator3.SetBool("ZombieCrawl", value: true);
	}

	private void ZombieWalk()
	{
		Zombie();
		animator.SetBool("ZombieWalk", value: true);
		animator2.SetBool("ZombieWalk", value: true);
		animator3.SetBool("ZombieWalk", value: true);
	}

	private void ZombieIdle2()
	{
		Zombie();
		animator.SetTrigger("ZombieIdle2");
		animator2.SetTrigger("ZombieIdle2");
		animator3.SetTrigger("ZombieIdle2");
	}

	private void Zombie()
	{
		Falses();
		zombie = true;
		animator.SetBool("IdleStand", value: true);
		animator2.SetBool("IdleStand", value: true);
		animator3.SetBool("IdleStand", value: true);
		animator.SetBool("ZombieIdle", value: true);
		animator2.SetBool("ZombieIdle", value: true);
		animator3.SetBool("ZombieIdle", value: true);
	}

	private void BlackSmithForge()
	{
		IdleStand();
		animator.SetTrigger("BlackSmithForge");
		animator2.SetTrigger("BlackSmithForge");
		animator3.SetTrigger("BlackSmithForge");
	}

	private void BlackSmithHammer()
	{
		IdleStand();
		animator.SetBool("BlackSmithHammer", value: true);
		animator2.SetBool("BlackSmithHammer", value: true);
		animator3.SetBool("BlackSmithHammer", value: true);
	}

	private void WoodSaw()
	{
		IdleStand();
		animator.SetBool("WoodSaw", value: true);
		animator2.SetBool("WoodSaw", value: true);
		animator3.SetBool("WoodSaw", value: true);
	}

	private void GiantEat()
	{
		GiantGrabIdle();
		animator.SetTrigger("GiantEat");
		animator2.SetTrigger("GiantEat");
		animator3.SetTrigger("GiantEat");
	}

	private void GiantGrabThrow2()
	{
		GiantGrabIdle2();
		animator.SetTrigger("GiantGrabThrow2");
		animator2.SetTrigger("GiantGrabThrow2");
		animator3.SetTrigger("GiantGrabThrow2");
	}

	private void GiantGrabThrow()
	{
		GiantGrabIdle2();
		animator.SetTrigger("GiantGrabThrow");
		animator2.SetTrigger("GiantGrabThrow");
		animator3.SetTrigger("GiantGrabThrow");
	}

	private void GiantGrabIdle()
	{
		Giant();
		animator.SetBool("GiantGrabIdle", value: true);
		animator2.SetBool("GiantGrabIdle", value: true);
		animator3.SetBool("GiantGrabIdle", value: true);
	}

	private void GiantGrabIdle2()
	{
		Giant();
		animator.SetBool("GiantGrabIdle2", value: true);
		animator2.SetBool("GiantGrabIdle2", value: true);
		animator3.SetBool("GiantGrabIdle2", value: true);
	}

	private void Giant3HitCombo2()
	{
		Giant();
		animator.SetTrigger("Giant3HitCombo2");
		animator2.SetTrigger("Giant3HitCombo2");
		animator3.SetTrigger("Giant3HitCombo2");
	}

	private void Giant3HitCombo()
	{
		Giant();
		animator.SetTrigger("Giant3HitCombo");
		animator2.SetTrigger("Giant3HitCombo");
		animator3.SetTrigger("Giant3HitCombo");
	}

	private void Giant2HandSlamSwing()
	{
		Giant2HandSlamIdle();
		animator.SetTrigger("Giant2HandSlamSwing");
		animator2.SetTrigger("Giant2HandSlamSwing");
		animator3.SetTrigger("Giant2HandSlamSwing");
	}

	private void Giant2HandSlamIdle()
	{
		Giant();
		animator.SetBool("Giant2HandSlamIdle", value: true);
		animator2.SetBool("Giant2HandSlamIdle", value: true);
		animator3.SetBool("Giant2HandSlamIdle", value: true);
	}

	private void Giant()
	{
		Falses();
		giant = true;
		animator.SetBool("IdleStand", value: true);
		animator2.SetBool("IdleStand", value: true);
		animator3.SetBool("IdleStand", value: true);
	}

	private void SuicideHeadShot()
	{
		IdleStand();
		animator.SetTrigger("SuicideHeadShot");
		animator2.SetTrigger("SuicideHeadShot");
		animator3.SetTrigger("SuicideHeadShot");
	}

	private void SexyDance()
	{
		IdleStand();
		animator.SetTrigger("SexyDance");
		animator2.SetTrigger("SexyDance");
		animator3.SetTrigger("SexyDance");
	}

	private void SexyDance2()
	{
		IdleStand();
		animator.SetTrigger("SexyDance2");
		animator2.SetTrigger("SexyDance2");
		animator3.SetTrigger("SexyDance2");
	}

	private void SexyDance3()
	{
		IdleStand();
		animator.SetTrigger("SexyDance3");
		animator2.SetTrigger("SexyDance3");
		animator3.SetTrigger("SexyDance3");
	}

	private void IceHockeySlapShot()
	{
		IdleStand();
		animator.SetTrigger("IceHockeySlapShot");
		animator2.SetTrigger("IceHockeySlapShot");
		animator3.SetTrigger("IceHockeySlapShot");
	}

	private void WallSit()
	{
		IdleStand();
		animator.SetBool("WallSit", value: true);
		animator2.SetBool("WallSit", value: true);
		animator3.SetBool("WallSit", value: true);
	}

	private void Whistle()
	{
		IdleStand();
		animator.SetTrigger("Whistle");
		animator2.SetTrigger("Whistle");
		animator3.SetTrigger("Whistle");
	}

	private void OneHandHeavySwing()
	{
		OneHandSwordReady();
		animator.SetTrigger("1HandHeavySwing");
		animator2.SetTrigger("1HandHeavySwing");
		animator3.SetTrigger("1HandHeavySwing");
	}

	private void OneHandHeavySwing2()
	{
		OneHandSwordReady();
		animator.SetTrigger("1HandHeavySwing2");
		animator2.SetTrigger("1HandHeavySwing2");
		animator3.SetTrigger("1HandHeavySwing2");
	}

	private void OneHandHeavyOverhead()
	{
		OneHandSwordReady();
		animator.SetTrigger("1HandHeavyOverhead");
		animator2.SetTrigger("1HandHeavyOverhead");
		animator3.SetTrigger("1HandHeavyOverhead");
	}

	private void OneHandSmallWeaponCombo()
	{
		OneHandSwordReady();
		animator.SetTrigger("1HandSmallWeaponCombo");
		animator2.SetTrigger("1HandSmallWeaponCombo");
		animator3.SetTrigger("1HandSmallWeaponCombo");
	}

	private void OneHandSwordJabCombo()
	{
		OneHandSwordReady();
		animator.SetTrigger("1HandSwordJabCombo");
		animator2.SetTrigger("1HandSwordJabCombo");
		animator3.SetTrigger("1HandSwordJabCombo");
	}

	private void OneHandSwordJabFootPush()
	{
		OneHandSwordReady();
		animator.SetTrigger("1HandSwordJabFootPush");
		animator2.SetTrigger("1HandSwordJabFootPush");
		animator3.SetTrigger("1HandSwordJabFootPush");
	}

	private void Loser()
	{
		IdleStand();
		animator.SetTrigger("Loser");
		animator2.SetTrigger("Loser");
		animator3.SetTrigger("Loser");
	}

	private void Handstand()
	{
		IdleStand();
		animator.SetTrigger("Handstand");
		animator2.SetTrigger("Handstand");
		animator3.SetTrigger("Handstand");
	}

	private void ArmFlex5()
	{
		IdleStand();
		animator.SetTrigger("ArmFlex5");
		animator2.SetTrigger("ArmFlex5");
		animator3.SetTrigger("ArmFlex5");
	}

	private void ArmFlex6()
	{
		IdleStand();
		animator.SetTrigger("ArmFlex6");
		animator2.SetTrigger("ArmFlex6");
		animator3.SetTrigger("ArmFlex6");
	}

	private void BackPackGrab()
	{
		IdleStand();
		animator.SetTrigger("BackPackGrab");
		animator2.SetTrigger("BackPackGrab");
		animator3.SetTrigger("BackPackGrab");
	}

	private void Roll()
	{
		IdleRun();
		animator.SetTrigger("Roll");
		animator2.SetTrigger("Roll");
		animator3.SetTrigger("Roll");
	}

	private void WallRunRight()
	{
		IdleRun();
		animator.SetBool("WallRunRight", value: true);
		animator2.SetBool("WallRunRight", value: true);
		animator3.SetBool("WallRunRight", value: true);
	}

	private void WallRunLeft()
	{
		IdleRun();
		animator.SetBool("WallRunLeft", value: true);
		animator2.SetBool("WallRunLeft", value: true);
		animator3.SetBool("WallRunLeft", value: true);
	}

	private void ScubaOK()
	{
		animator.SetTrigger("ScubaOK");
		animator2.SetTrigger("ScubaOK");
		animator3.SetTrigger("ScubaOK");
	}

	private void ScubaSwim()
	{
		Swim();
		animator.SetBool("ScubaSwim", value: true);
		animator2.SetBool("ScubaSwim", value: true);
		animator3.SetBool("ScubaSwim", value: true);
	}

	private void RoundHouse()
	{
		IdleFight();
		animator.SetTrigger("RoundHouse");
		animator2.SetTrigger("RoundHouse");
		animator3.SetTrigger("RoundHouse");
	}

	private void IdleEat()
	{
		IdleStand();
		animator.SetTrigger("IdleEat");
		animator2.SetTrigger("IdleEat");
		animator3.SetTrigger("IdleEat");
	}

	private void IdleDrink()
	{
		IdleStand();
		animator.SetTrigger("IdleDrink");
		animator2.SetTrigger("IdleDrink");
		animator3.SetTrigger("IdleDrink");
	}

	private void IdleBandage()
	{
		IdleStand();
		animator.SetTrigger("IdleBandage");
		animator2.SetTrigger("IdleBandage");
		animator3.SetTrigger("IdleBandage");
	}

	private void BackPackSearch()
	{
		BackPackOff();
		animator.SetTrigger("BackPackSearch");
		animator2.SetTrigger("BackPackSearch");
		animator3.SetTrigger("BackPackSearch");
	}

	private void BackPackOff()
	{
		IdleStand();
		animator.SetBool("BackPackOff", value: true);
		animator2.SetBool("BackPackOff", value: true);
		animator3.SetBool("BackPackOff", value: true);
	}

	private void SneakRight()
	{
		SneakIdle();
		animator.SetBool("SneakRight", value: true);
		animator2.SetBool("SneakRight", value: true);
		animator3.SetBool("SneakRight", value: true);
	}

	private void SneakLeft()
	{
		SneakIdle();
		animator.SetBool("SneakLeft", value: true);
		animator2.SetBool("SneakLeft", value: true);
		animator3.SetBool("SneakLeft", value: true);
	}

	private void SneakBackward()
	{
		SneakIdle();
		animator.SetBool("SneakBackward", value: true);
		animator2.SetBool("SneakBackward", value: true);
		animator3.SetBool("SneakBackward", value: true);
	}

	private void SneakForward()
	{
		SneakIdle();
		animator.SetBool("SneakForward", value: true);
		animator2.SetBool("SneakForward", value: true);
		animator3.SetBool("SneakForward", value: true);
	}

	private void SneakIdle()
	{
		IdleReady();
		animator.SetBool("SneakIdle", value: true);
		animator2.SetBool("SneakIdle", value: true);
		animator3.SetBool("SneakIdle", value: true);
	}

	private void SoccerPassHeavy()
	{
		SoccerRun();
		animator.SetTrigger("SoccerPassHeavy");
		animator2.SetTrigger("SoccerPassHeavy");
		animator3.SetTrigger("SoccerPassHeavy");
	}

	private void SoccerPassLight()
	{
		SoccerRun();
		animator.SetTrigger("SoccerPassLight");
		animator2.SetTrigger("SoccerPassLight");
		animator3.SetTrigger("SoccerPassLight");
	}

	private void SoccerRun()
	{
		Soccer();
		animator.SetBool("SoccerRun", value: true);
		animator2.SetBool("SoccerRun", value: true);
		animator3.SetBool("SoccerRun", value: true);
	}

	private void SoccerSprint()
	{
		Soccer();
		animator.SetBool("SoccerSprint", value: true);
		animator2.SetBool("SoccerSprint", value: true);
		animator3.SetBool("SoccerSprint", value: true);
	}

	private void SoccerStartKick()
	{
		Soccer();
		animator.SetTrigger("SoccerStartKick");
		animator2.SetTrigger("SoccerStartKick");
		animator3.SetTrigger("SoccerStartKick");
	}

	private void SoccerWalk()
	{
		Soccer();
		animator.SetBool("SoccerWalk", value: true);
		animator2.SetBool("SoccerWalk", value: true);
		animator3.SetBool("SoccerWalk", value: true);
	}

	private void SoccerTackle()
	{
		Soccer();
		animator.SetTrigger("SoccerTackle");
		animator2.SetTrigger("SoccerTackle");
		animator3.SetTrigger("SoccerTackle");
	}

	private void SoccerThrow()
	{
		Soccer();
		animator.SetTrigger("SoccerThrow");
		animator2.SetTrigger("SoccerThrow");
		animator3.SetTrigger("SoccerThrow");
	}

	private void Soccer()
	{
		Falses();
		soccer = true;
		animator.SetBool("IdleStand", value: true);
		animator2.SetBool("IdleStand", value: true);
		animator3.SetBool("IdleStand", value: true);
	}

	private void SoccerKeeperReady()
	{
		Soccer();
		animator.SetBool("SoccerKeeperReady", value: true);
		animator2.SetBool("SoccerKeeperReady", value: true);
		animator3.SetBool("SoccerKeeperReady", value: true);
	}

	private void SoccerKeeperStrafeRight()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperStrafeRight");
		animator2.SetTrigger("SoccerKeeperStrafeRight");
		animator3.SetTrigger("SoccerKeeperStrafeRight");
	}

	private void SoccerKeeperStrafeLeft()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperStrafeLeft");
		animator2.SetTrigger("SoccerKeeperStrafeLeft");
		animator3.SetTrigger("SoccerKeeperStrafeLeft");
	}

	private void SoccerKeeperJump()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperJump");
		animator2.SetTrigger("SoccerKeeperJump");
		animator3.SetTrigger("SoccerKeeperJump");
	}

	private void SoccerKeeperStrafeDiveFarLeft()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperDiveStrafeFarLeft");
		animator2.SetTrigger("SoccerKeeperDiveStrafeFarLeft");
		animator3.SetTrigger("SoccerKeeperDiveStrafeFarLeft");
	}

	private void SoccerKeeperStrafeDiveFarRight()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperDiveStrafeFarRight");
		animator2.SetTrigger("SoccerKeeperDiveStrafeFarRight");
		animator3.SetTrigger("SoccerKeeperDiveStrafeFarRight");
	}

	private void SoccerKeeperStrafeDiveCloseLeft()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperDiveStrafeCloseLeft");
		animator2.SetTrigger("SoccerKeeperDiveStrafeCloseLeft");
		animator3.SetTrigger("SoccerKeeperDiveStrafeCloseLeft");
	}

	private void SoccerKeeperStrafeDiveCloseRight()
	{
		SoccerKeeperReady();
		animator.SetTrigger("SoccerKeeperDiveStrafeCloseRight");
		animator2.SetTrigger("SoccerKeeperDiveStrafeCloseRight");
		animator3.SetTrigger("SoccerKeeperDiveStrafeCloseRight");
	}

	private void Katana45DegSwing()
	{
		animator.SetTrigger("Katana45DegSwing");
		animator2.SetTrigger("Katana45DegSwing");
		animator3.SetTrigger("Katana45DegSwing");
	}

	private void KatanaHorizontalSwing()
	{
		animator.SetTrigger("KatanaHorizontalSwing");
		animator2.SetTrigger("KatanaHorizontalSwing");
		animator3.SetTrigger("KatanaHorizontalSwing");
	}

	private void KatanaUpperBlock()
	{
		animator.SetTrigger("KatanaUpperBlock");
		animator2.SetTrigger("KatanaUpperBlock");
		animator3.SetTrigger("KatanaUpperBlock");
	}

	private void KatanaVerticalSwing()
	{
		animator.SetTrigger("KatanaVerticalSwing");
		animator2.SetTrigger("KatanaVerticalSwing");
		animator3.SetTrigger("KatanaVerticalSwing");
	}

	private void KatanaReadyLow()
	{
		katana = true;
		animator.SetBool("KatanaReadyHigh", value: false);
		animator2.SetBool("KatanaReadyHigh", value: false);
		animator3.SetBool("KatanaReadyHigh", value: false);
		animator.SetBool("KatanaReady", value: false);
		animator2.SetBool("KatanaReady", value: false);
		animator3.SetBool("KatanaReady", value: false);
		animator.SetBool("KatanaReadyLow", value: true);
		animator2.SetBool("KatanaReadyLow", value: true);
		animator3.SetBool("KatanaReadyLow", value: true);
	}

	private void KatanaReadyHigh()
	{
		katana = true;
		animator.SetBool("KatanaReadyHigh", value: true);
		animator2.SetBool("KatanaReadyHigh", value: true);
		animator3.SetBool("KatanaReadyHigh", value: true);
		animator.SetBool("KatanaReady", value: false);
		animator2.SetBool("KatanaReady", value: false);
		animator3.SetBool("KatanaReady", value: false);
		animator.SetBool("KatanaReadyLow", value: false);
		animator2.SetBool("KatanaReadyLow", value: false);
		animator3.SetBool("KatanaReadyLow", value: false);
	}

	private void KatanaReady()
	{
		katana = true;
		animator.SetBool("KatanaReadyHigh", value: false);
		animator2.SetBool("KatanaReadyHigh", value: false);
		animator3.SetBool("KatanaReadyHigh", value: false);
		animator.SetBool("KatanaReady", value: true);
		animator2.SetBool("KatanaReady", value: true);
		animator3.SetBool("KatanaReady", value: true);
		animator.SetBool("KatanaReadyLow", value: false);
		animator2.SetBool("KatanaReadyLow", value: false);
		animator3.SetBool("KatanaReadyLow", value: false);
	}

	private void KatanaNinjaDraw()
	{
		IdleStand();
		Falses();
		katana = true;
		animator.SetTrigger("KatanaNinjaDraw");
		animator2.SetTrigger("KatanaNinjaDraw");
		animator3.SetTrigger("KatanaNinjaDraw");
		KatanaReady();
		animator.SetBool("Katana", value: true);
		animator2.SetBool("Katana", value: true);
		animator3.SetBool("Katana", value: true);
	}

	private void KneesIdle()
	{
		IdleStand();
		animator.SetBool("KneesIdle", value: true);
		animator2.SetBool("KneesIdle", value: true);
		animator3.SetBool("KneesIdle", value: true);
	}

	private void WalkInjured()
	{
		IdleStand();
		animator.SetBool("WalkInjured", value: true);
		animator2.SetBool("WalkInjured", value: true);
		animator3.SetBool("WalkInjured", value: true);
	}

	private void SatNightFever()
	{
		IdleStand();
		animator.SetBool("SatNightFever", value: true);
		animator2.SetBool("SatNightFever", value: true);
		animator3.SetBool("SatNightFever", value: true);
	}

	private void RunningDance()
	{
		IdleStand();
		animator.SetBool("RunningDance", value: true);
		animator2.SetBool("RunningDance", value: true);
		animator3.SetBool("RunningDance", value: true);
	}

	private void RussianDance()
	{
		IdleStand();
		animator.SetBool("RussianDance", value: true);
		animator2.SetBool("RussianDance", value: true);
		animator3.SetBool("RussianDance", value: true);
	}

	private void Sewing()
	{
		OfficeSittingLegCross();
		animator.SetTrigger("Sewing");
		animator2.SetTrigger("Sewing");
		animator3.SetTrigger("Sewing");
	}

	private void Pointing()
	{
		IdleStand();
		animator.SetTrigger("Pointing");
		animator2.SetTrigger("Pointing");
		animator3.SetTrigger("Pointing");
	}

	private void Roar()
	{
		IdleStand();
		animator.SetTrigger("Roar");
		animator2.SetTrigger("Roar");
		animator3.SetTrigger("Roar");
	}

	private void Reveling()
	{
		IdleStand();
		animator.SetTrigger("Reveling");
		animator2.SetTrigger("Reveling");
		animator3.SetTrigger("Reveling");
	}

	private void LookUp()
	{
		IdleStand();
		animator.SetTrigger("LookUp");
		animator2.SetTrigger("LookUp");
		animator3.SetTrigger("LookUp");
	}

	private void KarateGreet()
	{
		IdleStand();
		animator.SetTrigger("KarateGreet");
		animator2.SetTrigger("KarateGreet");
		animator3.SetTrigger("KarateGreet");
	}

	private void IdleSadHips()
	{
		IdleStand();
		animator.SetTrigger("IdleSadHips");
		animator2.SetTrigger("IdleSadHips");
		animator3.SetTrigger("IdleSadHips");
	}

	private void GestureChestPumpSalute()
	{
		IdleStand();
		animator.SetTrigger("GestureChestPumpSalute");
		animator2.SetTrigger("GestureChestPumpSalute");
		animator3.SetTrigger("GestureChestPumpSalute");
	}

	private void GestureWonderful()
	{
		IdleStand();
		animator.SetTrigger("GestureWonderful");
		animator2.SetTrigger("GestureWonderful");
		animator3.SetTrigger("GestureWonderful");
	}

	private void GestureNoFear()
	{
		IdleStand();
		animator.SetTrigger("GestureNoFear");
		animator2.SetTrigger("GestureNoFear");
		animator3.SetTrigger("GestureNoFear");
	}

	private void GestureHandUp()
	{
		IdleStand();
		animator.SetTrigger("GestureHandUp");
		animator2.SetTrigger("GestureHandUp");
		animator3.SetTrigger("GestureHandUp");
	}

	private void GestureCutThroat()
	{
		IdleStand();
		animator.SetTrigger("GestureCutThroat");
		animator2.SetTrigger("GestureCutThroat");
		animator3.SetTrigger("GestureCutThroat");
	}

	private void GestureCrowdPump()
	{
		IdleStand();
		animator.SetTrigger("GestureCrowdPump");
		animator2.SetTrigger("GestureCrowdPump");
		animator3.SetTrigger("GestureCrowdPump");
	}

	private void FistPump2()
	{
		IdleStand();
		animator.SetTrigger("FistPump2");
		animator2.SetTrigger("FistPump2");
		animator3.SetTrigger("FistPump2");
	}

	private void FistPump()
	{
		IdleStand();
		animator.SetTrigger("FistPump");
		animator2.SetTrigger("FistPump");
		animator3.SetTrigger("FistPump");
	}

	private void Fishing()
	{
		IdleStand();
		animator.SetTrigger("Fishing");
		animator2.SetTrigger("Fishing");
		animator3.SetTrigger("Fishing");
	}

	private void FacePalm()
	{
		IdleStand();
		animator.SetTrigger("FacePalm");
		animator2.SetTrigger("FacePalm");
		animator3.SetTrigger("FacePalm");
	}

	private void ElvisLegs()
	{
		IdleStand();
		animator.SetBool("ElvisLegsLoop", value: true);
		animator2.SetBool("ElvisLegsLoop", value: true);
		animator3.SetBool("ElvisLegsLoop", value: true);
	}

	private void CheerJump()
	{
		IdleStand();
		animator.SetTrigger("CheerJump");
		animator2.SetTrigger("CheerJump");
		animator3.SetTrigger("CheerJump");
	}

	private void CheerKnees()
	{
		IdleStand();
		animator.SetTrigger("CheerKnees");
		animator2.SetTrigger("CheerKnees");
		animator3.SetTrigger("CheerKnees");
	}

	private void ArmFlex()
	{
		IdleStand();
		animator.SetTrigger("ArmFlex");
		animator2.SetTrigger("ArmFlex");
		animator3.SetTrigger("ArmFlex");
	}

	private void ArmFlex2()
	{
		IdleStand();
		animator.SetTrigger("ArmFlex2");
		animator2.SetTrigger("ArmFlex2");
		animator3.SetTrigger("ArmFlex2");
	}

	private void ArmFlex3()
	{
		IdleStand();
		animator.SetTrigger("ArmFlex3");
		animator2.SetTrigger("ArmFlex3");
		animator3.SetTrigger("ArmFlex3");
	}

	private void ArmFlex4()
	{
		IdleStand();
		animator.SetTrigger("ArmFlex4");
		animator2.SetTrigger("ArmFlex4");
		animator3.SetTrigger("ArmFlex4");
	}

	private void ApplePick()
	{
		IdleStand();
		animator.SetTrigger("ApplePick");
		animator2.SetTrigger("ApplePick");
		animator3.SetTrigger("ApplePick");
	}

	private void Flashlight()
	{
		IdleStand();
		animator.SetBool("Flashlight", value: true);
		animator2.SetBool("Flashlight", value: true);
		animator3.SetBool("Flashlight", value: true);
	}

	private void WalkBackward()
	{
		IdleStand();
		animator.SetBool("WalkBackward", value: true);
		animator2.SetBool("WalkBackward", value: true);
		animator3.SetBool("WalkBackward", value: true);
	}

	private void Loot()
	{
		IdleReady();
		animator.SetTrigger("Loot");
		animator2.SetTrigger("Loot");
		animator3.SetTrigger("Loot");
	}

	private void IdleDie2()
	{
		IdleReady();
		animator.SetTrigger("IdleDie2");
		animator2.SetTrigger("IdleDie2");
		animator3.SetTrigger("IdleDie2");
	}

	private void Windmill()
	{
		SixStep();
		animator.SetBool("Windmill", value: true);
		animator2.SetBool("Windmill", value: true);
		animator3.SetBool("Windmill", value: true);
	}

	private void Criticals()
	{
		SixStep();
		animator.SetTrigger("Criticals");
		animator2.SetTrigger("Criticals");
		animator3.SetTrigger("Criticals");
	}

	private void Flares()
	{
		SixStep();
		animator.SetBool("Flares", value: true);
		animator2.SetBool("Flares", value: true);
		animator3.SetBool("Flares", value: true);
	}

	private void DeadmanFloat()
	{
		SixStep();
		animator.SetBool("DeadmanFloat", value: true);
		animator2.SetBool("DeadmanFloat", value: true);
		animator3.SetBool("DeadmanFloat", value: true);
	}

	private void TwoThousand()
	{
		SixStep();
		animator.SetBool("2000", value: true);
		animator2.SetBool("2000", value: true);
		animator3.SetBool("2000", value: true);
	}

	private void SixStep()
	{
		IdleStand();
		breakdance = true;
		idleStandbool = false;
		animator.SetBool("SixStep", value: true);
		animator2.SetBool("SixStep", value: true);
		animator3.SetBool("SixStep", value: true);
	}

	private void StormStrike()
	{
		IdleStand();
		animator.SetTrigger("StormStrike");
		animator2.SetTrigger("StormStrike");
		animator3.SetTrigger("StormStrike");
	}

	private void Mutilate()
	{
		IdleStand();
		animator.SetTrigger("Mutilate");
		animator2.SetTrigger("Mutilate");
		animator3.SetTrigger("Mutilate");
	}

	private void FireBreath()
	{
		IdleStand();
		animator.SetTrigger("FireBreath");
		animator2.SetTrigger("FireBreath");
		animator3.SetTrigger("FireBreath");
	}

	private void ChannelCastOmni()
	{
		IdleStand();
		animator.SetBool("ChannelCastOmni", value: true);
		animator2.SetBool("ChannelCastOmni", value: true);
		animator3.SetBool("ChannelCastOmni", value: true);
	}

	private void ChannelCastDirected()
	{
		IdleStand();
		animator.SetBool("ChannelCastDirected", value: true);
		animator2.SetBool("ChannelCastDirected", value: true);
		animator3.SetBool("ChannelCastDirected", value: true);
	}

	private void BattleRoar()
	{
		IdleStand();
		animator.SetTrigger("BattleRoar");
		animator2.SetTrigger("BattleRoar");
		animator3.SetTrigger("BattleRoar");
	}

	private void BowFire2()
	{
		BowInstant2();
		animator.SetTrigger("BowFire2");
		animator2.SetTrigger("BowFire2");
		animator3.SetTrigger("BowFire2");
	}

	private void BowInstant2()
	{
		BowReady2();
		animator.SetBool("BowInstant2", value: true);
		animator2.SetBool("BowInstant2", value: true);
		animator3.SetBool("BowInstant2", value: true);
	}

	private void BowReady2()
	{
		BowIdle();
		animator.SetBool("BowReady2", value: true);
		animator2.SetBool("BowReady2", value: true);
		animator3.SetBool("BowReady2", value: true);
	}

	private void IdleSandCover()
	{
		IdleStand();
		animator.SetTrigger("IdleSandCover");
		animator2.SetTrigger("IdleSandCover");
		animator3.SetTrigger("IdleSandCover");
	}

	private void WalkDehydrated()
	{
		IdleStand();
		animator.SetBool("WalkDehydrated", value: true);
		animator2.SetBool("WalkDehydrated", value: true);
		animator3.SetBool("WalkDehydrated", value: true);
	}

	private void UpHillWalkHandGrab()
	{
		UpHillWalk();
		animator.SetTrigger("UpHillWalkHandGrab");
		animator2.SetTrigger("UpHillWalkHandGrab");
		animator3.SetTrigger("UpHillWalkHandGrab");
	}

	private void UpHillWalk()
	{
		IdleStand();
		animator.SetBool("UpHillWalk", value: true);
		animator2.SetBool("UpHillWalk", value: true);
		animator3.SetBool("UpHillWalk", value: true);
	}

	private void CardPlayerLook()
	{
		CardPlayerIdle();
		animator.SetTrigger("CardPlayerLook");
		animator2.SetTrigger("CardPlayerLook");
		animator3.SetTrigger("CardPlayerLook");
	}

	private void CardPlayerIdle()
	{
		DealerIdle();
		animator.SetBool("CardPlayerIdle", value: true);
		animator2.SetBool("CardPlayerIdle", value: true);
		animator3.SetBool("CardPlayerIdle", value: true);
	}

	private void DealerFan()
	{
		DealerIdle();
		animator.SetTrigger("DealerFan");
		animator2.SetTrigger("DealerFan");
		animator3.SetTrigger("DealerFan");
	}

	private void DealerShuffle()
	{
		DealerIdle();
		animator.SetTrigger("DealerShuffle");
		animator2.SetTrigger("DealerShuffle");
		animator3.SetTrigger("DealerShuffle");
	}

	private void DealerIdle()
	{
		IdleStand();
		cards = true;
		idleStandbool = false;
		animator.SetBool("DealerIdle", value: true);
		animator2.SetBool("DealerIdle", value: true);
		animator3.SetBool("DealerIdle", value: true);
	}

	private void StaffPowerUp()
	{
		StaffStand();
		animator.SetTrigger("StaffPowerUp");
		animator2.SetTrigger("StaffPowerUp");
		animator3.SetTrigger("StaffPowerUp");
	}

	private void StaffHeal()
	{
		StaffStand();
		animator.SetTrigger("StaffHeal");
		animator2.SetTrigger("StaffHeal");
		animator3.SetTrigger("StaffHeal");
	}

	private void StaffAttack()
	{
		StaffStand();
		animator.SetTrigger("StaffAttack");
		animator2.SetTrigger("StaffAttack");
		animator3.SetTrigger("StaffAttack");
	}

	private void StaffStand()
	{
		IdleStand();
		wand = true;
		idleStandbool = false;
		animator.SetBool("StaffStand", value: true);
		animator2.SetBool("StaffStand", value: true);
		animator3.SetBool("StaffStand", value: true);
	}

	private void WandAttack()
	{
		WandStand();
		animator.SetTrigger("WandAttack");
		animator2.SetTrigger("WandAttack");
		animator3.SetTrigger("WandAttack");
	}

	private void WandAttack2()
	{
		WandStand();
		animator.SetTrigger("WandAttack2");
		animator2.SetTrigger("WandAttack2");
		animator3.SetTrigger("WandAttack2");
	}

	private void WandStand()
	{
		IdleStand();
		wand = true;
		idleStandbool = false;
		animator.SetBool("WandStand", value: true);
		animator2.SetBool("WandStand", value: true);
		animator3.SetBool("WandStand", value: true);
	}

	private void SwimDogPaddle()
	{
		Swim();
		animator.SetBool("SwimDogPaddle", value: true);
		animator2.SetBool("SwimDogPaddle", value: true);
		animator3.SetBool("SwimDogPaddle", value: true);
	}

	private void SwimFreestyle()
	{
		Swim();
		animator.SetBool("SwimFreestyle", value: true);
		animator2.SetBool("SwimFreestyle", value: true);
		animator3.SetBool("SwimFreestyle", value: true);
	}

	private void Swim()
	{
		IdleStand();
		swim = true;
		idleStandbool = false;
		animator.SetBool("Swim", value: true);
		animator2.SetBool("Swim", value: true);
		animator3.SetBool("Swim", value: true);
	}

	private void WateringCanWatering()
	{
		WateringCan();
		animator.SetBool("WateringCanWatering", value: true);
		animator2.SetBool("WateringCanWatering", value: true);
		animator3.SetBool("WateringCanWatering", value: true);
	}

	private void WateringCan()
	{
		IdleStand();
		animator.SetBool("WateringCan", value: true);
		animator2.SetBool("WateringCan", value: true);
		animator3.SetBool("WateringCan", value: true);
	}

	private void OfficeSittingReadingPageFlip()
	{
		OfficeSittingReading();
		animator.SetBool("OfficeSittingReadingPageFlip", value: true);
		animator2.SetBool("OfficeSittingReadingPageFlip", value: true);
		animator3.SetBool("OfficeSittingReadingPageFlip", value: true);
	}

	private void OfficeSittingReadingLeanBack()
	{
		OfficeSittingReading();
		animator.SetBool("OfficeSittingReadingLeanBack", value: true);
		animator2.SetBool("OfficeSittingReadingLeanBack", value: true);
		animator3.SetBool("OfficeSittingReadingLeanBack", value: true);
	}

	private void OfficeSittingReading()
	{
		OfficeSitting();
		animator.SetBool("OfficeSittingReading", value: true);
		animator2.SetBool("OfficeSittingReading", value: true);
		animator3.SetBool("OfficeSittingReading", value: true);
	}

	private void OfficeSittingReadingCoffeeSip()
	{
		OfficeSittingReading();
		animator.SetBool("OfficeSittingReadingCoffeeSip", value: true);
		animator2.SetBool("OfficeSittingReadingCoffeeSip", value: true);
		animator3.SetBool("OfficeSittingReadingCoffeeSip", value: true);
	}

	private void OfficeSittingMouseMovement()
	{
		OfficeSitting();
		animator.SetBool("OfficeSittingMouseMovement", value: true);
		animator2.SetBool("OfficeSittingMouseMovement", value: true);
		animator3.SetBool("OfficeSittingMouseMovement", value: true);
	}

	private void OfficeSittingHandRestFingerTap()
	{
		OfficeSitting();
		animator.SetBool("OfficeSittingHandRestFingerTap", value: true);
		animator2.SetBool("OfficeSittingHandRestFingerTap", value: true);
		animator3.SetBool("OfficeSittingHandRestFingerTap", value: true);
	}

	private void OfficeSittingEyesRub()
	{
		OfficeSitting();
		animator.SetBool("OfficeSittingEyesRub", value: true);
		animator2.SetBool("OfficeSittingEyesRub", value: true);
		animator3.SetBool("OfficeSittingEyesRub", value: true);
	}

	private void OfficeSitting1LegStraight()
	{
		OfficeSitting();
		animator.SetBool("OfficeSitting1LegStraight", value: true);
		animator2.SetBool("OfficeSitting1LegStraight", value: true);
		animator3.SetBool("OfficeSitting1LegStraight", value: true);
	}

	private void OfficeSitting45DegLeg()
	{
		OfficeSitting();
		animator.SetBool("OfficeSitting45DegLeg", value: true);
		animator2.SetBool("OfficeSitting45DegLeg", value: true);
		animator3.SetBool("OfficeSitting45DegLeg", value: true);
	}

	private void OfficeSittingBack()
	{
		OfficeSitting();
		animator.SetBool("OfficeSittingBack", value: true);
		animator2.SetBool("OfficeSittingBack", value: true);
		animator3.SetBool("OfficeSittingBack", value: true);
	}

	private void OfficeSittingLegCross()
	{
		OfficeSitting();
		animator.SetBool("OfficeSittingLegCross", value: true);
		animator2.SetBool("OfficeSittingLegCross", value: true);
		animator3.SetBool("OfficeSittingLegCross", value: true);
	}

	private void OfficeSitting()
	{
		IdleStand();
		office = true;
		idleStandbool = false;
		animator.SetBool("OfficeSitting", value: true);
		animator2.SetBool("OfficeSitting", value: true);
		animator3.SetBool("OfficeSitting", value: true);
	}

	private void Yawn()
	{
		IdleStand();
		animator.SetBool("Yawn", value: true);
		animator2.SetBool("Yawn", value: true);
		animator3.SetBool("Yawn", value: true);
	}

	private void HeelClick()
	{
		IdleStand();
		animator.SetBool("HeelClick", value: true);
		animator2.SetBool("HeelClick", value: true);
		animator3.SetBool("HeelClick", value: true);
	}

	private void VaderChoke()
	{
		IdleStand();
		animator.SetBool("VaderChoke", value: true);
		animator2.SetBool("VaderChoke", value: true);
		animator3.SetBool("VaderChoke", value: true);
	}

	private void SpinDeath()
	{
		IdleFight();
		animator.SetBool("360SpinDeath", value: true);
		animator2.SetBool("360SpinDeath", value: true);
		animator3.SetBool("360SpinDeath", value: true);
	}

	private void ClimbRight()
	{
		ClimbIdle();
		animator.SetBool("ClimbRight", value: true);
		animator2.SetBool("ClimbRight", value: true);
		animator3.SetBool("ClimbRight", value: true);
	}

	private void ClimbLeft()
	{
		ClimbIdle();
		animator.SetBool("ClimbLeft", value: true);
		animator2.SetBool("ClimbLeft", value: true);
		animator3.SetBool("ClimbLeft", value: true);
	}

	private void ClimbUp()
	{
		ClimbIdle();
		animator.SetBool("ClimbUp", value: true);
		animator2.SetBool("ClimbUp", value: true);
		animator3.SetBool("ClimbUp", value: true);
	}

	private void ClimbIdle()
	{
		IdleStand();
		climbing = true;
		idleStandbool = false;
		animator.SetBool("ClimbIdle", value: true);
		animator2.SetBool("ClimbIdle", value: true);
		animator3.SetBool("ClimbIdle", value: true);
	}

	private void SkateboardKickPush()
	{
		SkateboardIdle();
		animator.SetBool("SkateboardKickPush", value: true);
		animator2.SetBool("SkateboardKickPush", value: true);
		animator3.SetBool("SkateboardKickPush", value: true);
	}

	private void SkateboardIdle()
	{
		IdleStand();
		skateboard = true;
		idleStandbool = false;
		animator.SetBool("SkateboardIdle", value: true);
		animator2.SetBool("SkateboardIdle", value: true);
		animator3.SetBool("SkateboardIdle", value: true);
	}

	private void IdleStandingJump()
	{
		IdleStand();
		animator.SetBool("IdleStandingJump", value: true);
		animator2.SetBool("IdleStandingJump", value: true);
		animator3.SetBool("IdleStandingJump", value: true);
	}

	private void IdleFeedThrow()
	{
		IdleStand();
		animator.SetBool("IdleFeedThrow", value: true);
		animator2.SetBool("IdleFeedThrow", value: true);
		animator3.SetBool("IdleFeedThrow", value: true);
	}

	private void IdleSlide()
	{
		IdleRun();
		animator.SetBool("IdleSlide", value: true);
		animator2.SetBool("IdleSlide", value: true);
		animator3.SetBool("IdleSlide", value: true);
	}

	private void RollerBladeTurnRight()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeTurnRight", value: true);
		animator2.SetBool("RollerBladeTurnRight", value: true);
		animator3.SetBool("RollerBladeTurnRight", value: true);
	}

	private void RollerBladeTurnLeft()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeTurnLeft", value: true);
		animator2.SetBool("RollerBladeTurnLeft", value: true);
		animator3.SetBool("RollerBladeTurnLeft", value: true);
	}

	private void RollerBladeCrossoverLeft()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeCrossoverLeft", value: true);
		animator2.SetBool("RollerBladeCrossoverLeft", value: true);
		animator3.SetBool("RollerBladeCrossoverLeft", value: true);
	}

	private void RollerBladeSkateFwd()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeSkateFwd", value: true);
		animator2.SetBool("RollerBladeSkateFwd", value: true);
		animator3.SetBool("RollerBladeSkateFwd", value: true);
	}

	private void RollerBladeFrontFlip()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeFrontFlip", value: true);
		animator2.SetBool("RollerBladeFrontFlip", value: true);
		animator3.SetBool("RollerBladeFrontFlip", value: true);
	}

	private void RollerBladeBackFlip()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeBackFlip", value: true);
		animator2.SetBool("RollerBladeBackFlip", value: true);
		animator3.SetBool("RollerBladeBackFlip", value: true);
	}

	private void RollerBladeCrossoverRight()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeCrossoverRight", value: true);
		animator2.SetBool("RollerBladeCrossoverRight", value: true);
		animator3.SetBool("RollerBladeCrossoverRight", value: true);
	}

	private void RollerBladeGrindRoyale()
	{
		RollerBladeJump();
		animator.SetBool("RollerBladeGrindRoyale", value: true);
		animator2.SetBool("RollerBladeGrindRoyale", value: true);
		animator3.SetBool("RollerBladeGrindRoyale", value: true);
	}

	private void RollerBladeJump()
	{
		RollerBladeRoll();
		animator.SetBool("RollerBladeJump", value: true);
		animator2.SetBool("RollerBladeJump", value: true);
		animator3.SetBool("RollerBladeJump", value: true);
	}

	private void RollerBladeStop()
	{
		RollerBladeStand();
		animator.SetBool("RollerBladeStop", value: true);
		animator2.SetBool("RollerBladeStop", value: true);
		animator3.SetBool("RollerBladeStop", value: true);
	}

	private void RollerBladeRoll()
	{
		RollerBladeStand();
		animator.SetBool("RollerBladeRoll", value: true);
		animator2.SetBool("RollerBladeRoll", value: true);
		animator3.SetBool("RollerBladeRoll", value: true);
	}

	private void RollerBladeStand()
	{
		Falses();
		IdleStand();
		idleStandbool = false;
		rollerBlade = true;
		animator.SetBool("RollerBladeStand", value: true);
		animator2.SetBool("RollerBladeStand", value: true);
		animator3.SetBool("RollerBladeStand", value: true);
	}

	private void MotorbikeSuperman()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeSuperman", value: true);
		animator2.SetBool("MotorbikeSuperman", value: true);
		animator3.SetBool("MotorbikeSuperman", value: true);
	}

	private void MotorbikeSpecialFlip()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeSpecialFlip", value: true);
		animator2.SetBool("MotorbikeSpecialFlip", value: true);
		animator3.SetBool("MotorbikeSpecialFlip", value: true);
	}

	private void PistolLeftHandStab()
	{
		PistolReady();
		animator.SetBool("PistolLeftHandStab", value: true);
		animator2.SetBool("PistolLeftHandStab", value: true);
		animator3.SetBool("PistolLeftHandStab", value: true);
	}

	private void CrouchStrafeRight()
	{
		IdleReadyCrouch();
		animator.SetBool("CrouchStrafeRight", value: true);
		animator2.SetBool("CrouchStrafeRight", value: true);
		animator3.SetBool("CrouchStrafeRight", value: true);
	}

	private void CrouchStrafeLeft()
	{
		IdleReadyCrouch();
		animator.SetBool("CrouchStrafeLeft", value: true);
		animator2.SetBool("CrouchStrafeLeft", value: true);
		animator3.SetBool("CrouchStrafeLeft", value: true);
	}

	private void CrouchWalkBackward()
	{
		IdleReadyCrouch();
		animator.SetBool("CrouchWalkBackward", value: true);
		animator2.SetBool("CrouchWalkBackward", value: true);
		animator3.SetBool("CrouchWalkBackward", value: true);
	}

	private void ProneLocomotion()
	{
		ProneIdle();
		animator.SetBool("ProneLocomotion", value: true);
		animator2.SetBool("ProneLocomotion", value: true);
		animator3.SetBool("ProneLocomotion", value: true);
	}

	private void ProneIdle()
	{
		IdleStand();
		animator.SetBool("ProneIdle", value: true);
		animator2.SetBool("ProneIdle", value: true);
		animator3.SetBool("ProneIdle", value: true);
	}

	private void CrawlLocomotion()
	{
		CrawlIdle();
		animator.SetBool("CrawlLocomotion", value: true);
		animator2.SetBool("CrawlLocomotion", value: true);
		animator3.SetBool("CrawlLocomotion", value: true);
	}

	private void CrawlIdle()
	{
		IdleStand();
		animator.SetBool("CrawlIdle", value: true);
		animator2.SetBool("CrawlIdle", value: true);
		animator3.SetBool("CrawlIdle", value: true);
	}

	private void IdleMouthWipe()
	{
		IdleStand();
		animator.SetBool("IdleMouthWipe", value: true);
		animator2.SetBool("IdleMouthWipe", value: true);
		animator3.SetBool("IdleMouthWipe", value: true);
	}

	private void IdleSpew()
	{
		IdleStand();
		animator.SetBool("IdleSpew", value: true);
		animator2.SetBool("IdleSpew", value: true);
		animator3.SetBool("IdleSpew", value: true);
	}

	private void RunBackRight()
	{
		RunBackward();
		animator.SetBool("RunBackRight", value: true);
		animator2.SetBool("RunBackRight", value: true);
		animator3.SetBool("RunBackRight", value: true);
	}

	private void RunBackLeft()
	{
		RunBackward();
		animator.SetBool("RunBackLeft", value: true);
		animator2.SetBool("RunBackLeft", value: true);
		animator3.SetBool("RunBackLeft", value: true);
	}

	private void WorkerShovel2()
	{
		IdleStand();
		animator.SetBool("WorkerShovel2", value: true);
		animator2.SetBool("WorkerShovel2", value: true);
		animator3.SetBool("WorkerShovel2", value: true);
	}

	private void WorkerShovel()
	{
		IdleStand();
		animator.SetBool("WorkerShovel", value: true);
		animator2.SetBool("WorkerShovel", value: true);
		animator3.SetBool("WorkerShovel", value: true);
	}

	private void WorkerPickaxe2()
	{
		IdleStand();
		animator.SetBool("WorkerPickaxe2", value: true);
		animator2.SetBool("WorkerPickaxe2", value: true);
		animator3.SetBool("WorkerPickaxe2", value: true);
	}

	private void WorkerPickaxe()
	{
		IdleStand();
		animator.SetBool("WorkerPickaxe", value: true);
		animator2.SetBool("WorkerPickaxe", value: true);
		animator3.SetBool("WorkerPickaxe", value: true);
	}

	private void WorkerHammer2()
	{
		IdleStand();
		animator.SetBool("WorkerHammer2", value: true);
		animator2.SetBool("WorkerHammer2", value: true);
		animator3.SetBool("WorkerHammer2", value: true);
	}

	private void WorkerHammer()
	{
		IdleStand();
		animator.SetBool("WorkerHammer", value: true);
		animator2.SetBool("WorkerHammer", value: true);
		animator3.SetBool("WorkerHammer", value: true);
	}

	private void WoodCut()
	{
		IdleStand();
		animator.SetBool("WoodCut", value: true);
		animator2.SetBool("WoodCut", value: true);
		animator3.SetBool("WoodCut", value: true);
	}

	private void OneHandSwordRollAttack()
	{
		OneHandSwordReady();
		animator.SetBool("1HandSwordRollAttack", value: true);
		animator2.SetBool("1HandSwordRollAttack", value: true);
		animator3.SetBool("1HandSwordRollAttack", value: true);
	}

	private void MotorbikeTurnRight()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeTurnRight", value: true);
		animator2.SetBool("MotorbikeTurnRight", value: true);
		animator3.SetBool("MotorbikeTurnRight", value: true);
	}

	private void MotorbikeTurnLeft()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeTurnLeft", value: true);
		animator2.SetBool("MotorbikeTurnLeft", value: true);
		animator3.SetBool("MotorbikeTurnLeft", value: true);
	}

	private void MotorbikeShootRight()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeShootRight", value: true);
		animator2.SetBool("MotorbikeShootRight", value: true);
		animator3.SetBool("MotorbikeShootRight", value: true);
	}

	private void MotorbikeShootLeft()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeShootLeft", value: true);
		animator2.SetBool("MotorbikeShootLeft", value: true);
		animator3.SetBool("MotorbikeShootLeft", value: true);
	}

	private void MotorbikeShootFwd()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeShootFwd", value: true);
		animator2.SetBool("MotorbikeShootFwd", value: true);
		animator3.SetBool("MotorbikeShootFwd", value: true);
	}

	private void MotorbikeShootBack()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeShootBack", value: true);
		animator2.SetBool("MotorbikeShootBack", value: true);
		animator3.SetBool("MotorbikeShootBack", value: true);
	}

	private void MotorbikeLassoRight()
	{
		MotorbikeLasso();
		animator.SetBool("MotorbikeLassoRight", value: true);
		animator2.SetBool("MotorbikeLassoRight", value: true);
		animator3.SetBool("MotorbikeLassoRight", value: true);
	}

	private void MotorbikeLassoLeft()
	{
		MotorbikeLasso();
		animator.SetBool("MotorbikeLassoLeft", value: true);
		animator2.SetBool("MotorbikeLassoLeft", value: true);
		animator3.SetBool("MotorbikeLassoLeft", value: true);
	}

	private void MotorbikeLassoBack()
	{
		MotorbikeLasso();
		animator.SetBool("MotorbikeLassoBack", value: true);
		animator2.SetBool("MotorbikeLassoBack", value: true);
		animator3.SetBool("MotorbikeLassoBack", value: true);
	}

	private void MotorbikeLassoFwd()
	{
		MotorbikeLasso();
		animator.SetBool("MotorbikeLassoFwd", value: true);
		animator2.SetBool("MotorbikeLassoFwd", value: true);
		animator3.SetBool("MotorbikeLassoFwd", value: true);
	}

	private void MotorbikeLasso()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeLasso", value: true);
		animator2.SetBool("MotorbikeLasso", value: true);
		animator3.SetBool("MotorbikeLasso", value: true);
	}

	private void MotorbikeWheelyNoHands()
	{
		MotorbikeWheely();
		animator.SetBool("MotorbikeWheelyNoHands", value: true);
		animator2.SetBool("MotorbikeWheelyNoHands", value: true);
		animator3.SetBool("MotorbikeWheelyNoHands", value: true);
	}

	private void MotorbikeWheely()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeWheely", value: true);
		animator2.SetBool("MotorbikeWheely", value: true);
		animator3.SetBool("MotorbikeWheely", value: true);
	}

	private void MotorbikeSeatStandWheely()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeSeatStandWheely", value: true);
		animator2.SetBool("MotorbikeSeatStandWheely", value: true);
		animator3.SetBool("MotorbikeSeatStandWheely", value: true);
	}

	private void MotorbikeSeatStand()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeSeatStand", value: true);
		animator2.SetBool("MotorbikeSeatStand", value: true);
		animator3.SetBool("MotorbikeSeatStand", value: true);
	}

	private void MotorbikeLookBack()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeLookBack", value: true);
		animator2.SetBool("MotorbikeLookBack", value: true);
		animator3.SetBool("MotorbikeLookBack", value: true);
	}

	private void MotorbikeHeartAttack()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeHeartAttack", value: true);
		animator2.SetBool("MotorbikeHeartAttack", value: true);
		animator3.SetBool("MotorbikeHeartAttack", value: true);
	}

	private void MotorbikeHeadstand()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeHeadstand", value: true);
		animator2.SetBool("MotorbikeHeadstand", value: true);
		animator3.SetBool("MotorbikeHeadstand", value: true);
	}

	private void MotorbikeHandstand()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeHandstand", value: true);
		animator2.SetBool("MotorbikeHandstand", value: true);
		animator3.SetBool("MotorbikeHandstand", value: true);
	}

	private void MotorbikeHandlebarSit()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeHandlebarSit", value: true);
		animator2.SetBool("MotorbikeHandlebarSit", value: true);
		animator3.SetBool("MotorbikeHandlebarSit", value: true);
	}

	private void MotorbikeBackwardStand()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeBackwardStand", value: true);
		animator2.SetBool("MotorbikeBackwardStand", value: true);
		animator3.SetBool("MotorbikeBackwardStand", value: true);
	}

	private void MotorbikeBackwardSittingCheer()
	{
		MotorbikeBackwardSitting();
		animator.SetBool("MotorbikeBackwardSittingCheer", value: true);
		animator2.SetBool("MotorbikeBackwardSittingCheer", value: true);
		animator3.SetBool("MotorbikeBackwardSittingCheer", value: true);
	}

	private void MotorbikeBackwardSitting()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeBackwardSitting", value: true);
		animator2.SetBool("MotorbikeBackwardSitting", value: true);
		animator3.SetBool("MotorbikeBackwardSitting", value: true);
	}

	private void MotorbikeAirWalk()
	{
		MotorbikeIdle();
		animator.SetBool("MotorbikeAirWalk", value: true);
		animator2.SetBool("MotorbikeAirWalk", value: true);
		animator3.SetBool("MotorbikeAirWalk", value: true);
	}

	private void MotorbikeIdle()
	{
		Falses();
		IdleStand();
		idleStandbool = false;
		motorbikeIdle = true;
		animator.SetBool("MotorbikeIdle", value: true);
		animator2.SetBool("MotorbikeIdle", value: true);
		animator3.SetBool("MotorbikeIdle", value: true);
	}

	private void WeaponReadyFire()
	{
		WeaponReady();
		animator.SetBool("WeaponReadyFire", value: true);
		animator2.SetBool("WeaponReadyFire", value: true);
		animator3.SetBool("WeaponReadyFire", value: true);
	}

	private void ShotgunReadyFire()
	{
		WeaponReady();
		animator.SetBool("ShotgunReadyFire", value: true);
		animator2.SetBool("ShotgunReadyFire", value: true);
		animator3.SetBool("ShotgunReadyFire", value: true);
	}

	private void IdleStun()
	{
		IdleStand();
		animator.SetBool("IdleStun", value: true);
		animator2.SetBool("IdleStun", value: true);
		animator3.SetBool("IdleStun", value: true);
	}

	private void OneHandSwordChargeSwipe()
	{
		OneHandSwordChargeUp();
		animator.SetBool("1HandSwordChargeSwipe", value: true);
		animator2.SetBool("1HandSwordChargeSwipe", value: true);
		animator3.SetBool("1HandSwordChargeSwipe", value: true);
	}

	private void OneHandSwordChargeHeavyBash()
	{
		OneHandSwordChargeUp();
		animator.SetBool("1HandSwordChargeHeavyBash", value: true);
		animator2.SetBool("1HandSwordChargeHeavyBash", value: true);
		animator3.SetBool("1HandSwordChargeHeavyBash", value: true);
	}

	private void OneHandSwordChargeUp()
	{
		OneHandSwordReady();
		animator.SetBool("1HandSwordChargeUp", value: true);
		animator2.SetBool("1HandSwordChargeUp", value: true);
		animator3.SetBool("1HandSwordChargeUp", value: true);
	}

	private void WeaponRunBackward()
	{
		WeaponReady();
		animator.SetBool("WeaponRunBackward", value: true);
		animator2.SetBool("WeaponRunBackward", value: true);
		animator3.SetBool("WeaponRunBackward", value: true);
	}

	private void RunBackward()
	{
		IdleStand();
		animator.SetBool("RunBackward", value: true);
		animator2.SetBool("RunBackward", value: true);
		animator3.SetBool("RunBackward", value: true);
	}

	private void OneHandSwordShieldBash()
	{
		OneHandSwordReady();
		animator.SetBool("1HandSwordShieldBash", value: true);
		animator2.SetBool("1HandSwordShieldBash", value: true);
		animator3.SetBool("1HandSwordShieldBash", value: true);
	}

	private void OneHandSwordStrafeLeft()
	{
		OneHandSwordReady();
		animator.SetBool("1HSwordStrafeRunLeft", value: true);
		animator2.SetBool("1HSwordStrafeRunLeft", value: true);
		animator3.SetBool("1HSwordStrafeRunLeft", value: true);
	}

	private void OneHandSwordStrafeRight()
	{
		OneHandSwordReady();
		animator.SetBool("1HSwordStrafeRunRight", value: true);
		animator2.SetBool("1HSwordStrafeRunRight", value: true);
		animator3.SetBool("1HSwordStrafeRunRight", value: true);
	}

	private void WeaponStrafeRunLeft()
	{
		WeaponReady();
		animator.SetBool("WeaponStrafeRunLeft", value: true);
		animator2.SetBool("WeaponStrafeRunLeft", value: true);
		animator3.SetBool("WeaponStrafeRunLeft", value: true);
	}

	private void WeaponStrafeRunRight()
	{
		WeaponReady();
		animator.SetBool("WeaponStrafeRunRight", value: true);
		animator2.SetBool("WeaponStrafeRunRight", value: true);
		animator3.SetBool("WeaponStrafeRunRight", value: true);
	}

	private void StrafeRunLeft()
	{
		IdleStand();
		animator.SetBool("StrafeRunLeft", value: true);
		animator2.SetBool("StrafeRunLeft", value: true);
		animator3.SetBool("StrafeRunLeft", value: true);
	}

	private void StrafeRunRight()
	{
		IdleStand();
		animator.SetBool("StrafeRunRight", value: true);
		animator2.SetBool("StrafeRunRight", value: true);
		animator3.SetBool("StrafeRunRight", value: true);
	}

	private void IdleTyping()
	{
		IdleStand();
		animator.SetBool("IdleTyping", value: true);
		animator2.SetBool("IdleTyping", value: true);
		animator3.SetBool("IdleTyping", value: true);
	}

	private void IdleButtonPress()
	{
		IdleStand();
		animator.SetBool("IdleButtonPress", value: true);
		animator2.SetBool("IdleButtonPress", value: true);
		animator3.SetBool("IdleButtonPress", value: true);
	}

	private void Idle180()
	{
		IdleStand();
		animator.SetBool("Idle180", value: true);
		animator2.SetBool("Idle180", value: true);
		animator3.SetBool("Idle180", value: true);
	}

	private void CrouchWalk()
	{
		IdleReadyCrouch();
		animator.SetBool("CrouchWalk", value: true);
		animator2.SetBool("CrouchWalk", value: true);
		animator3.SetBool("CrouchWalk", value: true);
	}

	private void Crouch180()
	{
		IdleReadyCrouch();
		animator.SetBool("Crouch180", value: true);
		animator2.SetBool("Crouch180", value: true);
		animator3.SetBool("Crouch180", value: true);
	}

	private void FlyDown()
	{
		IdleFly();
		animator.SetBool("FlyDown", value: true);
		animator2.SetBool("FlyDown", value: true);
		animator3.SetBool("FlyDown", value: true);
	}

	private void FlyUp()
	{
		IdleFly();
		animator.SetBool("FlyUp", value: true);
		animator2.SetBool("FlyUp", value: true);
		animator3.SetBool("FlyUp", value: true);
	}

	private void FlyRight()
	{
		IdleFly();
		animator.SetBool("FlyRight", value: true);
		animator2.SetBool("FlyRight", value: true);
		animator3.SetBool("FlyRight", value: true);
	}

	private void FlyLeft()
	{
		IdleFly();
		animator.SetBool("FlyLeft", value: true);
		animator2.SetBool("FlyLeft", value: true);
		animator3.SetBool("FlyLeft", value: true);
	}

	private void FlyBackward()
	{
		IdleFly();
		animator.SetBool("FlyBackward", value: true);
		animator2.SetBool("FlyBackward", value: true);
		animator3.SetBool("FlyBackward", value: true);
	}

	private void FlyForward()
	{
		IdleFly();
		animator.SetBool("FlyForward", value: true);
		animator2.SetBool("FlyForward", value: true);
		animator3.SetBool("FlyForward", value: true);
	}

	private void IdleFly()
	{
		IdleReady();
		animator.SetBool("IdleFly", value: true);
		animator2.SetBool("IdleFly", value: true);
		animator3.SetBool("IdleFly", value: true);
	}

	private void WizardNeoBlock()
	{
		IdleReady();
		animator.SetBool("WizardNeoBlock", value: true);
		animator2.SetBool("WizardNeoBlock", value: true);
		animator3.SetBool("WizardNeoBlock", value: true);
	}

	private void WizardEyeBeam()
	{
		IdleReady();
		animator.SetBool("WizardEyeBeam", value: true);
		animator2.SetBool("WizardEyeBeam", value: true);
		animator3.SetBool("WizardEyeBeam", value: true);
	}

	private void IdleMeditate()
	{
		IdleStand();
		animator.SetBool("IdleMeditate", value: true);
		animator2.SetBool("IdleMeditate", value: true);
		animator3.SetBool("IdleMeditate", value: true);
	}

	private void IdleDodgeLeft()
	{
		IdleReady();
		animator.SetBool("IdleDodgeLeft", value: true);
		animator2.SetBool("IdleDodgeLeft", value: true);
		animator3.SetBool("IdleDodgeLeft", value: true);
	}

	private void IdleDodgeRight()
	{
		IdleReady();
		animator.SetBool("IdleDodgeRight", value: true);
		animator2.SetBool("IdleDodgeRight", value: true);
		animator3.SetBool("IdleDodgeRight", value: true);
	}

	private void RunDive()
	{
		IdleRun();
		animator.SetBool("RunDive", value: true);
		animator2.SetBool("RunDive", value: true);
		animator3.SetBool("RunDive", value: true);
	}

	private void RunJump()
	{
		IdleRun();
		animator.SetBool("RunJump", value: true);
		animator2.SetBool("RunJump", value: true);
		animator3.SetBool("RunJump", value: true);
	}

	private void Cowboy1HandDraw()
	{
		IdleStand();
		animator.SetBool("Cowboy1HandDraw", value: true);
		animator2.SetBool("Cowboy1HandDraw", value: true);
		animator3.SetBool("Cowboy1HandDraw", value: true);
	}

	private void BowReady()
	{
		BowIdle();
		animator.SetBool("BowReady", value: true);
		animator2.SetBool("BowReady", value: true);
		animator3.SetBool("BowReady", value: true);
	}

	private void BowInstant()
	{
		BowReady();
		animator.SetBool("BowInstant", value: true);
		animator2.SetBool("BowInstant", value: true);
		animator3.SetBool("BowInstant", value: true);
	}

	private void BowFire()
	{
		BowInstant();
		animator.SetBool("BowFire", value: true);
		animator2.SetBool("BowFire", value: true);
		animator3.SetBool("BowFire", value: true);
	}

	private void BowIdle()
	{
		Falses();
		bowIdle = true;
		animator.SetBool("BowIdle", value: true);
		animator2.SetBool("BowIdle", value: true);
		animator3.SetBool("BowIdle", value: true);
	}

	private void OneHandSwordRun()
	{
		Falses();
		OneHandSwordReady();
		animator.SetBool("OneHandSwordRun", value: true);
		animator2.SetBool("OneHandSwordRun", value: true);
		animator3.SetBool("OneHandSwordRun", value: true);
	}

	private void OneHandSwordBlock()
	{
		OneHandSwordReady();
		animator.SetBool("OneHandSwordBlock", value: true);
		animator2.SetBool("OneHandSwordBlock", value: true);
		animator3.SetBool("OneHandSwordBlock", value: true);
	}

	private void OneHandSwordJab()
	{
		OneHandSwordReady();
		animator.SetBool("OneHandSwordJab", value: true);
		animator2.SetBool("OneHandSwordJab", value: true);
		animator3.SetBool("OneHandSwordJab", value: true);
	}

	private void OneHandSwordBackSwing()
	{
		OneHandSwordReady();
		animator.SetBool("OneHandSwordBackSwing", value: true);
		animator2.SetBool("OneHandSwordBackSwing", value: true);
		animator3.SetBool("OneHandSwordBackSwing", value: true);
	}

	private void OneHandSwordSwing()
	{
		OneHandSwordReady();
		animator.SetBool("OneHandSwordSwing", value: true);
		animator2.SetBool("OneHandSwordSwing", value: true);
		animator3.SetBool("OneHandSwordSwing", value: true);
	}

	private void OneHandSwordReady()
	{
		OneHandSwordIdle();
		animator.SetBool("OneHandSwordReady", value: true);
		animator2.SetBool("OneHandSwordReady", value: true);
		animator3.SetBool("OneHandSwordReady", value: true);
	}

	private void OneHandSwordIdle()
	{
		Falses();
		oneHandSwordIdle = true;
		animator.SetBool("OneHandSwordIdle", value: true);
		animator2.SetBool("OneHandSwordIdle", value: true);
		animator3.SetBool("OneHandSwordIdle", value: true);
	}

	private void WeaponRun()
	{
		WeaponReady();
		weaponRun = true;
		animator.SetBool("WeaponRun", value: true);
		animator2.SetBool("WeaponRun", value: true);
		animator3.SetBool("WeaponRun", value: true);
	}

	private void PistolReload()
	{
		PistolReady();
		animator.SetBool("PistolReload", value: true);
		animator2.SetBool("PistolReload", value: true);
		animator3.SetBool("PistolReload", value: true);
	}

	private void PistolFire()
	{
		PistolInstant();
		animator.SetBool("PistolFire", value: true);
		animator2.SetBool("PistolFire", value: true);
		animator3.SetBool("PistolFire", value: true);
	}

	private void PistolInstant()
	{
		animator.SetBool("PistolInstant", value: true);
		animator2.SetBool("PistolInstant", value: true);
		animator3.SetBool("PistolInstant", value: true);
	}

	private void PistolReady()
	{
		Falses();
		pistolReadybool = true;
		animator.SetBool("PistolReady", value: true);
		animator2.SetBool("PistolReady", value: true);
		animator3.SetBool("PistolReady", value: true);
	}

	private void WeaponReload()
	{
		WeaponReady();
		animator.SetBool("WeaponReload", value: true);
		animator2.SetBool("WeaponReload", value: true);
		animator3.SetBool("WeaponReload", value: true);
	}

	private void WeaponFire()
	{
		WeaponInstant();
		animator.SetBool("WeaponFire", value: true);
		animator2.SetBool("WeaponFire", value: true);
		animator3.SetBool("WeaponFire", value: true);
	}

	private void ShotgunFire()
	{
		WeaponInstant();
		animator.SetBool("ShotgunFire", value: true);
		animator2.SetBool("ShotgunFire", value: true);
		animator3.SetBool("ShotgunFire", value: true);
	}

	private void ShotgunReloadChamber()
	{
		WeaponInstant();
		animator.SetBool("ShotgunReloadChamber", value: true);
		animator2.SetBool("ShotgunReloadChamber", value: true);
		animator3.SetBool("ShotgunReloadChamber", value: true);
		animator.SetBool("ShotgunReloadMagazine", value: true);
		animator2.SetBool("ShotgunReloadMagazine", value: true);
		animator3.SetBool("ShotgunReloadMagazine", value: true);
	}

	private void ShotgunReloadMagazine()
	{
		WeaponInstant();
		animator.SetBool("ShotgunReloadMagazine", value: true);
		animator2.SetBool("ShotgunReloadMagazine", value: true);
		animator3.SetBool("ShotgunReloadMagazine", value: true);
	}

	private void WeaponInstant()
	{
		WeaponReady();
		animator.SetBool("WeaponInstant", value: true);
		animator2.SetBool("WeaponInstant", value: true);
		animator3.SetBool("WeaponInstant", value: true);
	}

	private void NadeThrow()
	{
		WeaponInstant();
		animator.SetBool("NadeThrow", value: true);
		animator2.SetBool("NadeThrow", value: true);
		animator3.SetBool("NadeThrow", value: true);
	}

	private void WeaponReady()
	{
		Falses();
		weaponStandbool = true;
		animator.SetBool("WeaponReady", value: true);
		animator2.SetBool("WeaponReady", value: true);
		animator3.SetBool("WeaponReady", value: true);
	}

	private void WeaponStand()
	{
		Falses();
		weaponStandbool = true;
		animator.SetBool("WeaponStand", value: true);
		animator2.SetBool("WeaponStand", value: true);
		animator3.SetBool("WeaponStand", value: true);
	}

	private void RHandPunch()
	{
		animator.SetBool("RHandPunch", value: true);
		animator2.SetBool("RHandPunch", value: true);
		animator3.SetBool("RHandPunch", value: true);
	}

	private void LHandPunch()
	{
		animator.SetBool("LHandPunch", value: true);
		animator2.SetBool("LHandPunch", value: true);
		animator3.SetBool("LHandPunch", value: true);
	}

	private void FaceHit()
	{
		animator.SetBool("FaceHit", value: true);
		animator2.SetBool("FaceHit", value: true);
		animator3.SetBool("FaceHit", value: true);
	}

	private void FrontKick()
	{
		animator.SetBool("FrontKick", value: true);
		animator2.SetBool("FrontKick", value: true);
		animator3.SetBool("FrontKick", value: true);
	}

	private void IdleStand()
	{
		Falses();
		idleStandbool = true;
		animator.SetBool("IdleStand", value: true);
		animator2.SetBool("IdleStand", value: true);
		animator3.SetBool("IdleStand", value: true);
	}

	private void IdleReady()
	{
		Falses();
		idleReadybool = true;
		animator.SetBool("IdleReady", value: true);
		animator2.SetBool("IdleReady", value: true);
		animator3.SetBool("IdleReady", value: true);
	}

	private void IdleMonster()
	{
		Falses();
		idleMonsterbool = true;
		animator.SetBool("IdleMonster", value: true);
		animator2.SetBool("IdleMonster", value: true);
		animator3.SetBool("IdleMonster", value: true);
	}

	private void IdleCheer()
	{
		IdleStand();
		animator.SetBool("IdleCheer", value: true);
		animator2.SetBool("IdleCheer", value: true);
		animator3.SetBool("IdleCheer", value: true);
	}

	private void IdleWalk()
	{
		IdleStand();
		animator.SetBool("IdleWalk", value: true);
		animator2.SetBool("IdleWalk", value: true);
		animator3.SetBool("IdleWalk", value: true);
	}

	private void CratePush()
	{
		IdleStand();
		animator.SetBool("CratePush", value: true);
		animator2.SetBool("CratePush", value: true);
		animator3.SetBool("CratePush", value: true);
	}

	private void CratePull()
	{
		IdleStand();
		animator.SetBool("CratePull", value: true);
		animator2.SetBool("CratePull", value: true);
		animator3.SetBool("CratePull", value: true);
	}

	private void IdleStrafeRight()
	{
		IdleStand();
		animator.SetBool("IdleStrafeRight", value: true);
		animator2.SetBool("IdleStrafeRight", value: true);
		animator3.SetBool("IdleStrafeRight", value: true);
	}

	private void IdleStrafeLeft()
	{
		IdleStand();
		animator.SetBool("IdleStrafeLeft", value: true);
		animator2.SetBool("IdleStrafeLeft", value: true);
		animator3.SetBool("IdleStrafeLeft", value: true);
	}

	private void IdleRun()
	{
		IdleReady();
		animator.SetBool("IdleRun", value: true);
		animator2.SetBool("IdleRun", value: true);
		animator3.SetBool("IdleRun", value: true);
	}

	private void ComeHere()
	{
		IdleStand();
		animator.SetBool("ComeHere", value: true);
		animator2.SetBool("ComeHere", value: true);
		animator3.SetBool("ComeHere", value: true);
	}

	private void IdleKeepBack()
	{
		IdleStand();
		animator.SetBool("IdleKeepBack", value: true);
		animator2.SetBool("IdleKeepBack", value: true);
		animator3.SetBool("IdleKeepBack", value: true);
	}

	private void IdleFight()
	{
		Falses();
		idleFightbool = true;
		animator.SetBool("IdleFight", value: true);
		animator2.SetBool("IdleFight", value: true);
		animator3.SetBool("IdleFight", value: true);
	}

	private void IdleReadyCrouch()
	{
		IdleReady();
		animator.SetBool("IdleReadyCrouch", value: true);
		animator2.SetBool("IdleReadyCrouch", value: true);
		animator3.SetBool("IdleReadyCrouch", value: true);
	}

	private void IdleReadyLook()
	{
		IdleReady();
		animator.SetBool("IdleReadyLook", value: true);
		animator2.SetBool("IdleReadyLook", value: true);
		animator3.SetBool("IdleReadyLook", value: true);
	}

	private void IdleSad()
	{
		IdleStand();
		animator.SetBool("IdleSad", value: true);
		animator2.SetBool("IdleSad", value: true);
		animator3.SetBool("IdleSad", value: true);
	}

	private void IdleTurns()
	{
		IdleStand();
		animator.SetBool("IdleTurns", value: true);
		animator2.SetBool("IdleTurns", value: true);
		animator3.SetBool("IdleTurns", value: true);
	}

	private void Wizard1HandThrow()
	{
		IdleReady();
		animator.SetBool("Wizard1HandThrow", value: true);
		animator2.SetBool("Wizard1HandThrow", value: true);
		animator3.SetBool("Wizard1HandThrow", value: true);
	}

	private void Wizard2HandThrow()
	{
		IdleReady();
		animator.SetBool("Wizard2HandThrow", value: true);
		animator2.SetBool("Wizard2HandThrow", value: true);
		animator3.SetBool("Wizard2HandThrow", value: true);
	}

	private void WizardBlock()
	{
		IdleReady();
		animator.SetBool("WizardBlock", value: true);
		animator2.SetBool("WizardBlock", value: true);
		animator3.SetBool("WizardBlock", value: true);
	}

	private void WizardOverhead()
	{
		IdleReady();
		animator.SetBool("WizardOverhead", value: true);
		animator2.SetBool("WizardOverhead", value: true);
		animator3.SetBool("WizardOverhead", value: true);
	}

	private void WizardPowerUp()
	{
		IdleReady();
		animator.SetBool("WizardPowerUp", value: true);
		animator2.SetBool("WizardPowerUp", value: true);
		animator3.SetBool("WizardPowerUp", value: true);
	}

	private void IdleDie()
	{
		IdleReady();
		animator.SetBool("IdleDie", value: true);
		animator2.SetBool("IdleDie", value: true);
		animator3.SetBool("IdleDie", value: true);
	}

	private void Falses()
	{
		weaponStandbool = false;
		idleStandbool = false;
		idleReadybool = false;
		idleMonsterbool = false;
		idleFightbool = false;
		weaponRun = false;
		oneHandSwordIdle = false;
		pistolReadybool = false;
		bowIdle = false;
		motorbikeIdle = false;
		rollerBlade = false;
		skateboard = false;
		climbing = false;
		office = false;
		swim = false;
		wand = false;
		cards = false;
		breakdance = false;
		katana = false;
		soccer = false;
		giant = false;
		zombie = false;
		iceHockey = false;
		animator.SetBool("IceHockeyGoalieReady", value: false);
		animator2.SetBool("IceHockeyGoalieReady", value: false);
		animator3.SetBool("IceHockeyGoalieReady", value: false);
		animator.SetBool("IceHockeyDekeMiddle", value: false);
		animator2.SetBool("IceHockeyDekeMiddle", value: false);
		animator3.SetBool("IceHockeyDekeMiddle", value: false);
		animator.SetBool("IceHockeyIdle", value: false);
		animator2.SetBool("IceHockeyIdle", value: false);
		animator3.SetBool("IceHockeyIdle", value: false);
		animator.SetBool("1HandSwordStrafeLeft", value: false);
		animator2.SetBool("1HandSwordStrafeLeft", value: false);
		animator3.SetBool("1HandSwordStrafeLeft", value: false);
		animator.SetBool("1HandSwordStrafeRight", value: false);
		animator2.SetBool("1HandSwordStrafeRight", value: false);
		animator3.SetBool("1HandSwordStrafeRight", value: false);
		animator.SetBool("ZombieCrawl", value: false);
		animator2.SetBool("ZombieCrawl", value: false);
		animator3.SetBool("ZombieCrawl", value: false);
		animator.SetBool("ZombieWalk", value: false);
		animator2.SetBool("ZombieWalk", value: false);
		animator3.SetBool("ZombieWalk", value: false);
		animator.SetBool("ZombieIdle", value: false);
		animator2.SetBool("ZombieIdle", value: false);
		animator3.SetBool("ZombieIdle", value: false);
		animator.SetBool("WoodSaw", value: false);
		animator2.SetBool("WoodSaw", value: false);
		animator3.SetBool("WoodSaw", value: false);
		animator.SetBool("BlackSmithHammer", value: false);
		animator2.SetBool("BlackSmithHammer", value: false);
		animator3.SetBool("BlackSmithHammer", value: false);
		animator.SetBool("GiantGrabIdle2", value: false);
		animator2.SetBool("GiantGrabIdle2", value: false);
		animator3.SetBool("GiantGrabIdle2", value: false);
		animator.SetBool("GiantGrabIdle", value: false);
		animator2.SetBool("GiantGrabIdle", value: false);
		animator3.SetBool("GiantGrabIdle", value: false);
		animator.SetBool("WallSit", value: false);
		animator2.SetBool("WallSit", value: false);
		animator3.SetBool("WallSit", value: false);
		animator.SetBool("WallRunLeft", value: false);
		animator2.SetBool("WallRunLeft", value: false);
		animator3.SetBool("WallRunLeft", value: false);
		animator.SetBool("WallRunRight", value: false);
		animator2.SetBool("WallRunRight", value: false);
		animator3.SetBool("WallRunRight", value: false);
		animator.SetBool("ScubaSwim", value: false);
		animator2.SetBool("ScubaSwim", value: false);
		animator3.SetBool("ScubaSwim", value: false);
		animator.SetBool("BackPackOff", value: false);
		animator2.SetBool("BackPackOff", value: false);
		animator3.SetBool("BackPackOff", value: false);
		animator.SetBool("SneakForward", value: false);
		animator2.SetBool("SneakForward", value: false);
		animator3.SetBool("SneakForward", value: false);
		animator.SetBool("SneakBackward", value: false);
		animator2.SetBool("SneakBackward", value: false);
		animator3.SetBool("SneakBackward", value: false);
		animator.SetBool("SneakLeft", value: false);
		animator2.SetBool("SneakLeft", value: false);
		animator3.SetBool("SneakLeft", value: false);
		animator.SetBool("SneakRight", value: false);
		animator2.SetBool("SneakRight", value: false);
		animator3.SetBool("SneakRight", value: false);
		animator.SetBool("SneakIdle", value: false);
		animator2.SetBool("SneakIdle", value: false);
		animator3.SetBool("SneakIdle", value: false);
		animator.SetBool("SoccerRun", value: false);
		animator2.SetBool("SoccerRun", value: false);
		animator3.SetBool("SoccerRun", value: false);
		animator.SetBool("SoccerSprint", value: false);
		animator2.SetBool("SoccerSprint", value: false);
		animator3.SetBool("SoccerSprint", value: false);
		animator.SetBool("SoccerWalk", value: false);
		animator2.SetBool("SoccerWalk", value: false);
		animator3.SetBool("SoccerWalk", value: false);
		animator.SetBool("SoccerKeeperReady", value: false);
		animator2.SetBool("SoccerKeeperReady", value: false);
		animator3.SetBool("SoccerKeeperReady", value: false);
		animator.SetBool("Katana", value: false);
		animator2.SetBool("Katana", value: false);
		animator3.SetBool("Katana", value: false);
		animator.SetBool("KatanaReadyHigh", value: false);
		animator2.SetBool("KatanaReadyHigh", value: false);
		animator3.SetBool("KatanaReadyHigh", value: false);
		animator.SetBool("KatanaReady", value: false);
		animator2.SetBool("KatanaReady", value: false);
		animator3.SetBool("KatanaReady", value: false);
		animator.SetBool("KatanaReadyLow", value: false);
		animator2.SetBool("KatanaReadyLow", value: false);
		animator3.SetBool("KatanaReadyLow", value: false);
		animator.SetBool("KatanaReady", value: false);
		animator2.SetBool("KatanaReady", value: false);
		animator3.SetBool("KatanaReady", value: false);
		animator.SetBool("KneesIdle", value: false);
		animator2.SetBool("KneesIdle", value: false);
		animator3.SetBool("KneesIdle", value: false);
		animator.SetBool("WalkInjured", value: false);
		animator2.SetBool("WalkInjured", value: false);
		animator3.SetBool("WalkInjured", value: false);
		animator.SetBool("SatNightFever", value: false);
		animator2.SetBool("SatNightFever", value: false);
		animator3.SetBool("SatNightFever", value: false);
		animator.SetBool("RunningDance", value: false);
		animator2.SetBool("RunningDance", value: false);
		animator3.SetBool("RunningDance", value: false);
		animator.SetBool("RussianDance", value: false);
		animator2.SetBool("RussianDance", value: false);
		animator3.SetBool("RussianDance", value: false);
		animator.SetBool("ElvisLegsLoop", value: false);
		animator2.SetBool("ElvisLegsLoop", value: false);
		animator3.SetBool("ElvisLegsLoop", value: false);
		animator.SetBool("Flashlight", value: false);
		animator2.SetBool("Flashlight", value: false);
		animator3.SetBool("Flashlight", value: false);
		animator.SetBool("WalkBackward", value: false);
		animator2.SetBool("WalkBackward", value: false);
		animator3.SetBool("WalkBackward", value: false);
		animator.SetBool("Windmill", value: false);
		animator2.SetBool("Windmill", value: false);
		animator3.SetBool("Windmill", value: false);
		animator.SetBool("Flares", value: false);
		animator2.SetBool("Flares", value: false);
		animator3.SetBool("Flares", value: false);
		animator.SetBool("DeadmanFloat", value: false);
		animator2.SetBool("DeadmanFloat", value: false);
		animator3.SetBool("DeadmanFloat", value: false);
		animator.SetBool("2000", value: false);
		animator2.SetBool("2000", value: false);
		animator3.SetBool("2000", value: false);
		animator.SetBool("SixStep", value: false);
		animator2.SetBool("SixStep", value: false);
		animator3.SetBool("SixStep", value: false);
		animator.SetBool("ChannelCastOmni", value: false);
		animator2.SetBool("ChannelCastOmni", value: false);
		animator3.SetBool("ChannelCastOmni", value: false);
		animator.SetBool("ChannelCastDirected", value: false);
		animator2.SetBool("ChannelCastDirected", value: false);
		animator3.SetBool("ChannelCastDirected", value: false);
		animator.SetBool("BowInstant2", value: false);
		animator2.SetBool("BowInstant2", value: false);
		animator3.SetBool("BowInstant2", value: false);
		animator.SetBool("BowReady2", value: false);
		animator2.SetBool("BowReady2", value: false);
		animator3.SetBool("BowReady2", value: false);
		animator.SetBool("WalkDehydrated", value: false);
		animator2.SetBool("WalkDehydrated", value: false);
		animator3.SetBool("WalkDehydrated", value: false);
		animator.SetBool("UpHillWalk", value: false);
		animator2.SetBool("UpHillWalk", value: false);
		animator3.SetBool("UpHillWalk", value: false);
		animator.SetBool("CardPlayerIdle", value: false);
		animator2.SetBool("CardPlayerIdle", value: false);
		animator3.SetBool("CardPlayerIdle", value: false);
		animator.SetBool("DealerIdle", value: false);
		animator2.SetBool("DealerIdle", value: false);
		animator3.SetBool("DealerIdle", value: false);
		animator.SetBool("StaffStand", value: false);
		animator2.SetBool("StaffStand", value: false);
		animator3.SetBool("StaffStand", value: false);
		animator.SetBool("WandStand", value: false);
		animator2.SetBool("WandStand", value: false);
		animator3.SetBool("WandStand", value: false);
		animator.SetBool("SwimDogPaddle", value: false);
		animator2.SetBool("SwimDogPaddle", value: false);
		animator3.SetBool("SwimDogPaddle", value: false);
		animator.SetBool("SwimFreestyle", value: false);
		animator2.SetBool("SwimFreestyle", value: false);
		animator3.SetBool("SwimFreestyle", value: false);
		animator.SetBool("Swim", value: false);
		animator2.SetBool("Swim", value: false);
		animator3.SetBool("Swim", value: false);
		animator.SetBool("WateringCan", value: false);
		animator2.SetBool("WateringCan", value: false);
		animator3.SetBool("WateringCan", value: false);
		animator.SetBool("OfficeSittingReadingLeanBack", value: false);
		animator2.SetBool("OfficeSittingReadingLeanBack", value: false);
		animator3.SetBool("OfficeSittingReadingLeanBack", value: false);
		animator.SetBool("OfficeSittingReading", value: false);
		animator2.SetBool("OfficeSittingReading", value: false);
		animator3.SetBool("OfficeSittingReading", value: false);
		animator.SetBool("OfficeSittingLegCross", value: false);
		animator2.SetBool("OfficeSittingLegCross", value: false);
		animator3.SetBool("OfficeSittingLegCross", value: false);
		animator.SetBool("OfficeSittingBack", value: false);
		animator2.SetBool("OfficeSittingBack", value: false);
		animator3.SetBool("OfficeSittingBack", value: false);
		animator.SetBool("OfficeSitting45DegLeg", value: false);
		animator2.SetBool("OfficeSitting45DegLeg", value: false);
		animator3.SetBool("OfficeSitting45DegLeg", value: false);
		animator.SetBool("OfficeSitting1LegStraight", value: false);
		animator2.SetBool("OfficeSitting1LegStraight", value: false);
		animator3.SetBool("OfficeSitting1LegStraight", value: false);
		animator.SetBool("OfficeSitting", value: false);
		animator2.SetBool("OfficeSitting", value: false);
		animator3.SetBool("OfficeSitting", value: false);
		animator.SetBool("ClimbUp", value: false);
		animator2.SetBool("ClimbUp", value: false);
		animator3.SetBool("ClimbUp", value: false);
		animator.SetBool("ClimbIdle", value: false);
		animator2.SetBool("ClimbIdle", value: false);
		animator3.SetBool("ClimbIdle", value: false);
		animator.SetBool("SkateboardIdle", value: false);
		animator2.SetBool("SkateboardIdle", value: false);
		animator3.SetBool("SkateboardIdle", value: false);
		animator.SetBool("IdleFeedThrow", value: false);
		animator2.SetBool("IdleFeedThrow", value: false);
		animator3.SetBool("IdleFeedThrow", value: false);
		animator.SetBool("RollerBladeCrossoverLeft", value: false);
		animator2.SetBool("RollerBladeCrossoverLeft", value: false);
		animator3.SetBool("RollerBladeCrossoverLeft", value: false);
		animator.SetBool("RollerBladeTurnLeft", value: false);
		animator2.SetBool("RollerBladeTurnLeft", value: false);
		animator3.SetBool("RollerBladeTurnLeft", value: false);
		animator.SetBool("RollerBladeTurnRight", value: false);
		animator2.SetBool("RollerBladeTurnRight", value: false);
		animator3.SetBool("RollerBladeTurnRight", value: false);
		animator.SetBool("RollerBladeSkateFwd", value: false);
		animator2.SetBool("RollerBladeSkateFwd", value: false);
		animator3.SetBool("RollerBladeSkateFwd", value: false);
		animator.SetBool("RollerBladeCrossoverRight", value: false);
		animator2.SetBool("RollerBladeCrossoverRight", value: false);
		animator3.SetBool("RollerBladeCrossoverRight", value: false);
		animator.SetBool("RollerBladeGrindRoyale", value: false);
		animator2.SetBool("RollerBladeGrindRoyale", value: false);
		animator3.SetBool("RollerBladeGrindRoyale", value: false);
		animator.SetBool("RollerBladeRoll", value: false);
		animator2.SetBool("RollerBladeRoll", value: false);
		animator3.SetBool("RollerBladeRoll", value: false);
		animator.SetBool("RollerBladeStand", value: false);
		animator2.SetBool("RollerBladeStand", value: false);
		animator3.SetBool("RollerBladeStand", value: false);
		animator.SetBool("CrouchStrafeLeft", value: false);
		animator2.SetBool("CrouchStrafeLeft", value: false);
		animator3.SetBool("CrouchStrafeLeft", value: false);
		animator.SetBool("CrouchStrafeRight", value: false);
		animator2.SetBool("CrouchStrafeRight", value: false);
		animator3.SetBool("CrouchStrafeRight", value: false);
		animator.SetBool("CrouchWalkBackward", value: false);
		animator2.SetBool("CrouchWalkBackward", value: false);
		animator3.SetBool("CrouchWalkBackward", value: false);
		animator.SetBool("ProneLocomotion", value: false);
		animator2.SetBool("ProneLocomotion", value: false);
		animator3.SetBool("ProneLocomotion", value: false);
		animator.SetBool("ProneIdle", value: false);
		animator2.SetBool("ProneIdle", value: false);
		animator3.SetBool("ProneIdle", value: false);
		animator.SetBool("CrawlLocomotion", value: false);
		animator2.SetBool("CrawlLocomotion", value: false);
		animator3.SetBool("CrawlLocomotion", value: false);
		animator.SetBool("CrawlIdle", value: false);
		animator2.SetBool("CrawlIdle", value: false);
		animator3.SetBool("CrawlIdle", value: false);
		animator.SetBool("RunBackRight", value: false);
		animator2.SetBool("RunBackRight", value: false);
		animator3.SetBool("RunBackRight", value: false);
		animator.SetBool("RunBackLeft", value: false);
		animator2.SetBool("RunBackLeft", value: false);
		animator3.SetBool("RunBackLeft", value: false);
		animator.SetBool("WorkerShovel2", value: false);
		animator2.SetBool("WorkerShovel2", value: false);
		animator3.SetBool("WorkerShovel2", value: false);
		animator.SetBool("WorkerShovel", value: false);
		animator2.SetBool("WorkerShovel", value: false);
		animator3.SetBool("WorkerShovel", value: false);
		animator.SetBool("WorkerPickaxe", value: false);
		animator2.SetBool("WorkerPickaxe", value: false);
		animator3.SetBool("WorkerPickaxe", value: false);
		animator.SetBool("WorkerPickaxe2", value: false);
		animator2.SetBool("WorkerPickaxe2", value: false);
		animator3.SetBool("WorkerPickaxe2", value: false);
		animator.SetBool("WorkerHammer2", value: false);
		animator2.SetBool("WorkerHammer2", value: false);
		animator3.SetBool("WorkerHammer2", value: false);
		animator.SetBool("WorkerHammer", value: false);
		animator2.SetBool("WorkerHammer", value: false);
		animator3.SetBool("WorkerHammer", value: false);
		animator.SetBool("WoodCut", value: false);
		animator2.SetBool("WoodCut", value: false);
		animator3.SetBool("WoodCut", value: false);
		animator.SetBool("MotorbikeLasso", value: false);
		animator2.SetBool("MotorbikeLasso", value: false);
		animator3.SetBool("MotorbikeLasso", value: false);
		animator.SetBool("MotorbikeWheelyNoHands", value: false);
		animator2.SetBool("MotorbikeWheelyNoHands", value: false);
		animator3.SetBool("MotorbikeWheelyNoHands", value: false);
		animator.SetBool("MotorbikeWheely", value: false);
		animator2.SetBool("MotorbikeWheely", value: false);
		animator3.SetBool("MotorbikeWheely", value: false);
		animator.SetBool("MotorbikeSeatStandWheely", value: false);
		animator2.SetBool("MotorbikeSeatStandWheely", value: false);
		animator3.SetBool("MotorbikeSeatStandWheely", value: false);
		animator.SetBool("MotorbikeSeatStand", value: false);
		animator2.SetBool("MotorbikeSeatStand", value: false);
		animator3.SetBool("MotorbikeSeatStand", value: false);
		animator.SetBool("MotorbikeLookBack", value: false);
		animator2.SetBool("MotorbikeLookBack", value: false);
		animator3.SetBool("MotorbikeLookBack", value: false);
		animator.SetBool("MotorbikeHeartAttack", value: false);
		animator2.SetBool("MotorbikeHeartAttack", value: false);
		animator3.SetBool("MotorbikeHeartAttack", value: false);
		animator.SetBool("MotorbikeHeadstand", value: false);
		animator2.SetBool("MotorbikeHeadstand", value: false);
		animator3.SetBool("MotorbikeHeadstand", value: false);
		animator.SetBool("MotorbikeHandstand", value: false);
		animator2.SetBool("MotorbikeHandstand", value: false);
		animator3.SetBool("MotorbikeHandstand", value: false);
		animator.SetBool("MotorbikeHandlebarSit", value: false);
		animator2.SetBool("MotorbikeHandlebarSit", value: false);
		animator3.SetBool("MotorbikeHandlebarSit", value: false);
		animator.SetBool("MotorbikeBackwardStand", value: false);
		animator2.SetBool("MotorbikeBackwardStand", value: false);
		animator3.SetBool("MotorbikeBackwardStand", value: false);
		animator.SetBool("MotorbikeBackwardSitting", value: false);
		animator2.SetBool("MotorbikeBackwardSitting", value: false);
		animator3.SetBool("MotorbikeBackwardSitting", value: false);
		animator.SetBool("MotorbikeAirWalk", value: false);
		animator2.SetBool("MotorbikeAirWalk", value: false);
		animator3.SetBool("MotorbikeAirWalk", value: false);
		animator.SetBool("MotorbikeIdle", value: false);
		animator2.SetBool("MotorbikeIdle", value: false);
		animator3.SetBool("MotorbikeIdle", value: false);
		animator.SetBool("IdleStun", value: false);
		animator2.SetBool("IdleStun", value: false);
		animator3.SetBool("IdleStun", value: false);
		animator.SetBool("1HandSwordChargeUp", value: false);
		animator2.SetBool("1HandSwordChargeUp", value: false);
		animator3.SetBool("1HandSwordChargeUp", value: false);
		animator.SetBool("WeaponRunBackward", value: false);
		animator2.SetBool("WeaponRunBackward", value: false);
		animator3.SetBool("WeaponRunBackward", value: false);
		animator.SetBool("RunBackward", value: false);
		animator2.SetBool("RunBackward", value: false);
		animator3.SetBool("RunBackward", value: false);
		animator.SetBool("1HSwordStrafeRunRight", value: false);
		animator2.SetBool("1HSwordStrafeRunRight", value: false);
		animator3.SetBool("1HSwordStrafeRunRight", value: false);
		animator.SetBool("1HSwordStrafeRunLeft", value: false);
		animator2.SetBool("1HSwordStrafeRunLeft", value: false);
		animator3.SetBool("1HSwordStrafeRunLeft", value: false);
		animator.SetBool("WeaponStrafeRunRight", value: false);
		animator2.SetBool("WeaponStrafeRunRight", value: false);
		animator3.SetBool("WeaponStrafeRunRight", value: false);
		animator.SetBool("WeaponStrafeRunLeft", value: false);
		animator2.SetBool("WeaponStrafeRunLeft", value: false);
		animator3.SetBool("WeaponStrafeRunLeft", value: false);
		animator.SetBool("StrafeRunRight", value: false);
		animator2.SetBool("StrafeRunRight", value: false);
		animator3.SetBool("StrafeRunRight", value: false);
		animator.SetBool("StrafeRunLeft", value: false);
		animator2.SetBool("StrafeRunLeft", value: false);
		animator3.SetBool("StrafeRunLeft", value: false);
		animator.SetBool("FlyUp", value: false);
		animator2.SetBool("FlyUp", value: false);
		animator3.SetBool("FlyUp", value: false);
		animator.SetBool("FlyDown", value: false);
		animator2.SetBool("FlyDown", value: false);
		animator3.SetBool("FlyDown", value: false);
		animator.SetBool("FlyRight", value: false);
		animator2.SetBool("FlyRight", value: false);
		animator3.SetBool("FlyRight", value: false);
		animator.SetBool("FlyLeft", value: false);
		animator2.SetBool("FlyLeft", value: false);
		animator3.SetBool("FlyLeft", value: false);
		animator.SetBool("FlyBackward", value: false);
		animator2.SetBool("FlyBackward", value: false);
		animator3.SetBool("FlyBackward", value: false);
		animator.SetBool("FlyForward", value: false);
		animator2.SetBool("FlyForward", value: false);
		animator3.SetBool("FlyForward", value: false);
		animator.SetBool("IdleFly", value: false);
		animator2.SetBool("IdleFly", value: false);
		animator3.SetBool("IdleFly", value: false);
		animator.SetBool("IdleMeditate", value: false);
		animator2.SetBool("IdleMeditate", value: false);
		animator3.SetBool("IdleMeditate", value: false);
		animator.SetBool("ShotgunReloadMagazine", value: false);
		animator2.SetBool("ShotgunReloadMagazine", value: false);
		animator3.SetBool("ShotgunReloadMagazine", value: false);
		animator.SetBool("BowReady", value: false);
		animator2.SetBool("BowReady", value: false);
		animator3.SetBool("BowReady", value: false);
		animator.SetBool("BowInstant", value: false);
		animator2.SetBool("BowInstant", value: false);
		animator3.SetBool("BowInstant", value: false);
		animator.SetBool("BowFire", value: false);
		animator2.SetBool("BowFire", value: false);
		animator3.SetBool("BowFire", value: false);
		animator.SetBool("IdleStrafeLeft", value: false);
		animator2.SetBool("IdleStrafeLeft", value: false);
		animator3.SetBool("IdleStrafeLeft", value: false);
		animator.SetBool("IdleStrafeRight", value: false);
		animator2.SetBool("IdleStrafeRight", value: false);
		animator3.SetBool("IdleStrafeRight", value: false);
		animator.SetBool("CratePull", value: false);
		animator2.SetBool("CratePull", value: false);
		animator3.SetBool("CratePull", value: false);
		animator.SetBool("CratePush", value: false);
		animator2.SetBool("CratePush", value: false);
		animator3.SetBool("CratePush", value: false);
		animator.SetBool("IdleWalk", value: false);
		animator2.SetBool("IdleWalk", value: false);
		animator3.SetBool("IdleWalk", value: false);
		animator.SetBool("WeaponRun", value: false);
		animator2.SetBool("WeaponRun", value: false);
		animator3.SetBool("WeaponRun", value: false);
		animator.SetBool("WeaponStand", value: false);
		animator2.SetBool("WeaponStand", value: false);
		animator3.SetBool("WeaponStand", value: false);
		animator.SetBool("IdleReady", value: false);
		animator2.SetBool("IdleReady", value: false);
		animator3.SetBool("IdleReady", value: false);
		animator.SetBool("IdleStand", value: false);
		animator2.SetBool("IdleStand", value: false);
		animator3.SetBool("IdleStand", value: false);
		animator.SetBool("IdleMonster", value: false);
		animator2.SetBool("IdleMonster", value: false);
		animator3.SetBool("IdleMonster", value: false);
		animator.SetBool("WeaponReady", value: false);
		animator2.SetBool("WeaponReady", value: false);
		animator3.SetBool("WeaponReady", value: false);
		animator.SetBool("WeaponInstant", value: false);
		animator2.SetBool("WeaponInstant", value: false);
		animator3.SetBool("WeaponInstant", value: false);
		animator.SetBool("IdleFight", value: false);
		animator2.SetBool("IdleFight", value: false);
		animator3.SetBool("IdleFight", value: false);
		animator.SetBool("PistolReady", value: false);
		animator2.SetBool("PistolReady", value: false);
		animator3.SetBool("PistolReady", value: false);
		animator.SetBool("PistolInstant", value: false);
		animator2.SetBool("PistolInstant", value: false);
		animator3.SetBool("PistolInstant", value: false);
		animator.SetBool("OneHandSwordIdle", value: false);
		animator2.SetBool("OneHandSwordIdle", value: false);
		animator3.SetBool("OneHandSwordIdle", value: false);
		animator.SetBool("OneHandSwordReady", value: false);
		animator2.SetBool("OneHandSwordReady", value: false);
		animator3.SetBool("OneHandSwordReady", value: false);
		animator.SetBool("OneHandSwordRun", value: false);
		animator2.SetBool("OneHandSwordRun", value: false);
		animator3.SetBool("OneHandSwordRun", value: false);
		animator.SetBool("IdleRun", value: false);
		animator2.SetBool("IdleRun", value: false);
		animator3.SetBool("IdleRun", value: false);
		animator.SetBool("BowIdle", value: false);
		animator2.SetBool("BowIdle", value: false);
		animator3.SetBool("BowIdle", value: false);
		animator.SetBool("IdleReadyCrouch", value: false);
		animator2.SetBool("IdleReadyCrouch", value: false);
		animator3.SetBool("IdleReadyCrouch", value: false);
		animator.SetBool("CrouchWalk", value: false);
		animator2.SetBool("CrouchWalk", value: false);
		animator3.SetBool("CrouchWalk", value: false);
	}

	private void Update()
	{
		if (animator.GetFloat("Curve") > 0.1f)
		{
			if (animator.GetBool("BowFire"))
			{
				BowReady();
			}
			animator.SetBool("Giant2HandSlamIdle", value: false);
			animator2.SetBool("Giant2HandSlamIdle", value: false);
			animator3.SetBool("Giant2HandSlamIdle", value: false);
			animator.SetBool("GiantGrabIdle2", value: false);
			animator2.SetBool("GiantGrabIdle2", value: false);
			animator3.SetBool("GiantGrabIdle2", value: false);
			animator.SetBool("GiantGrabIdle", value: false);
			animator2.SetBool("GiantGrabIdle", value: false);
			animator3.SetBool("GiantGrabIdle", value: false);
			animator.SetBool("WateringCanWatering", value: false);
			animator2.SetBool("WateringCanWatering", value: false);
			animator3.SetBool("WateringCanWatering", value: false);
			animator.SetBool("OfficeSittingReadingPageFlip", value: false);
			animator2.SetBool("OfficeSittingReadingPageFlip", value: false);
			animator3.SetBool("OfficeSittingReadingPageFlip", value: false);
			animator.SetBool("OfficeSittingEyesRub", value: false);
			animator2.SetBool("OfficeSittingEyesRub", value: false);
			animator3.SetBool("OfficeSittingEyesRub", value: false);
			animator.SetBool("OfficeSittingHandRestFingerTap", value: false);
			animator2.SetBool("OfficeSittingHandRestFingerTap", value: false);
			animator3.SetBool("OfficeSittingHandRestFingerTap", value: false);
			animator.SetBool("OfficeSittingMouseMovement", value: false);
			animator2.SetBool("OfficeSittingMouseMovement", value: false);
			animator3.SetBool("OfficeSittingMouseMovement", value: false);
			animator.SetBool("OfficeSittingReadingCoffeeSip", value: false);
			animator2.SetBool("OfficeSittingReadingCoffeeSip", value: false);
			animator3.SetBool("OfficeSittingReadingCoffeeSip", value: false);
			animator.SetBool("VaderChoke", value: false);
			animator2.SetBool("VaderChoke", value: false);
			animator3.SetBool("VaderChoke", value: false);
			animator.SetBool("HeelClick", value: false);
			animator2.SetBool("HeelClick", value: false);
			animator3.SetBool("HeelClick", value: false);
			animator.SetBool("Yawn", value: false);
			animator2.SetBool("Yawn", value: false);
			animator3.SetBool("Yawn", value: false);
			animator.SetBool("360SpinDeath", value: false);
			animator2.SetBool("360SpinDeath", value: false);
			animator3.SetBool("360SpinDeath", value: false);
			animator.SetBool("ClimbLeft", value: false);
			animator2.SetBool("ClimbLeft", value: false);
			animator3.SetBool("ClimbLeft", value: false);
			animator.SetBool("ClimbRight", value: false);
			animator2.SetBool("ClimbRight", value: false);
			animator3.SetBool("ClimbRight", value: false);
			animator.SetBool("SkateboardKickPush", value: false);
			animator2.SetBool("SkateboardKickPush", value: false);
			animator3.SetBool("SkateboardKickPush", value: false);
			animator.SetBool("IdleStandingJump", value: false);
			animator2.SetBool("IdleStandingJump", value: false);
			animator3.SetBool("IdleStandingJump", value: false);
			animator.SetBool("IdleSlide", value: false);
			animator2.SetBool("IdleSlide", value: false);
			animator3.SetBool("IdleSlide", value: false);
			animator.SetBool("RollerBladeFrontFlip", value: false);
			animator2.SetBool("RollerBladeFrontFlip", value: false);
			animator3.SetBool("RollerBladeFrontFlip", value: false);
			animator.SetBool("RollerBladeBackFlip", value: false);
			animator2.SetBool("RollerBladeBackFlip", value: false);
			animator3.SetBool("RollerBladeBackFlip", value: false);
			animator.SetBool("RollerBladeStop", value: false);
			animator2.SetBool("RollerBladeStop", value: false);
			animator3.SetBool("RollerBladeStop", value: false);
			animator.SetBool("RollerBladeJump", value: false);
			animator2.SetBool("RollerBladeJump", value: false);
			animator3.SetBool("RollerBladeJump", value: false);
			animator.SetBool("MotorbikeSuperman", value: false);
			animator2.SetBool("MotorbikeSuperman", value: false);
			animator3.SetBool("MotorbikeSuperman", value: false);
			animator.SetBool("MotorbikeSpecialFlip", value: false);
			animator2.SetBool("MotorbikeSpecialFlip", value: false);
			animator3.SetBool("MotorbikeSpecialFlip", value: false);
			animator.SetBool("PistolLeftHandStab", value: false);
			animator2.SetBool("PistolLeftHandStab", value: false);
			animator3.SetBool("PistolLeftHandStab", value: false);
			animator.SetBool("IdleMouthWipe", value: false);
			animator2.SetBool("IdleMouthWipe", value: false);
			animator3.SetBool("IdleMouthWipe", value: false);
			animator.SetBool("IdleSpew", value: false);
			animator2.SetBool("IdleSpew", value: false);
			animator3.SetBool("IdleSpew", value: false);
			animator.SetBool("1HandSwordRollAttack", value: false);
			animator2.SetBool("1HandSwordRollAttack", value: false);
			animator3.SetBool("1HandSwordRollAttack", value: false);
			animator.SetBool("MotorbikeTurnRight", value: false);
			animator2.SetBool("MotorbikeTurnRight", value: false);
			animator3.SetBool("MotorbikeTurnRight", value: false);
			animator.SetBool("MotorbikeTurnLeft", value: false);
			animator2.SetBool("MotorbikeTurnLeft", value: false);
			animator3.SetBool("MotorbikeTurnLeft", value: false);
			animator.SetBool("MotorbikeShootLeft", value: false);
			animator2.SetBool("MotorbikeShootLeft", value: false);
			animator3.SetBool("MotorbikeShootLeft", value: false);
			animator.SetBool("MotorbikeShootRight", value: false);
			animator2.SetBool("MotorbikeShootRight", value: false);
			animator3.SetBool("MotorbikeShootRight", value: false);
			animator.SetBool("MotorbikeShootFwd", value: false);
			animator2.SetBool("MotorbikeShootFwd", value: false);
			animator3.SetBool("MotorbikeShootFwd", value: false);
			animator.SetBool("MotorbikeShootBack", value: false);
			animator2.SetBool("MotorbikeShootBack", value: false);
			animator3.SetBool("MotorbikeShootBack", value: false);
			animator.SetBool("MotorbikeLassoRight", value: false);
			animator2.SetBool("MotorbikeLassoRight", value: false);
			animator3.SetBool("MotorbikeLassoRight", value: false);
			animator.SetBool("MotorbikeLassoLeft", value: false);
			animator2.SetBool("MotorbikeLassoLeft", value: false);
			animator3.SetBool("MotorbikeLassoLeft", value: false);
			animator.SetBool("MotorbikeLassoBack", value: false);
			animator2.SetBool("MotorbikeLassoBack", value: false);
			animator3.SetBool("MotorbikeLassoBack", value: false);
			animator.SetBool("MotorbikeLassoFwd", value: false);
			animator2.SetBool("MotorbikeLassoFwd", value: false);
			animator3.SetBool("MotorbikeLassoFwd", value: false);
			animator.SetBool("MotorbikeBackwardSittingCheer", value: false);
			animator2.SetBool("MotorbikeBackwardSittingCheer", value: false);
			animator3.SetBool("MotorbikeBackwardSittingCheer", value: false);
			animator.SetBool("WeaponReadyFire", value: false);
			animator2.SetBool("WeaponReadyFire", value: false);
			animator3.SetBool("WeaponReadyFire", value: false);
			animator.SetBool("ShotgunReadyFire", value: false);
			animator2.SetBool("ShotgunReadyFire", value: false);
			animator3.SetBool("ShotgunReadyFire", value: false);
			animator.SetBool("1HandSwordChargeUp", value: false);
			animator2.SetBool("1HandSwordChargeUp", value: false);
			animator3.SetBool("1HandSwordChargeUp", value: false);
			animator.SetBool("1HandSwordChargeSwipe", value: false);
			animator2.SetBool("1HandSwordChargeSwipe", value: false);
			animator3.SetBool("1HandSwordChargeSwipe", value: false);
			animator.SetBool("1HandSwordChargeHeavyBash", value: false);
			animator2.SetBool("1HandSwordChargeHeavyBash", value: false);
			animator3.SetBool("1HandSwordChargeHeavyBash", value: false);
			animator.SetBool("1HandSwordShieldBash", value: false);
			animator2.SetBool("1HandSwordShieldBash", value: false);
			animator3.SetBool("1HandSwordShieldBash", value: false);
			animator.SetBool("Crouch180", value: false);
			animator2.SetBool("Crouch180", value: false);
			animator3.SetBool("Crouch180", value: false);
			animator.SetBool("WizardNeoBlock", value: false);
			animator2.SetBool("WizardNeoBlock", value: false);
			animator3.SetBool("WizardNeoBlock", value: false);
			animator.SetBool("WizardEyeBeam", value: false);
			animator2.SetBool("WizardEyeBeam", value: false);
			animator3.SetBool("WizardEyeBeam", value: false);
			animator.SetBool("ShotgunFire", value: false);
			animator2.SetBool("ShotgunFire", value: false);
			animator3.SetBool("ShotgunFire", value: false);
			animator.SetBool("IdleDodgeLeft", value: false);
			animator2.SetBool("IdleDodgeLeft", value: false);
			animator3.SetBool("IdleDodgeLeft", value: false);
			animator.SetBool("IdleDodgeRight", value: false);
			animator2.SetBool("IdleDodgeRight", value: false);
			animator3.SetBool("IdleDodgeRight", value: false);
			animator.SetBool("RunDive", value: false);
			animator2.SetBool("RunDive", value: false);
			animator3.SetBool("RunDive", value: false);
			animator.SetBool("RunJump", value: false);
			animator2.SetBool("RunJump", value: false);
			animator3.SetBool("RunJump", value: false);
			animator.SetBool("Cowboy1HandDraw", value: false);
			animator2.SetBool("Cowboy1HandDraw", value: false);
			animator3.SetBool("Cowboy1HandDraw", value: false);
			animator.SetBool("WeaponReload", value: false);
			animator2.SetBool("WeaponReload", value: false);
			animator3.SetBool("WeaponReload", value: false);
			animator.SetBool("WeaponFire", value: false);
			animator2.SetBool("WeaponFire", value: false);
			animator3.SetBool("WeaponFire", value: false);
			animator.SetBool("RHandPunch", value: false);
			animator2.SetBool("RHandPunch", value: false);
			animator3.SetBool("RHandPunch", value: false);
			animator.SetBool("LHandPunch", value: false);
			animator2.SetBool("LHandPunch", value: false);
			animator3.SetBool("LHandPunch", value: false);
			animator.SetBool("FaceHit", value: false);
			animator2.SetBool("FaceHit", value: false);
			animator3.SetBool("FaceHit", value: false);
			animator.SetBool("FrontKick", value: false);
			animator2.SetBool("FrontKick", value: false);
			animator3.SetBool("FrontKick", value: false);
			animator.SetBool("IdleCheer", value: false);
			animator2.SetBool("IdleCheer", value: false);
			animator3.SetBool("IdleCheer", value: false);
			animator.SetBool("ComeHere", value: false);
			animator2.SetBool("ComeHere", value: false);
			animator3.SetBool("ComeHere", value: false);
			animator.SetBool("IdleKeepBack", value: false);
			animator2.SetBool("IdleKeepBack", value: false);
			animator3.SetBool("IdleKeepBack", value: false);
			animator.SetBool("IdleReadyLook", value: false);
			animator2.SetBool("IdleReadyLook", value: false);
			animator3.SetBool("IdleReadyLook", value: false);
			animator.SetBool("IdleSad", value: false);
			animator2.SetBool("IdleSad", value: false);
			animator3.SetBool("IdleSad", value: false);
			animator.SetBool("Wizard1HandThrow", value: false);
			animator2.SetBool("Wizard1HandThrow", value: false);
			animator3.SetBool("Wizard1HandThrow", value: false);
			animator.SetBool("Wizard2HandThrow", value: false);
			animator2.SetBool("Wizard2HandThrow", value: false);
			animator3.SetBool("Wizard2HandThrow", value: false);
			animator.SetBool("WizardBlock", value: false);
			animator2.SetBool("WizardBlock", value: false);
			animator3.SetBool("WizardBlock", value: false);
			animator.SetBool("WizardOverhead", value: false);
			animator2.SetBool("WizardOverhead", value: false);
			animator3.SetBool("WizardOverhead", value: false);
			animator.SetBool("WizardPowerUp", value: false);
			animator2.SetBool("WizardPowerUp", value: false);
			animator3.SetBool("WizardPowerUp", value: false);
			animator.SetBool("PistolFire", value: false);
			animator2.SetBool("PistolFire", value: false);
			animator3.SetBool("PistolFire", value: false);
			animator.SetBool("PistolReload", value: false);
			animator2.SetBool("PistolReload", value: false);
			animator3.SetBool("PistolReload", value: false);
			animator.SetBool("OneHandSwordSwing", value: false);
			animator2.SetBool("OneHandSwordSwing", value: false);
			animator3.SetBool("OneHandSwordSwing", value: false);
			animator.SetBool("OneHandSwordBackSwing", value: false);
			animator2.SetBool("OneHandSwordBackSwing", value: false);
			animator3.SetBool("OneHandSwordBackSwing", value: false);
			animator.SetBool("OneHandSwordJab", value: false);
			animator2.SetBool("OneHandSwordJab", value: false);
			animator3.SetBool("OneHandSwordJab", value: false);
			animator.SetBool("OneHandSwordBlock", value: false);
			animator2.SetBool("OneHandSwordBlock", value: false);
			animator3.SetBool("OneHandSwordBlock", value: false);
			animator.SetBool("IdleDie", value: false);
			animator2.SetBool("IdleDie", value: false);
			animator3.SetBool("IdleDie", value: false);
			animator.SetBool("IdleTurns", value: false);
			animator2.SetBool("IdleTurns", value: false);
			animator3.SetBool("IdleTurns", value: false);
			animator.SetBool("ShotgunReloadChamber", value: false);
			animator2.SetBool("ShotgunReloadChamber", value: false);
			animator3.SetBool("ShotgunReloadChamber", value: false);
			animator.SetBool("NadeThrow", value: false);
			animator2.SetBool("NadeThrow", value: false);
			animator3.SetBool("NadeThrow", value: false);
			animator.SetBool("Idle180", value: false);
			animator2.SetBool("Idle180", value: false);
			animator3.SetBool("Idle180", value: false);
			animator.SetBool("IdleButtonPress", value: false);
			animator2.SetBool("IdleButtonPress", value: false);
			animator3.SetBool("IdleButtonPress", value: false);
			animator.SetBool("IdleTyping", value: false);
			animator2.SetBool("IdleTyping", value: false);
			animator3.SetBool("IdleTyping", value: false);
		}
	}
}
