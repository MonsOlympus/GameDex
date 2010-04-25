//===================================================
//	Interface: MDIB_GR_ModifyActor
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyActor extends MDIB_GR_Modify;

simulated function ModifyActor(Actor A, optional bool bRemoveBonus=false, optional int GlobalMultiplier);