class UTM_NoDoubleJump extends UT_MDB_GameExp
	deprecated;

defaultproperties
{
	GroupNames(0)="POWERUPS"
	GroupNames(1)="JUMPING"

	PClass=class'UTOnePawn'

	Begin Object Class=UT_MDB_GR_UTOne Name=UT_MDB_GR_UTOne0
	End Object
	GR=UT_MDB_GR_UTOne0

//	ItemsToReplace(0)=(OldClassName="UTJumpBoots",NewInvType=class'UT_GameDex.UTSingleJumpBoots')

/*	Begin Object Class=UT_MDB_ItemReplacer Name=UT_MDB_FactoryReplacer0
		FactoriesSet[0]=(FactoryGroup=FT_Powerup,ReplacedFactory='',ReplacedWithFactory='',ReplacedWithFactoryPath="UT_GDP_Newtators.UTSingleJumpBoots")
	End Object
	FD=UT_MDB_FactoryReplacer0*/
}