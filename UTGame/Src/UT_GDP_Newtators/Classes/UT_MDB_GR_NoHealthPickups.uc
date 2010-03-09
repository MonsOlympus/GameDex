//===================================================
//	Class: UT_MDB_GR_NoHealthPickups
//	Creation date: 18/12/2007 02:23
//	Last updated: 07/03/2010 00:34
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_NoHealthPickups extends UT_MDB_GR_Item;

function bool CheckReplacement(Actor Other)
{
	local UTHealthPickupFactory F;

	F = UTHealthPickupFactory(Other);
	return (F == None);
}