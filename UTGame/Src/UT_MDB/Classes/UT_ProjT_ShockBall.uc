class UT_ProjT_ShockBall extends UTProj_ShockBall;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * 1.3;
	MaxSpeed = default.MaxSpeed * 1.3;
	ComboMomentumTransfer = default.ComboMomentumTransfer / 1.3;
	MomentumTransfer = default.MomentumTransfer / 1.3;
}

defaultproperties
{
	Begin Object Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
//		ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
	End Object
	CylinderComponent=CollisionCylinder
	Components(0)=CollisionCylinder
	CollisionComponent=CollisionCylinder
}