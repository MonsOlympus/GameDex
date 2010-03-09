//===================================================
//	Class: UT_UIFE_EnergyLeechMenu
//	Creation Date: 30/11/2007 22:21
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 2.5 Generic
//	http://creativecommons.org/licenses/by-nc-sa/2.5/
//===================================================
class UT_UIFE_EnergyLeechMenu extends UT_UIFE_Generic;

`include(MOD.uci)

var transient UTUICollectionCheckBox bShieldBelt;
var transient UTUICollectionCheckBox bVestArmour;
var transient UTUICollectionCheckBox bThighpadArmor;
var transient UTUICollectionCheckBox bHelmetArmor;
var transient UTUICollectionCheckBox bVehicleLeech;

event SceneActivated(bool bInitialActivation)
{
	Super.SceneActivated(bInitialActivation);

	if (bInitialActivation)
	{
		bShieldBelt = UTUICollectionCheckBox(FindChild('cbxShieldBelt', true));
		bVestArmour = UTUICollectionCheckBox(FindChild('cbxVestArmour', true));
		bThighpadArmor = UTUICollectionCheckBox(FindChild('cbxThighpadArmor', true));
		bHelmetArmor = UTUICollectionCheckBox(FindChild('cbxHelmetArmor', true));
		bVehicleLeech = UTUICollectionCheckBox(FindChild('cbxVehicles', true));
		bShieldBelt.SetValue(class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseShieldBelt);
		bVestArmour.SetValue(class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseVestArmour);
		bThighpadArmor.SetValue(class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseThighpadArmor);
		bHelmetArmor.SetValue(class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseHelmetArmor);
		bVehicleLeech.SetValue(class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseForVehicles);
	}
}

/** Callback for when the user accepts the changes. */
function OnAccept()
{
	class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseShieldBelt = bShieldBelt.IsChecked();
	class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseVestArmour = bVestArmour.IsChecked();
	class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseThighpadArmor = bThighpadArmor.IsChecked();
	class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseHelmetArmor = bHelmetArmor.IsChecked();
	class'`pak1.UT_MDB_GR_EnergyLeech'.default.bUseForVehicles = bVehicleLeech.IsChecked();
	class'`pak1.UT_MDB_GR_EnergyLeech'.static.StaticSaveConfig();

	CloseScene(self);
}

defaultproperties
{
	MutTitle="Energy Leech"
}