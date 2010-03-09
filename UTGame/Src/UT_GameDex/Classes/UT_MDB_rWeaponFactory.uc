//===================================================
//	Class: UTData_rWeaponFactory
//	Creation date: 22/08/2008 06:25
//	Contributors: 00zX
//---------------------------------------------------
class UT_MDB_rWeaponFactory extends UT_MDB_FactoryReplacer;

defaultproperties
{
	//Find PAckage for:  ReplacedWithFactoryPath="Mutatoes.UTItemRandomFactory"
	ReplacementFactories(0)=(FactoryGroup='FT_Weapon',ReplacedFactory="UTWeaponPickupFactory", ReplacedWithFactory="UTItemRandomFactory", ReplacedWithFactoryPath="UT_GameDex.UTItemRandomFactory")
}