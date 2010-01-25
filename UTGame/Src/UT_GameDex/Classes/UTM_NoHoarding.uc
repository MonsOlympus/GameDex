//===================================================
//	Class: UTM_NoHoarding
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UTM_NoHoarding extends UT_MDB_GameExp
	config(Newtators);

`include(MOD.uci)

var config bool bHoardWeaponStay;

function InitMutator(string Options, out string ErrorMessage)
{
//	local UTGameRules_Hoarding HoardRules;

	UTGame(WorldInfo.Game).bWeaponStay = !bHoardWeaponStay;
	`logd("WeaponStay: "$UTGame(WorldInfo.Game).bWeaponStay);

	super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
	bHoardWeaponStay=False
//	GRClass=Class'Newtators.UTGameRules_Hoarding'
//	UTGameDataClass=Class'UT_GDP_Newtators.UTGameRules_Hoarding'

/*	Begin Object Class=UT_MDB_GameDex Name=UT_MDB_GameDex_0
		Begin Object Class=UT_MDB_FactoryReplacer Name=UT_MDB_SpeedBoots_0
			FactoriesSet.Add((FactoryGroup=FT_Powerup,ReplacedFactory="UTPickupFactory_JumpBoots", ReplacedWithFactory="UTPickupFactory_SpeedBoots", ReplacedWithFactoryPath="`Pak1.UTPickupFactory_SpeedBoots"))
//			FactoriesSet(0)=(FactoryGroup='FT_Powerup',ReplacedFactory="UTPickupFactory_JumpBoots", ReplacedWithFactory="UTPickupFactory_SpeedBoots", ReplacedWithFactoryPath="`Pak1.UTPickupFactory_SpeedBoots")
		End Object
		//FD=UT_MDB_SpeedBoots_0

		Begin Object Class=UT_MDB_GR_Hoarding Name=UT_MDB_GR_Hoarding_0
			bCanHoardArmour=False
			bCanHoardHealth=False
			bCanHoardPowerups=False
			bCanHoardAmmo=False
		End Object
	End Object
	UTGameDex=UT_MDB_GameDex_0*/
}