//===================================================
//	Class: UT_LMsg_Vampire
//	Creation date: 10/06/2008 11:48
//	Last updated: 26/06/2009 22:45
//	Contributors: OZX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_LMsg_Vampire extends LocalMessage;

var(Message) color Green, Red;

static function string GetString(
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
}

static function color GetColor(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if(Switch > 0)
		return default.Green;

	return default.Red;
}

defaultproperties
{
	Green=(B=0,G=255,R=0,A=255)
	Red=(B=0,G=0,R=255,A=255)
	bBeep=False
	Lifetime=1.000000
	PosY=0.650000	//0.650000
	FontSize=2
}
