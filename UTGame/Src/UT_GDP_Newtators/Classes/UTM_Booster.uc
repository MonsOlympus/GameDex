class UTM_Booster extends UT_MDB_GameExp;

//`include(MOD.uci)

defaultproperties
{
//	GroupNames(0)="POWERUPS"

	Begin Object Class=UT_MDB_FactoryReplacer Name=UT_MDB_Bloodlust_FR_0
		FactoriesSet(0)=(FactoryGroup="FT_Powerup",ReplacedFactory="UTPickupFactory_Berserk", ReplacedWithFactory="UT_PF_Booster", ReplacedWithFactoryPath="UT_GDP_Newtators.UT_PF_Booster")
	End Object
	FD=UT_MDB_Bloodlust_FR_0

	Begin Object Class=UT_MDB_ItemReplacer Name=UT_MDB_Booster_IR_0
		ReplacerSet(0)=(ReplaceItem="UTBerserk",WithItem=class'UT_GDP_Newtators.UT_TPG_Booster')
	End Object
	IR=UT_MDB_Booster_IR_0
}