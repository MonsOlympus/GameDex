//===================================================
//	Class: UT_MDB_GameExp				//%GAMEEXPANSIONCLASS%   (ClassName)
//	Creation date: 06/12/2007 08:10	//%CREATIONDATE% (Date)
//	Last updated: 05/03/2010 23:52		//%UPDATEDDATE%  (Date)
//	Contributors: 00zX					//%CONTRIBUTORS% (String)
//---------------------------------------------------
//SuperClass for all Game Expansion Mutators
//covers alot of the base functionality which will
//be reused alot through these.
//
//TODO: Expanded Tag Support -
//	Can be used to auto assign groups based on what adjustments are made.
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_GameExp extends UTMutator
	abstract;

`include(MOD.uci)

/** Version number for this Game Expasion Mutator. */
var private int							MutVer;

//Gametype - Moved back from GameDex (GameDex=Obsolete)
var() class<Gameinfo>					GClass;
var() class<PlayerController>			PCClass;	/// Controller for this Mutator.
var() class<UTPawn>						PClass;		/// Pawn for this Mutator.
var() class<HUD>						HUDClass;	/// HUD for this Mutator.
var() class<UTLinkedReplicationInfo>	LRIPath;	/// Class to use for this expansions player replication
var() class<UTCheatManager>			CMClass;

//TODO: HUD, Controllers per Gametype struct
/*struct GameMut
{
	var GameInfo Game;
	var() class<PlayerController>		PCClass;
	var() class<HUD>					HUDClass;
};*/

//TODO: Hoverboard Per FamilyInfo, like species
//var class<UTVehicle>					HBClass;

//GameRules Objects
var UT_MDB_ObjectList					GRList;		//TODO: Move to UT_MDB_GameRules?
var UT_MDB_GameRules					GR;
var private UT_MDB_GameRules			fGR;		//First GameRules in List

/** Factory Replacement/Per Map Factory Replacement */
var UT_MDB_FactoryReplacer				FD;			///FactoryData
//var class<UT_MDB_FactoryReplacer>		cFactoryReplacer;

/** Item Replacement/Per Map Item Replacement */
var UT_MDB_ItemReplacer				IR;

/** Inventory */
var bool								bUseNewDefaultInventory;
var array< class<Inventory> >			NewDefaultInventory;

/** Info Actor Attachements */
//TODO: Move up to object/actor? Provider?
struct ActorInfo{
	var bool			bSpawnForSubClasses;
	var name			AttachedToActor;
	var class<UT_MDI>	AttachedInfo;
//	var class<Info>		AttachedInfo;	//It is possible 1 actor will have more than 1 attachment
};										//It would be faster in check replace to find next in an
var array<ActorInfo> InfoAttachments;	//AttachedInfo array rather than having a second or third entry

//---------------------------------------------------

/** Logging */
var UT_MDB_LogObj						LogObj;

var int k,l;
//var array<name> FactoryList;

//---------------------------------------------------
//class'UTHeroPawn'
var array<UTPawn> PawnList;	// list of pawn paths
//---------------------------------------------------
//var const Pawn NextPawn;

//PawnList[0]=class'UTGame.UTDummyPawn';			//DummyCamera
//PawnList[1]=class'UTGame.UTPawn';				//Default
//PawnList[2]=class'UTGame.UTHeroPawn';			//Titan
//PawnList[3]=class'UTGame.UTBetrayalPawn';		//Betrayal
//Pawn.CurrFamilyInfo

/*	PlayerReplicationInfoClass=class'UTGame.UTBetrayalPRI'
	GameReplicationInfoClass=class'UTGame.UTBetrayalGRI'
	DefaultPawnClass=class'UTBetrayalPawn'
	HUDType=class'UTBetrayalHUD'*/
//---------------------------------------------------
//Globals
var float	ImpartedDmgScale;
var float	SelfRecievedDmgScale;		//0-2
var float	BotImpartedDmgScale;
//var float	VehicleDmgMultiplier;
var float	VehicleRecievedDmgScale,
			VehicleImpartedDmgScale;

/*struct DamageScaling
{
	var name type;			//Enemy.Type?
	var float Imparted;		//%
	var float Recieved;		//%
//	var enum ImpartedOn;	//Injured.Type?
};var array<DamageScaling> DmgScale;*/

//UTTeamGame(WorldInfo.Game).FriendlyFireScale = FriendlyFireScale;

//Gravity
var float	VehicleGravityScale;	//Could be %
var float	InfantryGravityScale;

//From GameInfo
var bool	bNewPlayersVsBots;
var bool	bNewCustomBots;
var bool	bNewWeaponStay;
var bool	bAllowTranslocator;
//UTGame(WorldInfo.Game).bAllowHoverboard = false;
//---------------------------------------------------
replication
{
	if(bNetDirty && (Role == ROLE_Authority) && bNetInitial)
		GR;
}

////
/** @return the name of the package this object resides in */
/*final function name GetPackageNameFor(Object O)
{
//	local Object O;

//	O = self;
	while (O.Outer != None){
		O = O.Outer;
	}
	return O.Name;
}*/

//final function string AppendPackageNameFor(Object O)
/*final function string AppendPackageNameFor(name O)
{
	local Object Oot;

//	O = self;
	while (O.Outer != None){
		Oot = O.Outer;
	}
	//return O.Name$;
	return Oot.Name$O.class;
}*/

////
function GetServerDetails(out GameInfo.ServerResponseLine ServerState)
{
	local int i;

	Super.GetServerDetails(ServerState);

	i = ServerState.ServerInfo.Length;

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "`GD";
	ServerState.ServerInfo[i++].Value = "v2.1";
}

