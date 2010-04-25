//===================================================
//	Interface: MDIB_GR_ModifyPawn
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyPawn extends MDIB_GR_Modify;

//TODO: Obsolete? Depreciate!
//NOTE: This will only allow modification of defaults, might prove to be useful though being static
simulated function ModifyPawn(Pawn P, optional bool bRemoveBonus=false, optional int GlobalMultiplier);