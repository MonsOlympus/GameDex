//====================================================
///	Class: UT_MDB_GameRules
///	Creation date: 15/01/2009 07:02
///	Last Updated: 20/08/2009 14:51
///	Contributors: 00zX
//----------------------------------------------------
///	Attribution-Noncommercial-Share Alike 3.0 Unported
///	http://creativecommons.org/licenses/by-nc-sa/3.0/
//====================================================
class UT_MDB_GameRules extends UT_MDB
	config(UT_MDB_GR);

var GameRules			MasterGR;
var UT_MDB_GameRules	NextGR;				//GameRulesList!

var globalconfig bool	bUseSuperHealth;
var globalconfig bool	bUseForVehicles;	//Infantry Vs Vehicle || Vehicle Vs Vehicle Damage!
var globalconfig bool	bUseForKnights;
var globalconfig bool	bUseForRooks;		//Castles cant have vampire :S

////
//TIMERS - Redundant Function Calls!~
final function SetTimer(float inRate, optional bool inbLoop, optional Name inTimerFunc='Timer'){
	MasterGR.SetTimer(inRate, inbLoop, inTimerFunc, self);
}

final function ClearTimer(optional Name inTimerFunc='Timer'){
	MasterGR.ClearTimer(inTimerFunc, self);
}

////
/** Initialize Gamerules - mainly for logging */
function Init()
{
//	`logd("Rules Object Initialized: "$class.name,,'GameRules');
	`logd("Rules Object Initialized: "$self.name,,'GameRules');
/*	while(NextGR != none){
		`logd("Rules Object List: "$NextGR,,'GameRules');
	}*/
}

function SetNextGR()
{
	NextGR = UT_MDB_GameRules(UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).GRList.GetNext(self));
}

function bool OverridePickupQuery(UTPawn Other, class<Inventory> ItemClass, Actor Pickup)
{
	return (NextGR != none) ? NextGR.OverridePickupQuery(Other, ItemClass, Pickup) : false;
}

function int DamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn injured)
{
//	`logd(PathName(self)$": Damage Taken: "$Enemy.Damage,,'GameRules');
	if(NextGR != None)
		return NextGR.DamageTaken(Enemy,injured);
	else
		return (Enemy.ModifiedDamage != 0 && Enemy.Damage != Enemy.ModifiedDamage) ? Enemy.ModifiedDamage : Enemy.Damage;

//	return (NextGR != none) ? NextGR.DamageTaken(Enemy,injured) : Enemy.Damage;
}

function int SelfDamage(UT_GR_Info.EnemyInfo Enemy)
{
	//`logd("Self Damage: "$Enemy.Damage,,'GameRules');
	return (NextGR != none) ? NextGR.SelfDamage(Enemy) : Enemy.Damage;
}

//----
//Some of these might need access to gameinfo/worldinfo

//TODO: This might be called at different times, such as
//*when a player picks up an item		|Last Duration of Item
//*when a player first spawns 			|Last Until Death
//										|Last Entire Match
simulated function ModifyPawn(Pawn P, optional int AbilityLevel)
{
	if(NextGR != none)
		NextGR.ModifyPawn(P,AbilityLevel);
}

simulated function ModifyRook(UTHeroPawn R, optional int AbilityLevel)
{
	if(NextGR != none)
		NextGR.ModifyRook(R,AbilityLevel);
}

simulated function ModifyController(Controller PC, optional int AbilityLevel)
{
	if(NextGR != none)
		NextGR.ModifyController(PC,AbilityLevel);
}

//TODO: HOOKS TO CHECK REPLACE SPECIFIC FOR WEAPONS (MODIFIER)
static simulated function ModifyWeapon(Weapon W, optional int AbilityLevel);
static simulated function UnModifyWeapon(Weapon W, optional int AbilityLevel);

//TODO: HOOKS TO CHECK REPLACE SPECIFIC FOR WEAPONS (MODIFIER)
static simulated function ModifyVehicle(Vehicle V, optional int AbilityLevel);
static simulated function UnModifyVehicle(Vehicle V, optional int AbilityLevel);

static function ScoreKill(Controller Killer, Controller Killed, bool bOwnedByKiller, optional int AbilityLevel);

//Ability Levels to remove
//NOTES: Really AbilityLevel is just another way of saying a global modifier?

/*static simulated function int Cost(RPGPlayerDataObject Data, int CurrentLevel)
{
	if (CurrentLevel < default.MaxLevel)
		return default.StartingCost + default.CostAddPerLevel * CurrentLevel;
	else
		return 0;
}*/