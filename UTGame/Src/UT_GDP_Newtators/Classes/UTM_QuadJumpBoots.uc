class UTM_QuadJumpBoots extends UT_MDB_GameExp;

defaultproperties
{
	GroupNames(0)="JUMPBOOTS"	//"POWERUPS"

	Begin Object Class=UT_MDB_ItemReplacer Name=UT_MDB_QuadJump_IR_0
		ReplacerSet(0)=(ReplaceItem="UTJumpBoots",WithItem=class'UT_GDP_Newtators.UTQuadJumpBoots')
	End Object
	IR=UT_MDB_QuadJump_IR_0
}