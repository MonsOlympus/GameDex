//===================================================
//	Class: UT_MDB_FactoryReplacer
//	Creation date: 11/08/2008 15:39
//	Last updated: 26/06/2009 22:02
//	Contributors: 00zX
//---------------------------------------------------
///TODO:
///*Linked list of struct?
///--FactoryReplacer
///--MapFactoryReplacerSet
///*Function which outs ReplacementFactories to ReplaceWith() in GameExpansion
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_FactoryReplacer extends UT_MDB
	Config(GameDex);

//`include(MOD.uci)

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
	FT_Vehicle,
		FT_SVehicle
};

/** Factories to replace on a Per Map basis
	- Get from global when not found*/
struct FactoryReplacer
{
	var FactoryType FactoryGroup;
	var name ReplacedFactory;
	var name ReplacedWithFactory;					//TODO: ReplaceWith=None
	var string ReplacedWithFactoryPath;
	//var name NextFactory, LastFactory;

	structdefaultproperties
	{
		FactoryGroup=FT_None
		ReplacedWithFactory=None
	}
};
var config array<FactoryReplacer> FactoriesSet;	//Factory Replacer Set Array (Global)

/** Global Factories to replace */
struct MapFactoryReplacerSet
{
	var string Map;
	var int MapSetID;
	var array<FactoryReplacer> FactoriesToReplace;
};
var config array<MapFactoryReplacerSet> PerMapFactorySet;

var bool bCheckMapFactoryList;					/// Map is not found on the list, create a new entry in the ini using the defaults.
var config bool bUsePerMapFactorySet;			/// This mutator uses Per Map Setting from the FactoryReplacer
//---------------------------------------------------

//	iFactory = PerMapFactorySet[iMap].FactoriesToReplace.Find('ReplacedFactory', Factory.Name);

//TODO
/*function SArrayFind(array<MapFactoryReplacerSet> PMFS, <array> FactoriesToReplace)
{
	local int iFactory;

	PMFS=PerMapFactorySet;

	//Cant do this for array find,
	//struct needs to be declared within the calling class, unless package.struct specified
	//hmm!~

	//iMap = Key1
	//iFactory = Key2

	iFactory = PMFS[iMap]
	if(iFactory != INDEX_NONE)
	{
		PerMapFactorySet
	}

	return(PerMapFactorySet);
//	SaveConfig();
}*/

//onSpawn
//`logd("Factor Replacer: "$FactoryData,,'GameData');

/*function int Length(){
//	if(ReplacerFactories.Length > 0)
		return(ReplacerFactories.Length);
//	else return(PM_FactorySet.Length);
}*/

function bool isEmpty(){return (FactoriesSet.length == 0) ? true : false;}

//if(FactoryData.ReplacerFactories[i].FactoryGroup != 'FT_Vehicle')

//TODO: Parse commandline options for this?
function SetupPerMapData(int iMap,optional name FactoryName, out optional string Options)
{
//	local FactoryReplacer NewFactorySet;
	local int iFactory;

	iFactory = PerMapFactorySet[iMap].FactoriesToReplace.Find('ReplacedFactory', FactoryName);
	if(iFactory != INDEX_NONE)
	{
		//Moves Per Map Settings to the Global Array for use.
		FactoriesSet[iFactory].ReplacedFactory = PerMapFactorySet[iMap].FactoriesToReplace[iFactory].ReplacedFactory;
		FactoriesSet[iFactory].ReplacedWithFactory = PerMapFactorySet[iMap].FactoriesToReplace[iFactory].ReplacedWithFactory;
		FactoriesSet[iFactory].ReplacedWithFactoryPath = PerMapFactorySet[iMap].FactoriesToReplace[iFactory].ReplacedWithFactoryPath;
	}
	SaveConfig();
}

/** Adds Map Name only entry if none is found! */
function AddDummyMapEntry(string CurrentMap)
{
	local MapFactoryReplacerSet NewPerMapFactorySet;

	NewPerMapFactorySet.Map = CurrentMap;
	PerMapFactorySet.AddItem(NewPerMapFactorySet);
//	bCheckMapFactoryList = True;

	SaveConfig();//	EditMade();
}

/** Creates Empty Arrays for All Maps -slow */
/*function FillAllDummies(array<string> AllMaps)
{
	local array<MapFactoryReplacerSet> NewPerMapFactorySet;
	local int i;

	for(i=0;i < AllMaps.length;i++)
	{
		NewPerMapFactorySet[i].Map = AllMaps[i];
		PerMapFactorySet.Insert(NewPerMapFactorySet, 1);
		//PerMapFactorySet[i]
		//PerMapFactorySet.AddItem(NewPerMapFactorySet);
	}
}*/

 /**
 * Checks to see if the factory is a pickup or vehicle factory.
 * Notes:	Could have an array here for classes which allow this to be used with them
 * 			Excess Function Call, Redundant but cleaner code!
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function bool CheckNavPoint(NavigationPoint Factory)
{
	if(Factory == None)
		return false;

	if(!ClassIsChildOf(Factory.class ,class'PickupFactory') ||
		!ClassIsChildOf(Factory.class ,class'UTVehicleFactory'))
			return false;

	return true;
}

 /**
 * ASSIGN - Bind a new key to a new value
 * Adds a Global Value to the Factory Replacer Set Array.
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function AddGlobalEntry(NavigationPoint Factory)
{
	local FactoryReplacer NewFactorySet;

	//Optimize: Excess function call?!
	if(!CheckNavPoint(Factory))
		return;

//	`logd("FactoryList: "$Factory.Name$" added to Factory List!",,'FactoryReplacer');
	NewFactorySet.ReplacedFactory = Factory.Name;
	FactoriesSet.AddItem(NewFactorySet);

	SaveConfig();
}

 /**
 * ASSIGN - Bind a new key to a new value
 * @param	iMap		Map Index, pointer to Map in the dynamic array
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function AddPerMapEntry(int iMap, NavigationPoint Factory)
{
	local FactoryReplacer NewFactorySet;

	if(!CheckNavPoint(Factory))
		return;

//	`logd("FactoryList: "$Factory.Name$" added to Per Map Factory Set!",,'FactoryReplacer');
	NewFactorySet.ReplacedFactory = Factory.Name;
	PerMapFactorySet[iMap].FactoriesToReplace.AddItem(NewFactorySet);

	SaveConfig();
}

 /**
 * REASSIGN - if key is found update it
 * @param	iMap		Map Index, pointer to Map in the dynamic array
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function UpdatePerMapEntry(int iMap, NavigationPoint Factory)
{
	local int iFactory;

	if(!CheckNavPoint(Factory))
		return;

	iFactory = PerMapFactorySet[iMap].FactoriesToReplace.Find('ReplacedFactory', Factory.Name);
	if(iFactory != INDEX_NONE){
//		`logd("FactoryList: "$Factory.Name$" set entry updated!",,'FactoryReplacer');
		PerMapFactorySet[iMap].FactoriesToReplace[iFactory].ReplacedFactory = Factory.Name;
	}
	SaveConfig();
}