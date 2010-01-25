class UTOnePawn extends UTPawn;

var bool	bCanWallDodge;

event SetWalking(bool bNewIsWalking)
{
	if(bNewIsWalking != bIsWalking)
	{
		bIsWalking = bNewIsWalking;
//		ChangeAnimation();
//TODO: Adjust Anim Speed like TMPawn!
//TODO: Adjust footstep volume.
	}
}

function bool DoJump(bool bUpdating)
{
	// This extra jump allows a jumping or dodging pawn to jump again mid-air
	// (via thrusters). The pawn must be within +/- DoubleJumpThreshold velocity units of the
	// apex of the jump to do this special move.
/*	if (!bUpdating && CanDoubleJump()&& (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled())
	{
		if ( PlayerController(Controller) != None )
			PlayerController(Controller).bDoubleJump = true;
		DoDoubleJump(bUpdating);
		MultiJumpRemaining -= 1;
		return true;
	}*/

	if(bJumpCapable && !bIsCrouched && !bWantsToCrouch && (Physics == PHYS_Walking || Physics == PHYS_Ladder || Physics == PHYS_Spider))
	{
		if(Physics == PHYS_Spider)
			Velocity = JumpZ * Floor;
		else if(Physics == PHYS_Ladder)
			Velocity.Z = 0;
		else if(bIsWalking)
			Velocity.Z = Default.JumpZ;
		else
			Velocity.Z = JumpZ;

		if(Base != None && !Base.bWorldGeometry && Base.Velocity.Z > 0.f)
		{
			if((WorldInfo.WorldGravityZ != WorldInfo.DefaultGravityZ) && (GetGravityZ() == WorldInfo.WorldGravityZ))
				Velocity.Z += Base.Velocity.Z * sqrt(GetGravityZ()/WorldInfo.DefaultGravityZ);
			else
				Velocity.Z += Base.Velocity.Z;
		}
		SetPhysics(PHYS_Falling);
		InvManager.OwnerEvent('Jump');
		//bReadyToDoubleJump = true;
		bReadyToDoubleJump = false;
		bDodging = false;
		if(!bUpdating)
			PlayJumpingSound();
		return true;
	}
	return false;
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	if(Physics == PHYS_Falling)
		if(!bCanWallDodge)
			return false;

	return Super.Dodge(DoubleClickMove);
}

function bool PerformDodge(eDoubleClickDir DoubleClickMove, vector Dir, vector Cross)
{
	local float VelocityZ;

	if(Physics == PHYS_Falling)
		TakeFallingDamage();

	bDodging = true;
//	bReadyToDoubleJump = (JumpBootCharge > 0);
	bReadyToDoubleJump = false;
	VelocityZ = Velocity.Z;
	Velocity = DodgeSpeed*Dir + (Velocity Dot Cross)*Cross;

	if(VelocityZ < -200)
		Velocity.Z = VelocityZ + DodgeSpeedZ;
	else
		Velocity.Z = DodgeSpeedZ;

	CurrentDir = DoubleClickMove;
	SetPhysics(PHYS_Falling);
	SoundGroupClass.Static.PlayDodgeSound(self);
	return true;
}

defaultproperties
{
	WalkingPct=0.600000		//0.400000
	bCanWallDodge=false
}