////
//TODO: Add class of the GameRules to find!
static final function GameRules GetGameRules(GameInfo G)
{
	local GameRules GRs;
	local UT_GR_Info mGR;

	for(GRs = G.GameRulesModifiers; GRs != None && mGR == None; GRs = GRs.NextGameRules)
		mGR = UT_GR_Info(GRs);

	return mGR;
}
/*
// simple utility to find the mutator in the given game
static final function MutUT2004RPG GetRPGMutator(GameInfo G)
{
	local Mutator M;
	local MutUT2004RPG RPGMut;

	for (M = G.BaseMutator; M != None && RPGMut == None; M = M.NextMutator)
		RPGMut = MutUT2004RPG(M);

	return RPGMut;
}*/


////
event Destroyed();

function ModifyLogin(out string Portal, out string Options)
{
	Super.ModifyLogin(Portal, Options);
	if(NextMutator == None)
		`logd("Logged in!",,'GameExp');
}

////
event PreBeginPlay()
{
//	local UT_MDB_GR_GlobalDamage DmgGR;
	local UT_MDB_GameRules DmgGR;

	`LogdFunc('GameExp')

	if(LogObj != none)
	{
		LogObj.lMuts.Additem(class.name);

		if(ImpartedDmgScale != 1.0f || SelfRecievedDmgScale != 1.0f ||
			BotImpartedDmgScale != 1.0f || VehicleRecievedDmgScale != 1.0f ||
			VehicleImpartedDmgScale != 1.0f)
		{
			DmgGR = new(self)class'UT_MDB_GR_GlobalDamage';
			`logd("GameRules: "$PathName(DmgGR)$" created!",,'GameExp');
		}

		if(GR != none)
		{
			GRList = UT_MDB_ObjectList(findobject(PathName(LogObj.GRList), class'UT_MDB_ObjectList'));
			if(GRList == none)
			{
				GRList = new(self)class'UT_MDB_ObjectList';
				GRList.owner = self;
				LogObj.GRList = GRList;
				`logd("ObjList: GameRules: "$PathName(GRList)$" Initialized!",,'GameExp');
			}
//			else
//				`logd("ObjList: GameRules: "$PathName(GRList)$" Found!",,'GameDex');

			`logd("GameRules: "$PathName(GR)$" Added to ObjList!",,'GameExp');
			GRList.Add(GR);

			if(DmgGR != None){
				`logd("GameRules: "$PathName(DmgGR)$" Added to ObjList!",,'GameExp');
				GRList.Add(DmgGR);
			}
		}
	}
}

