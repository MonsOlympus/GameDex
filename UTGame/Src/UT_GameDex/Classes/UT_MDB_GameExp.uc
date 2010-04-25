//===================================================
//	Class: UT_MDB_GameExp
//	Creation Date: 06/12/2007 08:10
//	Last Updated: 20/04/2010 21:20
//	Contributors: 00zX
//---------------------------------------------------
//TODO: Expanded Tag Support -
//	Can be used to auto assign groups based on what adjustments are made.

//Removed Redundant function calls
//Moved Info Attachments to Gamerules objects
//Killed the ObjectList and put the list functionality in this class
//Moved FactoryData and ItemReplacer functionality out to GameRules object subclasses
//Started readying things for UTM_ prefix class depreciation
//Added new GameInfo object, moved all LogObj and associated functionality that was in this class there
//Added enter/exit vehicle modify/notifys
//Removed Notify object and replaced with interfaces 
//	-which allows calling of only specific GameRules subclasses based on their functionality
//	-this in turn lead to removal of the secondary for loops in place of an interface != none comparison (as suggested by SolidSnake)

//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_GameExp extends UTMutator
	abstract;

`include(MOD.uci)

/* Version number for this Game Expasion Mutator. */
Const MutVer = 2.72;

/* Gametype Data Object */
var UT_MDB_GameInfo						GameData;

/* GameRules Objects - Hybrid Array/List */
var protected array<UT_MDB_GameRules>	GameRulesList;

////
//TODO: Could make this a function of GameData;
final function UT_GR_Info GetMasterGameRules()
{
	local GameRules MasterGameRules;
	
	MasterGameRules = WorldInfo.Game.GameRulesModifiers;

	//Spawn the Master GameRules for GameDex
	if(MasterGameRules == none)
	{
		WorldInfo.Game.AddGameRules(class'UT_GameDex.UT_GR_Info');
		MasterGameRules = WorldInfo.Game.GameRulesModifiers;
		UT_GR_Info(MasterGameRules).GameExp = self;
	}
	//TODO: Search for class if other non-GameDex mutators are used.

	return UT_GR_Info(MasterGameRules);
}

//Returns none if next is none, returns object if found.
//FIXME: It is a possibility that 'this' will not be in the list at all
//which would mean, Find will fail returning index_none and breakin the return
final function UT_MDB_GameRules GetNextGameRules(UT_MDB_GameRules this)
{
	local int idx;

	idx = self.GameRulesList.Find(this);
	return self.GameRulesList[idx+1];
}

final function UT_MDB_GameRules GetBaseGameRules()
{
	return self.GameRulesList[0];
}

//Returns first instance of GameRules matching class
//Or creates a new instance of GameRules and returns that
final function UT_MDB_GameRules UpdateGameRules(class<UT_MDB_GameRules> GRC)
{
	local UT_MDB_GameRules GR;

	for(GR = GetBaseGameRules(); GR != None; GR = GetNextGameRules(GR))
	{
		if(GR.Class == GRC)
			return GR;
	}
	
	GR = new(self)GRC;
	self.GameRulesList.Additem(GR);
	GR.Init();
	return GR;
}

////
final function AddGroupName(string G)
{
	local int idx;
	
	idx = GroupNames.find(G);
	if(idx != INDEX_NONE)
		GroupNames.Additem(G);
}

final function RemoveGroupName(string G)
{
	local int idx;
	
	idx = GroupNames.find(G);
	if(idx != INDEX_NONE)
		GroupNames.Removeitem(G);
}

////
function GetServerDetails(out GameInfo.ServerResponseLine ServerState)
{
	local UT_MDB_GameRules GR;
	local int i;

	Super.GetServerDetails(ServerState);

	i = ServerState.ServerInfo.Length;

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "GameDex";
	ServerState.ServerInfo[i++].Value = "v"$MutVer;

	//All GameRules GetServerDetails called
	foreach self.GameRulesList(GR)
		GR.GetServerDetails(ServerState);
}

////
//TODO: Tidy everything up in this case.
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
	`LogdFuncN()
}

event PostBeginPlay()
{
	local UT_MDB_GameRules GR;

	`LogdFuncN()

	Super.PostBeginPlay();

	foreach self.GameRulesList(GR)
		 if(MDIB_GR_PostBeginPlay(GR) != None)
			MDIB_GR_PostBeginPlay(GR).PostBeginPlay();
}

function InitMutator(string Options, out string ErrorMessage)
{
	`LogdFuncN()

	Super.InitMutator(Options, ErrorMessage);

	//Ran only once for all mutators regardless of Mutator.Next!
	if(NextMutator == None)
	{
		PostInitMutator();
		GameData.Init();
	}
}

singular function PostInitMutator()
{
	local UT_GR_Info MasterGameRules;
	local UT_MDB_GameRules GR;

	`LogdFuncN()

	if(WorldInfo.Game != none)
	{
		GameData.CurWorldInfo = WorldInfo;
		GameData.CurGameType = UTGame(WorldInfo.Game);
		GameData.CurMap = WorldInfo.GetMapName(true);
		
		//TODO: Check LinkedList for UT_GR_Info, not just First in List!
		MasterGameRules = GetMasterGameRules();
		MasterGameRules.SetBaseGameRules();
		`logd("MasterGameRules: "$PathName(MasterGameRules)$" Initialized!",,'GameExp',);

		//All GameRules get the Init() method called regardless of interface
		foreach self.GameRulesList(GR)
			GR.Init();
	}
}

