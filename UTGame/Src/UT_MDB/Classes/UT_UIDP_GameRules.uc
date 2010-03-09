//===================================================
//	Class: UT_UIDP_GameRules
//	Creation Date: 06/03/2010 16:13
//	Last Updated: 06/03/2010 16:13
//	Contributors: 00zX
//---------------------------------------------------
//	Provides data for a UT3 vehicle.
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_UIDP_GameRules extends UTUIResourceDataProvider
	PerObjectConfig;

/** The Modules class path */
var config string ClassName;

/** optional flags separated by pipes | that can be parsed by the UI as arbitrary options (for example, to exclude weapons from some menus, etc) */
var config string Flags;

/** Friendly name for the Module */
var config localized string FriendlyName;

/** Description for the Module */
var config localized string Description;

/** Is this Module configurable*/
var config bool bHasOptions;

defaultproperties
{
	bSearchAllInis=True//TODO: Remove?
}