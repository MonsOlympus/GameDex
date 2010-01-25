//===================================================
//	Class: UT_MDB_LogObj
//	Creation date: 21/08/2009 02:04
//	Last updated: 02/09/2009 15:14
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//-Holds vars for callback logging
//-Could be used to delay logging of arrays until the
//list is full, should help speed as we arnt logging
//inside iterators!
//===================================================
class UT_MDB_LogObj extends UT_MDB;

//GameDex
//var bool				blGD;
//var UT_MDB_GameDex		lGD;

//GameRules - ObjectList
var name				GRln;
var name				GRlpn;
var UT_MDB_ObjectList	GRList;
var array<UT_MDB_GameRules>	lGR;

var UTGame				lG;
var array<name>			lMuts;
//var array<UTMutator>	lMuts;

var name				lPawn;
var name				lVehicle;
var name				lRook;

var string				lCurrentMap;

//var array<UTPawn> LoggedPawn;
//var array<name> LoggedPawns;

//FactoryData
var bool				logFD;

//GameRules Object Logging
var int					lInitHealth,
						lGiveHealth,
						lConversion,
						lDamage;

function DumpGameRuleListStats()
{
	`logd("ObjList: GameRules: "$GRlpn$"."$GRln,,'LogObj');
}

function DumpMutStats()
{
	local name tmp;
	foreach lMuts(tmp)
	{
		`logd("Mutator: "$tmp,,'LogObj');
	}
}

function DumpMatchStats()
{
	`logd("CurrentMap: "$lCurrentMap,,'LogObj');
	`logd("Gametype: "$lG,,'LogObj');
}

function DumpRuleStats()
{
	local name tmp;
	foreach lGR(tmp)
	{
		`logd("GameRules: "$tmp,,'LogObj');
	}
}

static function DumpClassFunc(name ownername, name classname, name func)
{
	`logd(ownername$"."$classname$"."$func,,'LogObj');
}