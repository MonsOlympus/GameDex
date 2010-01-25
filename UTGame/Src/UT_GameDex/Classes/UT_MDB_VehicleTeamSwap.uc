//===================================================
//	Class: UT_MDB_VehicleTeamSwap
//	Creation date: 20/12/2008 21:03
//	Last updated: 04/04/2009 09:01
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_VehicleTeamSwap extends UT_MDB_FactoryReplacer
	Config(GameDex);

`include(MOD.uci)

const numTeams = 2;							//0 = red, 1 = blue
struct PowerCoreSet
{
	var bool bTeamIsNecris;
	var bool bTeamWasNecris;
	var bool bTeamVehiclesChanged;
};
var config PowerCoreSet TeamCore[numTeams];

//TODO: SET/ARRAY MIRROR!

//TODO: Change these to linked list?
const numFactories = 8;
var class<UTVehicleFactory> AxonFactories[numFactories];
var class<UTVehicleFactory> NecrisFactories[numFactories];
var class<UTVehicleFactory> SwapAxonFactories[numFactories];
var class<UTVehicleFactory> SwapNecrisFactories[numFactories];

//TODO: Tidy this up some :) perhaps move to super or subclass of object for callback static
//These factories could be stored in the vehicle class for custom vehicle support
//use linked list here also so numFactories isnt limited (ForEach.next, While.Next!=None)
/*struct VehicleSet{
	var class<UTVehicleFactory> Factories[numFactories];
	var class<UTVehicleFactory> SwapFactories[numFactories];
};var VehicleSet VehicleTeamSwapSet[numTeams];*/

const CheckRadius = 196;			//64,128
//---------------------------------------------------
//TODO: Change this to a BYTE array!
//struct PerMapCoreSetup{
//	var bool bTeamIsNecris;
//};

//TODO: Add bool for swapping nightshade and darkwalker
struct MapTeamSwapSettings
{
	var string Map;
	var PowerCoreSet PerMapTeamCore[numTeams];
};
var config array<MapTeamSwapSettings> PerMapTeamSwapSet;

//---------------------------------------------------
//Map Exceptions for which factory will spawn for the opposing one.
//For eg, Raptor gets replaced with Fury by default.
/*struct MapExceptionAxonVehicleSet{
	var class<UTVehicleFactory> MapAxonFactories;
	var class<UTVehicleFactory> MapSwapAxonFactories;
}

struct MapExceptionNecrisVehicleSet{
	var class<UTVehicleFactory> MapNecrisFactories;
	var class<UTVehicleFactory> MapSwapNecrisFactories;
}*/

/*struct MapExceptionVehicleSet{
	var array< class<UTVehicleFactory> > Factories;
	var array< class<UTVehicleFactory> > SwapFactories;
};*/

/*struct MapExceptionSwapSet{
	var string Map;
	var MapExceptionAxonVehicleSet MapExctSwapAxon[numFactories];
	var MapExceptionNecrisVehicleSet MapExctSwapNecris[numFactories];
};*/

/*struct MapExceptionSwapSet{
	var string Map;
	var MapExceptionVehicleSet MapExctSwapSet[numTeams];
};var config array<MapExceptionSwapSet> PerMapSwapSet;*/
//---------------------------------------------------

/*function AddDummyMapEntry(string CurrentMap)
{
	PerMapFactorySet.Map = CurrentMap;
	PerMapFactorySet.AddItem(NewPerMapFactorySet);
}

function AddPerMapEntry(int iMap, PickupFactory Factory)
{

}

function UpdatePerMapEntry(int iMap, PickupFactory Factory)
{

}*/



/*simulated function PostBeginPlay(){
	local UTOnslaughtGame_Content WarGame;
	local UTOnslaughtPowerCore WarCore[numTeams];
	local UTOnslaughtPowerCore TempWarCore;
	local UTVehicleFactory WarFactory;
	local byte i, k;//, m;
	local int j;

	local bool bInPerMapList;
	local MapTeamSwapSettings NewMapSwapSettings;

//	local MapExceptionSwapSet NewPerMapSwapSet;
//	local MapExceptionVehicleSet NewMapExctSwapSet[numTeams];
//	local int Index, MapIndex;
	//, VehicleIndex;


	Super.PostBeginPlay();

	/// Checks for Warfare and if found processes Cores and Vehicle Factories
	WarGame = UTOnslaughtGame_Content(WorldInfo.Game);
	if(WarGame == None){
		`logd("Skipping Core checks, Gametype is not Warfare!",,'VehicleTeamSwap');
