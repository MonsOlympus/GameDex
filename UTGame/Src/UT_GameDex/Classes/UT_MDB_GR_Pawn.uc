//===================================================
//	Class: UT_MDB_GR_Pawn
//	Creation date: 20/08/2009 15:47
//	Last Updated: 20/04/2010 12:51
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Pawn extends UT_MDB_GameRules
	implements(MDIB_GR_ModifyPawn);
	
simulated function ModifyPawn(Pawn P, optional bool bRemoveBonus=false, optional int GlobalMultiplier);