event PostBeginPlay()
{
	`LogdFunc('GameExp')

	Super.PostBeginPlay();

/*	if(NextMutator == None)
		if(UTGameDex != none &&UTGameDex.mGR != none)
			UT_GR_Info(UTGameDex.mGR).SetFirstGR();*/
}

function InitMutator(string Options, out string ErrorMessage)
{
	local Sequence GSeq;
	local array<SequenceObject> AllFactoryActions;
	local UTActorFactoryPickup PickupFactory;
	local int i, iMap, iSeq;

	if(WorldInfo != None && LogObj != none)
	{
		//STUPID STUPID! SUPER.CALLS.NEXTMUTATOR, WANK!
		Super.InitMutator(Options, ErrorMessage);

		//EVERYTHING UNDER HERE GETS CALLED, ONLY ONCE DUH!~
		//Actually, this is getting called twice still, grrrrrrr!
		//ARE YOU SUUUURE!

//		GameDex: GameRulesList:UT_MDB_ObjectList_0 Initialized for: UT_MDB_GameDex0
//		GameExp: PostInitMutator!
//		GameDex: GameRulesList:UT_MDB_ObjectList_1 Initialized for: UT_MDB_GameDex0
//		GameDex: GameData: UT_MDB_GameDex0

		//INITGAMEDEX() being called once!

		k=0;

		if(IR != none)
		{
			`logd("ItemMgr: "$IR,,'GameExp');

			// also check if any Kismet actor factories spawn powerups
			GSeq = WorldInfo.GetGameSequence();
			if(GSeq != None)
			{
				`logd(PathName(GSeq),,'GameExp');
				GSeq.FindSeqObjectsByClass(class'SeqAct_ActorFactory', true, AllFactoryActions);
				for(i = 0; i < AllFactoryActions.length; i++)
				{
					PickupFactory = UTActorFactoryPickup(SeqAct_ActorFactory(AllFactoryActions[i]).Factory);
					if(PickupFactory != None && ClassIsChildOf(PickupFactory.InventoryClass, class'UTInventory'))
					{
						iSeq = IR.ReplacerSet.Find('ReplaceItem', PickupFactory.InventoryClass.name);
						if(iSeq != Index_None)
						{
//							`logd("UTActorFactoryPickup = "$PathName(PickupFactory)$"; UTActorFactoryPickup.InventoryClass = "$PickupFactory.InventoryClass,,'GameExp');
							PickupFactory.InventoryClass = IR.ReplacerSet[iSeq].WithItem;
//							`logd("UTActorFactoryPickup = "$PathName(PickupFactory)$"; UTActorFactoryPickup.InventoryClass = "$PickupFactory.InventoryClass,,'GameExp');
						}
					}
				}
			}
		}

		if(FD != none)
		{
			`logd("FactoryMgr: "$FD,,'GameExp');

			if(FD.bUsePerMapFactorySet)
			{
				`logd("FactoryMgr: Using Per Map Factory Replacer Settings!",,'GameExp');

				iMap = FD.PerMapFactorySet.Find('Map', LogObj.lCurrentMap);
				if(iMap != INDEX_NONE){
					FD.SetupPerMapData(iMap);
				}else{
					`logd("FactoryMgr: Using Global Factory Replacer Settings!",,'GameExp');
					FD.AddDummyMapEntry(LogObj.lCurrentMap);
				}
			}
//			InitFactoryReplacer(CurrentMap);
		}
		else if(!LogObj.logFD)
		{
			//Dont run factory replacer, not needed!
			LogObj.logFD = true;
			`log("FactoryMgr: No Factory Data Found!",,'GameExp');
		}
	}
	else
		Super.InitMutator(Options, ErrorMessage);

	if(NextMutator == None)
		PostInitMutator();
}

