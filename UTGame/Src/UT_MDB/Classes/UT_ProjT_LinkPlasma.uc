class UT_ProjT_LinkPlasma extends UTProj_LinkPlasma;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Speed = default.Speed * class'UT_MDB_Turbo'.const.TurboSpeedP;
	MaxSpeed = default.MaxSpeed * class'UT_MDB_Turbo'.const.TurboSpeedC;
//	MomentumTransfer = default.MomentumTransfer / 1.3;
}