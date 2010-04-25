//===================================================
//	Class: MDIB_GameRules
//	Creation Date: 20/04/2010 10:49
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GameRules extends MDIB;

function GetServerDetails(out GameInfo.ServerResponseLine ServerState);

function Init();