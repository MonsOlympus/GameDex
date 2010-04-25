//===================================================
//	Class: UTInfo_DodgeJump
//	Creation date: 27/05/2008 21:02
//	Last updated: 21/03/2010 20:37
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI_DodgeJump extends UT_MDI;

var UTPlayerController PC;

Replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		PC;
}

//TODO: Add delay in WorldInfo.TimeSeconds to second dodges
//		Currently dodges can be performed anytime without delay,
//		provided player is not in Active state meanin they havent touched the ground yet.
Simulated Function Tick(float dt)
{
	local UTPawn P;

	if(WorldInfo.NetMode != NM_Client)
		PC = UTPlayerController(Owner);

	if(PC != None)
	{
		P = UTPawn(PC.Pawn);
		if(P != None)
		{
			if(P.bDodging || PC.DoubleClickDir == DCLICK_Active)
			{
				P.bReadyToDoubleJump = True;
				P.bDodging = False;
		// slow player down if double jump landing
	//if ((MultiJumpRemaining < MaxMultiJump && bStopOnDoubleLanding)
		//|| bDodging
		//|| Velocity.Z < -2 * JumpZ)
			}
//			P.bStopOnDoubleLanding = False;
//			P.SlopeBoostFriction = -0.800000;	//-0.4,0.2
		}
	}
	else
	{
		disable('tick');
		destroy();
	}
}

defaultproperties
{
	bTickable=True

	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}