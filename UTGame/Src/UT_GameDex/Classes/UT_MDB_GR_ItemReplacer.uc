//===================================================
//	Class: UT_MDB_GR_ItemReplacer
//	Creation date: 07/09/2009 01:34
//	Last updated: 20/04/2010 13:03
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_ItemReplacer extends UT_MDB_GR_Replacer
	implements(MDIB_GR_CheckReplacement)
	Config(GameDex);

/** Global Factories to replace */
struct ItemReplacer extends Replacer
{
	var class<Inventory>		ReplacedWithClass;
};
var config array<ItemReplacer> ReplacerSet;


struct MapItemReplacer extends MapReplacer
{
	var array<ItemReplacer>	ToReplace;
};
var config array<MapItemReplacer> PerMapReplacerSet;

//var class<NavigationPoint> UseForClass[4];

function Init()
{
	local Sequence GSeq;
	local array<SequenceObject> AllFactoryActions;
	local UTActorFactoryPickup PickupFactory;
	local int i, iMap, iSeq;

	Super.Init();

	if(GameData.CurMap != "")
	{
		//Initialize Factory Replacement
		if(bUsePerMapSettings)
		{
			iMap = PerMapReplacerSet.Find('Map', GameData.CurMap);
			if(iMap != INDEX_NONE)
			{
				//Moves Per Map Settings to the Global Array for use.
				//SetupPerMapData(iMap);
			}
			else
			{
				//AddDummyMapEntry(Exp.GameData.CurMap);
			}
		}

		// also check if any Kismet actor factories spawn powerups
		if(bReplaceKismetSeqs)
		{
			GSeq = GameData.CurWorldInfo.GetGameSequence();
			if(GSeq != None)
			{
				`logd(PathName(GSeq),,'ItemReplacer');
				GSeq.FindSeqObjectsByClass(class'SeqAct_ActorFactory', true, AllFactoryActions);
				for(i = 0; i < AllFactoryActions.length; i++)
				{
					PickupFactory = UTActorFactoryPickup(SeqAct_ActorFactory(AllFactoryActions[i]).Factory);
					if(PickupFactory != None && ClassIsChildOf(PickupFactory.InventoryClass, class'UTInventory'))
					{
						iSeq = ReplacerSet.Find('ReplacedName', PickupFactory.InventoryClass.name);
						if(iSeq != Index_None)
						{
//							`logd("UTActorFactoryPickup = "$PathName(PickupFactory)$"; UTActorFactoryPickup.InventoryClass = "$PickupFactory.InventoryClass,,'GameExp');
							PickupFactory.InventoryClass = ReplacerSet[iSeq].ReplacedWithClass;
//							`logd("UTActorFactoryPickup = "$PathName(PickupFactory)$"; UTActorFactoryPickup.InventoryClass = "$PickupFactory.InventoryClass,,'GameExp');
						}
					}
				}
			}
		}
	}
}

function bool CheckReplacement(Actor Other)
{
	local UTWeaponPickupFactory Factory;
	local UTHealthPickupFactory F;

	//TODO: Remove Super Weapons, vehicles (key vehicles), etc
	Factory = UTWeaponPickupFactory(Other);
	if(Factory != None)
	{
		if(Factory.WeaponPickupClass.Default.bSuperWeapon)
			return false;
	}
	

	if(Other.IsA('UTHealthPickupFactory'))
	{
	//	F = UTHealthPickupFactory(Other);
	//	return (F == None);
	}
	
	//Start Factory Replacer Module | TODO: Run this only on map start!@
	if(Other.IsA('NavigationPoint'))
	{
		if(ReplacerSet.length > 0)
		{
			return ItemReplacement(NavigationPoint(Other)); //Pass Name instead of Actor, speed?
		}
	}
	return true;
}

function bool ItemReplacement(Actor Other)
{
	local UTVehicleFactory VF;
	local UTPickupFactory PF;
	local int idx;

	//Straight Inventory Replacement!
	PF = UTPickupFactory(Other);
	if(PF != none)
	{
		//Gives Access to certain variables only assigned on Init()
		PF.InitializePickup();

		idx = ReplacerSet.Find('ReplacedName', Other.Name);
		if (idx != INDEX_NONE)
		{
			if(ReplacerSet[idx].ReplacedWithClass == none)
				return false;
			else
				PF.InventoryType = ReplacerSet[idx].ReplacedWithClass;
		}

		//ReInitialize Pickup factory, hopefully this is okay to do.
		PF.InitializePickup();

		//	PF.bIsSuperItem
	}
	
	VF = UTVehicleFactory(Other);
	if(VF != None)
	{
		//UTVehicleFactory.VehicleClassPath
	}

	//var() class<UTWeapon> WeaponPickupClass;

	
	return true;
}


defaultproperties
{
	bReplaceKismetSeqs=true
}