class UT_ProjT_SeekingRocket extends UTProj_SeekingRocket;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MaxSpeed = default.MaxSpeed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MomentumTransfer = default.MomentumTransfer / class'UT_MDB_Turbo'.const.TurboSpeedP;
}