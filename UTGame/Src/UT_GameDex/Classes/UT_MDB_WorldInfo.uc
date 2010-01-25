//===================================================
//	Class: UT_MDB_WorldInfo
//	Creation date: 17/03/2009 02:22
//	Last updated: 08/09/2009 20:41
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_WorldInfo extends UT_MDB;

var private WorldInfo WI;

function setWorldInfo(WorldInfo tWI)
{
	WI=tWI;
}

//TODO: Hook into kismet, per map exceptions for maps like heatray
//eg. change the dark walker spawn to another vehicle and/or
//change the pickups dropped by a dead darkwalker.

//Angle_Mapper
//http://forums.beyondunreal.com/showthread.php?t=183561
/*function Something()
{
		local int i;
		local Sequence GameSeq;
		local array<SequenceObject> AllSeqEvents;

		GameSeq = WorldInfo.GetGameSequence();

		if(GameSeq != None)
		{
				GameSeq.FindSeqObjectsByClass(class'SeqEvent_Something', true, AllSeqEvents);
				for(i=0; i<AllSeqEvents.Length; i++)
						SeqEvent_Something(AllSeqEvents[i]).CheckActivate(WorldInfo, None);
		}
}*/

/*function FindActorYinKismet(object FindME)
{
	local Sequence GSeq;
//	local array<SeqAct_ActorFactory> ASeqE;
	local array<SequenceObject> ASeqE;
	local int i;

	GSeq = WI.GetGameSequence();
	if(GSeq != None)
	{
		GSeq.FindSeqObjectsByClass(class'SeqAct_ActorFactory',true,ASeqE);

		for(i=0; i<ASeqE.Length; i++)
			if(SeqAct_ActorFactory(AllSeqEvents[i]).Factory = FindME)
	}
}*/

/*simulated function PostBeginPlay()
{
	local Sequence GSeq;
	local array<SequenceObject> AllFactoryActions;
//	local SeqAct_ActorFactory FactoryAction;
	local UTActorFactoryPickup PickupFactory;
//	local UTActorFactoryVehicle VehicleFactory;
	local int i;

	// also check if any Kismet actor factories spawn powerups
	GSeq = WI.GetGameSequence();
	if(GSeq != None)
	{
		GSeq.FindSeqObjectsByClass(class'SeqAct_ActorFactory', true, AllFactoryActions);
		for (i = 0; i < AllFactoryActions.length; i++)
		{
			//FactoryAction = SeqAct_ActorFactory(AllFactoryActions[i]);

			PickupFactory = UTActorFactoryPickup(SeqAct_ActorFactory(AllFactoryActions[i]).Factory);
			if(PickupFactory != None && ClassIsChildOf(PickupFactory.InventoryClass, class'UTInventory'))
				FactoryData.FactoriesSet.Find()
				if(PickupFactory.InventoryClass.name == FactoryData.FactoriesSet(j).ReplacedFactory)
					PickupFactory.InventoryClass = class(FactoryData.FactoriesSet(j).ReplacedWithFactory).InventoryType;
				//PickupFactory.InventoryClass=NewInventoryClass;

//			VehicleFactory = UTActorFactoryVehicle(SeqAct_ActorFactory(AllFactoryActions[i]).Factory);
//			if(VehicleFactory != None && ClassIsChildOf(VehicleFactory.VehicleClass, class'UTVehicle'))
//				VehicleFactory.VehicleClass=NewVehicleClass;
		}
	}
}*/

//WI.Game is of Type ()()()
//KnownCustomGames = WI.Game is of Type ()()()
//WI.GameTypesSupportedOnThisMap

//var transient const private	NavigationPoint		NavigationPointList;
//var const private			Controller			ControllerList;
//var const					Pawn				PawnList;
//var transient const			CoverLink			CoverList;

/*replication
{
	if( bNetDirty && Role==ROLE_Authority )
		Pauser, TimeDilation, WorldGravityZ, bHighPriorityLoading;
}*/
//native final function MapInfo GetMapInfo();

//===================================================
simulated function PreBeginPlay()
{
//	local class<EmitterPool> PoolClass;
//	local class<DecalManager> DecalManagerClass;

	//GetMapInfo()

//	Super.PreBeginPlay();

	// create the emitter pool and decal manager
//	if (WorldInfo.NetMode != NM_DedicatedServer){	}
}
//===================================================

/** particle emitter pool for gameplay effects that are spawned independent of their owning Actor */
//var globalconfig string EmitterPoolClassPath;
//var EmitterPool MyEmitterPool;

/** decal pool and lifetime manager */
//var globalconfig string DecalManagerClassPath;
//var DecalManager MyDecalManager;

//native function float GetGravityZ();
//native final function Sequence GetGameSequence() const;
//native final function SetLevelRBGravity(vector NewGrav);

//simulated function class<GameInfo> GetGameClass()

//native final noexport function NavigationPointCheck(vector Point, vector Extent, optional out array<NavigationPoint> Navs, optional out array<ReachSpec> Specs);
//native final iterator function AllControllers(class<Controller> BaseClass, out Controller C);
//native final iterator function AllPawns(class<Pawn> BaseClass, out Pawn P, optional vector TestLocation, optional float TestRadius);

//native final function NotifyMatchStarted(optional bool bShouldActivateLevelStartupEvents=true, optional bool bShouldActivateLevelBeginningEvents=true, optional bool bShouldActivateLevelLoadedEvents=false);
