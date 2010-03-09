//===================================================
//	Class: UT_TPG_Booster
//	Creation date: 18/12/2007 02:23
//	Last updated: 25/03/2009 23:05
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_TPG_Booster extends UT_TimedPowerupGeneric;

`include(MOD.uci)

var UTPawn Pawnt;


simulated static function AddWeaponOverlay(UTGameReplicationInfo GRI){}

/** adds or removes our bonus from the given pawn */
simulated function AdjustPawn(UTPawn P, bool bRemoveBonus)
{
	if(P != None && Role == ROLE_Authority)
	{
		Pawnt = P;

		if(!bRemoveBonus)
		{
			Pawnt.Spawn(class'`pak1.UT_MDI_Booster',Pawnt);
			SetTimer(4.6, True, 'GiveHealth');
		}
		else
		{
			SetTimer(0.6, False, 'GiveHealth');
		}
	}
}

function GiveHealth()
{
	if(Pawnt != None)
	{
		if(Pawnt.Health >= Pawnt.SuperHealthMax)
			Pawnt.Health = Pawnt.SuperHealthMax;
		else
			Pawnt.Health = Pawnt.Health + 10;
	}
}

defaultproperties
{
	TimeRemaining=45.000000 //30,60
	WarningTime=6.000000
	RespawnTime=110.000000 //90

	bCanDenyPowerup=True
	bHavePowerup=True

	PowerupFadingSound=SoundCue'Newtators_Pickups.Booster.Cue.BoosterFading'
	PickupSound=SoundCue'Newtators_Pickups.Booster.Cue.BoosterPickup'
	PowerupAmbientSound=SoundCue'Newtators_Pickups.Booster.Cue.BoosterLoop'
//	PowerupOverSound=SoundCue'Newtators_Pickups.VDamage.Cue.Invis_VDamage_End2'

	/*
   OverlayMaterialInstance=Material'PICKUPS.Berserk.M_Berserk_Overlay'
   VehicleWeaponEffect=(Mesh=StaticMesh'Envy_Effects.Mesh.S_VH_Powerups',Material=Material'Envy_Effects.Energy.Materials.M_VH_Beserk')
   HudIndex=1
   PowerupOverSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Berzerk_EndCue'*/
	PowerupStatName="POWERUPTIME_BOOSTER"
	IconCoords=(U=744.000000,UL=35.000000,VL=55.000000)
	PP_Scene_HighLights=(X=0.000000,Y=0.300000,Z=0.000000)//(X=-0.150000,Y=0.180000,Z=-0.150000)
//	bRenderOverlays=True
	bReceiveOwnerEvents=True
	PickupMessage="BOOSTER!"
//	PickupSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Berzerk_PickupCue'
	Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
		StaticMesh=StaticMesh'PICKUPS.Berserk.Mesh.S_Pickups_Berserk'
		Materials(0)=Material'Newtators_Pickups.Booster.Materials.M_Booster'
		CullDistance=8000.000000
		CachedCullDistance=8000.000000
		bUseAsOccluder=False
		CastShadow=False
		bForceDirectLightMap=True
		bCastDynamicShadow=False
		CollideActors=False
		BlockRigidBody=False
		Translation=(X=0.000000,Y=0.000000,Z=5.000000)
		Scale3D=(X=0.700000,Y=0.700000,Z=0.700000)
//		Name="MeshComponentA"
//		ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
	End Object
	DroppedPickupMesh=MeshComponentA
	PickupFactoryMesh=MeshComponentA

/*   Begin Object Class=UTParticleSystemComponent Name=BerserkParticles ObjName=BerserkParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
	  Template=ParticleSystem'PICKUPS.Berserk.Effects.P_Pickups_Berserk_Idle'
	  bAutoActivate=False
	  Translation=(X=0.000000,Y=0.000000,Z=5.000000)
	  Name="BerserkParticles"
	  ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   DroppedPickupParticles=BerserkParticles*/
//   Name="Default__UTBooster"
//   ObjectArchetype=UTTimedPowerup_Generic'MutatorFramework.Default__UTTimedPowerup_Generic'
}
