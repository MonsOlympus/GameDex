//===================================================
//	Class: UT_MDI_Deflector
//	Creation date: 13/09/2009 04:52
//	Last updated: 13/09/2009 04:52
//	Contributors: 00zX
//===================================================
class UT_MDI_Deflector extends UT_MDI;

var float ForceRadius;

simulated event PostBeginPlay()
{
//	local int i;

	if(Owner == None)
		Destroy();

	SetTimer(0.05, true, 'DeflectTimer');
}

function DeflectTimer()
{
//	local vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z;
	local UTProjectile Proj;

	local vector dir;
	local float dist, strength;

	if(Owner == None)
		Destroy();

	// push aside projectiles
	ForEach VisibleCollidingActors(class'UTProjectile', Proj, ForceRadius, Owner.Location)
	{
//		if ( (Proj.Physics == PHYS_Projectile || Proj.Physics == PHYS_Falling)
	//		&& (Normal(Proj.Location - Owner.Location) Dot X) > 0.9 )
		if(Proj.Physics == PHYS_Projectile || Proj.Physics == PHYS_Falling)
		{
			//dir=Normal(Proj.Location - Owner.Location);	// pointing towards center of the deflector
			dir=Normal(Owner.Location - Proj.Location);	// pointing away from the center of the deflector?
			dist = VSize(Proj.Location - Owner.Location);
			strength =WorldInfo.WorldGravityZ * (2.1 - 2 * Square(dist / ForceRadius));

			//Proj.AddVelocity(dir * strength);	// automatically sets physics, etc.
			Proj.Velocity.X = Proj.Velocity.X + (dir.X*strength);
			Proj.Velocity.Y = Proj.Velocity.Y + (dir.Y*strength);
			Proj.Velocity.Z = Proj.Velocity.Z + (dir.Z*strength);
			//if ( (WorldInfo.WorldGravityZ != WorldInfo.DefaultGravityZ) && (Other.GetGravityZ() == WorldInfo.WorldGravityZ) )
				//P.Velocity *= sqrt(Other.GetGravityZ()/WorldInfo.DefaultGravityZ);


//			Proj.speed = VSize(Proj.Velocity);
//			if(Proj.Velocity Dot Y > 0)
//				P.Velocity = P.Speed * Normal(P.Velocity + (750 - VSize(P.Location - Owner.Location)) * Y);
//			else
//				P.Velocity = P.Speed * Normal(P.Velocity - (750 - VSize(P.Location - Owner.Location)) * Y);
		}
	}
}

defaultproperties
{
	ForceRadius=550
}
