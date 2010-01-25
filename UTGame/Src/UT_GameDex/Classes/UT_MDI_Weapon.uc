//===================================================
//	Class: UT_MDI_Weapon
//	Creation date: 13/12/2008 18:00
//	Last updated: 07/09/2009 05:09
//	Contributors: 00zX
//---------------------------------------------------
//This class gets attached to the weapon and makes adjustments.
//===================================================
class UT_MDI_Weapon extends UT_MDI;

`include(MOD.uci)

//var array< class< UTWeapon > > cUseforWeaps;

/** Weapon class so we can check owner is right type and set vars */
//var UTWeapon Weap;

/** Gets the times from the weapons and sets them to the replicated variables */
reliable server function GetWeapProps(UTWeapon W);

/** Sets the clients weapon to use the replicated variables */
reliable client function SetWeapProps(UTWeapon W);

/** Make sure we have an owner and its the right type before moving on */
//simulated event PostBeginPlay()
event PostBeginPlay()
{
//	local int i;
	`logd("Owner:"$Owner,,'MDI_Weapon');

	if(UTWeapon(Owner) == None)/* || cUseforWeaps.length <= 0)*/
		Destroy();

//	Weap = UTWeapon(Owner);
//	if(Weap != None){
/*		for(i==0;i<cUseforWeaps.length;i++){
			if(Weap.IsA(cUseforWeaps[i]){*/
				if(WorldInfo.NetMode != NM_Client)
					GetWeapProps(UTWeapon(Owner));

				SetTimer(0.01, false, 'SetPropsTimer');
/*			}else
				Destroy();
		}*/
//	}else
//		Destroy();
}

function SetPropsTimer(){	SetWeapProps(UTWeapon(Owner));}

defaultproperties
{
	//remove all from array
	//cUseforWeapons(0)=none

	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True

}