//		Destroy();
	}else{
		if(bUsePerMapSettings){
			`logd("Using Per Map Settings!",,'VehicleTeamSwap');

			for(j=0; j < PerMapSettings.length; j++){
				if(PerMapSettings[j].Map ~= CurrentMap){
					for(k=0; k < numTeams; k++){
						TeamCore[k].bTeamIsNecris = PerMapSettings[j].PerMapTeamCore[k].bTeamIsNecris;
						`logd("Per Map Settings: Team"$k$" is Necris: "$TeamCore[k].bTeamIsNecris,,'VehicleTeamSwap');
					}
					bInPerMapList = True;
				}
				else if(CurrentMap != PerMapSettings[j].Map){
					bInPerMapList = False;
				}
			}

			//Map is not found on the list, create a new entry in the ini using the defauls
			if(!bInPerMapList){
				NewMapSwapSettings.Map = CurrentMap;
				for(k=0; k < numTeams; k++)
					NewMapSwapSettings.PerMapTeamCore[k].bTeamIsNecris = TeamCore[k].bTeamIsNecris;

				PerMapSettings.AddItem(NewMapSwapSettings);
				SaveConfig();
			}
		}

		//Map Exceptions from config to handle spawning/balance issues with vehicles on some maps!
*//*		MapIndex = PerMapSwapSet.Find('Map', CurrentMap);
		if(MapIndex != INDEX_NONE)
		{
			for(j=0;j < numTeams;j++)
			{
				for(k=0;k < PerMapSwapSet[MapIndex].MapExctSwapSet[j].Factories.length;k++)
				{
					NewMapExctSwapSet[j].Factories[k] = PerMapSwapSet[MapIndex].MapExctSwapSet[j].Factories[k];
					NewMapExctSwapSet[j].SwapFactories[k] = PerMapSwapSet[MapIndex].MapExctSwapSet[j].SwapFactories[k];
					`logd("New Map Exception Swap Set: Factory: "$NewMapExctSwapSet[j].Factories[k]$" to be replaced with "$NewMapExctSwapSet[j].SwapFactories[k],,'VehicleTeamSwap');

					for(m=0;m < numFactories;m++)
					{
						if(NewMapExctSwapSet[0].Factories[k] == AxonFactories[m]){
							SwapAxonFactories[m] = NewMapExctSwapSet[0].SwapFactories[k];
							`logd("Set Map Exception: "$SwapAxonFactories[m],,'VehicleTeamSwap');
						}

						if(NewMapExctSwapSet[1].Factories[k] == NecrisFactories[m]){
							SwapNecrisFactories[m] = NewMapExctSwapSet[1].SwapFactories[k];
							`logd("Set Map Exception: "$SwapNecrisFactories[m],,'VehicleTeamSwap');
						}
					}
				}
			}
		}*//*

		//Exception for Downtown to Fix Darkwalker Spawn problem.
		if(CurrentMap ~= "WAR-DOWNTOWN"){
			SwapNecrisFactories[5] = class'Newtators.TSVehicleFactory_Nightshade';
			SwapNecrisFactories[7] = class'Newtators.TSVehicleFactory_DarkWalker';
		}

		//Assuming first one found is red, bad right? :P
		//bSidesAreSwitched
		foreach AllActors(Class'UTOnslaughtPowerCore', TempWarCore){
			WarCore[i] = TempWarCore;
			i++;
		}

		//Checks the Cores to make sure replacement needs to be run!
		for(i=0; i < numTeams; i++){
//			WarCore[i] = UTOnslaughtGRI(WarGame.GameReplicationInfo).GetTeamCore(i);
			`logd("Check Power Core : "$WarCore[i].Name$" Necris Core = "$WarCore[i].bNecrisCore$"; No Core Switch = "$WarCore[i].bNoCoreSwitch,,'VehicleTeamSwap');

			TeamCore[i].bTeamWasNecris = WarCore[i].bNecrisCore;

			if((TeamCore[i].bTeamWasNecris == True && TeamCore[i].bTeamIsNecris == False) ||
				(TeamCore[i].bTeamWasNecris == False && TeamCore[i].bTeamIsNecris == True))
			{
				//If is Necris initially but does not equal TeamIsNecris (Team was Necris, Team is Axon)
				//If is Axon initially but does not equal TeamIsNecris (Team was Axon, Team is Necris)
				TeamCore[i].bTeamVehiclesChanged = true;
			}
			else if(TeamCore[i].bTeamWasNecris == TeamCore[i].bTeamIsNecris){
				//Is a Necris or Axon Core being switched to the same type!
				TeamCore[i].bTeamVehiclesChanged = false;
			}
		}

		//No need to swap vehicles if vehicle teams havent changed!
		if(!TeamCore[0].bTeamVehiclesChanged && !TeamCore[1].bTeamVehiclesChanged){
			`logd("No need for vehicle swap!",,'VehicleTeamSwap');
			return;
		}

		foreach DynamicActors(Class'UTVehicleFactory', WarFactory)
			if(WarFactory != None && WarFactory != UTVehicleFactory_TrackTurretBase(WarFactory))
				SetWarFactories(WarFactory);

		//Sets cores to new faction type!
		for(i=0; i < numTeams; i++){
			if(TeamCore[i].bTeamVehiclesChanged)
				WarCore[i].bNecrisCore = TeamCore[i].bTeamIsNecris;

			`logd("Set Power Core : "$WarCore[i].Name$" Necris Core = "$WarCore[i].bNecrisCore$"; No Core Switch = "$WarCore[i].bNoCoreSwitch,,'VehicleTeamSwap');
		}
	}
}*/

defaultproperties
{
	bUsePerMapFactorySet=false
}