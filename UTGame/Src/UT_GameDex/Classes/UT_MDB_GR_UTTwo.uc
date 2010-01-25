//===================================================
//	Class: UT_MDB_GR_UTTwo
//	Creation date: 27/11/2007 15:52
//	Last updated: 14/09/2009 17:13
//	Contributors: 00zX
//===================================================
class UT_MDB_GR_UTTwo extends UT_MDB_GR_Pawn;

simulated function ModifyPawn(Pawn P, optional int AbilityLevel)
{
	Super.ModifyPawn(P, AbilityLevel);

	UTPawn(P).bCanDoubleJump=True;			//UT3: True
	UTPawn(P).MaxMultiJump = 1;			//UT3: 1
	UTPawn(P).MultiJumpRemaining = 1;		//UT3: 1
	UTPawn(P).MultiJumpBoost=25;			//UT3: -45.0
	UTPawn(P).JumpZ = 340.0;				//UT3: 325.0	//Old: 400.0
//	UTPawn(P).GroundSpeed=400.0;			//UT3: 440.0
//	UTPawn(P).AirSpeed=400.0;				//UT3: 440.0
//	UTPawn(P).WaterSpeed=200.0;			//UT3: 220.0
	UTPawn(P).DodgeSpeed=660.0;			//UT3: 600.0
	UTPawn(P).DodgeSpeedZ=210.0;			//UT3: 295.0	//UT: 160?
	UTPawn(P).AirControl=0.35;				//UT3: 0.45?

	if(P.IsA('UTOnePawn'))
		UTOnePawn(P).bCanWalldodge=True;	//UT3: True
}