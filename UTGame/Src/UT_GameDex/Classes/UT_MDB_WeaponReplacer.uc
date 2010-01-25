//===================================================
//	Class: UT_MDB_WeaponReplacer
//	Creation date: 07/09/2009 01:49
//	Last updated: 12/09/2009 02:49
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_WeaponReplacer extends UT_MDB_ReplacerIze
	Config(GameDex);

struct WeaponReplacer extends Replacer
{
	var class<Inventory> WithItem;
};
var config array<WeaponReplacer> ReplacerSet;
//var config array<ReplacementInfo> AmmoToReplace;

/** Global Factories to replace */
struct PerMapReplacerSet extends PerMapReplacer
{
	var array<WeaponReplacer> ToReplace;
};
var config array<PerMapReplacerSet> PerMapSet;


function bool CheckNavPoint(NavigationPoint Factory)
{
	if(Factory == None)
		return false;

	if(!ClassIsChildOf(Factory.class ,class'UTWeaponPickupFactory') ||
		!ClassIsChildOf(Factory.class ,class'UTAmmoPickupFactory'))
			return false;

	return true;
}