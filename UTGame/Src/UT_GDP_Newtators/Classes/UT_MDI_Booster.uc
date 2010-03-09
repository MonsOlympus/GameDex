//===================================================
//	Class: UT_MDI_Booster
//	Creation date: 22/06/2008 10:11
//	Last updated: 23/06/2008 11:01
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 2.5 Generic
//	http://creativecommons.org/licenses/by-nc-sa/2.5/
//===================================================
class UT_MDI_Booster extends UT_MDI_Pawn;

`include(MOD.uci)

//var UTPawn Pawnt;
var() repnotify float NewHealth;

var bool bSetHealth;

replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		NewHealth;
}

/** Make sure we have an owner and its the right type before moving on */
simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	if(Owner == None)
		Destroy();

	`logd("Info Owner: "$Owner,,'Booster');

//	Pawn = UTPawn(Owner);
	if(Pawn != None){
		NewHealth = Pawn.Health;
		Pawn.HealthMax = 199;
		Pawn.SuperHealthMax = 299;
		Enable('tick');
	}else{
		`logd("Destroy Info: PC == None;" ,,'Booster');
		Destroy();
	}
}

function DegenHealthTimer()
{
//	local int TempHealth;
//	local bool bHealth;

//	`logd("Degen Health!",,'Booster');

/*	if(bHealth){
		TempHealth = Pawnt.Health;
		bHealth = False;
	}*/

	Pawn.HealthMax -= 1;
	Pawn.SuperHealthMax -= 1;
	Pawn.Health -= 1;

	if(Pawn.HealthMax <= 100 || Pawn.SuperHealthMax <= 199)
	{
		Pawn.HealthMax = 100;
		Pawn.SuperHealthMax = 199;

		if(Pawn.Health <= NewHealth)
		{
			Pawn.Health = NewHealth;
			Destroy();
		}
		//TODO: If player takes damage and ends up under NewHealth amount
		// then it'll bump their health back up. Dont want this!
	}

	//TODO: If kill ourselves with booster!
	//if(P.Health)
}

simulated event Tick(float DeltaTime)
{
	if(Pawn == None)
		Disable('tick');

	if(UTInventoryManager(Pawn.InvManager) != None)
	{
		if(UTInventoryManager(Pawn.InvManager).HasInventoryOfClass(class'`pak1.UT_TPG_Booster') == None)
		{
			//Degen health back to normal after set time!
			if(!IsTimerActive('DegenHealthTimer'))
				SetTimer(0.5, True, 'DegenHealthTimer');

			Disable('tick');
		}
	}
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}