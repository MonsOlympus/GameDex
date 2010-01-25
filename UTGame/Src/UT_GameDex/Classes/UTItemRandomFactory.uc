//===================================================
//	Class: UTItemRandomFactory
//	Creation date: 06/12/2007 10:00
//	Last Updated: 06/12/2007 10:00
//	Contributors: 00zX
//---------------------------------------------------
//===================================================
class UTItemRandomFactory extends UTWeaponPickupFactory;

/** The glow that emits from the base while the weapon is available */
//var ParticleSystemComponent BaseGlow;

defaultproperties
{
//	bWeaponStay=True
//	YawRotationRate=24000.000000
	MaxDesireability=0.700000
	bNoDelete=false
	bStatic=false
//	InventoryType=Class'Mutatoes.UTRandomWeapon'
	WeaponPickupClass=Class'UT_GameDex.UTrWeapon'
	WeaponPickupScaling=1.600000		//1.200000
}