////
//CheckReplacement won't catch any classes whose bGameRelevant property is set to True 
//	(namely any subclasses of Effects, Projectile, xEmitter and several more)
function bool CheckReplacement(Actor Other)
{
	local Controller C;
	local UT_MDB_GameRules GR;
	
	if(GameData == None)
		return true;

	C = Controller(Other);

	//for(GR = GetBaseGameRules(); GR != None; GR = GetNextGameRules(GR))
	foreach self.GameRulesList(GR)
	{
		if(MDIB_GR_CheckReplacement(GR) != None)
			return MDIB_GR_CheckReplacement(GR).CheckReplacement(Other);

		if(C != None)
		{
			if(C.name != GameData.CurController)
			{
				`logd("Controller: "$PathName(C),,'GameExp');
				GameData.CurController = C.name;
				GameData.NotifyAllControllers(C);
			}

			//if(MDIB_GR_NotifyController(GR) != None)
			//	MDIB_GR_NotifyController(GR).NotifyController(C);
		}

		//ET_OnSpawn?
		if(Other.IsA('Weapon'))
		{
			if(MDIB_GR_ModifyWeapon(GR) != None)
				MDIB_GR_ModifyWeapon(GR).ModifyWeapon(Weapon(Other));

			//foreach GR.EventNotifier.Notifies(HandleNotify)
			//	if(HandleNotify.EventName == ET_OnStart && HandleNotify.NotifyName == NT_Weapon)
			//		GR.ModifyWeapon(Weapon(Other));
		}
	}

	return true;
}

////
function ModifyPlayer(Pawn Other)
{
	local UTPawn P;
	local UTVehicle V;

	local UT_GR_Info.PawnInfo PInfo;
	local UT_MDB_GameRules BaseGameRules, GR;

	if(GameData == None)
		return;

	BaseGameRules = GetBaseGameRules();

	//new PawnInfo
	PInfo.Type = class'UT_GR_Info'.static.GetPawnType(Other);
	PInfo.Pawn = Other;

	if(BaseGameRules != None)
	{
		//BaseGameRules.ModifyPawnInfo(PInfo);

		P = UTPawn(Other);
		if(P != None)
		{
			//for(GR = GetBaseGameRules(); GR != None; GR = GetNextGameRules(GR))
			foreach self.GameRulesList(GR)
			{
				if(MDIB_GR_ModifyRook(GR) != None)
				{
					//FIXME: Optimize here, for every gamerules !UTHero is called excessively
					if(UTHeroPawn(P) != None)
						MDIB_GR_ModifyRook(GR).ModifyRook(UTHeroPawn(P));
					else
						MDIB_GR_ModifyPawn(GR).ModifyPawn(P);
				}
			}
		
			if(UTHeroPawn(P) != None)
			{
				if(UTHeroPawn(P).name != GameData.CurRook)
				{
					`logd("Rook: "$PathName(UTHeroPawn(P)),,'GameExp');
					GameData.CurRook = UTHeroPawn(P).name;
				}
			}
			else
			{
				if(P.name != GameData.CurPawn)
				{
					`logd("Pawn: "$PathName(P),,'GameExp');
					GameData.CurPawn = P.name;
				}
			}
		}
	}
	
	// TODO: Only modifys the vehicle once a player enters it or on spawn?
	V = UTVehicle(Other);
	if(V != None)
	{
//		ModifyKnight(V);
		if(GameData != None && V.name != GameData.CurVehicle)
		{
			`logd("Vehicle: "$PathName(V),,'GameExp');
			GameData.CurVehicle = V.name;
		}

		foreach self.GameRulesList(GR)
			if(MDIB_GR_ModifyVehicle(GR) != None)
				MDIB_GR_ModifyVehicle(GR).ModifyVehicle(V);
	}

	Super.ModifyPlayer(Other);
}

function DriverEnteredVehicle(Vehicle V, Pawn P)
{
	local UT_MDB_GameRules GR;

	foreach self.GameRulesList(GR)
	{
		if(MDIB_GR_ModifyVehicleOnEnter(GR) != None)
			MDIB_GR_ModifyVehicleOnEnter(GR).ModifyVehicleOnEnter(V);

//		if(MDIB_GR_NotifyPawnOnVehicleEnter(GR) != None)
//			MDIB_GR_NotifyPawnOnVehicleEnter(GR).NotifyPawnOnVehicleExit(P);
	}
}

function DriverLeftVehicle(Vehicle V, Pawn P)
{
	local UT_MDB_GameRules GR;

	foreach self.GameRulesList(GR)
	{
		if(MDIB_GR_ModifyVehicleOnEnter(GR) != None)
			MDIB_GR_ModifyVehicleOnEnter(GR).ModifyVehicleOnEnter(V);

		if(MDIB_GR_NotifyPawnOnVehicleExit(GR) != None)
			MDIB_GR_NotifyPawnOnVehicleExit(GR).NotifyPawnOnVehicleExit(P);
	}
}

defaultproperties
{
	Begin Object Class=UT_MDB_GameInfo Name=UT_MDB_GameInfo0
	End Object
	GameData=UT_MDB_GameInfo0
}