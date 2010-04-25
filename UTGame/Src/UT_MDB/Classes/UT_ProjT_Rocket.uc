class UT_ProjT_Rocket extends UTProj_Rocket;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MaxSpeed = default.MaxSpeed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MomentumTransfer = default.MomentumTransfer / class'UT_MDB_Turbo'.const.TurboSpeedP;
}