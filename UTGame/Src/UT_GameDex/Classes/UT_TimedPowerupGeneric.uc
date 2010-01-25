//===================================================
//	Class: UT_TimedPowerupGeneric
//	Creation date: 19/12/2007 01:40
//	Last Updated: 25/03/2009 23:05
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_TimedPowerupGeneric extends UTTimedPowerup
	abstract;

/** sound played when our owner fires */
var SoundCue PowerupFireSound;
/** sound played when the UDamage is running out */
var SoundCue PowerupFadingSound;
/** last time we played that sound, so it isn't too often */
var float LastPowerupSoundTime;

/** overlay material applied to owner */
var MaterialInterface OverlayMaterialInstance;
var byte AssignWeaponOverlay;	//For unique Weapon Overlay in GRI

/** particle effect played on vehicle weapons */
var MeshEffect VehicleWeaponEffect;
/** ambient sound played while active*/
var SoundCue PowerupAmbientSound;
/** already have boots cant get more */
var bool bCanDenyPowerup;
/** already have boots cant get more */
var bool bHavePowerup;


/*function SetWeaponOverlayFlag(byte FlagToSet)
{
	ApplyWeaponOverlayFlags(WeaponOverlayFlags | (1 << FlagToSet));
}

function ClearWeaponOverlayFlag(byte FlagToClear)
{
	ApplyWeaponOverlayFlags(WeaponOverlayFlags & ( 0xFF ^ (1 << FlagToClear)) );
}*/

/*simulated static function AddWeaponOverlay(UTGameReplicationInfo GRI)
{
	if(default.OverlayMaterialInstance != None)
	{
//		GRI.WeaponOverlays[class.default.AssignWeaponOverlay] = default.OverlayMaterialInstance;
		GRI.WeaponOverlays[class.default.AssignWeaponOverlay] = class.default.OverlayMaterialInstance;
	}

	if(default.VehicleWeaponEffect.Mesh != None && default.VehicleWeaponEffect.Material != None)
	{
//		GRI.VehicleWeaponEffects[class.default.AssignWeaponOverlay] = default.VehicleWeaponEffect;
	}
}*/

simulated function AdjustPawn(UTPawn P, bool bRemoveBonus){}

function GivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	local UTPawn P;

	Super.GivenTo(NewOwner, bDoNotActivate);

	P = UTPawn(NewOwner);
	if(P != None)	{
		AdjustPawn(P, false);
		bHavePowerup = True;

		if(PowerupAmbientSound != None)		{
			P.SetPawnAmbientSound(PowerupAmbientSound);
		}

		if(OverlayMaterialInstance != None)		{
			// apply Pickup overlay
			P.SetWeaponOverlayFlag(AssignWeaponOverlay);
		}
	}

	if(PowerupFadingSound != None)	{
		// set timer for ending sounds
		SetTimer(TimeRemaining - 3.0, false, 'PlayPowerupFadingSound');
	}
}

reliable client function ClientGivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	Super.ClientGivenTo(NewOwner, bDoNotActivate);

	if(Role < ROLE_Authority)	{
		AdjustPawn(UTPawn(NewOwner), false);
	}
}

function ItemRemovedFromInvManager()
{
	local UTPlayerReplicationInfo UTPRI;
	local UTPawn P;

	P = UTPawn(Owner);
	if(P != None)	{
		if(PowerupAmbientSound != None)		{
			P.SetPawnAmbientSound(none);
		}

		if(OverlayMaterialInstance != None)		{
			P.ClearWeaponOverlayFlag(AssignWeaponOverlay);
		}

		//Stop the timer on the powerup stat
		if(P.DrivenVehicle != None)		{
			UTPRI = UTPlayerReplicationInfo(P.DrivenVehicle.PlayerReplicationInfo);
		}		else		{
			UTPRI = UTPlayerReplicationInfo(P.PlayerReplicationInfo);
		}

		if(UTPRI != None)		{
			UTPRI.StopPowerupTimeStat(GetPowerupStatName());
		}
	}

	if (PowerupFadingSound != None)
	{
		SetTimer(0.0, false, 'PlayPowerupFadingSound');
	}
}

simulated function OwnerEvent(name EventName)
{
	if(PowerupFireSound != None)
	{
		if(EventName == 'FiredWeapon' && Instigator != None && WorldInfo.TimeSeconds - LastPowerupSoundTime > 0.25)
		{
			LastPowerupSoundTime = WorldInfo.TimeSeconds;
			Instigator.PlaySound(PowerupFireSound, false, true);
		}
	}
}

/** called on a timer to play UDamage ending sound */
function PlayPowerupFadingSound()
{
	// reset timer if time got added
	if(TimeRemaining > 3.0)	{
		SetTimer(TimeRemaining - 3.0, false, 'PlayPowerupFadingSound');
	}	else	{
		Instigator.PlaySound(PowerupFadingSound);
		SetTimer(0.75, false, 'PlayPowerupFadingSound');
	}
}

function bool DenyPickupQuery(class<Inventory> ItemClass, Actor Pickup)
{
	Super.DenyPickupQuery(ItemClass, Pickup);

	if(ItemClass == Class && bCanDenyPowerup)	{
		bHavePowerup = default.bHavePowerup;
		Pickup.PickedUpBy(Instigator);
		AnnouncePickup(Instigator);
		return true;
	}

	return false;
}

simulated event Destroyed()
{
//	if (Role < ROLE_Authority)
//	{
		AdjustPawn(UTPawn(Owner), true);
		bHavePowerup = False;
//	}

	Super.Destroyed();
}

defaultproperties
{
	AssignWeaponOverlay=5	//my values start here
}
