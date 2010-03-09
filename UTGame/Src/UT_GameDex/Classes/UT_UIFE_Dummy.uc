//===================================================
//	Class: UT_UIFE_Dummy
//	Creation Date: 06/03/2010 22:33
//	Last Updated: 06/03/2010 22:33
//	Contributors: 00zX
//---------------------------------------------------
//	New GameRules objects are initialized in here,
//	then passed to UT_MDB_GameExp as a master.
//	(owner object)
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_UIFE_Dummy extends UT_UIFE_Generic;



//---------------------------------------------------
//WIDGETS
var transient UIList	AvailableList;		// List of available mutators.
var transient UIList	EnabledList;		// List of enabled mutators.
var transient UIList	LastFocusedList;	// The last list that was focused.

//---------------------------------------------------
//DATA
/* Mirrored in UT_MDB_GameExp */
//var UT_MDB_ObjectList	AvailableGameRulesList;	//TODO:	This needs a widget?
var UT_MDB_ObjectList	GameRulesList;		//		Hooks to provider for icon/name/desc automatic!

/** Reference to the menu item datastore. */
var transient UTUIDataStore_MenuItems MenuDataStore;

/** List of possible weapon classes. */
var transient array<string>	ModuleClassNames;
var transient array<string>	ModuleFriendlyNames;
var transient array<UTUIDataProvider_Weapon> WeaponProviders;

/** Mutators that were enabled when we entered the scene. */
var transient array<int>	OldEnabledMutators;

//---------------------------------------------------

event SceneActivated(bool bInitialActivation)
{
	Super.SceneActivated(bInitialActivation);

	if(bInitialActivation)
	{
		if(GameRulesList == None)
		{
			GameRulesList = new(self)class'UT_MDB_ObjectList';

			//TODO: Link to owner mutator for this UIScene
			//GameRulesList.owner = self;

			//TODO: Pass GameRulesList to mutator

			`logd("ObjList: GameRules: "$PathName(GameRulesList)$" Initialized!",,'FrontEnd');
		}
	}

}

event PostInitialize()
{
	local string ModStr;
	local array<UTUIResourceDataProvider> ModProviders;
	local int i, j;
	local array<string> ModList, SavedModList;

	Super.PostInitialize();

	// Get reference to the menu and settings datastore
	MenuDataStore = UTUIDataStore_MenuItems(GetCurrentUIController().DataStoreManager.FindDataStore('Modules'));

	if(MenuDataStore.GetProviderSet('GameRules', ModProviders))
	{
		// First build up the class lists
		ModList.Length = ModProviders.Length;

		for(i = 0; i < ModProviders.Length; ++i)
			ModList[i] = UT_UIDP_GameRules(ModProviders[i]).ClassName;

		ParseStringIntoArray(ModStr, SavedModList, ",", False);

		// Now compare the class lists in order to build up the index list
		if(UT_UIDS_MutatorModuleMenuItems(MenuDataStore) != None)
		{
			UT_UIDS_MutatorModuleMenuItems(MenuDataStore).EnabledModules.Length = 0;

			for(i = 0; i < SavedModList.Length; ++i)
			{
				j = ModList.Find(SavedModList[i]);
				if(j != INDEX_None)
					UT_UIDS_MutatorModuleMenuItems(MenuDataStore).EnabledModules.AddItem(j);
			}
		}
	}
}

/** @return Returns the current list of enabled mutators, separated by commas. */
//static function string GetEnabledModules();
static function string GetEnabledModules()
{
	local string MutatorString, SavedMutStr;
	local string ClassName;
	local int MutatorIdx;
	local UTUIDataStore_MenuItems LocalMenuDataStore;
//	local UIDataStore_OnlineGameSettings OnlineDataStore;
//	local Settings GameSettings;

	// Add mutators from the menu data store
	LocalMenuDataStore = UTUIDataStore_MenuItems(GetCurrentUIController().DataStoreManager.FindDataStore('UTMenuItems'));

	for(MutatorIdx=0; MutatorIdx < LocalMenuDataStore.EnabledMutators.length; MutatorIdx++)
	{
		if(LocalMenuDataStore.GetValueFromProviderSet('EnabledMutators', 'ClassName', LocalMenuDataStore.EnabledMutators[MutatorIdx], ClassName))
		{
			if(MutatorIdx > 0)
			{
				MutatorString $= ",";
			}

			MutatorString $= ClassName;
		}
	}

	return MutatorString;
}