//===================================================
//	Class: UT_MDB_GR_Attrition
//	Creation date: 11/12/2008 21:03
//	Last updated: 15/01/2009 07:07
//	Contributors: 00zX
//---------------------------------------------------
//Armour Degeneration
//===================================================
class UT_MDB_GR_Attrition extends UT_MDB_GR_Pickup;

var name PickupName;

//TODO: Delay degeneration of shields when damaged, need to delay it after pickup as well.
//function bool PickupQuery(Pawn Other, class<Inventory> ItemClass, Actor Pickup)
function bool PickupQuery(UTPawn Other, class<Inventory> ItemClass, Actor Pickup)
{
//	local UTPawn_Attrition	aPawn;

//	aPawn = UTPawn_Attrition(Other);
//	if(aPawn != None && bAllowPickups)
//	{
/*		if(Pickup.IsA(PickupName){}*/

		//if(Pickup.IsA('UTArmorPickup_ShieldBelt'))
		//{
			//if(!aPawn.IsTimerActive('ShieldBeltTimer') && !aPawn.IsTimerActive('ShieldBeltCountdownToDegen'))
			//{
				//TODO: Move to info
				////aPawn.SetTimer(5.0, false, 'ShieldBeltCountdownToDegen');
			//}
			//else if(aPawn.IsTimerActive('ShieldBeltTimer') && !aPawn.IsTimerActive('ShieldBeltCountdownToDegen'))
			//{
			//	ClearTimer('ShieldBeltTimer');
			//	aPawn.SetTimer(2.5, false, 'ShieldBeltCountdownToDegen');
			//}
		//}
//	}
//('UTArmorPickup_ShieldBelt')
//('UTDroppedShieldBelt')
//(Pickup.IsA('UTArmorPickup_Vest') && aPawn.VestArmor != 50)
//if(Pickup.IsA('UTArmorPickup_Thighpads') && aPawn.ThighpadArmor != 30)
//if(Pickup.IsA('UTArmorPickup_Helmet') && aPawn.HelmetArmor != 20)

//if(Pickup.IsA('UTPickupFactory_HealthVial'))
//if(Pickup.IsA('UTPickupFactory_SuperHealth'))
}
/*
bAllowPickups
class'UTArmorPickup_ShieldBelt'
class'UTDroppedShieldBelt'
class'UTArmorPickup_Vest'
class'UTArmorPickup_Thighpads'
class'UTArmorPickup_Helmet'
class'UTPickupFactory_HealthVial'
class'UTPickupFactory_SuperHealth'
*/