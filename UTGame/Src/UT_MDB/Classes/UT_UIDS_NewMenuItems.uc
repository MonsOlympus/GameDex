//===================================================
//	Class: UT_UIDS_NewMenuItems
//	Creation Date: 30/11/2007 22:21
//	Last Updated: 01/02/2008 05:48
//	Contributors: CaptainSnarf, 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_UIDS_NewMenuItems extends UTUIDataStore_MenuItems;

//native function int FindValueInProviderSet(name ProviderFieldName, name SearchTag, string SearchValue);
var transient array<UT_UIDP_Vehicles> VehicleProviders;

/** List of possible Vehicle classes. */
var transient array<string>	VehicleClassNames;

function FillFactories()
{
	local array<UTUIResourceDataProvider> OutProviders;
	local UTUIResourceDataProvider tempProvider;
//	local int VehicleIdx;
//	local bool bAddVehicle;

	GetAllResourceDataProviders(class'UT_UIDP_Vehicles', OutProviders);

	foreach OutProviders(tempProvider)
	{
		if(UT_UIDP_Vehicles(tempProvider) != None)
		{
			`logd("DataProvider Stuff!");
//			UTUIDataProvider_Vehicles(tempProvider).ClassPath
//			UTUIDataProvider_Vehicles(tempProvider).FactoryClassName
		}
	}

/*	for(VehicleIdx = 0; VehicleIdx < OutProviders.length; VehicleIdx++)
	{
		bAddVehicle=true;

		if(bAddVehicle)
		{
			VehicleProviders.AddItem(UTUIDataProvider_Vehicles(OutProviders[VehicleIdx]));
		}
	}*/
}

event Registered(LocalPlayer PlayerOwner)
{
	`logd("Registered Datastore: "$self.name$" to "$PlayerOwner,,'Debug');
}

defaultproperties
{
//   ElementProviderTypes(0)=(ProviderTag="Vehicles",ProviderClassName="Newtators.UTUIDataProvider_Vehicle")
/*    ElementProviderTypes(0)=
   ElementProviderTypes(1)=
   ElementProviderTypes(2)=
   ElementProviderTypes(3)=
   ElementProviderTypes(4)=
   ElementProviderTypes(5)=
   ElementProviderTypes(6)=
   ElementProviderTypes(7)=
   ElementProviderTypes(8)=
   ElementProviderTypes(9)=
   ElementProviderTypes(10)=
   ElementProviderTypes(11)= */
//   ElementProviderTypes(12)=(ProviderTag="DropDownVehicles",ProviderClassName="Newtators.UTUIDataProvider_Vehicles")
	Tag="Vehicles"
//	Name="Default__UTUIDataStore_NewMenuItems"
//	ObjectArchetype=UIDataStore_GameResource'UTGame.Default__UTUIDataStore_MenuItems'
}