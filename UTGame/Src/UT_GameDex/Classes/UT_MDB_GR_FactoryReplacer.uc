//===================================================
//	Class: UT_MDB_GR_FactoryReplacer
//	Creation date: 11/08/2008 15:39
//	Last updated: 20/04/2010 13:03
//	Contributors: 00zX
//---------------------------------------------------
//TODO: Make sure only 1 factory replaces current
//eg. 2 entries want to replace the same factory.
//TODO: Only check subclasses of factories as required
//no need to check otherwise.
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_FactoryReplacer extends UT_MDB_GR_Replacer
	implements(MDIB_GR_CheckReplacement)
	Config(GameDex);

/** Global Factories to replace */
struct FactoryReplacer extends Replacer
{
	var name					ReplacedWithName;
	var string					ReplacedWithPath;
//	var name					NextFactory, LastFactory;

	structdefaultproperties
	{
		ReplacedWithName=NavigationPoint					//TODO: ReplaceWith=None
		ReplacedWithPath=""
	}
};
var config array<FactoryReplacer> ReplacerSet;

/** Factories to replace on a Per Map basis - Get from global when not found */
struct MapFactoryReplacerSet extends MapReplacer
{
	var array<FactoryReplacer> ToReplace;
};
var config array<MapFactoryReplacerSet> MapReplacerSet;


