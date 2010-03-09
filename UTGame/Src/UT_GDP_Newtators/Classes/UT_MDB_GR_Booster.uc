//===================================================
//	Class: UT_MDB_GR_Booster
//	Creation date: 22/06/2008 11:17
//	Last Updated: 07/03/2010 01:16
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Booster extends UT_MDB_GR_Pickup;

`include(MOD.uci)

//function bool OverridePickupQuery(Pawn Other, class<Inventory> ItemClass, Actor Pickup)
function bool PickupQuery(UTPawn P, class<Inventory> ItemClass, Actor Pickup)
{
	local UTInventoryManager InvMgr;
	local UTPickupFactory_MediumHealth MedHealthFactory;
	local int HealAmount;

	InvMgr = UTInventoryManager(P.InvManager);

	if(InvMgr.HasInventoryOfClass(class'`Pak1.UT_TPG_Booster') != None)
	{
		if(Pickup != None && P != None)
		{
			//Medium Health packs usually only allow pickup if you have under 100 health!
			//This overrides that and forces the player to pickup the item.
			MedHealthFactory = UTPickupFactory_MediumHealth(Pickup);
			if(MedHealthFactory != None)
			{
				HealAmount = (P.Health + MedHealthFactory.HealingAmount) - P.SuperHealthMax;
//				if(UTPawn(Other).Health <= UTPawn(Other).HealthMax){}

				if(P.Health <= P.SuperHealthMax)
				{
					if(P.Health + MedHealthFactory.HealingAmount > P.SuperHealthMax)
						P.Health += HealAmount;
					else
						P.Health += MedHealthFactory.HealingAmount;

					MedHealthFactory.GiveTo(P);
					return true;
				}
			}
		}
	}

/*	if((NextGR != None) &&  NextGR.OverridePickupQuery(P, ItemClass, Pickup))
		return true;

	return false;*/
	return Super.PickupQuery(P, ItemClass, Pickup);
}