//Ran only once for all mutators regardless of Mutator.Next!
function PostInitMutator()
{
	local GameRules mGR;

	`LogdFunc('GameExp')

	if(WorldInfo.Game != none)
	{
		UTGame(WorldInfo.Game).bAllowTranslocator = default.bAllowTranslocator;

		LogObj.lCurrentMap = WorldInfo.GetMapName(true);
		LogObj.lG = UTGame(WorldInfo.Game);

		if(PClass != None)		WorldInfo.Game.DefaultPawnClass = PClass;
		if(PCClass != None)		WorldInfo.Game.PlayerControllerClass = PCClass;
		if(HUDClass != None)	WorldInfo.Game.HUDType = HUDClass;

		`logd("Pawn.Class: "$WorldInfo.Game.DefaultPawnClass,,'GameExp');
		`logd("Controller.Class: "$WorldInfo.Game.PlayerControllerClass,,'GameExp');
		`logd("HUD.Class: "$WorldInfo.Game.HUDType,,'GameExp');

		if(GR!=none)
		{
			//TODO: Check LinkedList for UT_GR_Info, not just First in List!
			//mGR = UT_GR_Info(WI.Game.GameRulesModifiers);

			mGR = WorldInfo.Game.GameRulesModifiers;

			//Spawn the Master GameRules for GameDex
			if(mGR == none)
			{
				WorldInfo.Game.AddGameRules(class'UT_GameDex.UT_GR_Info');
				mGR = WorldInfo.Game.GameRulesModifiers;
				UT_GR_Info(mGR).GameExp = self;
			}

//			if(mGR != none && mGR.IsA('UT_GR_Info'))//		if(UT_GR_Info(mGR) != none)
//				UT_GR_Info(mGR).GD=self;

			if(mGR != none && mGR.IsA('UT_GR_Info'))
				UT_GR_Info(mGR).SetFirstGR();

			`logd("MasterGameRules: "$PathName(mGR)$" Initialized!",,'GameExp',);

			if(!GRList.isEmpty())
			{
				GRList.DumpLogForAllObj('GameRules');

				if(mGR != none && mGR.IsA('UT_GR_Info'))
					GRList.SetMasterGR(UT_GR_Info(mGR));

				GRList.SetSpecialGR();

				if(fGR == none)
					fGR = UT_MDB_GameRules(GRList.GetFirst());
			}
		}
		else
			`logd("GameRules not found for "$class.name,,'GameExp');
	}
}

