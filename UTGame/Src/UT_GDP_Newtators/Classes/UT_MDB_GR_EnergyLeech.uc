//===================================================
//	Class: UT_MDB_GR_EnergyLeech
//	Creation date: 04/12/2007 04:01
//	Last Updated: 23/11/2009 06:34
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//-Support for Infantry Vs Vehicle
//===================================================
class UT_MDB_GR_EnergyLeech extends UT_MDB_GR_DmgConversion
	config(GDP_Newtators);

`include(MOD.uci)

var globalconfig bool	bUseShieldBelt;
var globalconfig bool	bUseVestArmour;
var globalconfig bool	bUseThighpadArmor;
var globalconfig bool	bUseHelmetArmor;

//Branch 2
function int DamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	local int ArmourAmount, DifArmour;

//	Super.DamageTaken(Enemy, Injured);

	if(Enemy.Type == ET_Infantry)
	{
		if(UTPawn(Injured).ShieldBeltArmor > 0 && bUseShieldBelt)
		{
			ConversionRatio = 0.500;		//0.5	// shield belt absorbs 100% of damage
			ArmourAmount = UTPawn(Enemy.Pawn).ShieldBeltArmor;

/*			if(bUsePercentageReward){
				`logd("Enemy.Damage = "$Enemy.Damage$"; ConversionRatio = "$ConversionRatio,,'EnergyLeech');
				Enemy.Damage = fRandPercent(Enemy.Damage, 0.25);
				`logd("Enemy.Damage = "$Enemy.Damage,,'EnergyLeech');
			}*/

			UTPawn(Enemy.Pawn).ShieldBeltArmor = min(ArmourAmount+Enemy.Damage*ConversionRatio, 100);
			DifArmour = UTPawn(Enemy.Pawn).ShieldBeltArmor - ArmourAmount;
			//`logd(Enemy.Pawn$"; Initial SB="$ArmourAmount$"; SB Gained="$DifArmour$"; New SB="$UTPawn(Enemy.Pawn).ShieldBeltArmor,,'EnergyLeech');
		}
		else if(UTPawn(Injured).VestArmor > 0 && bUseVestArmour)
		{
			ConversionRatio = 0.375;		//0.3	// vest absorbs 75% of damage
			ArmourAmount = UTPawn(Enemy.Pawn).VestArmor;
			UTPawn(Enemy.Pawn).VestArmor = min(ArmourAmount+Enemy.Damage*ConversionRatio, 50);
			DifArmour = UTPawn(Enemy.Pawn).VestArmor - ArmourAmount;
			//`logd(Enemy.Pawn$"; Initial VA="$ArmourAmount$"; VA Gained="$DifArmour$"; New VA="$UTPawn(Enemy.Pawn).VestArmor,,'EnergyLeech');
		}
		else if(UTPawn(Injured).ThighpadArmor > 0 && bUseThighpadArmor)
		{
			ConversionRatio = 0.250;		//0.2	// thighpads absorb 50% of damage
			ArmourAmount = UTPawn(Enemy.Pawn).ThighpadArmor;
			UTPawn(Enemy.Pawn).ThighpadArmor = min(ArmourAmount+Enemy.Damage*ConversionRatio, 30);
			DifArmour = UTPawn(Enemy.Pawn).ThighpadArmor - ArmourAmount;
			//`logd(Enemy.Pawn$"; Initial TP="$ArmourAmount$"; TP Gained="$DifArmour$"; New TP="$UTPawn(Enemy.Pawn).ThighpadArmor,,'EnergyLeech');
		}
		else if(UTPawn(Injured).HelmetArmor > 0 && bUseHelmetArmor)
		{
			ConversionRatio = 0.250;		//0.1	// helmet absorbs 20% of damage
			ArmourAmount = UTPawn(Enemy.Pawn).HelmetArmor;
			UTPawn(Enemy.Pawn).HelmetArmor = min(ArmourAmount+Enemy.Damage*ConversionRatio, 20);
			DifArmour = UTPawn(Enemy.Pawn).HelmetArmor - ArmourAmount;
			//`logd(Enemy.Pawn$"; Initial HA="$ArmourAmount$"; HA Gained="$DifArmour$"; New HA="$UTPawn(Enemy.Pawn).HelmetArmor,,'EnergyLeech');
		}

		//Updated to support Vehicles!
		if(Enemy.Type == ET_Vehicle && bUseForVehicles)
		{
			ConversionRatio = 0.250;		//For vehicles we go a quater of health to armour
			ArmourAmount = UTPawn(Enemy.Pawn).ShieldBeltArmor;
			UTPawn(Enemy.Pawn).ShieldBeltArmor = min(ArmourAmount+Enemy.Damage*ConversionRatio, 100);
			DifArmour = UTPawn(Enemy.Pawn).ShieldBeltArmor - ArmourAmount;
		}

		if(DifArmour != 0)
			if(PlayerController(Enemy.Pawn.Controller) != None)
				PlayerController(Enemy.Pawn.Controller).ReceiveLocalizedMessage(class'`pak1.UT_LMsg_EnergyLeech', DifArmour);
	}

	return Super.DamageTaken(Enemy, Injured);
//	return Enemy.ModifiedDamage;
}

defaultproperties
{
	bUseShieldBelt=True
	bUseVestArmour=False
	bUseThighpadArmor=False
	bUseHelmetArmor=False
	bUseForVehicles=True
}