/*
* Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
* jump boots drastically increase a player's double jump velocity
* New Jumpboots - fixed the fact JumpBoots rely on the double jump to be present to function correctly.
*/
class UTSingleJumpBoots extends UTJumpBoots;

/** adds or removes our bonus from the given pawn */
simulated function AdjustPawn(UTPawn P, bool bRemoveBonus)
{
	if(P != None)
	{
		if(bRemoveBonus)
		{
			if(P.CanDoubleJump==True)
				P.MultiJumpBoost -= MultiJumpBoost;
			else
				P.JumpZ -= MultiJumpBoost;

			P.MaxFallSpeed -= MultiJumpBoost;
			P.JumpBootCharge = 0;

			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
			if (P.Controller != None)
				P.Controller.HighJumpNodeCostModifier -= 1000;
		}
		else
		{
			if(P.CanDoubleJump==True)
				P.MultiJumpBoost += MultiJumpBoost;
			else
				P.JumpZ += MultiJumpBoost;

			P.MaxFallSpeed += MultiJumpBoost;
			P.JumpBootCharge = Charges;

			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
			if (P.Controller != None)
				P.Controller.HighJumpNodeCostModifier += 1000;
		}
	}
}

simulated function OwnerEvent(name EventName)
{
	if(Role == ROLE_Authority)
	{
//		if((EventName == 'MultiJump') || (EventName == 'Jump' && UTPawn(Owner).bCanDoubleJump == false))
		if(EventName == 'Jump' && UTPawn(Owner).bCanDoubleJump == false && !UTPawn(Owner).bIsWalking)
		{
			Charges--;
			UTPawn(Owner).JumpBootCharge = Charges;
			Spawn(class'UTJumpBootEffect', Owner,, Owner.Location, Owner.Rotation);
			Owner.PlaySound(ActivateSound, false, true, false);
		}
		else if(EventName == 'Landed' && Charges <= 0)
		{
			Destroy();
		}
	}
//	else if ((EventName == 'MultiJump') || (EventName == 'Jump' && UTPawn(Owner).bCanDoubleJump == false))
	else if(EventName == 'Jump' && UTPawn(Owner).bCanDoubleJump == false && !UTPawn(Owner).bIsWalking )
	{
		Owner.PlaySound(ActivateSound, false, true, false);
	}
}

/*defaultproperties
{
   MultiJumpBoost=750.000000
   Charges=3
   ActivateSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_JumpBoots_JumpCue'
   RanOutText="The Jump Boots have run out."
   bRenderOverlays=True
   bReceiveOwnerEvents=True
   bDropOnDeath=True
   RespawnTime=30.000000
   MaxDesireability=1.000000
   PickupMessage="Jump Boots"
   PickupSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_JumpBoots_PickupCue'
   Begin Object Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
	  StaticMesh=StaticMesh'PICKUPS.JumpBoots.Mesh.S_UN_Pickups_Jumpboots002'
	  bUseAsOccluder=False
	  CastShadow=False
	  bForceDirectLightMap=True
	  bCastDynamicShadow=False
	  CollideActors=False
	  BlockRigidBody=False
	  Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
	  Scale=1.700000
	  Name="StaticMeshComponent1"
	  ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=StaticMeshComponent1
   PickupFactoryMesh=StaticMeshComponent1
}*/