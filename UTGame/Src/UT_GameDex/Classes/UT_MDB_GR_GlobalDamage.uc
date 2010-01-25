//===================================================
//	Class: UT_MDB_GR_GlobalDamage
//	Creation date: 08/09/2009 01:40
//	Last Updated: 12/09/2009 03:52
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_GlobalDamage extends UT_MDB_GR_DmgConversion;

//Global GameExp: Self Damage Scaling
function int SelfDamage(UT_GR_Info.EnemyInfo Enemy)
{
	Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).SelfRecievedDmgScale;
	return Super.SelfDamage(Enemy);
}

//Global GameExp: Bot Damage Scaling, Vehicle Damage Scaling
function int DamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	`logd("Enemy.Damage = "$Enemy.Damage,,'GlobalDamage');

	if(Enemy.bIsBot)
		Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).BotImpartedDmgScale;

	if(Enemy.Type == ET_Infantry)
	{
		//TODO: Get value from GameExp, Default 1.0
		if(Vehicle(Injured) != none && ClassIsChildOf(Enemy.DamageType,class'UTDamageType'))
			Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).VehicleRecievedDmgScale;
	}

	if(Enemy.Type == ET_Vehicle)
	{
//		if(UTPawn(Injured) != none)
			Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).VehicleImpartedDmgScale;
	}

	Enemy.Damage = Enemy.Damage * UT_MDB_GameExp(UT_GR_Info(MasterGR).GameExp).ImpartedDmgScale;

	`logd("Enemy.Damage = "$Enemy.Damage,,'GlobalDamage');

	return Super.DamageTaken(Enemy,Injured);
}