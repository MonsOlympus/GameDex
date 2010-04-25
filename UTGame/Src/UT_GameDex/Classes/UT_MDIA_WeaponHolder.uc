//===================================================
//	Class: UT_MDIA_WeaponHolder
//	Creation Date: 21/04/2010 05:23
//	Last Updated: 21/04/2010 05:26
//	Contributors: 00zX
//---------------------------------------------------
//Holder for a pawn's old weapon
//Used by AbilityNoWeaponDrop to keep a pawn's active weapon and ammo after the pawn dies
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDIA_WeaponHolder extends UT_MDI_Actor;

var Weapon Weapon;

/*function PostBeginPlay()
{
	SetTimer(1.0, true);

	Super.PostBeginPlay();
}*/

function CheckOwner()
{
	if (Controller(Owner) == None || Weapon == None)
		Destroy();
}

function Destroyed()
{
	if (Weapon != None)
		Weapon.Destroy();

	Super.Destroyed();
}

defaultproperties
{
	 bHidden=True
	 RemoteRole=ROLE_None
}