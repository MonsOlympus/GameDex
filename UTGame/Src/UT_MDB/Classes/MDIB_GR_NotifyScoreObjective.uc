//===================================================
//	Interface: MDIB_GR_NotifyScoreObjective
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_NotifyScoreObjective extends MDIB_GR_Modify;

simulated function NotifyScoreObjective(PlayerReplicationInfo Scorer, Int Score);