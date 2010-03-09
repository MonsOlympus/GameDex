class UTM_SpeedBoots extends UT_MDB_GameExp;

`include(MOD.uci)

defaultproperties
{
	GroupNames(0)="JUMPBOOTS"	//"POWERUPS"

	Begin Object Class=UT_MDB_FactoryReplacer Name=UT_MDB_SpeedBoots0
		FactoriesSet(0)=(FactoryGroup="FT_Powerup",ReplacedFactory="UTPickupFactory_JumpBoots", ReplacedWithFactory="UT_PF_SpeedBoots", ReplacedWithFactoryPath="UT_GDP_Newtators.UT_PF_SpeedBoots")
	End Object
	FD=UT_MDB_SpeedBoots0
}