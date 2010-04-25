class UT_ProjT_LoadedRocket extends UTProj_LoadedRocket;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MaxSpeed = default.MaxSpeed * class'UT_MDB_Turbo'.const.TurboSpeedP;
//	MomentumTransfer = default.CustomizedRocketLauncher.fRocketMomentum;
}