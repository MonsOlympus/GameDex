//===================================================
//	Class: UTSpeedBootEffect
//	Creation Date: 15/02/2008 18:12
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UTSpeedBootEffect extends UTJumpBootEffect;

var UTEmitter RightFootEmitter, LeftFootEmitter;

simulated function AttachToOwner()
{
	local vector SocketLocation;
	local rotator SocketRotation;

	`logd("Emitter Controller Attached!",,'SpeedBoots');

	if(OwnerPawn != None && OwnerPawn.Mesh != None)
	{
		if(OwnerPawn.Mesh.GetSocketWorldLocationAndRotation(OwnerPawn.PawnEffectSockets[0], SocketLocation, SocketRotation))
		{
			RightFootEmitter = Spawn(class'UTEmitter', OwnerPawn,, SocketLocation, SocketRotation);
			RightFootEmitter.LifeSpan=0;
/*			if(OwnerPawn.Mesh.bOwnerNoSee)
			{
				FootEmitter.ParticleSystemComponent.SetOwnerNoSee(true);
			}*/
			RightFootEmitter.SetBase(OwnerPawn,, OwnerPawn.Mesh, OwnerPawn.PawnEffectSockets[0]);
			RightFootEmitter.SetTemplate(JumpingEffect, true);
		}
		if(OwnerPawn.Mesh.GetSocketWorldLocationAndRotation(OwnerPawn.PawnEffectSockets[1], SocketLocation, SocketRotation))
		{
			LeftFootEmitter = Spawn(class'UTEmitter', OwnerPawn,, SocketLocation, SocketRotation);
			LeftFootEmitter.LifeSpan=0;
/*			if(OwnerPawn.Mesh.bOwnerNoSee)
			{
				FootEmitter.ParticleSystemComponent.SetOwnerNoSee(true);
			}*/
			LeftFootEmitter.SetBase(OwnerPawn,, OwnerPawn.Mesh, OwnerPawn.PawnEffectSockets[1]);
			LeftFootEmitter.SetTemplate(JumpingEffect, true);
		}
	}
}

//event Destroyed()
//event ShutDown()
function Destroyed()
{
	Super.Destroyed();

	`logd("Emitter Controller Destroyed!",,'SpeedBoots');
	RightFootEmitter.ParticleSystemComponent.SecondsBeforeInactive = 0.000001;
	LeftFootEmitter.ParticleSystemComponent.SecondsBeforeInactive = 0.000001;
/*	RightFootEmitter.ShutDown();
	LeftFootEmitter.ShutDown();
	ShutDown();*/
/*	RightFootEmitter.bCurrentlyActive = false;
	LeftFootEmitter.bCurrentlyActive = false;
	RightFootEmitter.ParticleSystemComponent.DeactivateSystem();
	LeftFootEmitter.ParticleSystemComponent.DeactivateSystem();

	RightFootEmitter.ParticleSystemComponent.SetActive(false);
	LeftFootEmitter.ParticleSystemComponent.SetActive(false);

	RightFootEmitter.LifeSpan=0.001;
	LeftFootEmitter.LifeSpan=0.001;

	LifeSpan=0.001;*/
}

defaultproperties
{
	LifeSpan=0.00000	//30
	JumpingEffect=ParticleSystem'Newtators_Pickups.Speedboots.Effects.P_SpeedBoot_Effect_C'
}