//===================================================
//	Class: UT_MDB_GR_DmgConversion
//	Creation date: 20/08/2009 14:46
//	Last Updated: 06/03/2010 19:15
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//-Vampire/EnergyLeech, give conversion ratio +/-25%
//
//-Reward Delays
//-TODO: Vampire/EnergyLeech, Falloff based on distance/view of target
//===================================================
class UT_MDB_GR_DmgConversion extends UT_MDB_GameRules
	config(Newtators);

`include(MOD.uci)

var globalconfig bool	bUseSuperHealth;
var globalconfig bool	bUseForVehicles;	//Infantry Vs Vehicle || Vehicle Vs Vehicle Damage!
var globalconfig bool	bUseForKnights;
var globalconfig bool	bUseForRooks;		//Castles cant have vampire :S

/** Conversion of damage to armour, varies depending on armour type.
	Armour is based on the amount of damage it blocks. */

/** Conversion of damage to health, varies depending on armour.
	Armour is based on the amount of damage it blocks. */
var float				ConversionRatio;

/**	The delay between taking the damage and recieving it back as health */
var() bool				bUseRewardDelay;
var() float				RewardDelay;
var float				PassReward;
var pawn				EnemyP;

var() bool				bUsePercentageReward;

/** Linear falloff for damage conversion based on the distance from the target.*/
//var() interp float		FalloffExponent;
//var() float				MaxConversionDistance;	//relevant only with distance falloff!
var bool				bUseFalloff;
var fRange				Falloff;

/*struct DmgFalloff
{
	var float Distance;
	var float Percentage;
};
var array<DmgFalloff> Falloff;*/

//Global GameDex: Self Damage Scaling
/*function int SelfDamage(UT_GR_Info.EnemyInfo Enemy)
{
	Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).SelfDmgMultiplier;
	return Super.SelfDamage(Enemy);
}*/

//Global GameDex: Bot Damage Scaling, Vehicle Damage Scaling
function int DamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	local float FalloffPercent;

/*	if(Enemy.bIsBot)
		Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).BotDmgMultiplier;

	if(Enemy.Type == ET_Vehicle){
//		if(Enemy.Pawn == Vehicle(Enemy.Pawn)){
			//TODO: Get value from GameDex, Default 1.0
			Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).VehicleDmgMultiplier;
//		}
	}*/

	//Rule_Variation: This is a Percentage Variation on the Damage by +/- 25%
	Enemy.ModifiedDamage=bUsePercentageReward ? int(fRandPercent(Enemy.Damage, 0.25)) : Enemy.Damage;

	//Rule_Variation: Falloff based on Players Distance to the enemy.
	if(bUseFalloff)
	{
		FalloffPercent = ((1 - (DistToEnemy(Enemy, Injured) - Falloff.Min)) / (Falloff.Max - Falloff.Min));
		ConversionRatio = ConversionRatio * FalloffPercent;
		`Logd("Enemy.Damage = "$Enemy.Damage$"; FalloffPercent = "$FalloffPercent$";  ConversionRatio = "$ConversionRatio,, 'DmgConvert');
	}

	return Super.DamageTaken(Enemy,Injured);
}

function RewardTimer()
{
	if(EnemyP != none && Vehicle(EnemyP) == none)
		EnemyP.Health = PassReward;
	else if(Vehicle(EnemyP) != none)
		Vehicle(EnemyP).HealDamage(PassReward, EnemyP.Controller, class'UTDmgType_LinkBeam');	//h4z
}

static final function float fRandBetween(float Bottom, float Top)
{
	return FRand()* (Top-Bottom) + Bottom;//	return FClamp(FRand(), Bottom, Top);
}

//static final simulated function  float RandRange( float InMin, float InMax )

//TODO: Vampire/EnergyLeech, give conversion ration +/-25% //25% of Conversion and/or damage
final function float PercentConversion(float A, float Percent)
{
	return (Rand(2)>0) ? A+A*Percent : A-A*Percent;
}

final function float fRandPercent(float A, float Pcnt)
{
	//return (Rand(2)>0) ? A+A*Rand(Percent) : A-A*Rand(Percent);
//	return (Rand(2)>0) ? A+A*FClamp(FRand(), A*Percent, A) : A-A*FClamp(FRand(), A*Percent, A);
	return (Rand(2)>0) ? A+A*fRandBetween(0,Pcnt) : A-A*fRandBetween(0,Pcnt);
}

//FROM: Unreal 2
// Randomly modifies the given float by +/- given %.
// e.g. PerturbFloatPercent( 100.0, 20.0) will return a value in 80.0..120.0
/*static final function float PerturbFloatPercent(float Num, float PerturbPercent){
	local float Perturb;

	Perturb = 2.0*PerturbPercent / 100.0;
	return Num + Num * ( ( Perturb * FRand() - Perturb / 2.0 ) );
}*/

/*static final function int PerturbInt(int Num, int PerturbPlusMinus){
	return Num + Rand( 2*PerturbPlusMinus +  1 ) - PerturbPlusMinus;
}*/


//TODO: Vampire/EnergyLeech, Falloff based on distance/view of target
final function float DistToEnemy(UT_GR_Info.EnemyInfo Enemy, pawn Injured)
{
	local float Dist;

	Dist = VSize(Enemy.Pawn.Location-Injured.Location);
	`Logd("DamageConversion: Distance to Enemy:"$Dist,, 'DmgConvert');
	return Dist;
}

defaultproperties
{
	bUsePercentageReward=True

	bUseRewardDelay=False
	RewardDelay=0.4

	bUseFalloff=False
	Falloff=(Min=200, Max=1300)
}