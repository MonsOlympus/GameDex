//===================================================
//	Class: UT_MDIA_SwitchSpeed
//	Creation Date: 14/12/2007 23:57
//	Last Updated: 14/04/2010 06:34
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDIA_SwitchSpeed extends UT_MDI_Actor;

/** How long does it take to Equip this weapon */
var() repnotify float NewEquipTime;

/** How long does it take to put this weapon down */
var() repnotify float NewPutDownTime;

//var() repnotify float NewFireInterval;

replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		NewEquipTime, NewPutDownTime;
}

/** Gets the times from the weapons and sets them to the replicated variables */
reliable server function GetWeapProps(UTWeapon W)
{
//	`logd("Server: "$W$" OldEquipTime = "$W.default.EquipTime$" OldPutDownTime = "$W.default.EquipTime,,'FastWeapSwitch');
	NewEquipTime = W.default.EquipTime * 0.68;		//0.5-0.75
	NewPutDownTime = W.default.PutDownTime * 0.70;	//0.5-0.75
//	`logd("Server: NewEquipTime = "$NewEquipTime$" NewPutDownTime = "$NewPutDownTime,,'FastWeapSwitch');
}

/** Sets the clients weapon to use the replicated variables */
reliable client function SetWeapProps(UTWeapon W)
{
	W.EquipTime = NewEquipTime;
	W.PutDownTime = NewPutDownTime;
//	`logd("Client: "$W$" EquipTime = "$W.EquipTime$" PutDownTime = "$W.PutDownTime,,'FastWeapSwitch');
}

defaultproperties
{
	cUseforActors(0)=class'UTWeapon'
}