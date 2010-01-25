class UT_ProjT_BioGlob extends UTProj_BioGlob;

var protected int gSpeedMult;	//1.3
var protected int gLifeMult;	//1.3

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * gSpeedMult;
	MaxSpeed = default.MaxSpeed * gSpeedMult;
	MomentumTransfer = default.MomentumTransfer / 1.3;
	GloblingSpeed = default.GloblingSpeed * 1.3;

	LifeSpan = default.LifeSpan / gLifeMult; //Could be longer
}

/**
 * Spawns several children globs
 */
simulated function SplashGloblings()
{
	local int g;
	local UTProj_BioShot NewGlob;
	local float GlobVolume;
	local Vector VNorm;

	if ( (GlobStrength > MaxRestingGlobStrength) && (UTPawn(Base) == None) )
	{
		if (Role == ROLE_Authority)
		{
			GlobVolume = Sqrt(GlobStrength);

			for (g=0; g<GlobStrength-MaxRestingGlobStrength; g++)
			{
				NewGlob = Spawn(class'UT_ProjT_BioGlobling', self,, Location+GlobVolume*6*SurfaceNormal);
				if (NewGlob != None)
				{
					// init newglob
					NewGlob.Velocity = (GloblingSpeed + FRand()*150.0) * (SurfaceNormal + VRand()*0.8);
					if (Physics == PHYS_Falling)
					{
						VNorm = (Velocity dot SurfaceNormal) * SurfaceNormal;
						NewGlob.Velocity += (-VNorm + (Velocity - VNorm)) * 0.1;
					}
					NewGlob.InstigatorController = InstigatorController;
				}
			}
		}
		SetGlobStrength(MaxRestingGlobStrength);
	}
}

defaultproperties
{
	gSpeedMult=1.3
	gLifeMult=1.3

	Begin Object Name=ProjectileMeshFloor ObjName=ProjectileMeshFloor Archetype=StaticMeshComponent'UTGameContent.Default__UTProj_BioGlob:ProjectileMeshFloor'
//		ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTProj_BioGlob:ProjectileMeshFloor'
	End Object
	GooLandedMesh=ProjectileMeshFloor
	Begin Object Name=HitWallFX ObjName=HitWallFX Archetype=ParticleSystemComponent'UTGameContent.Default__UTProj_BioGlob:HitWallFX'
//		ObjectArchetype=ParticleSystemComponent'UTGameContent.Default__UTProj_BioGlob:HitWallFX'
	End Object
	HitWallEffect=HitWallFX
	Begin Object Name=ProjectileSkelMeshAir ObjName=ProjectileSkelMeshAir Archetype=SkeletalMeshComponent'UTGameContent.Default__UTProj_BioGlob:ProjectileSkelMeshAir'
//		Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'UTGameContent.Default__UTProj_BioGlob:MeshSequenceA'
//			ObjectArchetype=AnimNodeSequence'UTGameContent.Default__UTProj_BioGlob:MeshSequenceA'
//		End Object
//		Animations=AnimNodeSequence'Mutatoes.Default__UTProj_TurboBioGlob:ProjectileSkelMeshAir.MeshSequenceA'
//		ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTProj_BioGlob:ProjectileSkelMeshAir'
	End Object
	GooMesh=ProjectileSkelMeshAir
	Begin Object Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_BioGlob:CollisionCylinder'
//		ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_BioGlob:CollisionCylinder'
	End Object
	CylinderComponent=CollisionCylinder
	Components(0)=CollisionCylinder
	Components(1)=ProjectileSkelMeshAir
	CollisionComponent=CollisionCylinder
}