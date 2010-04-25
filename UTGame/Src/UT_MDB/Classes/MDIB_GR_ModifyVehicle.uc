//===================================================
//	Interface: MDIB_GR_ModifyVehicle
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyVehicle extends MDIB_GR_Modify;

simulated function ModifyVehicle(Vehicle V, optional bool bRemoveBonus=false, optional int GlobalMultiplier);