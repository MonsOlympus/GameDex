//===================================================
//	Class: UT_LMsg_EnergyLeech
//	Creation date: 10/06/2008 17:08
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_LMsg_EnergyLeech extends UT_LMsg_Vampire;

var(Message) color Gold, Silver;

/*static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if(Switch > 0)
		return "+"$Switch;
	else
		return ""$Switch;
}*/

static function color GetColor(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if(Switch > 0)
		return default.Gold;

	return default.Silver;
}

defaultproperties
{
	Gold=(B=10,G=80,R=170,A=255)
	Silver=(B=100,G=100,R=100,A=255)
//	bBeep=False
//	Lifetime=1.000000
//	PosY=0.650000	//0.650000
//	FontSize=2
}