//===================================================
//	Class: UT_MDI_Weapon
//	Creation date: 13/12/2008 18:00
//	Last Updated: 10/03/2010 09:33
//	Contributors: 00zX
//---------------------------------------------------
//This class gets attached to the weapon and makes adjustments.
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI_Weapon extends UT_MDI;

var array< class< UTWeapon > > cUseforWeaps;

/** Gets the times from the weapons and sets them to the replicated variables */
reliable server function GetWeapProps(UTWeapon W);

/** Sets the clients weapon to use the replicated variables */
reliable client function SetWeapProps(UTWeapon W);

final function bool Allowed(UTWeapon W, optional bool bUseforSubclasses=false)
{
	local class<UTWeapon> UTWC;

	foreach cUseforWeaps(UTWC)
	{
		if(!bUseforSubclasses)
		{
			//if(W.IsA(UTWC))
			if(W.class == UTWC)
				return true;
		}
		else
		{
			if(ClassIsChildOf(W.Class, UTWC))
				return true;
		}
	}
	return false;
}

/** Make sure we have an owner and its the right type before moving on */
simulated event PostBeginPlay()
{
//	`logd("Owner:"$Owner,,'MDI_Weapon');

	if(UTWeapon(Owner) == None)
		Destroy();
	
	if(Allowed(UTWeapon(Owner), true))
	{
		if(WorldInfo.NetMode != NM_Client)
			GetWeapProps(UTWeapon(Owner));

		SetTimer(UpdateRate, false, 'SetPropsTimer');
		SetTimer(DestroyTime,true, 'CheckOwner');
	}
}

function SetPropsTimer()
{
	SetWeapProps(UTWeapon(Owner));
}

function CheckOwner()
{
	if(UTWeapon(Owner) == None)
	{
//		`logd("MDI: Info: "$self$".Destroy();",,'GameExp');
		Destroy();
	}
}

defaultproperties
{
	//remove all from array
	cUseforWeaps(0)=class'UTWeapon'

	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True

}