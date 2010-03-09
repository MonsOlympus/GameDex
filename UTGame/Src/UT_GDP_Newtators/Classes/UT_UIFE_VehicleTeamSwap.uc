//===================================================
//	Class: UTUI_FE_VehicleTeamSwap
//	Creation Date: 04/12/2007 22:21
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 2.5 Generic
//	http://creativecommons.org/licenses/by-nc-sa/2.5/
//===================================================
class UT_UIFE_VehicleTeamSwap extends UT_UIFE_Generic;

`include(MOD.uci)

/*var transient UTUICollectionCheckBox bBlueIsNecris;
var transient UTUICollectionCheckBox bRedIsNecris;

event SceneActivated(bool bInitialActivation)
{
	Super.SceneActivated(bInitialActivation);

	if(bInitialActivation)
	{
		bRedIsNecris = UTUICollectionCheckBox(FindChild('cbxTeam2', true));
		bBlueIsNecris = UTUICollectionCheckBox(FindChild('cbxTeam1', true));

		bRedIsNecris.SetValue(class'`pak1.UTM_VehicleTeamSwap'.UT_MDB_VehicleTeamSwap.default.TeamCore[0].bTeamIsNecris);
		bBlueIsNecris.SetValue(class'`pak1.UTM_VehicleTeamSwap'.UT_MDB_VehicleTeamSwap.default.TeamCore[1].bTeamIsNecris);
	}
}*/

/** Callback for when the user accepts the changes. */
/*function OnAccept()
{
	class'`pak1.UTM_VehicleTeamSwap '.UT_MDB_VehicleTeamSwap.default.TeamCore[0].bTeamIsNecris = bRedIsNecris.IsChecked();
	class'`pak1.UTM_VehicleTeamSwap '.UT_MDB_VehicleTeamSwap.default.TeamCore[1].bTeamIsNecris = bBlueIsNecris.IsChecked();
	class'`pak1.UTM_VehicleTeamSwap '.static.StaticSaveConfig();

	CloseScene(self);
}*/

defaultproperties
{
	MutTitle="Vehicle Team Swap"
}