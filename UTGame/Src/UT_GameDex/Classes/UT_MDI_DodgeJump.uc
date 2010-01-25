//===================================================
//	Class: UTInfo_DodgeJump
//	Creation date: 27/05/2008 21:02
//	Contributors: 00zX
//===================================================
class UT_MDI_DodgeJump extends UT_MDI;

var UTPlayerController PC;

Replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		PC;
}

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
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}