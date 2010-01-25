//===================================================
//	Class: UT_GR_Info
//	Creation date: 12/12/2008 19:35
//	Last updated: 22/11/2009 04:56
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_GR_Info extends GameRules;

`include(MOD.uci)

enum EnemyType
{
	ET_Infantry,
	ET_Hero,
	ET_Vehicle,
	ET_Rook,	//Castle
	ET_Knight,	//Manta, Viper?
	ET_Bishop,	//Hero
	ET_Turret
};

struct PawnInfo
{
	var Pawn Pawn;
	var EnemyType Type;
};

struct EnemyInfo extends PawnInfo
{
	var bool bIsBot;
	var bool bIsFriendly;
	var int Damage;
	var int ModifiedDamage;	//ConversionRatio>??
	var class<DamageType> DamageType;
};

var UTMutator					GameExp;
var private UT_MDB_GameRules	FirstGR;

/*event PreBeginPlay()
{
//	`logdfunc('GameRules');

	if(GD == None)
		return;

	if(GD.GRList != none)
		FirstGR = UT_MDB_GameRules(GD.GRList.GetFirst());
}*/

/**wtf why am I grey?*/
function SetFirstGR()
{
	if(UT_MDB_GameExp(GameExp) == None)
		return;

	`logd("GameRules Info Controller Initalized!",,'GameRulesInfo');
	if(UT_MDB_GameExp(GameExp).GRList != none)
		FirstGR = UT_MDB_GameRules(UT_MDB_GameExp(GameExp).GRList.GetFirst());

	`logd("FirstGR:"$FirstGR,,'GameRulesInfo');
}

function bool OverridePickupQuery(Pawn Other, class<Inventory> ItemClass, Actor Pickup, out byte bAllowPickup)
{
	//Only Pawns have inventory managers?
	//InvMgr = UTInventoryManager(Other.InvManager);

	if(GameExp == None)
		return false;

	if(UT_MDB_GameExp(GameExp).GRList.isEmpty())
		return false;

	if(Pickup != None && UTPawn(Other) != None)
		if((FirstGR != None) && FirstGR.OverridePickupQuery(UTPawn(Other), ItemClass, Pickup))
			return true;
	return false;
}

//Cumulative
//TODO: SUPPORT OTHER MUTS, USE THE LINKED LIST ONTOP OF OBJECT LIST!!~
function NetDamage(int OriginalDamage, out int Damage, pawn injured, Controller instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
	local EnemyInfo Enemy;			///New Branch
//	local EnemyInfo Injured;
//	local UT_MDB_GameRules fGR;

	///	InjuredPRI = injured.PlayerReplicationInfo;
//	`logd("Master: NetDamage",,'GameRules');

//	if (injured == None || instigatedBy == None || injured.Controller == None || instigatedBy.Controller == None)
//		return Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

	if(GameExp == None)
		return;

	if(UT_MDB_GameExp(GameExp).GRList.isEmpty())
		return;

//	`logd("Master: GameData: "$GD,,'GameRules');

	if(!WorldInfo.Game.IsInState('MatchInProgress') ||
		(injured == None && instigatedBy == None))
	{
		Damage = 0;
		return;
	}

	if(UT_MDB_GameExp(GameExp).GRList.isEmpty())
		Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

//	fGR = UT_MDB_GameRules(GD.GRList.GetFirst());
//	`logd("Master: ObjList: FirstRules: "$PathName(fGR),,'GameRules');

	if(instigatedBy != None && instigatedBy.Pawn != None)
	{
		//`logd("NetDamage::UT_GR_Info:(instigatedBy != None && instigatedBy.Pawn != None)",,'GameRulesInfo');
		Enemy.Pawn = InstigatedBy.Pawn;
		Enemy.Damage = OriginalDamage;

		if(ClassIsChildOf(Enemy.Pawn.class,class'UTPawn'))
		{
			//`logd("NetDamage::UT_GR_Info:(ClassIsChildOf(Enemy.Pawn.class,class'UTPawn'))",,'GameRulesInfo');
			//Added Rook 2.0
			if(Enemy.Pawn.IsA('UTHeroPawn'))
			{
				if(UTHeroPawn(InstigatedBy.Pawn).bIsHero && !UTHeroPawn(InstigatedBy.Pawn).bIsSuperHero)
					Enemy.Type=ET_Hero;//Enemy.Type=ET_Rook;
				else if (!UTHeroPawn(InstigatedBy.Pawn).bIsHero && UTHeroPawn(InstigatedBy.Pawn).bIsSuperHero)
					Enemy.Type=ET_Rook;//Enemy.Type=ET_Knight;
			}
			else
				Enemy.Type=ET_Infantry;

		}
		else if(ClassIsChildOf(InstigatedBy.Pawn.class, class'UTVehicle'))
		{
			if(ClassIsChildOf(InstigatedBy.Pawn.class, class'UTVehicle_TrackTurretBase'))
				Enemy.Type=ET_Turret;
			else
				Enemy.Type=ET_Vehicle;
		}

		//`logd("Enemy is of Type: "$Enemy.Type,,'GameRulesInfo');

		//Enemy isA UTBot
		if(UTBot(instigatedBy) != None && UTBot(injured.controller) == None &&
			UTBot(injured.controller) != UTBot(instigatedBy))
				Enemy.bIsBot = true;

		//Self-Damage
		if(Enemy.Pawn == injured)
			Damage = FirstGR.SelfDamage(Enemy);//Damage = FirstGR.SelfDamage(Enemy);

		//Damage From EnemyPawn
		else if(injured != instigatedBy)
		{
			//Team Damage
			if(WorldInfo.Game.bTeamGame)
			{
				if(instigatedBy.GetTeamNum() != injured.GetTeamNum())
					Damage = FirstGR.DamageTaken(Enemy,Injured);//Damage = FirstGR.DamageTaken(Enemy,Injured);
				else
					Enemy.bIsFriendly = true;
			}
			//FFA Damage
			else
				Damage = FirstGR.DamageTaken(Enemy,Injured);//Damage = FirstGR.DamageTaken(Enemy,Injured);

			//if((EnemyPRI != None) && (injured.PlayerReplicationInfo != None) &&
			//	((EnemyPRI.Team == None) || (EnemyPRI.Team != injured.PlayerReplicationInfo.Team)))
		}
	}
}

//TODO: REMAP TO NEW GR OBJECTS!
/*
function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string incomingName )
{
	if ( NextGameRules != None )
		return NextGameRules.FindPlayerStart(Player,InTeam,incomingName);

	return None;
}

function bool HandleRestartGame()
{
	if ( (NextGameRules != None) && NextGameRules.HandleRestartGame() )
		return true;
	return false;
}

function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
	if ( NextGameRules != None )
		return NextGameRules.CheckEndGame(Winner,Reason);

	return true;
}

function bool PreventDeath(Pawn Killed, Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	if ( (NextGameRules != None) && NextGameRules.PreventDeath(Killed,Killer, damageType,HitLocation) )
		return true;
	return false;
}

function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{
	if ( NextGameRules != None )
		NextGameRules.ScoreObjective(Scorer,Score);
}

function ScoreKill(Controller Killer, Controller Killed)
{
	if ( NextGameRules != None )
		NextGameRules.ScoreKill(Killer,Killed);
}*/