//===================================================
//	Class: UT_MDB_GR_Replacer
//	Creation Date: 11/04/2010 02:16
//	Last Updated: 18/04/2010 13:28
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Replacer extends UT_MDB_GameRules;
	
/** Factory Group */
enum ReplaceType
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

/** Class limiting searches */
struct ReplacedClassTypes
{
	var ReplaceType				FactoryGroup;
	var class<PickupFactory>	FactoryClass;
	var class<Inventory>		SpawnableClass;
	var string					ClassVariable;
};
var array<ReplacedClassTypes>	ReplacedTypes;

/** Global Replacement */
struct Replacer
{
	var ReplaceType				ReplacedGroup;
	var name					ReplacedName;
	
	structdefaultproperties
	{
		ReplacedGroup=FT_None
	}
};

/** Replacement on a Per Map basis - Get from global when not found */
struct MapReplacer
{
	var string					Map;					/// Map name, this is not a unique id!
	var byte					MapSetID;				/// This is so multiple entries can be chosen per map.
	
	structdefaultproperties
	{
		MapSetID=0
	}
};

var UT_MDB_GameInfo				GameData;

var bool						bReplaceKismetSeqs;
var bool						bCheckMapFactoryList;				/// Map is not found on the list, create a new entry in the ini using the defaults.
var config bool					bUsePerMapSettings;

/*struct GameTypeReplacer
{
	var string GameType;
	var MapReplacer ToReplace;
};
var config array<GameTypeReplacer> GameTypeMapReplacerSet;*/


function Init()
{
	GameData = UT_MDB_GameExp(Master).GameData;
}

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

//	if(!ClassIsChildOf(Factory.class ,class'UTWeaponPickupFactory') ||
//		!ClassIsChildOf(Factory.class ,class'UTAmmoPickupFactory'))
//			return false;

	return true;
}

/**
 * Loads all maps supported by the current GameType.
 * @input	Maps		Maps DataProvider
 */
function LoadAllMaps(out array<UTUIDataProvider_MapInfo> Maps)
{
	local array<UTUIResourceDataProvider> ProviderList;
	local int i;

	if (Maps.Length == 0)
	{
		Class'UTUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_MapInfo', ProviderList);

		for(i = 0; i < ProviderList.Length; ++i)
		{
			if(ProviderList[i] != none)
				if(UTUIDataProvider_MapInfo(ProviderList[i]).SupportedByCurrentGameMode())
					Maps.AddItem(UTUIDataProvider_MapInfo(ProviderList[i]));
			//if(ProviderList[i] != none)
			//	Maps.AddItem(UTUIDataProvider_MapInfo(ProviderList[i]));
		}
	}
}

defaultproperties
{
	//function string GetSpecialValue(name PropertyName);
	//function SetSpecialValue(name PropertyName, string NewValue);
	ReplacedTypes(0)=(FactoryGroup=FT_None, FactoryClass=class'NavigationPoint', SpawnableClass=none, ClassVariable="")
	ReplacedTypes(1)=(FactoryGroup=FT_Health, FactoryClass=class'UTHealthPickupFactory', SpawnableClass=none, ClassVariable="")
	ReplacedTypes(2)=(FactoryGroup=FT_Ammo, FactoryClass=class'UTAmmoPickupFactory', SpawnableClass=none, ClassVariable="TargetWeapon")
	ReplacedTypes(3)=(FactoryGroup=FT_Armour, FactoryClass=class'UTArmorPickupFactory', SpawnableClass=none, ClassVariable="")
	ReplacedTypes(4)=(FactoryGroup=FT_Powerup, FactoryClass=class'UTPowerupPickupFactory', SpawnableClass=class'UTTimedPowerup', ClassVariable="InventoryType")
	ReplacedTypes(5)=(FactoryGroup=FT_SPowerup, FactoryClass=class'UTPowerupPickupFactory', SpawnableClass=class'UTTimedPowerup', ClassVariable="InventoryType")
	ReplacedTypes(6)=(FactoryGroup=FT_Weapon, FactoryClass=class'UTWeaponPickupFactory', SpawnableClass=class'UTWeapon', ClassVariable="WeaponPickupClass")
	ReplacedTypes(7)=(FactoryGroup=FT_SWeapon, FactoryClass=class'UTWeaponPickupFactory', SpawnableClass=class'UTWeapon', ClassVariable="WeaponPickupClass")
	ReplacedTypes(8)=(FactoryGroup=FT_Deployable, FactoryClass=class'UTWeaponPickupFactory', SpawnableClass=class'UTDeployable', ClassVariable="DeployablePickupClass")
	ReplacedTypes(9)=(FactoryGroup=FT_Vehicle, FactoryClass=class'UTVehicleFactory', SpawnableClass=class'UTVehicle', ClassVariable="VehicleClassPath")
	ReplacedTypes(10)=(FactoryGroup=FT_SVehicle, FactoryClass=class'UTVehicleFactory', SpawnableClass=class'UTVehicle', ClassVariable="VehicleClassPath")
	ReplacedTypes(11)=(FactoryGroup=FT_Turret, FactoryClass=class'UTVehicleFactory_TrackTurretBase', SpawnableClass=class'UTVehicleFactory_TrackTurretBase', ClassVariable="VehicleClassPath")
}