//===================================================
//	Class: UT_TPG_SpeedBoots
//	Creation date: 29/11/2007 14:50
//	Last updated: 25/03/2009 23:05
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//TODO: Make it so the speed effect only plays when the foot hits the ground!
//===================================================
class UT_TPG_SpeedBoots extends UT_TimedPowerupGeneric;

`include(MOD.uci)

var float SpeedBoost;		/// the Speed boost to give the owner
var float MultiJumpBoost;	/// the Z velocity boost to give the owner's double jumps

/** camera overlay effect - New blur effect, no motionblur sucks >:)*/
//var PostProcessChain CameraEffect;

//TODO: If player stops then Ambient = none?
//A_Vehicle_Hoverboard.Cue.A_Vehicle_Hoverboard_Jump

/** adds or removes our bonus from the given pawn */
simulated function AdjustPawn(UTPawn P, bool bRemoveBonus){
	local UTJumpBootEffect SpeedEffect;
	local bool bCheckDoubleLanding;

	if(P != None)	{
		if(!bRemoveBonus)		{
			`logd("Start Speed!",,'SpeedBoots');
//			DoMotionBlur(P);
//			ClientSetCameraEffect(P.Controller, true);

			SpeedEffect = Spawn(class'`pak1.UTSpeedBootEffect', P,, P.Location, P.Rotation);
//			SpeedEffect.LifeSpan = 30.00000;
//			SpeedEffect.JumpingEffect = ParticleSystem'Newtators_Pickups.Particles.P_SpeedBoot_Effect';

			P.AirControl = P.AirControl * SpeedBoost;
			P.GroundSpeed = P.GroundSpeed * SpeedBoost;
			P.WaterSpeed = P.WaterSpeed * SpeedBoost;
			P.AirSpeed = P.AirSpeed * SpeedBoost;
			P.MultiJumpBoost = P.MultiJumpBoost + MultiJumpBoost;

			bCheckDoubleLanding = P.bStopOnDoubleLanding;
			P.bStopOnDoubleLanding = False;
			P.SlopeBoostFriction = -0.400000;
			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
