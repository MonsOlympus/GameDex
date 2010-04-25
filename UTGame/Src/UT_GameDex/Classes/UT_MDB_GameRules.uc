//====================================================
//	Class: UT_MDB_GameRules
//	Creation date: 15/01/2009 07:02
//	Last Updated: 22/04/2010 11:08
//	Contributors: 00zX
//----------------------------------------------------

//Added CheckReplacement support to this, wrapped spawn like timers through Master Actor
//Rewrote LinkedReplicationInfo functionality, now uses forloop and checks for none (will work for all members of list)
//Completely rewrote the way rules work based on (stub) interfaces
//*this allows only certain gamerules to access functions reducing the call stack quite significantly over the old linked list method

//----------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//====================================================
class UT_MDB_GameRules extends UT_MDB
	implements(MDIB_GameRules)
	config(UT_MDB_GR);

var UT_GR_Info						MasterGameRules;
var UT_MDB_GameRules				NextGameRules;

var() array<UT_MDB_GameRules>		GameRules;			//Sub-GameRules, that means these could contain Subs and so on
var() array<Info.KeyValuePair>		GameRulesInfo;

//TODO: Prioty Que

//TODO: Cost/Wieght?
/*static simulated function int Cost(Object Data, optional int GlobalMultiplier)
{
	if (Data.AdrenalineMax < 150 || Data.Attack < 50)
		return 0;
	else if (CurrentLevel < default.MaxLevel)
		return default.StartingCost + default.CostAddPerLevel * CurrentLevel;
	else
		return 0;
}*/

////
/** Initialize Gamerules - mainly for logging */
function Init()
{
	local UT_MDB_GameRules GR;

	`logd("Rules Object Initialized: "$self.name,,'GameRules');

	Master = MasterGameRules.GameExp;
	if(Master == None)
		`logd("Master Mutator not found!",,'GameRules');//Send Object to GC
	else
		NextGameRules = UT_MDB_GameExp(Master).GetNextGameRules(self);

	//Iterates over each subOption/subGameRulesList
	if(GameRules.Length > 0)
	{
		foreach GameRules(GR)
		{
			//FIXME: This doesnt copy properties if the object happens to exist already.
			GR = UT_MDB_GameExp(Master).UpdateGameRules(GR);
		}
	}
}

function GetServerDetails(out GameInfo.ServerResponseLine ServerState)
{
	local Info.KeyValuePair tPair;
	local int i;

	foreach GameRulesInfo(tPair)
	{
		i = ServerState.ServerInfo.Length;
		ServerState.ServerInfo.Length = i+1;
		ServerState.ServerInfo[i].Key = tPair.Key;
		ServerState.ServerInfo[i].Value = tPair.Value;
	}
}

////
/** Added to allow Gametype hook to UTLinkedReplicationInfo.
Similar to Info attachment method but instead links a replication info to the PRI.*/
//NOTE: Should be called from check replacement!
final function AddReplicationInfo(Actor Other, class<UTLinkedReplicationInfo> LRIC)
{
	local UTLinkedReplicationInfo LRI;
	local UTPlayerReplicationInfo PRI;

	if(LRIC != None)
		return;

	PRI = UTPlayerReplicationInfo(Other);
	for(LRI = PRI.CustomReplicationInfo; LRI == None; LRI = LRI.NextReplicationInfo)
	{
		if(LRI.Class == LRIC)
			break;

		//Spawn(LRIC, Other.Owner);
		LRI = Master.Spawn(LRIC, Other.Owner);
		`logd("PRI.CustomReplicationInfo: "$LRI,,'GameExp');
	}
}