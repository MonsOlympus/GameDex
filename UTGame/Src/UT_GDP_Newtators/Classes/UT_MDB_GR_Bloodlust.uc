//===================================================
//	Class: UT_MDB_GR_Bloodlust
//	Creation date: 18/12/2007 04:30
//	Last updated: 08/09/2009 21:06
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Bloodlust extends UT_MDB_GR_Vampire;

function int DamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured)
{
	if(Enemy.Type == ET_Infantry)
		if(UTInventoryManager(Enemy.Pawn.InvManager).HasInventoryOfClass(class'UT_GDP_Newtators.UT_TPG_VDamage') != None)
			Super.DamageTaken(Enemy, Injured);

	return Enemy.Damage;
}

defaultproperties
{
	bUseSuperHealth=True
}