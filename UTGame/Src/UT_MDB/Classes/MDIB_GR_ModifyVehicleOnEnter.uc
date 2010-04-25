//===================================================
//	Interface: MDIB_GR_ModifyVehicleOnEnter
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyVehicleOnEnter extends MDIB_GR_Modify;

simulated function ModifyVehicleOnEnter(Vehicle V, optional bool bRemoveBonus=false, optional int GlobalMultiplier);