//===================================================
//	Class:  UT_MDI_ADegen
//	Creation date: 17/03/2009 01:57
//	Last updated: 17/03/2009 01:57
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI_ADegen extends UT_MDI_Pawn;

//var UTPawn Pawnt;
var() repnotify float NewHealth;

var bool bSetHealth;

replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		NewHealth;
}

/** Make sure we have an owner and its the right type before moving on */
/*simulated event PostBeginPlay()
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
*//*
function DegenHealthTimer()
{
//	local int TempHealth;
//	local bool bHealth;

//	`logd("Degen Health!",,'Booster');

//	if(bHealth){
//		TempHealth = Pawnt.Health;
//		bHealth = False;
//	}

	Pawnt.HealthMax -= 1;
	Pawnt.SuperHealthMax -= 1;
	Pawnt.Health -= 1;

	if(Pawnt.HealthMax <= 100 || Pawnt.SuperHealthMax <= 199){
		Pawnt.HealthMax = 100;
		Pawnt.SuperHealthMax = 199;

		if(Pawnt.Health <= NewHealth){
			Pawnt.Health = NewHealth;
			Destroy();
		}
		//TODO: If player takes damage and ends up under NewHealth amount
		// then it'll bump their health back up. Dont want this!
	}

	//TODO: If kill ourselves with booster!
	//if(P.Health)
}*//*

simulated event Tick(float DeltaTime)
{
	if(Pawnt == None)
		Disable('tick');

	if(UTInventoryManager(Pawnt.InvManager) != None)
	{
		if(UTInventoryManager(Pawnt.InvManager).HasInventoryOfClass(class'Newtators.UTBooster') == None)
		{
			//Degen health back to normal after set time!
			if(!IsTimerActive('DegenHealthTimer'))
				SetTimer(0.5, True, 'DegenHealthTimer');

			Disable('tick');
		}
	}
}*/

//---------------------------------------------------
//Health Degen Timer
simulated function HealthCountdownToDegen(){
	if(!IsTimerActive('HealthTimer'))
		SetTimer(5.0, true, 'HealthTimer');
}

simulated function HealthTimer(){
	if(Pawn.Health > 100)
		Pawn.Health = Pawn.Health - 2;
	else
		ClearTimer('HealthTimer');
}

//Shieldbelt Degen Timer
simulated function ShieldBeltCountdownToDegen()
{
	if(!IsTimerActive('ShieldBeltTimer'))
		SetTimer(3.0, true, 'ShieldBeltTimer');
}

simulated function ShieldBeltTimer()
{
	if(Pawn.ShieldBeltArmor > 0)
		Pawn.ShieldBeltArmor = Pawn.ShieldBeltArmor - 2;
	else
		ClearTimer('ShieldBeltTimer');
}

//Vest Degen Timer
simulated function VestCountdownToDegen()
{
	if(!IsTimerActive('VestTimer'))
		SetTimer(4.0, true, 'VestTimer');
}

simulated function VestTimer()
{
	if(Pawn.VestArmor > 0)
		Pawn.VestArmor = Pawn.VestArmor - 1;
	else
		ClearTimer('VestTimer');
}

//Thighpad Degen Timer
simulated function ThighpadCountdownToDegen()
{
	if(!IsTimerActive('ThighpadTimer'))
		SetTimer(5.0, true, 'ThighpadTimer');
}

simulated function ThighpadTimer()
{
	if(Pawn.ThighpadArmor > 0)
		Pawn.ThighpadArmor = Pawn.ThighpadArmor - 1;
	else
		ClearTimer('ThighpadTimer');
}

//Helmet Degen Timer *This one doesnt start until damage has been taken.
simulated function HelmetCountdownToDegen()
{
	if(!IsTimerActive('HelmetTimer'))
		SetTimer(8.0, true, 'HelmetTimer');
}

simulated function HelmetTimer()
{
	if(Pawn.HelmetArmor > 0)
		Pawn.HelmetArmor = Pawn.HelmetArmor - 1;
	else
		ClearTimer('HelmetTimer');
}

defaultproperties
{
	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}