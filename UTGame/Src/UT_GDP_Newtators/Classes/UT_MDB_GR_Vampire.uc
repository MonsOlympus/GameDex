//===================================================
//	Class: UT_MDB_GR_Vampire
//	Creation date: 27/11/2007 04:01
//	Last Updated: 17/11/2009 09:34
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//Modified version of Epics VampireGameRules from 2k4
//-Support for UT3's armour system
//-Support for Infantry Vs Vehicle
//-Support for Vehicle Vs Vehicle
//
//-Support for v2.0
//--Knights? Manta's, light armour
//--Rooks, Beamoth and juggernauts

//TODO: Rampup, more damage = more health returned, armour still blocks.
//===================================================
class UT_MDB_GR_Vampire extends UT_MDB_GR_DmgConversion
	config(GDP_Newtators);

`include(MOD.uci)

var float	AccumulateDamage,		/// Track damage accumulated during a tick
			AccumulationTime;		/// Tick time for which damage is being accumulated

//Branch 2
function int DamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	local int VampHealth, VampMaxHealth, DifHealth;
	local int tEnemyDamage;
	local int LogInitHealth;/*, LogDamage, LogConversion;*/

	if(Injured == None || !ClassIsChildOf(Injured.class, class'UTPawn'))
		return Enemy.Damage;

	VampHealth = Enemy.Pawn.Health;
	LogInitHealth = VampHealth;

	if(bUseSuperHealth)
		VampMaxHealth = UTPawn(Enemy.Pawn).SuperHealthMax;
	else
		VampMaxHealth = Enemy.Pawn.HealthMax;

	//Branch 3
	if(Enemy.Type == ET_Infantry)
	{
			if(UTPawn(Injured).ShieldBeltArmor > 0)
				return Super(UT_MDB_GameRules).DamageTaken(Enemy, Injured);
			else if(UTPawn(Injured).VestArmor > 0)
				ConversionRatio=bUseSuperHealth ? 0.1875 : 0.375;//if(bUseSuperHealth) ? ConversionRatio = 0.1875 : ConversionRatio = 0.375;
			else if(UTPawn(Injured).ThighpadArmor > 0)
				ConversionRatio=bUseSuperHealth ? 0.125 : 0.250;//if(bUseSuperHealth) ? ConversionRatio = 0.125 : ConversionRatio = 0.250;
			else if(UTPawn(Injured).HelmetArmor > 0)
				ConversionRatio=bUseSuperHealth ? 0.125 : 0.250;//if(bUseSuperHealth) ? ConversionRatio = 0.125 : ConversionRatio = 0.250;
			else
				ConversionRatio=bUseSuperHealth ? 0.5 : 0.35;//if(bUseSuperHealth) ? ConversionRatio = 0.5 : ConversionRatio = 0.35;

		DifHealth = Enemy.Pawn.Health - VampHealth;
	}
	else if(Enemy.Type == ET_Vehicle && bUseForVehicles)
	{
		if(Enemy.Pawn == Vehicle(Enemy.Pawn))
		{
			VampHealth = Vehicle(Enemy.Pawn).Health;
			VampMaxHealth = Vehicle(Enemy.Pawn).HealthMax;
			ConversionRatio = 0.5;

			DifHealth = Enemy.Damage*ConversionRatio;
		}
	}

	`Logd("Enemy = "$Enemy.Pawn.name$"; Damage = "$Enemy.Damage$"; ModifiedDamage = "$Enemy.ModifiedDamage$"; ConversionRatio = "$ConversionRatio,,'Vampire');
	//TODO: Insert 'fRandPercent(Enemy.Damage, 0.25)' into equation

	if(!bUseRewardDelay)
	{
		//Rule_Standard: Give Infantry/Vehicle Health Straight Away with no Percent Variation.
		//Rule_Variation: Give Infantry/Vehicle Health Straight Away with Percent Variation.
		if(Enemy.Type == ET_Infantry)
		{
			Enemy.Pawn.Health = Clamp(VampHealth+Enemy.Damage*ConversionRatio, VampHealth, VampMaxHealth);
			//Enemy.Pawn.Health = Clamp(VampHealth+Enemy.ModifiedDamage*ConversionRatio, VampHealth, VampMaxHealth);
		}
		else if(Enemy.Type == ET_Vehicle && bUseForVehicles)
		{
			Vehicle(Enemy.Pawn).HealDamage(Enemy.Damage*ConversionRatio, Enemy.Pawn.Controller, Enemy.DamageType);
			//Vehicle(Enemy.Pawn).HealDamage(Enemy.ModifiedDamage*ConversionRatio, Enemy.Pawn.Controller, Enemy.DamageType);
		}
	}
	else
	{
		//Rule_Variation: Give Infantry/Vehicle Health after a Delay with no Percent Variation.
		//Rule_Variation: Give Infantry/Vehicle Health after a Delay with Percent Variation.
		if(Enemy.Type == ET_Infantry)
		{
			PassReward = Clamp(VampHealth+Enemy.Damage*ConversionRatio, VampHealth, VampMaxHealth);
			//PassReward = Clamp(VampHealth+Enemy.ModifiedDamage*ConversionRatio, VampHealth, VampMaxHealth);
		}
		else if(Enemy.Type == ET_Vehicle && bUseForVehicles)
		{
			PassReward = Clamp(Enemy.Damage*ConversionRatio, VampHealth, VampMaxHealth);
			//PassReward = Clamp(Enemy.ModifiedDamage*ConversionRatio, VampHealth, VampMaxHealth);
		}
	}

	if(bUseRewardDelay)
		SetTimer(RewardDelay, false, 'RewardTimer');

/*	if(!bUseForVehicles)
		return Super.DamageTaken(Enemy, Injured);
	else{
		//Branch4: Do vehicle code here, optimized?
	}*/

	//Displays a message on the Players Hud informing them of the Amount of Health leached from the Enemy.
	DifHealth = Enemy.Pawn.Health - VampHealth;
	if(DifHealth != 0)
		if(PlayerController(Enemy.Pawn.Controller) != None)
			PlayerController(Enemy.Pawn.Controller).ReceiveLocalizedMessage(class'`pak1.UT_LMsg_Vampire', DifHealth);

	//TODO: Support for Rook 2.0
	return super.DamageTaken(Enemy, Injured);//	return Super(UT_MDB_GameRules).DamageTaken(Enemy, Injured);
}

defaultproperties
{
	bUsePercentageReward=True
	bUseRewardDelay=False
	bUseFalloff=False
}