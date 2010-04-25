//===================================================
//	Class: UT_MDB_GR_Group
//	Creation date: 24/04/2010 03:51
//	Last updated: 24/04/2010 03:51
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Group extends UT_MDB_GameRules;

struct GroupOption
{
	var UT_MDB_GameRules GRule;
	var bool GValue;
};
var config array<GroupOption> GOptions;

var name GName;

function bool SwapGOption(int idx)
{
	GOptions[idx].GValue = !GOptions[idx].GValue;
}

function SaveGOptions()
{
	staticsaveconfig();
}

function Init()
{
	local UT_MDB_GameRules GR;
	local GroupOption tGOption;

	//Iterates over each subOption/subGameRulesList
	foreach GOptions(tGOption)
	{
		if(tGOption.GValue)
			GR = UT_MDB_GameExp(Master).UpdateGameRules(tGOption.GRule);
	}
}

defaultproperties
{
//	GOptions(0)=(GName="ExtraSelfDamage", GValue=true)
}