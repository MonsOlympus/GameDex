//===================================================
//	Class: UT_MDI_W_EnforcerDual
//	Creation date: 17/05/2008 00:55
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//This class gets attached to the weapon and makes adjustments.
//===================================================
class UT_MDI_W_EnforcerDual extends UT_MDI_Weapon;

/** How long does it take to Equip this weapon */
var() repnotify bool NewbLoaded;

replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		NewbLoaded;
}

/**
 * On a remote client, watch for a change in bDualMode and if it changes, signal this has become a dual
 * weapon.
 */
/*simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'DualMode')
		BecomeDual();
	else
		Super.ReplicatedEvent(VarName);
}*/


/** Gets the times from the weapons and sets them to the replicated variables */
reliable server function GetWeapProps(UTWeapon W)
{
	NewbLoaded = True;
}

/** Sets the clients weapon to use the replicated variables */
reliable client function SetWeapProps(UTWeapon W)
{
//	local int i;

//	for (i=0;i<cUseforWeaps.length;i++)
//	{
/*		if(W.IsA(cUseforWeaps())
		{*/
			//UTWeap_Enforcer(W).DualMode == EDM_Dual;
//			UTWeap_Enforcer(W).DualMode = EDM_DualEquipping;
			UTWeap_Enforcer(W).DelayedBecomeDual(); //Oiiiii!~
			UTWeap_Enforcer(W).bLoaded = NewbLoaded;
//			UTWeap_Enforcer(W).BecomeDual();


/*		}*/
//	}
//	`logd("Client: "$W$" EquipTime = "$W.EquipTime$" PutDownTime = "$W.PutDownTime,,'FastWeapSwitch');
}

defaultproperties
{
//	cUseforWeaps(0)=class'UTGame.UTWeap_Enforcer'
}