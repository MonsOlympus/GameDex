//===================================================
//	Class: UTQuadJumpBoots
//	Creation date: 26/11/2007 12:00
//	Last updated: 19/05/2008 07:39
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//---------------------------------------------------
//Modified version of UTJumpBoots to support Quadjumps
//TODO: add proper bot support so they know how high they can jump
//===================================================
class UTQuadJumpBoots extends UTJumpBoots;

var int JumpsBoost;

/** sound to play when the boots are used */
var array<SoundCue> ActivationSounds;

/** adds or removes our bonus from the given pawn */
simulated function AdjustPawn(UTPawn P, bool bRemoveBonus)
{
	if(P != None)
	{
		if(bRemoveBonus)
		{
			P.MaxMultiJump = 1;
			P.MultiJumpRemaining = 1;
			P.MultiJumpBoost=-45;
			P.JumpBootCharge = 0;

			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
			if(P.Controller != None)
				P.Controller.HighJumpNodeCostModifier -= 400;	//1000
		}
		else
		{
			P.MaxMultiJump = JumpsBoost;
			P.MultiJumpRemaining = JumpsBoost;
			P.MultiJumpBoost=MultiJumpBoost;
			P.JumpBootCharge = Charges;

			// increase cost of high jump nodes so bots don't waste the boots for small shortcuts
			if(P.Controller != None)
				P.Controller.HighJumpNodeCostModifier += 400;	//1000
		}
	}
}

simulated function OwnerEvent(name EventName)
{
	if(Role == ROLE_Authority)
	{
		if(EventName == 'MultiJump')
		{
			Charges--;
			UTPawn(Owner).JumpBootCharge = Charges;
			Spawn(class'UTJumpBootEffect', Owner,, Owner.Location, Owner.Rotation);
			Owner.PlaySound(ActivateSound, false, true, false);
		}

		if(Charges <= 0)
		{
			Destroy();
		}
	}
	else if(EventName == 'MultiJump')
	{
		Owner.PlaySound(ActivateSound, false, true, false);
	}
}

defaultproperties
{
	JumpsBoost=3
	MultiJumpBoost=50.000000
	Charges=20
	ActivateSound=SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_JumpBoots_JumpCue'
	RanOutText="The Quad-Jump Boots have run out."
	bRenderOverlays=True
	bReceiveOwnerEvents=True
	bDropOnDeath=True
	RespawnTime=30.000000
	MaxDesireability=1.000000
	PickupMessage="Quad-Jump Boots"
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
	End Object
	DroppedPickupMesh=StaticMeshComponent1
	PickupFactoryMesh=StaticMeshComponent1
}