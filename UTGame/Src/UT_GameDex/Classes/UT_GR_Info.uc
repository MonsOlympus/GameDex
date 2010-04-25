//===================================================
//	Class: UT_GR_Info
//	Creation date: 12/12/2008 19:35
//	Last updated: 19/04/2010 21:38
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_GR_Info extends GameRules;

enum PawnType
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
	var PawnType Type;
};

struct EnemyInfo extends PawnInfo
{
	var bool bIsBot;
	var bool bIsFriendly;
	var int Damage;
	var int ModifiedDamage;	//ConversionRatio>??
	var class<DamageType> DamageType;

	structdefaultproperties
	{
		bIsBot=false
		bIsFriendly=false
		Damage=0
		ModifiedDamage=0
		DamageType=class'DmgType_Suicided'
	}
};

var UT_MDB_GameExp				GameExp;
var private UT_MDB_GameRules	BaseGameRules;

/** wtf why am I grey? */
function SetBaseGameRules()
{
	if(GameExp == None)
		return;

	`logd("GameRules Info Controller Initalized!",,'GameRulesInfo');

	self.BaseGameRules = GameExp.GetBaseGameRules();
	`logd("BaseGameRules:"$BaseGameRules,,'GameRulesInfo');
}

static function PawnType GetPawnType(Pawn Pawn)
{
	local PawnType PType;
	
	if(ClassIsChildOf(Pawn.class,class'UTPawn'))
	{
		//Added Rook 2.0
		if(Pawn.IsA('UTHeroPawn'))
		{
			if(UTHeroPawn(Pawn).bIsHero && !UTHeroPawn(Pawn).bIsSuperHero)
				PType = ET_Hero;
			else if (!UTHeroPawn(Pawn).bIsHero && UTHeroPawn(Pawn).bIsSuperHero)
				PType = ET_Rook;
		}
		else
			PType = ET_Infantry;

	}
	//isA UTVehicle
	else if(ClassIsChildOf(Pawn.class, class'UTVehicle'))
	{
		if(ClassIsChildOf(Pawn.class, class'UTVehicle_TrackTurretBase'))
			PType = ET_Turret;
		else
			PType = ET_Vehicle;
	}
	
	return PType;
}

//FIXME: Call next mutator that has Interface of this type in array, {hybrid list}
function bool HandleRestartGame()
{
	if(GameExp == None || BaseGameRules == None)
		return false;
//	if((NextGameRules != None) && NextGameRules.HandleRestartGame())
//		return true;
	return false;
}

//FIXME: Call next mutator that has Interface of this type in array, {hybrid list}
function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
	if(GameExp == None || BaseGameRules == None)
		return false;
//	if(NextGameRules != None)
//		return NextGameRules.CheckEndGame(Winner,Reason);
	return true;
}

//FIXME: Call next mutator that has Interface of this type in array, {hybrid list}
function bool OverridePickupQuery(Pawn Other, class<Inventory> ItemClass, Actor Pickup, out byte bAllowPickup)
{
	if(GameExp == None || BaseGameRules == None)
		return false;
//	if(Pickup != None && UTPawn(Other) != None)
//		if((self.BaseGameRules != None) && self.BaseGameRules.PickupQuery(UTPawn(Other), ItemClass, Pickup))
//			return true;
	return false;
}

//FIXME: Whats the Objective again? subclass of GameObjective required to be passed for full override/modification
function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{
	local UT_MDB_GameRules GR;

	if(GameExp == None || self.BaseGameRules == None)
		return;

	for(GR = self.BaseGameRules; GR != None; GR = GameExp.GetNextGameRules(GR))
	{
		if(MDIB_GR_ModifyScoreObjective(GR) != None)
			MDIB_GR_ModifyScoreObjective(GR).ModifyScoreObjective(Scorer, Score);

//		if(MDIB_GR_NotifyScoreObjective(GR) != None)
//			MDIB_GR_NotifyScoreObjective(GR).NotifyScoreObjective(Scorer);
	}
}

function ScoreKill(Controller Killer, Controller Killed)
{
	local UT_MDB_GameRules GR;

	if(GameExp == None || self.BaseGameRules == None)
		return;

	for(GR = self.BaseGameRules; GR != None; GR = GameExp.GetNextGameRules(GR))
	{
		if(MDIB_GR_ModifyScoreKill(GR) != None)
			MDIB_GR_ModifyScoreKill(GR).ModifyScoreKill(Killer, Killed);

		if(MDIB_GR_NotifyScoreKill(GR) != None)
			MDIB_GR_NotifyScoreKill(GR).NotifyScoreKill(Killer);
	}
}

//Cumulative
//TODO: SUPPORT OTHER MUTS, USE THE LINKED LIST ONTOP OF OBJECT LIST!!~
function NetDamage(int OriginalDamage, out int Damage, pawn injured, Controller instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
	local EnemyInfo Enemy;
	local UT_MDB_GameRules GR;

	if(GameExp == None || self.BaseGameRules == None)
		return;

	if(!WorldInfo.Game.IsInState('MatchInProgress') || (injured == None && instigatedBy == None))
	{
		Damage = 0;
		return;
	}
	
	//GameInfo.ReduceDamage // then check if carrying items that can reduce damage
//	if((damage > 0) && (injured.InvManager != None))
//		injured.InvManager.ModifyDamage(Damage, instigatedBy, HitLocation, Momentum, DamageType);
	
	if(instigatedBy != None && instigatedBy.Pawn != None)
	{
		Enemy.Pawn = InstigatedBy.Pawn;
		Enemy.Damage = OriginalDamage;
		Enemy.Type = GetPawnType(Enemy.Pawn);

		//!include {static function PawnType GetPawnType(Pawn Pawn)}

		//Enemy isA UTBot
		if(UTBot(instigatedBy) != None && UTBot(injured.controller) == None &&
			UTBot(injured.controller) != UTBot(instigatedBy))
				Enemy.bIsBot = true;

		for(GR = self.BaseGameRules; GR != None; GR = GameExp.GetNextGameRules(GR))
		{
			//Self-Damage
			if(Enemy.Pawn == injured)
				if(MDIB_GR_ModifySelfDamage(GR) != None)
					MDIB_GR_ModifySelfDamage(GR).ModifySelfDamage(Enemy);
			//if(Enemy.Pawn == injured)
			//	Damage = self.BaseGameRules.ModifySelfDamage(Enemy);

			//Damage From EnemyPawn
			else if(injured != instigatedBy)
			{
				//Team Damage
				if(WorldInfo.Game.bTeamGame)
				{
					if(instigatedBy.GetTeamNum() != injured.GetTeamNum())
					{
						if(MDIB_GR_ModifyDamageTaken(GR) != None)
							MDIB_GR_ModifyDamageTaken(GR).ModifyDamageTaken(Enemy, Injured);
						//Damage = self.BaseGameRules.ModifyDamageTaken(Enemy, Injured);
					}
					else
						Enemy.bIsFriendly = true;
				}
				//FFA Damage
				else
					if(MDIB_GR_ModifyDamageTaken(GR) != None)
						MDIB_GR_ModifyDamageTaken(GR).ModifyDamageTaken(Enemy, Injured);
					//Damage = self.BaseGameRules.ModifyDamageTaken(Enemy, Injured);
			}
		}
	}
}