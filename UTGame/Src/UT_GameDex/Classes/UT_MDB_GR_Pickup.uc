//===================================================
//	Class: UT_MDB_GR_Pickup
//	Creation date: 20/08/2009 15:42
//	Last Updated: 20/04/2010 12:51
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Pickup extends UT_MDB_GameRules
	implements(MDIB_GR_PickupQuery);
	
function bool PickupQuery(UTPawn Other, class<Inventory> ItemClass, Actor Pickup)
{
	//FIXME: Call next mutator that has Interface of this type in array, {hybrid list}
	//return (NextGameRules != none) ? NextGameRules.PickupQuery(Other, ItemClass, Pickup) : false;
	return false;
}
