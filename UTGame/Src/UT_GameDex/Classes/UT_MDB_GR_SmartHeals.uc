//===================================================
//	Class: UT_MDB_GR_SmartHeals
//	Creation Date: 23/04/2010 05:41
//	Last Updated: 23/04/2010 05:41
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_SmartHeals extends UT_MDB_GR_Pickup;

/*static function bool OverridePickupQuery(Pawn Other, Pickup item, out byte bAllowPickup, int AbilityLevel)
{
	local int HealMax;

	if (TournamentHealth(item) != None)
	{
		HealMax = TournamentHealth(item).GetHealMax(Other);
		if (Other.Health + TournamentHealth(item).HealingAmount < HealMax)
		{
			Other.GiveHealth(int(float(TournamentHealth(item).HealingAmount) * 0.25 * AbilityLevel), HealMax);
			bAllowPickup = 1;
			return true;
		}
	}

	return false;
}*/