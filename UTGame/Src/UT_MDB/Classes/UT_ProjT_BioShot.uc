class UT_ProjT_BioShot extends UTProj_BioShot;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MaxSpeed = default.MaxSpeed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MomentumTransfer = default.MomentumTransfer / class'UT_MDB_Turbo'.const.TurboSpeedP;

	LifeSpan = default.LifeSpan / class'UT_MDB_Turbo'.const.TurboSpeedP; //Could be longer
	RestTime = default.RestTime / class'UT_MDB_Turbo'.const.TurboSpeedP;
	DripTime = default.DripTime / class'UT_MDB_Turbo'.const.TurboSpeedP;
}