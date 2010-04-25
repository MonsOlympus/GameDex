class UT_ProjT_StingerShard extends UTProj_StingerShard;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MaxSpeed = default.MaxSpeed * class'UT_MDB_Turbo'.const.TurboSpeedC;
	MomentumTransfer = default.MomentumTransfer / class'UT_MDB_Turbo'.const.TurboSpeedP;
}