////
//Replacement functions
function bool CheckReplacement(Actor Other)
{
	local UTPlayerController UTPlayer;
//	local PickupFactory PickupReplacer;
	local UT_MDI AttachedInfo;
	local int idx,i;

	UTPlayer = UTPlayerController(Controller(other));
	if(UTPlayer != None && CMClass != None)
		UTPlayer.CheatClass = default.CMClass;

	//Spawn/Attach Info's (called here for Spawn[actor])	//Faster?
	//TODO: Add support for spawnin for all subclasses of InfoAttachments.AttachedToActor!
	if(InfoAttachments.length >= 1)
	{
		idx=InfoAttachments.find('AttachedToActor', Other.class.name);
//		`logd("Other.name: "$Other.name$"; Other.Class.Name: "$Other.class.name,,'GameExp');
		if(idx != Index_None){
			AttachedInfo = Spawn(InfoAttachments[idx].AttachedInfo, Other);
			`logd("MDI: Info: "$AttachedInfo.name$" AttachedTo: "$InfoAttachments[idx].AttachedToActor$"."$Other,,'GameExp');
		}

		//Slower for all Subclasses
/*		for (i=0;i<InfoAttachments.length; i++)
			if(InfoAttachments[i].bSpawnForSubClasses)
				if(Other.IsA(InfoAttachments[i].AttachedToActor))
					Spawn(InfoAttachments[i].AttachedInfo, Other);*/

		i=InfoAttachments.find('bSpawnForSubClasses', true);
		if(i != Index_None)
			if(Other.IsA(InfoAttachments[i].AttachedToActor)){
				AttachedInfo = Spawn(InfoAttachments[i].AttachedInfo, Other);
				`logd("MDI: Info: "$AttachedInfo.name$" AttachedTo: "$InfoAttachments[i].AttachedToActor$"."$Other,,'GameExp');
			}
	}

	//Start Factory Replacer Module | TODO: Run this only on map start!@
	//NavigationPoint(Other)!=none
	if(FD != None && Other.IsA('NavigationPoint')){
		if(!FD.isEmpty()){
			return FactoryReplacement(NavigationPoint(Other)); //Pass Name instead of Actor, speed?
			//`log("FactoryMgr: No Replacement Factories Found!",,'GameExp');
		}
	}/*else{
		`log("No Factory Data Found!",,'FactoryReplacer');
	}*/

	//TODO: Need to fix for weapons and ammo
/*	if(ItemsToReplace.length >= 1){
		idx=ItemsToReplace.find('OldClassName', PickupFactory(Other).class.name);
		if(idx != Index_None){
			PickupFactory(other).InventoryType=ItemsToReplace[idx].NewInvType;
			PickupFactory(other).InitializePickup();
		}
	}*/

	if(GRList != none)
	{
		if(!GRList.isEmpty())
		{
			if(fGR == none)
				fGR = UT_MDB_GameRules(GRList.GetFirst());

			return fGR.CheckReplacement(Other);
		}
	}

	return true;
}

//Sort Struct Array by Enum?

function bool FactoryReplacement(NavigationPoint Other)
{
	local int /*iMap,*/ iRep;

	if(FD.FactoriesSet.length > 0 && k == 0)
	{
		`logd("FactoryMgr: Factory Set Length = "$FD.FactoriesSet.length,,'GameExp');
		k++;
	}

	iRep=FD.FactoriesSet.find('ReplacedFactory', Other.class.name);
	if(iRep != Index_None)
	{
		if(Other.class.name != FD.FactoriesSet[iRep].ReplacedWithFactory)
		{
			//ReplaceWith(Other, AppendPackageNameFor(FD.FactoriesSet[iRep].ReplacedWithFactory));
			ReplaceWith(Other, FD.FactoriesSet[iRep].ReplacedWithFactoryPath);
			`logd("FactoryMgr: Factory: "$Other$" Replaced With: "$FD.FactoriesSet[iRep].ReplacedWithFactoryPath,,'GameExp');
			return false;
		}

		//if(UTVehicleFactory(Other) != UTVehicleFactory_TrackTurretBase(Other))

/*		if(FD.bUsePerMapFactorySet)
		{
			iMap = FD.PerMapFactorySet.Find('Map', LogObj.lCurrentMap);
			if(iMap != INDEX_NONE)
			{
				//TODO: Will add entry for every factory in the map, do not want!
				iFactory = FD.PerMapFactorySet[iMap].FactoriesToReplace.Find('ReplacedFactory', Other.Name);
				if(iFactory == INDEX_NONE)
					FD.AddPerMapEntry(iMap, PickupFactory(Other));
				else if(iFactory != INDEX_NONE)
					FD.UpdatePerMapEntry(iMap, PickupFactory(Other));
			}
		}*/
	}

	return true;
}

