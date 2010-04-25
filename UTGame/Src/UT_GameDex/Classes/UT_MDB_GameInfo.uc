//===================================================
//	Class: UT_MDB_GameInfo
//	Creation date: 11/04/2010 20:26
//	Last updated: 24/04/2010 01:41
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GameInfo extends UT_MDB;

var WorldInfo	CurWorldInfo;
var UTGame		CurGameType;
var string		CurMap;

//WorldInfo.Game.bTeamGame

//GameType - Pawn Subclasses
var name		CurController;
var name		CurPawn;
var name		CurVehicle;
var name		CurRook;

//GameRules - ObjectList
var array<UT_MDB_GameRules>	GRList;
var array<name>					GRNameList;

//Major Classtypes
var() class<Gameinfo>					GClass;
var() class<PlayerController>			PCClass;	/// Controller for this Mutator.
var() class<UTPawn>						PClass;		/// Pawn for this Mutator.
var() class<HUD>						HUDClass;	/// HUD for this Mutator.
var() class<UTCheatManager>			CMClass;

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
struct logName
{
	var name			LogSet;
	var array<name>		logNames;
};
var array<logName>		logNamesArray;

struct logObject
{
	var name			LogSet;
	var array<object>	logObjects;
};
var array<logObject>	logObjectsArray;

struct logActor
{
	var name			LogSet;
	var array<Actor>	logActor;
	var class<actor>	logLimitor;
};
var array<logActor>	logActorsArray;
//---------------------------------------------------

function Init()
{
//	Master = UT_MDB_GameExp;

	CurGameType.bAllowTranslocator = default.bAllowTranslocator;

	if(PClass != None)
		CurGameType.DefaultPawnClass = PClass;
	if(PCClass != None)
		CurGameType.PlayerControllerClass = PCClass;
	if(HUDClass != None)
		CurGameType.HUDType = HUDClass;

	`logd("Pawn.Class: "$CurGameType.DefaultPawnClass,,'GameInfo');
	`logd("Controller.Class: "$CurGameType.PlayerControllerClass,,'GameInfo');
	`logd("HUD.Class: "$CurGameType.HUDType,,'GameInfo');	
}

//Called from CheckReplacement specifically for actors which need notifications but not replacement.
//simulated function NotifyAllActors(Actor Other)
simulated function NotifyAllControllers(Controller Other)
{
	local UTPlayerController UTPlayer;

	//NOTE: WorldInfo Foreach AllControllers
	UTPlayer = UTPlayerController(other);
	if(UTPlayer != None && CMClass != None)
		UTPlayer.CheatClass = default.CMClass;
}

/* SetPlayerDefaults()
 first make sure pawn properties are back to default, then give mutators an opportunity to modify them */
/*function SetPlayerDefaults(Pawn PlayerPawn)
{
	PlayerPawn.AirControl = PlayerPawn.Default.AirControl;
	PlayerPawn.GroundSpeed = PlayerPawn.Default.GroundSpeed;
	PlayerPawn.WaterSpeed = PlayerPawn.Default.WaterSpeed;
	PlayerPawn.AirSpeed = PlayerPawn.Default.AirSpeed;
	PlayerPawn.Acceleration = PlayerPawn.Default.Acceleration;
	PlayerPawn.AccelRate = PlayerPawn.Default.AccelRate;
	PlayerPawn.JumpZ = PlayerPawn.Default.JumpZ;
	if ( BaseMutator != None )
		BaseMutator.ModifyPlayer(PlayerPawn);
	PlayerPawn.PhysicsVolume.ModifyPlayer(PlayerPawn);
}*/

////
//Logging
function DumpGameRuleList()
{
	local UT_MDB_GameRules GR;
	local int i;
	
	foreach GRList(GR, i)
		`logd("GameRulesList("$i$"): "$GR,,'GameInfo');
}


defaultproperties
{
	PClass=None
	PCClass=None
	HUDClass=None
	CMClass=None
}