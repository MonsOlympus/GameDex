//===================================================
//	Class: UT_MDB_ReplacerIze
//	Creation date: 07/09/2009 01:34
//	Last updated: 12/09/2009 02:49
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_ReplacerIze extends UT_MDB
	abstract;

/** Factory Group */
enum FactoryType
{
	FT_None,
	FT_Health,
	FT_Ammo,
	FT_Armour,
	FT_Powerup,
		FT_SPowerup,
	FT_Weapon,
		FT_SWeapon,
	FT_Deployable,
	FT_Vehicle,
		FT_SVehicle,
	FT_Turret
};

struct Replacer
{
	var FactoryType FactoryGroup;	//TODO: link this in with the subclasses!
	var name ReplaceItem;
};

/** Global Factories to replace */
struct PerMapReplacer
{
	var string Map;					/// Map name, this is not a unique id!
	var int MapSetID;				/// This is so multiple entries can be chosen per map.
};

var bool bCheckMapList;			/// Map is not found on the list, create a new entry in the ini using the defaults.
var  bool bUsePerMapSet;			/// This mutator uses Per Map Setting from the FactoryReplacer

//var array<UTUIDataProvider_MapInfo> Maps;

/*
	local array<UTUIResourceDataProvider> ProviderList;
	local int i, j, k;
	local array<string> Loc;
	local bool bSkipPrefixCheck;

	if (MapProviders.Length == 0)
	{
		Class'UTUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_MapInfo', ProviderList);

		for (i=0; i<ProviderList.Length; ++i)
			if (ProviderList[i] != none)
				Maps.AddItem(UTUIDataProvider_MapInfo(ProviderList[i]));
	}
*/

//var class<NavigationPoint> UseForClass[4];

 /**
 * Checks to see if the factory is a pickup or vehicle factory.
 * Notes:	Could have an array here for classes which allow this to be used with them
 * 			Excess Function Call, Redundant but cleaner code!
 * @param	NavP		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function bool CheckNavPoint(NavigationPoint Factory);
