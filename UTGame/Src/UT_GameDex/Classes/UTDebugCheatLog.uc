//===================================================
//	Class: UTDebugCheatLog
//	Creation date: 10/06/2008 05:19
//	Last updated: 10/06/2008 05:19
//	Contributors: OlympusMons(/d!b\)
//---------------------------------------------------
//===================================================
class UTDebugCheatLog extends UTCheatManager within UTPlayerController;

exec function BecomeSpectator()
{
	UTGame(WorldInfo.Game).BecomeSpectator(UTPlayerController(Pawn.Controller));
}