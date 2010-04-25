//===================================================
//	Interface: MDIB_GR_ModifyRook
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyRook extends MDIB_GR_Modify;

simulated function ModifyRook(UTHeroPawn R, optional bool bRemoveBonus=false, optional int GlobalMultiplier);