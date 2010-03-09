//===================================================
//	Class: UT_UIFE_VampireMenu
//	Creation Date: 30/11/2007 22:21
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 2.5 Generic
//	http://creativecommons.org/licenses/by-nc-sa/2.5/
//===================================================
class UT_UIFE_VampireMenu extends UT_UIFE_Generic;

`include(MOD.uci)

var transient UTUICollectionCheckBox bSuperHealth, bVehicleVamp;

event SceneActivated(bool bInitialActivation)
{
	Super.SceneActivated(bInitialActivation);

	if (bInitialActivation)
	{
		bSuperHealth = UTUICollectionCheckBox(FindChild('cbxHealth', true));
		bSuperHealth.SetValue(class'`pak1.UT_MDB_GR_Vampire'.default.bUseSuperHealth);
		bVehicleVamp = UTUICollectionCheckBox(FindChild('cbxVehicles', true));
		bVehicleVamp.SetValue(class'`pak1.UT_MDB_GR_Vampire'.default.bUseForVehicles);
	}
}

/** Callback for when the user accepts the changes. */
function OnAccept()
{
	class'`pak1.UT_MDB_GR_Vampire'.default.bUseSuperHealth = bSuperHealth.IsChecked();
	class'`pak1.UT_MDB_GR_Vampire'.default.bUseForVehicles = bVehicleVamp.IsChecked();
	class'`pak1.UT_MDB_GR_Vampire'.static.StaticSaveConfig();

	CloseScene(self);
}

defaultproperties
{
	MutTitle="Vampire"
}