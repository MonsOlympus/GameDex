//===================================================
//	Class: UT_MDB_GR_Agility
//	Creation date: 27/05/2008 21:02
//	Last updated: 07/03/2010 01:16
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Agility extends UT_MDB_GR_Pawn;

simulated function ModifyPawn(Pawn P, optional bool bRemoveBonus=false, optional int AbilityLevel)
{
	Super.ModifyPawn(P, bRemoveBonus, AbilityLevel);

	UTPawn(P).JumpZ=332;		//322.0

	UTPawn(P).bStopOnDoubleLanding = False;
//	UTPawn(P).SlopeBoostFriction = -0.800000;	//-0.400000//.0.200000
	UTPawn(P).SlopeBoostFriction = -1.200000;

//	UTPawn(P).MaxMultiJump=2;				//1
	UTPawn(P).MultiJumpBoost=-30;			//-45.0

	//Somethin about an exploit fix!
	//Doesnt look like these do anything :S
//	DodgeResetTime=0.35
//	UTPawn(P).MaxMultiDodge=3;
//	UTPawn(P).MultiDodgeRemaining=2;

	UTPawn(P).CustomGravityScaling=0.95;	//1.0
	UTPawn(P).MaxDoubleJumpHeight=110;		//87.0
	UTPawn(P).DoubleJumpThreshold=200.0;	//160.0
	UTPawn(P).FallSpeedThreshold=150.0;	//125.0
}