//===================================================
//	Interface: MDIB_GR_ModifyDamageTaken
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifyDamageTaken extends MDIB_GR_Modify
	dependson(UT_GR_Info);

static function int ModifyDamageTaken(UT_GR_Info.EnemyInfo Enemy, optional pawn Injured);
