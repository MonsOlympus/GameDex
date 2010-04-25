//===================================================
//	Class: UT_UIDS_Factories
//	Creation Date: 12/03/2010 22:14
//	Last Updated: 12/03/2010 22:14
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_UIDS_Factories extends UTUIDataStore_MenuItems;

struct FactoryType
{
	var name Type;
	var class<actor> SubClassOf;
	var class<actor> FactoryIsSubclassOf;
};

var array<FactoryType> FactoryTypes;

//var transient array<UTUIDataProvider_Vehicles> VehicleProviders;
//var transient array<UTUIDataProvider_Weapon> WeaponProviders;

function FillFactories()
{
	local FactoryType tempFactoryType;

/*	foreach FactoryTypes(tempFactoryType)
	{
		if(tempFactoryType.SubClassOf
	}*/

	//class'UTVehicleFactory'.VehicleClass
	//class'UTWeaponPickupFactory'.WeaponPickupClass

	//class'UTPowerupPickupFactory'.InventoryType
	//class'UTPickupFactory_JumpBoots'.InventoryType

	//class'UTAmmoPickupFactory'.TargetWeapon

//	if (ClassIsChildOf(TargetWeapon, Bot.FavoriteWeapon))


//UTVehicleFactory.VehicleClassPath (string)

//UTPickupFactory.InventoryType (class)
//UTWeaponFactory.WeaponPickupClass (class)
//UTDeployablePickupFactory.DeployablePickupClass (class)

}

event Registered(LocalPlayer PlayerOwner)
{
	`logd("Registered Datastore: "$self.name$" to "$PlayerOwner,,'Debug');
}

defaultproperties
{
/*	FactoryTypes(0)=(Type='Vehicle', SubClassOf=class'UTVehicle', FactoryIsSubclassOf=class'UTVehicleFactory')
	FactoryTypes(1)=(Type='Weapon', SubClassOf=class'UTWeapon', FactoryIsSubclassOf=class'UTWeaponPickupFactory')
	//No inventory type for ammunition
	//FactoryTypes(2)=(Type='Ammunition', SubClassOf=class'', FactoryIsSubclassOf=class'UTAmmoPickupFactory')

	//UTInventory
	FactoryTypes(3)=(Type='Powerup', SubClassOf=class'UTTimedPowerup', FactoryIsSubclassOf=class'UTPowerupPickupFactory')
	FactoryTypes(4)=(Type='JumpBoot', SubClassOf=class'UTJumpBoots', FactoryIsSubclassOf=class'UTPickupFactory_JumpBoots')

	FactoryTypes(5)=(Type='Deployable', SubClassOf=class'', FactoryIsSubclassOf=class'UTDeployablePickupFactory')*/

	Tag="Factories"
//	Name="Default__UTUIDataStore_Factories"
//	ObjectArchetype=UIDataStore_GameResource'UTGame.Default__UTUIDataStore_Factories'
}