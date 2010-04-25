//===================================================
//	Class:  UT_MDI_AmmoRegen
//	Creation Date: 23/04/2010 05:33
//	Last Updated: 23/04/2010 05:33
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI_AmmoRegen extends UT_MDI;

var int RegenAmount;

/*
function PostBeginPlay()
{
	SetTimer(3.0, true);

	Super.PostBeginPlay();
}

function Timer()
{
	local Inventory Inv;
	local Ammunition Ammo;
	local Weapon W;

	if (Instigator == None || Instigator.Health <= 0)
	{
		Destroy();
		return;
	}

	for (Inv = Instigator.Inventory; Inv != None; Inv = Inv.Inventory)
	{
		W = Weapon(Inv);
		if (W != None)
		{
			if (W.bNoAmmoInstances && W.AmmoClass[0] != None && !class'MutUT2004RPG'.static.IsSuperWeaponAmmo(W.AmmoClass[0]))
			{
				W.AddAmmo(RegenAmount * (1 + W.AmmoClass[0].default.MaxAmmo / 100), 0);
				if (W.AmmoClass[0] != W.AmmoClass[1] && W.AmmoClass[1] != None)
					W.AddAmmo(RegenAmount * (1 + W.AmmoClass[1].default.MaxAmmo / 100), 1);
			}
		}
		else
		{
			Ammo = Ammunition(Inv);
			if (Ammo != None && !class'MutUT2004RPG'.static.IsSuperWeaponAmmo(Ammo.Class))
				Ammo.AddAmmo(RegenAmount * (1 + Ammo.default.MaxAmmo / 100));
		}
	}
}*/