function Init()
{
//	local Sequence GSeq;
//	local array<SequenceObject> AllFactoryActions;
//	local UTActorFactoryPickup PickupFactory;
//	local int i, iSeq;
	local int iMap, iRep;
	local MapFactoryReplacerSet NewMapReplacerSet;
	local name ReplacedName;

	Super.Init();

	if(GameData.CurMap != "")
	{
		//Initialize Factory Replacement
		if(bUsePerMapSettings)
		{
			`logd("FactoryReplacer: Using Per Map Factory Replacer Settings!",,'GameExp');
			iMap = MapReplacerSet.Find('Map', GameData.CurMap);
			if(iMap != INDEX_NONE)
			{
				//Moves Per Map Settings to the Global Array for use.
				iRep = MapReplacerSet[iMap].ToReplace.Find('ReplacedName', ReplacedName);
				if(iRep != INDEX_NONE)
				{
					//Moves Per Map Settings to the Global Array for use.
					ReplacerSet[iRep].ReplacedName = MapReplacerSet[iMap].ToReplace[iRep].ReplacedName;
					ReplacerSet[iRep].ReplacedWithName = MapReplacerSet[iMap].ToReplace[iRep].ReplacedWithName;
					ReplacerSet[iRep].ReplacedWithPath = MapReplacerSet[iMap].ToReplace[iRep].ReplacedWithPath;
				}
				SaveConfig();
			}
			else
			{
				NewMapReplacerSet.Map = GameData.CurMap;
				MapReplacerSet.AddItem(NewMapReplacerSet);
			}
		}
		
//		`logd("ItemMgr: "$IR,,'GameExp');

		// also check if any Kismet actor factories spawn powerups
/*		GSeq = UT_MDB_GameExp(Master).GameData.CurWorldInfo.GetGameSequence();
		if(GSeq != None)
		{
			`logd(PathName(GSeq),,'GameExp');
			GSeq.FindSeqObjectsByClass(class'SeqAct_ActorFactory', true, AllFactoryActions);
			for(i = 0; i < AllFactoryActions.length; i++)
			{
				PickupFactory = UTActorFactoryPickup(SeqAct_ActorFactory(AllFactoryActions[i]).Factory);
				if(PickupFactory != None && ClassIsChildOf(PickupFactory.InventoryClass, class'UTInventory'))
				{
					iSeq = ReplacerSet.Find('ReplaceItem', PickupFactory.InventoryClass.name);
					if(iSeq != Index_None)
					{
						PickupFactory.InventoryClass = ReplacerSet[iSeq].WithItem;
//						`logd("UTActorFactoryPickup = "$PathName(PickupFactory)$"; UTActorFactoryPickup.InventoryClass = "$PickupFactory.InventoryClass,,'GameExp');
					}
				}
			}
		}*/
	}
}

function bool CheckReplacement(Actor Other)
{
	local int iMap, iRep;
	
	//Start Factory Replacer Module | TODO: Run this only on map start!@
	if(Other.IsA('NavigationPoint') && CheckNavPoint(NavigationPoint(Other)))
	{
		//TODO: Only check subclasses of factories as required no need to check otherwise.
		//if(CheckNavPoint(NavigationPoint(Other)))
		
		if(ReplacerSet.length > 0)
		{
			iRep = ReplacerSet.find('ReplacedName', Other.class.name);
			if(iRep != Index_None)
			{
				if(Other.class.name != ReplacerSet[iRep].ReplacedWithName)
				{
					//ReplaceWith(Other, AppendPackageNameFor(FD.FactoriesSet[iRep].ReplacedWithFactory));
					UTMutator(Master).ReplaceWith(Other, ReplacerSet[iRep].ReplacedWithPath);
					`logd("FactoryReplacer: Factory: "$Other$" Replaced With: "$ReplacerSet[iRep].ReplacedWithPath,,'GameExp');
					return false;
				}

				//if(UTVehicleFactory(Other) != UTVehicleFactory_TrackTurretBase(Other))

				if(bUsePerMapSettings)
				{
					iMap = MapReplacerSet.Find('Map', GameData.CurMap);
					if(iMap != INDEX_NONE)
					{
						iRep = MapReplacerSet[iMap].ToReplace.Find('ReplacedName', Other.Name);
						if(iRep != INDEX_NONE)
						{
							MapReplacerSet[iMap].ToReplace[iRep].ReplacedName = Other.Name;
							//UpdatePerMapEntry(iMap, PickupFactory(Other));
						}
						//TODO: Will add entry for every factory in the map, do not want!
/*						else if(iRep == INDEX_NONE)
						{
							NewReplacerSet.ReplacedName = Other.Name;
							PerMapReplacerSet[iMap].ToReplace.AddItem(NewReplacerSet);
						//	AddPerMapEntry(iMap, PickupFactory(Other));
						}*/
					}
				}
			}
		}
	}

	return true;
}

//---------------------------------------------------
//Utilities

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
function bool CheckNavPoint(NavigationPoint NavPoint)
{
	if(NavPoint == None)
		return false;

/*	if(!ClassIsChildOf(Factory.class ,class'PickupFactory') ||
		!ClassIsChildOf(Factory.class ,class'UTVehicleFactory'))
			return false;*/

	return true;
}

/**
 * ASSIGN - Bind a new key to a new value
 * Adds a Global Value to the Factory Replacer Set Array.
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function AddGlobalEntry(NavigationPoint NavPoint)
{
	local FactoryReplacer NewReplacerSet;

	//Optimize: Excess function call?!
	if(!CheckNavPoint(NavPoint))
		return;

//	`logd("FactoryList: "$Factory.Name$" added to Factory List!",,'FactoryReplacer');
	NewReplacerSet.ReplacedName = NavPoint.Name;
	ReplacerSet.AddItem(NewReplacerSet);

	SaveConfig();
}

/**
 * ASSIGN - Bind a new key to a new value
 * @param	iMap		Map Index, pointer to Map in the dynamic array
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function AddPerMapEntry(int iMap, NavigationPoint NavPoint)
{
	local FactoryReplacer NewReplacerSet;

	if(!CheckNavPoint(NavPoint))
		return;

//	`logd("FactoryList: "$Factory.Name$" added to Per Map Factory Set!",,'FactoryReplacer');
	NewReplacerSet.ReplacedName = NavPoint.Name;
	MapReplacerSet[iMap].ToReplace.AddItem(NewReplacerSet);

	SaveConfig();
}

/**
 * REASSIGN - if key is found update it
 * @param	iMap		Map Index, pointer to Map in the dynamic array
 * @param	Factory		Any subclass of Navigation Point, usually a Pickup or Vehicle Factory
 */
function UpdatePerMapEntry(int iMap, int iRep, NavigationPoint NavPoint)
{
	if(!CheckNavPoint(NavPoint))
		return;

//	`logd("FactoryList: "$Factory.Name$" set entry updated!",,'FactoryReplacer');
	MapReplacerSet[iMap].ToReplace[iRep].ReplacedName = NavPoint.Name;

	SaveConfig();
}