//===================================================
//	Class: UT_UIDS_MutatorModuleMenuItems
//	Creation Date: 06/03/2010 16:13
//	Last Updated: 06/03/2010 16:13
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_UIDS_MutatorModuleMenuItems extends UTUIDataStore_MenuItems;

/** Array of enabled modules, the available modules list will not contain any of these modules. */
var array<int> EnabledModules;

defaultproperties
{
	Tag="Modules"
//	Name="Default__UTUIDataStore_NewMenuItems"
//	ObjectArchetype=UIDataStore_GameResource'UTGame.Default__UTUIDataStore_MenuItems'
}