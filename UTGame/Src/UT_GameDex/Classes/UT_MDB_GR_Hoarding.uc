//===================================================
//	Class: UT_MDB_GR_Hoarding
//	Creation date: 04/12/2007 15:12
//	Last updated: 17/03/2009 02:22
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_GR_Hoarding extends UT_MDB_GR_Pickup
	config(Newtators);

var config bool	bCanHoardArmour,
				bCanHoardHealth,
				bCanHoardPowerups,
				bCanHoardAmmo;
//var bool		bCanHoardWeapons;		//Weaponstay off!

function bool PickupQuery(UTPawn Other, class<Inventory> ItemClass, Actor Pickup)
{
	local UTInventoryManager InvMgr;
	local array<UTWeapon> WeaponList;
	local class<UTWeapon> Weapon;
	local UTPickupFactory_MediumHealth MedHealthFactory;
	local UTAmmoPickupFactory AmmoFactory;
	local int i;

	InvMgr = UTInventoryManager(Other.InvManager);

//	if(Pickup != None && UTPawn(Other) != None)	{

		if(!bCanHoardPowerups)		{
//			if(ClassIsChildOf(UTInventory, Class<UTTimedPowerup>))
//				return true;

			if(Pickup.IsA('UTPickupFactory_JumpBoots') && Other.JumpBootCharge == 3)
				return true;

			//TODO: Jump boot stacking, max=6->10 charges

/*			Pickup.IsA('UTPickupFactory_Berserk')	Pickup.IsA('UTPickupFactory_Invisibility')
			Pickup.IsA('UTPickupFactory_Invulnerability')	Pickup.IsA('UTPickupFactory_UDamage')*/
		}

		if(!bCanHoardHealth)		{
			if(((Pickup.IsA('UTPickupFactory_HealthVial') || Pickup.IsA('UTPickupFactory_SuperHealth')) && Other.Health == Other.SuperHealthMax) ||
				(Pickup.IsA('UTPickupFactory_MediumHealth') && Other.Health == Other.HealthMax))
					return true;
		}else{
			///Medium Health packs usually only allow pickup if you have under 100 health!
			///This overrides that and forces the player to pickup the item.
			MedHealthFactory = UTPickupFactory_MediumHealth(Pickup);
			if(MedHealthFactory != None && Other.Health >= Other.HealthMax)// && UTPawn(Other).Health == UTPawn(Other).SuperHealthMax)
			{
				MedHealthFactory.GiveTo(Other);
				return true;
			}
		}

		//TODO: Shield Stacking! <--- 2x50=100, 2x100=150, 2x35=70 //no helmet stack
		if(!bCanHoardArmour)		{
			///Cannot pickup Armour Pickups if you have full.
			///Default is Armour Pickups are always allowed to be picked up. (Hoard)
			if((Pickup.IsA('UTArmorPickup_ShieldBelt') && Other.ShieldBeltArmor == 100) ||
				(Pickup.IsA('UTArmorPickup_Vest') && Other.VestArmor == 50) ||
				(Pickup.IsA('UTArmorPickup_Thighpads') && Other.ThighpadArmor == 30) ||
				(Pickup.IsA('UTArmorPickup_Helmet') && Other.HelmetArmor == 20))
					return true;
		}

		//Removed, no need for this with weaponstay off!
//		if(bCanHoardWeapons){}

		if(bCanHoardAmmo)		{
			//Checks the Weapons ammo and the stores, if they are full then 1 ammo is removed
			//to allow pickup of ammo all the time.
			AmmoFactory = UTAmmoPickupFactory(Pickup);
			if(AmmoFactory != None && InvMgr != None){
				Weapon = AmmoFactory.TargetWeapon;
				`logd("Weapon: "$Weapon);

				// Get the list of weapons
				InvMgr.GetWeaponList(WeaponList);
				for(i=0;i<WeaponList.Length;i++){
					// The Pawn has this weapon
					if(ClassIsChildOf(WeaponList[i].Class, Weapon)){
						if(WeaponList[i].AmmoCount == WeaponList[i].MaxAmmoCount){
							WeaponList[i].AddAmmo(-1);
							return false;
						}
					}
				}

				// Add to to our stores for later.
				for(i=0;i<InvMgr.AmmoStorage.Length;i++){
					// We are already tracking this type of ammo, so just increment the ammount
					if(InvMgr.AmmoStorage[i].WeaponClass == Weapon){
						if(InvMgr.AmmoStorage[i].Amount == Weapon.default.MaxAmmoCount){
							InvMgr.AmmoStorage[i].Amount -= 1;
							return false;
						}
					}
				}
			}
		}

//	}

//	if((NextGameRules != None) &&  NextGameRules.OverridePickupQuery(Other, ItemClass, Pickup, bAllowPickup))
//		return true;

//	return false;
}

defaultproperties
{
	bCanHoardArmour=False
	bCanHoardHealth=False
	bCanHoardPowerups=False
	bCanHoardAmmo=False
}