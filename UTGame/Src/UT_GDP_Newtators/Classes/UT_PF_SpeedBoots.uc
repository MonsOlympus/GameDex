//===================================================
//	Class: UT_PF_SpeedBoots
//	Creation date: 19/05/2008 00:42
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_PF_SpeedBoots extends UTPickupFactory_JumpBoots;

defaultproperties
{
	PickupStatName="PICKUPS_SPEEDBOOTS"
	InventoryType=Class'UT_GDP_Newtators.UT_TPG_SpeedBoots'
	bHasLocationSpeech=False	//True
	BaseBrightEmissive=(R=0.500000,G=0.500000,B=0.500000,A=1.000000)
	BaseDimEmissive=(R=0.500000,G=0.500000,B=0.500000,A=1.000000)

	bStatic=False		//True
	bNoDelete=False		//True
}