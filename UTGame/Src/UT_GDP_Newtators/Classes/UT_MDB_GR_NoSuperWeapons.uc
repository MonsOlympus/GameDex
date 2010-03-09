//===================================================
//	Class: UT_MDB_GR_NoSuperWeapons
//	Creation date: 18/12/2007 02:23
//	Last updated: 07/03/2010 00:34
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_NoSuperWeapons extends UT_MDB_GR_Item;

function bool CheckReplacement(Actor Other)
{
	local UTWeaponPickupFactory Factory;

	Factory = UTWeaponPickupFactory(Other);
	if(Factory != None)
	{
		if(Factory.WeaponPickupClass.Default.bSuperWeapon)
			return false;
	}

	return true;
}
