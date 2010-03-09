// Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
class UTM_NoSuperWeapons extends UTMutator
	deprecated;

function bool CheckReplacement(Actor Other)
{
	local UTWeaponPickupFactory Factory;

	Factory = UTWeaponPickupFactory(Other);
	if(Factory != None)
	{
		if (Factory.WeaponPickupClass.Default.bSuperWeapon)
		{
			return false;
		}
	}

	return true;
}
