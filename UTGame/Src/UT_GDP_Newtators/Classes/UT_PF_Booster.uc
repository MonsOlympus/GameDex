//===================================================
//	Class: UT_PF_Booster
//	Creation date: 19/05/2008 00:42
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_PF_Booster extends UTPickupFactory_Berserk;

/*Assertion failed: Token.MetaClass [File:.\Src\UnScrCom.cpp] [Line: 4397]

Stack:

RaiseException() Address = 0x7c812aeb (filename not found)
CxxThrowException() Address = 0x78158e89 (filename not found)
Address = 0xbb4c52   (filename not found)
Address = 0xe8781b4c (filename not found) */

`include(MOD.uci)

defaultproperties
{
	PickupStatName="PICKUPS_BOOSTER"
	InventoryType=Class'`pak1.UT_TPG_Booster'
	Begin Object /*Class=UTParticleSystemComponent*/ Name=BerserkParticles ObjName=BerserkParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
		Template=ParticleSystem'Newtators_Pickups.Booster.Effects.P_Pickups_Booster_Idle'
		bAutoActivate=False
		Translation=(X=0.000000,Y=0.000000,Z=5.000000)
	End Object
	bHasLocationSpeech=False	//True
	BaseBrightEmissive=(R=0.000000,G=20.000000,B=1.000000,A=1.000000)
	BaseDimEmissive=(R=0.000000,G=1.000000,B=0.100000,A=1.000000)

	bStatic=False		//True
	bNoDelete=False		//True
}