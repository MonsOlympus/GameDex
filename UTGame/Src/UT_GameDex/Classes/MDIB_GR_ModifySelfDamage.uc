//===================================================
//	Interface: MDIB_GR_ModifySelfDamage
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDIB_GR_ModifySelfDamage extends MDIB_GR_Modify
	dependson(UT_GR_Info);

function int ModifySelfDamage(UT_GR_Info.EnemyInfo Enemy);
