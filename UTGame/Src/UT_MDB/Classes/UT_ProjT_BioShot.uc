class UT_ProjT_BioShot extends UTProj_BioShot;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * 1.3;
	MaxSpeed = default.MaxSpeed * 1.3;
	MomentumTransfer = default.MomentumTransfer / 1.3;

	LifeSpan = default.LifeSpan / 1.3; //Could be longer
	RestTime = default.RestTime / 1.3;
	DripTime = default.DripTime / 1.3;
}

defaultproperties
{
	Begin Object Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'UTGameContent.Default__UTProj_BioShot:ProjectileMesh'
//		ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTProj_BioShot:ProjectileMesh'
	End Object
	Begin Object Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
//		ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
	End Object
	CylinderComponent=CollisionCylinder
	Components(0)=CollisionCylinder
	Components(1)=ProjectileMesh
	CollisionComponent=CollisionCylinder
}