//			if (P.Controller != None) P.Controller.HighJumpNodeCostModifier += 1000;
		}		else		{
			`logd("End Speed!",,'SpeedBoots');
//			DoMotionBlur(P);
//			ClientSetCameraEffect(P.Controller, false);

			if(SpeedEffect != None)
				SpeedEffect.Destroyed();

			P.AirControl = P.AirControl / SpeedBoost;
			P.GroundSpeed = P.GroundSpeed / SpeedBoost;
			P.WaterSpeed = P.WaterSpeed / SpeedBoost;
			P.AirSpeed = P.AirSpeed / SpeedBoost;
			P.MultiJumpBoost = P.MultiJumpBoost - MultiJumpBoost;

			if(!bCheckDoubleLanding)
				P.bStopOnDoubleLanding = True;

			P.SlopeBoostFriction = 0.200000;
			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
//			if (P.Controller != None) P.Controller.HighJumpNodeCostModifier -= 1000;
		}
	}
}

/** turns on or off the camera effect */
/*reliable client function ClientSetCameraEffect(Controller C, bool bEnabled)
{
	local UTPlayerController PC;
	local LocalPlayer LP;
//	local MaterialEffect NewEffect;
//	local byte Team;
	local int i;

	PC = UTPlayerController(C);
	if(PC != None)
	{
		LP = LocalPlayer(PC.Player);
		if(LP != None)
		{
			if(bEnabled)
			{
				LP.InsertPostProcessingChain(CameraEffect, INDEX_NONE, true);
//				NewEffect = MaterialEffect(LP.PlayerPostProcess.FindPostProcessEffect('SpeedbootsEffect'));
//				if(NewEffect != None)
//				{
//					Team = C.GetTeamNum();
//					NewEffect.Material = (Team < TeamCameraMaterials.length) ? TeamCameraMaterials[Team] : TeamCameraMaterials[0];
//				}
			}
			else
			{
				for(i = 0; i < LP.PlayerPostProcessChains.length; i++)
				{
					if(LP.PlayerPostProcessChains[i].FindPostProcessEffect('SpeedbootsEffect') != None)
					{
						LP.RemovePostProcessingChain(i);
						i--;
					}
				}
			}
		}
	}
}

Simulated function DoMotionBlur(UTPawn P)
{
	local LocalPlayer			LocPlayer;
	local PostProcessEffect		PPE;

	LocPlayer = LocalPlayer(UTPlayerController(P.Controller).Player);
	if(LocPlayer != None)
	{
		PPE = LocPlayer.PlayerPostProcess.FindPostProcessEffect('MotionBlur');
		if(PPE != None)
		{
			PPE.bShowInGame = !PPE.bShowInGame;
		}

		if(PPE.bShowInGame)
		{
			MotionBlurEffect(PPE).MaxVelocity = 1.000000;//2.0
			MotionBlurEffect(PPE).MotionBlurAmount = 0.400000;//0.5,2.5
			MotionBlurEffect(PPE).CameraRotationThreshold=90.000000;//45
			MotionBlurEffect(PPE).CameraTranslationThreshold = 100.000000;
		}
		else
		{
			MotionBlurEffect(PPE).MaxVelocity = 1.000000;
			MotionBlurEffect(PPE).MotionBlurAmount = 0.400000;
			MotionBlurEffect(PPE).CameraRotationThreshold = 90.000000;
			MotionBlurEffect(PPE).CameraTranslationThreshold = 10000.000000;
		}
	}
}*/

//	FootSound = SoundGroupClass.static.GetFootstepSound(FootDown, GetMaterialBelowFeet());

//TODO: Add sound effect for jumping and dodging
/*simulated function OwnerEvent(name EventName)
{
	if(Role == ROLE_Authority)
	{
		if(EventName == 'MultiJump')
		{
			Charges--;
			UTPawn(Owner).JumpBootCharge = Charges;
			Spawn(class'UTJumpBootEffect', Owner,, Owner.Location, Owner.Rotation);
			Owner.PlaySound(ActivateSound, false, true, false);
		}
		else if(EventName == 'Landed' && Charges <= 0)
		{
			Destroy();
		}
	}
	else if(EventName == 'MultiJump')
	{
		Owner.PlaySound(ActivateSound, false, true, false);
	}
	UTPawn(Owner).bDodging;
}*/

defaultproperties
{
//	CameraEffect=PostProcessChain'Newtators_Pickups.Speedboots.LensEffects.SpeedbootsPostProcess'

	bCanDenyPowerup=True
	bHavePowerup=True
	SpeedBoost=1.4				//1.35,1.4, 1.45
	MultiJumpBoost=35.000000	//25
	TimeRemaining=30.000000
	RespawnTime=45.000000		//30.000000
//	PowerupAmbientSound=SoundCue'A_Vehicle_Hoverboard.Cue.A_Vehicle_Hoverboard_EngineCue'
	PowerupAmbientSound=SoundCue'Newtators_Pickups.Speedboots.Cue.SpeedbootsLoop'
//	PowerupSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Berzerk_WarningCue'
	HudIndex=4
//	PowerupOverSound=SoundCue'A_Vehicle_Hoverboard.Cue.A_Vehicle_Hoverboard_WaterDisruptCue'
	PowerupOverSound=SoundCue'Newtators_Pickups.Speedboots.Cue.SpeedbootsEnd'
	PowerupStatName="POWERUPTIME_SPEEDBOOTS"
	IconCoords=(U=744.000000,UL=35.000000,VL=55.000000)
//	PP_Scene_HighLights=(X=-0.150000,Y=-0.080000,Z=0.050000)
	PickupMessage="Speed Boots!"
//	bRenderOverlays=True
	bReceiveOwnerEvents=True
	MaxDesireability=1.000000
//	PickupSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_JumpBoots_PickupCue'
	PickupSound=SoundCue'Newtators_Pickups.Speedboots.Cue.SpeedbootsPickup'
	Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
		StaticMesh=StaticMesh'PICKUPS.JumpBoots.Mesh.S_UN_Pickups_Jumpboots002'
		Materials(0)=Material'Newtators_Pickups.SpeedBoots.Materials.M_SpeedBoots'
		bUseAsOccluder=False
		CastShadow=False
		bForceDirectLightMap=True
		bCastDynamicShadow=False
		CollideActors=False
		BlockRigidBody=False
		Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
		Scale=1.700000
		Name="StaticMeshComponent1"
		ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
	End Object
	DroppedPickupMesh=StaticMeshComponent1
	PickupFactoryMesh=StaticMeshComponent1
}