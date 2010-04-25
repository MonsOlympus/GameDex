//===================================================
//	Interface: MDIB_GR_ModifyController
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyController extends MDIB_GR_Modify;

simulated function ModifyController(Actor A, optional bool bRemoveBonus=false, optional int GlobalMultiplier);