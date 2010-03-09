//===================================================
//	Class: UT_UIFE_HoardingMenu
//	Creation Date: 01/02/2008 02:14
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 2.5 Generic
//	http://creativecommons.org/licenses/by-nc-sa/2.5/
//===================================================
class UT_UIFE_HoardingMenu extends UT_UIFE_Generic;

`include(MOD.uci)

var transient UTUICollectionCheckBox bHoardArmour;
var transient UTUICollectionCheckBox bHoardHealth;
var transient UTUICollectionCheckBox bHoardPowerups;
var transient UTUICollectionCheckBox bHoardAmmo;
var transient UTUICollectionCheckBox bHoardWeapons;

event SceneActivated(bool bInitialActivation)
{
	Super.SceneActivated(bInitialActivation);

	if (bInitialActivation)
	{
		bHoardArmour = UTUICollectionCheckBox(FindChild('cbxHoardArmour', true));
		bHoardHealth = UTUICollectionCheckBox(FindChild('cbxHoardHealth', true));
		bHoardPowerups = UTUICollectionCheckBox(FindChild('cbxHoardPowerups', true));
		bHoardAmmo = UTUICollectionCheckBox(FindChild('cbxHoardAmmo', true));
		bHoardWeapons = UTUICollectionCheckBox(FindChild('cbxHoardWeapons', true));

		bHoardArmour.SetValue(class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardArmour);
		bHoardHealth.SetValue(class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardHealth);
		bHoardPowerups.SetValue(class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardPowerups);
		bHoardAmmo.SetValue(class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardAmmo);
		bHoardWeapons.SetValue(class'`GD.UTM_NoHoarding'.default.bHoardWeaponStay);
	}
}

/** Callback for when the user accepts the changes. */
function OnAccept()
{
	class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardArmour = bHoardArmour.IsChecked();
	class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardHealth = bHoardHealth.IsChecked();
	class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardPowerups = bHoardPowerups.IsChecked();
	class'`GD.UT_MDB_GR_Hoarding'.default.bCanHoardAmmo = bHoardAmmo.IsChecked();
	class'`GD.UTM_NoHoarding'.default.bHoardWeaponStay = bHoardWeapons.IsChecked();
	class'`GD.UT_MDB_GR_Hoarding'.static.StaticSaveConfig();

	CloseScene(self);
}

defaultproperties
{
	MutTitle="Hoarding"
}