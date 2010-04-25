//===================================================
//	Class: UT_MDB_GR_DamageConversion
//	Creation date: 20/08/2009 14:46
//	Last Updated: 14/04/2010 06:58
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
class UT_MDB_GR_DamageConversion extends UT_MDB_GameRules
	implements(MDIB_GR_ModifyDamageTaken)
	implements(MDIB_GR_ModifySelfDamage)
	config(GameDex);

var config bool			bUseSuperHealth,
						bUseForVehicles,	//Infantry Vs Vehicle || Vehicle Vs Vehicle Damage!
						bUseForKnights,
						bUseForRooks;		//Castles cant have vampire :S

/** Conversion of damage to armour or damage to health, varies depending on armour.
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

static function int ModifySelfDamage(UT_GR_Info.EnemyInfo Enemy)
{
	//FIXME: Call next mutator that has Interface of this type in array, {hybrid list}
//	return (NextGameRules != none) ? NextGameRules.ModifySelfDamage(Enemy) : Enemy.Damage;
	return 0;
}
//FIXME: Add out Damage back? out Enemy?
function int ModifyDamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	local float FalloffPercent;

	//Rule_Variation: This is a Percentage Variation on the Damage by +/- 25%
	Enemy.Damage = default.bUsePercentageReward ? int(fRandPercent(Enemy.Damage, 0.25)) : Enemy.Damage;
	//Enemy.ModifiedDamage = bUsePercentageReward ? int(fRandPercent(Enemy.Damage, 0.25)) : Enemy.Damage;

	//Rule_Variation: Falloff based on Players Distance to the enemy.
	if(default.bUseFalloff)
	{
		FalloffPercent = ((1 - (VSize(Enemy.Pawn.Location - Injured.Location) - default.Falloff.Min)) / (default.Falloff.Max - default.Falloff.Min));
		ConversionRatio = ConversionRatio * FalloffPercent;
		`Logd("Enemy.Damage = "$Enemy.Damage$"; FalloffPercent = "$FalloffPercent$";  ConversionRatio = "$ConversionRatio,, 'DmgConvert');
		//`Logd("DamageConversion: Distance to Enemy:"$VSize(Enemy.Pawn.Location-Injured.Location),, 'DmgConvert');
	}

	//FIXME: Call next mutator that has Interface of this type in array, {hybrid list}
	//if(NextGameRules != None)
	//	return NextGameRules.ModifyDamageTaken(Enemy, injured);
/*	else
		return (Enemy.ModifiedDamage != 0 && Enemy.Damage != Enemy.ModifiedDamage) ? Enemy.ModifiedDamage : Enemy.Damage;*/
	return Enemy.Damage;
}

function RewardTimer()
{
	if(EnemyP != none && Vehicle(EnemyP) == none)
		EnemyP.Health = PassReward;
	else if(Vehicle(EnemyP) != none)
		Vehicle(EnemyP).HealDamage(PassReward, EnemyP.Controller, class'UTDmgType_LinkBeam');	//h4z
}

static final function float fRandBetween(float Min, float Max)
{
	return FRand() * (Max - Min) + Min;
}

//static final simulated function  float RandRange( float InMin, float InMax )

//TODO: Vampire/EnergyLeech, give conversion ration +/-25% //25% of Conversion and/or damage
static final function float PercentConversion(float A, float Percent)
{
	return (Rand(2)>0) ? A+A*Percent : A-A*Percent;
}

static final function float fRandPercent(float A, float Percent)
{
	//return (Rand(2)>0) ? A+A*Rand(Percent) : A-A*Rand(Percent);
	return (Rand(2)>0) ? A+A*fRandBetween(0, Percent) : A-A*fRandBetween(0, Percent);
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

/*function CausePainTo(Actor Other)
{
	if (DamagePerSec > 0)
	{
		if ( WorldInfo.bSoftKillZ && (Other.Physics != PHYS_Walking) )
			return;
		if ( (DamageType == None) || (DamageType == class'DamageType') )
			`log("No valid damagetype specified for "$self);
		Other.TakeDamage(DamagePerSec, DamageInstigator, Location, vect(0,0,0), DamageType);
	}
	else
	{
		Other.HealDamage(DamagePerSec, DamageInstigator, DamageType);
	}
}*/

defaultproperties
{
	bUsePercentageReward=True

	bUseRewardDelay=False
	RewardDelay=0.4

	bUseFalloff=False
	Falloff=(Min=200, Max=1300)
}