//===================================================
//	Class: UT_MDI_Pawn
//	Creation date: 13/12/2008 18:00
//	Last updated: 16/12/2008 21:18
//	Contributors: 00zX
//---------------------------------------------------
//This class gets attached to the pawn and makes adjustments.
//===================================================
class UT_MDI_Pawn extends UT_MDI;

var array<class<UTPawn> > cUseforPawns;

/** Pawn class so we can check owner is right type and set vars */
var UTPawn Pawn;

/** Gets the times from the weapons and sets them to the replicated variables */
reliable server function GetPawnProps(UTPawn P);

/** Sets the clients weapon to use the replicated variables */
reliable client function SetPawnProps(UTPawn P);

/** Make sure we have an owner and its the right type before moving on */
simulated event PostBeginPlay()
{
//	local int i;

	if(Owner == None || cUseforPawns.length <= 0)
		Destroy();

	Pawn = UTPawn(Owner);
	if(Pawn != None)
	{
//		for(i==0;i<cUseforPawns.length;i++)		{
//			if(Pawn.IsA(cUseforPawns())
//			{
				if(WorldInfo.NetMode != NM_Client)
					GetPawnProps(Pawn);

				SetTimer(0.01, false, 'SetPropsTimer');
				SetTimer(10,true, 'CheckOwner');
//			}			else//				Destroy();
//		}
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