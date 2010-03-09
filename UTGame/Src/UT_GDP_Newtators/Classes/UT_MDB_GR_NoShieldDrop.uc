//===================================================
//	Class: UT_MDB_GR_NoShieldDrop
//	Creation date: 04/04/2009 18:12
//	Last updated: 07/03/2010 01:16
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_NoShieldDrop extends UT_MDB_GR_Pawn;

simulated function ModifyPawn(Pawn P, optional bool bRemoveBonus=false, optional int AbilityLevel)
{
	Super.ModifyPawn(P, bRemoveBonus, AbilityLevel);
	UTPawn(P).ShieldBeltPickupClass = None;
}