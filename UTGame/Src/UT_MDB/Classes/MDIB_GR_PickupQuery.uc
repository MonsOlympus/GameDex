//===================================================
//	Interface: MDIB_GR_PickupQuery
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_PickupQuery extends MDIB;

function bool PickupQuery(UTPawn Other, class<Inventory> ItemClass, Actor Pickup);