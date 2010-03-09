//===================================================
//	Class: UTM_VehicleTeamSwap
//	Creation date: 20/12/2008 21:03
//	Last updated: 27/03/2009 01:46
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UTM_VehicleTeamSwap extends UT_MDB_GameExp;

/*
simulated function PostBeginPlay()
{
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

	/** Checks for Warfare and if found processes Cores and Vehicle Factories */
	WarGame = UTOnslaughtGame_Content(WorldInfo.Game);
	if(WarGame == None)
	{
		`logd("Skipping Core checks, Gametype is not Warfare!",,'VehicleTeamSwap');
//		Destroy();
	}
	else
	{
*/

defaultproperties
{
/*	Begin Object Class=UT_MDB_VehicleTeamSwap Name=UT_MDB_VehicleTeamSwap
		TeamCore[0].bTeamIsNecris=false
		TeamCore[1].bTeamIsNecris=false
	End Object
	UTGameData=UT_MDB_VehicleTeamSwap
	cUTGameDex=class'UT_MDB_VehicleTeamSwap'*/
}