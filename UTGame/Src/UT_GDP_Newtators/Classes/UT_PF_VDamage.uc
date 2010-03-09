//===================================================
//	Class: UT_PF_VDamage
//	Creation date: 19/12/2007 08:47
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_PF_VDamage extends UTPickupFactory_UDamage;

`include(MOD.uci)

defaultproperties
{
	PickupStatName="PICKUPS_VDAMAGE"
	InventoryType=Class'`pak1.UT_TPG_VDamage'
	Begin Object /*Class=UTParticleSystemComponent*/ Name=DamageParticles ObjName=DamageParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
		Template=ParticleSystem'Newtators_Pickups.VDamage.Effects.P_Pickups_VDamage_Idle'
		bAutoActivate=False
		Translation=(X=0.000000,Y=0.000000,Z=5.000000)
//		Name="DamageParticles"
//		ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
	End Object
	bHasLocationSpeech=False	//True
	BaseBrightEmissive=(R=50.000000,G=1.000000,B=0.000000,A=1.000000)
	BaseDimEmissive=(R=5.000000,G=0.100000,B=0.000000,A=1.000000)

	bStatic=False		//True
	bNoDelete=False		//True
}