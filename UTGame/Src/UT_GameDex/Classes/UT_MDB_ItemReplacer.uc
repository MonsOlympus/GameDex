//===================================================
//	Class: UT_MDB_ItemReplacer
//	Creation date: 07/09/2009 01:26
//	Last updated: 12/09/2009 02:49
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_ItemReplacer extends UT_MDB_ReplacerIze
	Config(GameDex);

struct ItemReplacer extends Replacer
{
	var class<Inventory> WithItem;
};
var config array<ItemReplacer> ReplacerSet;

/** Global Factories to replace */
struct PerMapReplacerSet extends PerMapReplacer
{
	var array<ItemReplacer> ToReplace;
};
var config array<PerMapReplacerSet> PerMapSet;


function bool CheckNavPoint(NavigationPoint Factory)
{
	if(Factory == None)
		return false;

	if(!ClassIsChildOf(Factory.class ,class'UTItemPickupFactory') ||
		!ClassIsChildOf(Factory.class ,class'UTPowerupPickupFactory'))
			return false;

	return true;
}

//if(!ClassIsChildOf(Factory.class ,class'UTItemPickupFactory')
///	factory type is a ammo, armour or health.
///	if its none of those then its generic item.

//if(!ClassIsChildOf(Factory.class ,class'UTPowerupPickupFactory')
///	factory type is a Powerup
///	if its bIsSuperItem=true then factory type is Super Powerup

//if(!ClassIsChildOf(Factory.class ,class'UTWeaponPickupFactory ')

