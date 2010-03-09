class UTM_Bloodlust extends UT_MDB_GameExp;

//`include(MOD.uci)

defaultproperties
{
	GroupNames(0)="VAMPIRE"

	Begin Object Class=UT_MDB_GR_Bloodlust Name=UT_MDB_GR_Bloodlust0
		bUseSuperHealth=True
		bUseForVehicles=False
		bUseForKnights=False
		bUseForRooks=False
	End Object
	GR=UT_MDB_GR_Bloodlust0

	Begin Object Class=UT_MDB_FactoryReplacer Name=UT_MDB_Bloodlust_FR_0
		FactoriesSet(0)=(FactoryGroup="FT_Powerup",ReplacedFactory="UTPickupFactory_UDamage", ReplacedWithFactory="UT_PF_VDamage", ReplacedWithFactoryPath="UT_GDP_Newtators.UT_PF_VDamage")
	End Object
	FD=UT_MDB_Bloodlust_FR_0

	Begin Object Class=UT_MDB_ItemReplacer Name=UT_MDB_Bloodlust_IR_0
		ReplacerSet(0)=(ReplaceItem="UTUDamage",WithItem=class'UT_GDP_Newtators.UT_TPG_VDamage')
	End Object
	IR=UT_MDB_Bloodlust_IR_0
}