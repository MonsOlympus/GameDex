//===================================================
//	Interface: MDIB_GR_ModifyWeapon
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyWeapon extends MDIB_GR_Modify;

simulated function ModifyWeapon(Weapon W, optional bool bRemoveBonus=false, optional int GlobalMultiplier);