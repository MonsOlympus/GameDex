//===================================================
//	Class: UTrWeapon
//	Creation date: 01/12/2007 09:00
//	Last Updated: 06/12/2007 10:00
//	Contributors: 00zX
//---------------------------------------------------
//*Add support for Dual Enforcers
//*Add support for doing Evil which links to mut options
//===================================================
//class UTrWeapon extends UTInventory
class UTrWeapon extends UTWeapon
	HideDropDown;
//	config(Muatatoes);

/** Storage for all Weapons this Weapon can give as Random */
var array< class<Inventory> > WeaponsList;

/** sound to play when the boots are used */
var SoundCue ActivateSound;
var SoundCue DeniedSound;
var SoundCue FizzleSound;

var int count;

////
/*function DropFrom(vector StartLocation, vector StartVelocity)
{
	ClientLostItem();

//	Super.DropFrom(StartLocation, StartVelocity);
}*/

////
//reliable client function ClientGivenTo(Pawn NewOwner, bool bDoNotActivate)
//{
//	Super.ClientGivenTo(NewOwner, bDoNotActivate);

/*	if(Role < ROLE_Authority)
	{
		AdjustPawn(UTPawn(NewOwner), false);
	}*/
//}

function GivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	local array<UTWeapon> YourWeapons;
	local UTPawn P;
	local UTInventoryManager Inv;
	local int rA, rB, rC;

	Super.GivenTo(NewOwner,bDoNotActivate);

	P = UTPawn(NewOwner);
	if(P != None)
	{
		Inv = UTInventoryManager(P.InvManager);
		`logd("Inventory Manager: "$Inv);
		if(Inv != None)
		{
			//Get a random number from the Possible Weapons.
			rA = Rand(WeaponsList.length);

			//Get the list of your current weapons.
			Inv.GetWeaponList(YourWeapons,False);

			if(Inv.FindInventoryType(WeaponsList[rA], True) == None)
			{
				Inv.CreateInventory(WeaponsList[rA]);
				`logd("Gave Weapon: "$WeaponsList[rA]);
				P.PlaySound(ActivateSound, false, true, false);
				Count--;
			}
			else if(YourWeapons.Length > 0)
			{
				//Get a random number from the Your Weapons.
				rB = Rand(YourWeapons.length);

				if(Inv.NeedsAmmo(YourWeapons[rB].Class) == True)
				{
					`logd("Gave more ammo for: "$YourWeapons[rB]);
					Inv.AddAmmoToWeapon(YourWeapons[rB].AmmoCount.,YourWeapons[rB].Class);
					Count--;
				}
				else
				{
					`logd("Dont need ammo for: "$YourWeapons[rB]$"  Do something Evil here??");
					P.PlaySound(DeniedSound, false, true, false);
					Count--;
				}
			}
			else
			{
				`logd("Something Not Workin!Do more Evil here??");
				Count--;
			}

			//Destroy if we're out of ammo!
			if(Role == ROLE_Authority && count == 0)
			{
				rC = Max(1,Rand(9));
				Inv.SwitchWeapon(rC);
				Destroy();
			}
		}
		else
		{
			`logd("Random Weapon Maker Not Workin!");
		}
	}
}

defaultproperties
{
	count=1
	ActivateSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_JumpBoots_JumpCue'
	DeniedSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_JumpBoots_PickupCue'
	FizzleSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Berzerk_PowerLoopCue'

	WeaponsList(0)=Class'UTGame.UTWeap_LinkGun'
	WeaponsList(1)=Class'UTGameContent.UTWeap_BioRifle_Content'
//	WeaponsList(2)=Class'UTGame.UTWeap_Enforcer'
	WeaponsList(2)=Class'UTGame.UTWeap_FlakCannon'
	WeaponsList(3)=Class'UTGame.UTWeap_RocketLauncher'
	WeaponsList(4)=Class'UTGame.UTWeap_ShockRifle'
	WeaponsList(5)=Class'UTGame.UTWeap_SniperRifle'
	WeaponsList(6)=Class'UTGame.UTWeap_Stinger'

	MaxDesireability=1.000000
	RespawnTime=30.000000
	bReceiveOwnerEvents=False//True
	bDropOnDeath=True
	PickupMessage="Random Weapon"
//	bExportMenuData=False
//	bCanThrow=False
//	AmmoCount=1
//	LockerAmmoCount=1
//	MaxAmmoCount=1
	PickupSound=SoundCue'A_Pickups_Deployables.EMPMine.EMPMine_DropCue'
//	InventoryGroup=155
//	AttachmentClass=Class'Mutatoes.UTAttachment_RandomWeapon'
//	GroupWeight=0.510000
//	WeaponColor=(B=128,G=255,R=255,A=255)
//	PlayerViewOffset=(X=0.000000,Y=7.000000,Z=-9.000000)
	Begin Object Class=StaticMeshComponent Name=PickupMesh2 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
		StaticMesh=StaticMesh'PICKUPS.Deployables.Mesh.S_Deployables_SlowVolume_Cube'
		HiddenGame=True
		bUseAsOccluder=False
		CastShadow=False
		BlockActors=False
		BlockRigidBody=False
//		Translation=(X=-455.000000,Y=-200.000000,Z=0.000000)
//		Scale3D=(X=1.020000,Y=1.550000,Z=1.300000)
		Translation=(X=0.000000,Y=0.000000,Z=-10.000000)
		Scale3D=(X=0.040000,Y=0.040000,Z=0.060000)
	End Object

//	Begin Object /*Class=SkeletalMeshComponent*/ Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
//		SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
//		Translation=(X=0.000000,Y=0.000000,Z=0.000000)
//		Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
//		Scale3D=(X=0.250000,Y=0.250000,Z=0.250000)//SetScale3D(vector NewScale3D);
//		ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
//	End Object
	DroppedPickupMesh=PickupMesh2
	PickupFactoryMesh=PickupMesh2
}