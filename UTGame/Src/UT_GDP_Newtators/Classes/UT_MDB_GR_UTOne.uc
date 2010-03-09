//===================================================
//	Class: UT_MDB_GR_UTOne
//	Creation date: 27/11/2007 15:52
//	Last updated: 07/03/2010 01:16
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_UTOne extends UT_MDB_GR_Pawn;

var bool bCanWalldodge;

simulated function ModifyPawn(Pawn P, optional bool bRemoveBonus=false, optional int AbilityLevel)
{
	Super.ModifyPawn(P, bRemoveBonus, AbilityLevel);

	UTPawn(P).bCanDoubleJump=False;		//UT3: True
	UTPawn(P).MaxMultiJump = 0;			//UT3: 1
	UTPawn(P).MultiJumpRemaining = 0;		//UT3: 1
	UTPawn(P).JumpZ = 375.0;				//UT3: 325.0	//Old: 400.0
	UTPawn(P).GroundSpeed=400.0;			//UT3: 440.0
	UTPawn(P).AirSpeed=400.0;				//UT3: 440.0
	UTPawn(P).WaterSpeed=200.0;			//UT3: 220.0
	UTPawn(P).DodgeSpeed=600.0;			//UT3: 600.0
	UTPawn(P).DodgeSpeedZ=200.0;			//UT3: 295.0	//UT: 160?
	UTPawn(P).AirControl=0.35;				//UT3: 0.45? //FIXME: NEEDS TO BE REPLICATED!

	if(P.IsA('UTOnePawn'))
		UTOnePawn(P).bCanWalldodge=bCanWalldodge;	//UT3: True
}

defaultproperties
{
	bCanWalldodge=false
}