////
//Modify functions
function ModifyPlayer(Pawn Other)
{
	local UTPawn P;
	local UTVehicle V;

	//if(Other.IsA(class'')){}

/*	if(WorldInfo.NetMode == NM_Client)
		`logd("Client: Made it to "$GetFuncName(),,'GameExp');
	else
		`logd("Server: Made it to "$GetFuncName(),,'GameExp');*/

	P = UTPawn(Other);
	if(P != None){
		ModifyPawn(P);

		if(UTHeroPawn(P) != None)
			ModifyRook(UTHeroPawn(P));
	}

	V = UTVehicle(Other);
	if(V != None){
//		ModifyKnight(V);
		ModifyVehicle(V);
	}

	Super.ModifyPlayer(Other);
	//Remeber to call super if you want to use the below;
}

function ModifyPawn(UTPawn P)
{
	if(P == None)
		return;

	if(P.name != LogObj.lPawn){
		`log("Pawn: "$PathName(P),,'GameExp');
		LogObj.lPawn = P.name;
	}

	if(self.fGR != none)
		self.fGR.ModifyPawn(P);
}

/* Hero Vehicle? */
/*function ModifyKnight(UTVehicle V)
{
	if(V == None)
		return;

	`log("Vehicle: "$V);
}*/

// NOTE: Only modifys the vehicle once a player enters it or on spawn?
function ModifyVehicle(UTVehicle V)
{
//	local UT_MDB_GameRules tGR;

	if(V == None)
		return;

	if(V.name != LogObj.lVehicle){
		`log("Vehicle: "$PathName(V),,'GameExp');
		LogObj.lVehicle = V.name;
	}

	if(self.fGR != none)
		self.fGR.ModifyVehicle(V);
}

function ModifyRook(UTHeroPawn R)
{
	if(R == None)
		return;

	if(R.name != LogObj.lRook){
		`log("Rook: "$PathName(R),,'GameExp');
		LogObj.lRook = R.name;
	}

	if(self.fGR != none)
		self.fGR.ModifyRook(R);
}

////
/** Added to allow Gametype hook to UTLinkedReplicationInfo.
Similar to Info attachment method but instead links a replication info to the PRI.*/
//NOTE: Should be called from check replacement!
function AddReplicationInfo(Actor Other)
{
	local UTLinkedReplicationInfo LRI;
	local UTPlayerReplicationInfo PRI;
///	local UTPlayerReplicationInfo PCRI;
//	local class<UTLinkedReplicationInfo> LRIPath;
//	foreach dynamicactors(class'PlayerController', pc) {

//	LRIPath = LRIPath;
	PRI = UTPlayerReplicationInfo(Other);
	if(PRI != None && LRIPath != None)
	{
		if(PRI.CustomReplicationInfo != None)
		{
			LRI = PRI.CustomReplicationInfo;
//			while(LRI.NextReplicationInfo != None){
//				LRI = LRI.NextReplicationInfo;
//			}
			LRI.NextReplicationInfo = Spawn(LRIPath, Other.Owner);
			`logd("PRI.CRI.NextReplicationInfo: "$LRI.NextReplicationInfo,,'GameExp');
		}
		else
		{
			PRI.CustomReplicationInfo = Spawn(LRIPath, Other.Owner);
			`logd("PRI.CustomReplicationInfo: "$PRI.CustomReplicationInfo,,'GameExp');
		}
	}
}

//TODO: Port from 2k4, FamilyInfo
// Called when a player sucessfully changes to a new class
/*function PlayerChangedClass(Controller aPlayer)
{
	if(NextMutator != None)
		NextMutator.PlayerChangedClass(aPlayer);
}*/

defaultproperties
{
	Begin Object Class=UT_MDB_LogObj Name=UT_MDB_LogObj0
	End Object
	LogObj=UT_MDB_LogObj0

	PClass=None
	PCClass=None
	LRIPath=None
	HUDClass=None
	CMClass=None
	bUseNewDefaultInventory=False

	FD=none
	GR=none

	ImpartedDmgScale=1.0
	SelfRecievedDmgScale=1.0
	BotImpartedDmgScale=1.0
	VehicleRecievedDmgScale=1.0
	VehicleImpartedDmgScale=1.0
}