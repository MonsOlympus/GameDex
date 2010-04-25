//===================================================
//	Class: UT_MDI_Pawn
//	Creation date: 13/12/2008 18:00
//	Last updated: 15/03/2010 21:40
//	Contributors: 00zX
//---------------------------------------------------
//This class gets attached to the pawn and makes adjustments.
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI_Pawn extends UT_MDI;

var array<class<Pawn> > cUseforPawns;

/** Pawn class so we can check owner is right type and set vars */
var UTPawn Pawn;

/** Gets the times from the weapons and sets them to the replicated variables */
reliable server function GetPawnProps(UTPawn P);

/** Sets the clients weapon to use the replicated variables */
reliable client function SetPawnProps(UTPawn P);

final function bool Allowed(Pawn P)
{
	local int i;

	if(cUseforPawns.length > 0)
	{
		for(i = 0; i < cUseforPawns.length; i++)
		{
			if(ClassIsChildOf(P.Class, cUseforPawns[i]))
				return true;
//			if(P.IsA(cUseforPawns[i]))
//				return true;
		}
	}
	return false;
}

/** Make sure we have an owner and its the right type before moving on */
simulated event PostBeginPlay()
{
	if(Owner == None)
		Destroy();

	Pawn = UTPawn(Owner);
	if(Pawn != None)
	{
		`logd("Info Owner: "$Pawn,,'PawnInfo');
		if(WorldInfo.NetMode != NM_Client)
			GetPawnProps(Pawn);

		SetTimer(0.01, false, 'SetPropsTimer');
		SetTimer(10,true, 'CheckOwner');
	}
	else
	{
		Destroy();
	}
}

function SetPropsTimer()
{
	SetPawnProps(Pawn);
}

function CheckOwner()
{
	if(UTPawn(Owner) == None)
		Destroy();
}

/*
//BRANCH
simulated event Tick(float DeltaTime)
{
	local UTInventoryManager	UTInvManager;

	UTInvManager = UTInventoryManager(Pawn.InvManager);
	Disable('tick');
}
*/

/*
// Alternate
simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	if(Owner == None)
		Destroy();

	`logd("Info Owner: "$Owner,,'Booster');

	if(Pawn!=None):Enable('Tick')?Destroy();

//	if(Pawn != None){Enable('tick');}
//	else{
//		`logd("Destroy Info: PC == None;" ,,'Booster');
//		Destroy();
//	}
}

function DegenHealthTimer()
{
	local UTInventoryManager	UTInvManager;

	UTInvManager = UTInventoryManager(Pawn.InvManager);
}

simulated event Tick(float DeltaTime)
{
	if(Pawn == None)		Disable('tick');

	if(UTInventoryManager(Pawn.InvManager) != None)
	{
		if(UTInventoryManager(Pawn.InvManager).HasInventoryOfClass(class'Newtators.UTBooster') == None)
		{
			//Degen health back to normal after set time!
			if(!IsTimerActive('DegenHealthTimer'))
				SetTimer(0.5, True, 'DegenHealthTimer');

			Disable('tick');
		}
	}
}
*/

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}