//===================================================
//	Class: UT_MDB_GR_GlobalDamage
//	Creation date: 08/09/2009 01:40
//	Last Updated: 14/04/2010 01:17
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_GlobalDamage extends UT_MDB_GR_DamageConversion;

/*struct DamageScaling
{
	var name ImpartedType;			//Enum: Enemy.Type?
	var float ImpartedDmg;			//%
	var name RecievedType;			//Enum: Pawn.Type?
	var float RecievedDmg;			//%
};var array<DamageScaling> DmgScale;*/

/*struct DamageScaling
{
	var name Type;			//Enum: Enemy.Type?
	var float ImpartedDmg;			//%
	var float RecievedDmg;			//%
};var array<DamageScaling> DmgScale;*/

var float	ImpartedDmgScale;
var float	SelfRecievedDmgScale;
var float	BotImpartedDmgScale;
var float	VehicleRecievedDmgScale,
			VehicleImpartedDmgScale;

//UTTeamGame(WorldInfo.Game).FriendlyFireScale = FriendlyFireScale;

static function int ModifySelfDamage(UT_GR_Info.EnemyInfo Enemy)
{
	Enemy.Damage = Enemy.Damage * default.SelfRecievedDmgScale;
	return super.ModifySelfDamage(Enemy);
}

function int ModifyDamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	`logd("Enemy.Damage = "$Enemy.Damage,,'GlobalDamage');

	if(Enemy.bIsBot)
		Enemy.Damage *= default.BotImpartedDmgScale;

	if(Enemy.Type == ET_Infantry)
	{
		if(Vehicle(Injured) != none && ClassIsChildOf(Enemy.DamageType,class'UTDamageType'))
			Enemy.Damage *= default.VehicleRecievedDmgScale;
	}

	if(Enemy.Type == ET_Vehicle)
		Enemy.Damage *= default.VehicleImpartedDmgScale;

	Enemy.Damage *= default.ImpartedDmgScale;

	`logd("Enemy.Damage = "$Enemy.Damage,,'GlobalDamage');

	return super.ModifyDamageTaken(Enemy,Injured);
}

defaultproperties
{
	ImpartedDmgScale=1.0
	SelfRecievedDmgScale=1.0
	BotImpartedDmgScale=1.0
	VehicleRecievedDmgScale=1.0
	VehicleImpartedDmgScale=1.0
}