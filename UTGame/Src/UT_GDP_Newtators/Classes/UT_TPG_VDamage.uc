//===================================================
//	Class: UT_TPG_VDamage
//	Creation date: 18/12/2007 03:58
//	Last updated: 25/03/2009 23:05
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_TPG_VDamage extends UT_TimedPowerupGeneric;

/** post processing applied while holding this powerup */
var vector PP_Scene_MidTones;
var vector PP_Scene_Shadows;

//TODO: Some kind of kewl semi transparent material for the player.

simulated static function AddWeaponOverlay(UTGameReplicationInfo GRI)
{
	GRI.WeaponOverlays[2] = default.OverlayMaterialInstance;
	GRI.VehicleWeaponEffects[2] = default.VehicleWeaponEffect;
}

/** adds or removes our bonus from the given pawn */
/*simulated function AdjustPawn(UTPawn P, bool bRemoveBonus)
{
	if(P != None && Role == ROLE_Authority)
	{
		if(!bRemoveBonus){}
		else{}
	}
}*/

//SkeletalMeshComponent(Mesh).AttachComponentToSocket( BeamEmitter[CurrentFireMode],BeamSockets[CurrentFireMode] );
//Mesh.GetSocketWorldLocationAndRotation('RocketSocket',RocketSocketL, RocketSocketR);

//SkeletalMeshComponent(Mesh).Attachments[i]

//native final function AttachComponent(ActorComponent Component,name BoneName,optional vector RelativeLocation,optional rotator RelativeRotation,optional vector RelativeScale);
//native final function DetachComponent(ActorComponent Component);
//native final function SkeletalMeshSocket GetSocketByName( Name InSocketName );

/** applies and removes any post processing effects while holding this item */
simulated function AdjustPPEffects(Pawn P, bool bRemove)
{
	local UTPlayerController PC;

	if(P != None){
		PC = UTPlayerController(P.Controller);
		if(PC == None && P.DrivenVehicle != None){
			PC = UTPlayerController(P.DrivenVehicle.Controller);
		}
		if (PC != None){
			if(bRemove){
				PC.PostProcessModifier.Scene_HighLights -= PP_Scene_Highlights;
				PC.PostProcessModifier.Scene_MidTones -= PP_Scene_MidTones;
				PC.PostProcessModifier.Scene_Shadows -= PP_Scene_Shadows;
			}else{
				PC.PostProcessModifier.Scene_HighLights += PP_Scene_Highlights;
				PC.PostProcessModifier.Scene_MidTones += PP_Scene_MidTones;
				PC.PostProcessModifier.Scene_Shadows += PP_Scene_Shadows;
			}
		}
	}
}

defaultproperties
{
	AssignWeaponOverlay=2	//my values start here

	PickupMessage="Vampire!"		//"VAMPYRIC DAMAGE!"
//	PickupMessage="BLOODLUST!"		//"VAMPYRIC DAMAGE!"

	TimeRemaining=45.000000
	RespawnTime=96.000000

//	PowerupFadingSound=SoundCue'Newtators_Pickups.VDamage.Cue.Invis_VDamage_Loop'
	PowerupFireSound=SoundCue'Newtators_Pickups.VDamage.Cue.VDamage_FireSound'
	PickupSound=SoundCue'Newtators_Pickups.VDamage.Cue.Necris_IHunger_VDamage'

//	PowerupAmbientSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Invisibility_PowerLoopCue'
	PowerupAmbientSound=SoundCue'Newtators_Pickups.VDamage.Cue.Invis_VDamage_Loop'
	PowerupOverSound=SoundCue'Newtators_Pickups.VDamage.Cue.Invis_VDamage_End2'

	OverlayMaterialInstance=Material'Newtators_Pickups.VDamage.M_VDamage_Overlay'
	VehicleWeaponEffect=(Mesh=StaticMesh'Envy_Effects.Mesh.S_VH_Powerups',Material=Material'Envy_Effects.Energy.Materials.M_VH_Beserk')
	PowerupStatName="POWERUPTIME_BLOODLUST"
	IconCoords=(U=792.000000,V=41.000000,UL=43.000000,VL=58.000000)

	PP_Scene_HighLights=(X=-0.100000,Y=0.080000,Z=0.080000)//(X=0.180000,Y=0.200000,Z=0.200000)
	PP_Scene_MidTones=(X=-0.060000,Y=0.060000,Z=0.060000)//(X=-0.080000,Y=0.060000,Z=0.060000)
	PP_Scene_Shadows=(X=-0.030000,Y=0.030000,Z=0.030000)//(X=-0.040000,Y=0.030000,Z=0.030000)

	bRenderOverlays=True
	bReceiveOwnerEvents=True

	bCanDenyPowerup=False
	Begin Object Class=StaticMeshComponent Name=MeshComponentV ObjName=MeshComponentV Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
		StaticMesh=StaticMesh'PICKUPS.UDamage.Mesh.S_Pickups_UDamage'
		Materials(0)=Material'Newtators_Pickups.VDamage.Materials.M_Vdamage_Base'
		Materials(1)=Material'Newtators_Pickups.VDamage.Materials.M_Vdamage_Add'
//		CullDistance=8000.000000
//		CachedCullDistance=8000.000000
		bUseAsOccluder=False
		CastShadow=False
		bForceDirectLightMap=True
		bCastDynamicShadow=False
		CollideActors=False
		BlockRigidBody=False
		Translation=(X=0.000000,Y=0.000000,Z=5.000000)
		Scale3D=(X=0.600000,Y=0.800000,Z=0.600000)//Scale3D=(X=0.600000,Y=0.600000,Z=0.600000)
	End Object
	DroppedPickupMesh=MeshComponentV
	PickupFactoryMesh=MeshComponentV
	Begin Object Class=UTParticleSystemComponent Name=PickupParticles ObjName=PickupParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
		Template=ParticleSystem'Newtators_Pickups.VDamage.Effects.P_Pickups_VDamage_Idle'
		bAutoActivate=False
		Translation=(X=0.000000,Y=0.000000,Z=5.000000)
		SecondsBeforeInactive=1.0f
	End Object
	DroppedPickupParticles=PickupParticles
}