//===================================================
//	Interface: MDIB_GR_ModifyPawnInfo
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyPawnInfo extends MDIB_GR_Modify;

simulated function ModifyPawnInfo(UT_GR_Info.PawnInfo PInfo, optional bool bRemoveBonus=false, optional int GlobalMultiplier)
{
	switch (PInfo.Type)
	{
		case ET_Infantry: break;
		case ET_Hero: break;
		case ET_Vehicle: break;
		case ET_Rook: break;
		case ET_Knight: break;
		case ET_Bishop: break;
		case ET_Turret: break;
	}
}