//===================================================
//	Interface: MDIB_GR_ModifyScoreObjective
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyScoreObjective extends MDIB_GR_Modify;

simulated function ModifyScoreObjective(PlayerReplicationInfo Scorer, Int Score);