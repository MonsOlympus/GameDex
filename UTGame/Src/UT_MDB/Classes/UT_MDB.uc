//===================================================
//	Class: UT_MDB	//Buffer
//	Creation Date:	12/12/2008 19:56
//	Last Updated: 11/04/2010 13:29
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB extends Object;

//---------------------------------------------------
//Ordered Pairs - duples

struct bRange
{
	var byte Min, Max;		//can find centerpoint
};

struct iRange
{
	var int Min, Max;
};

// Used to generate random values between Min and Max
struct fRange
{
	var float Min, Max;		//can find centerpoint
};
//---------------------------------------------------
//Calling Actor Hook (very skidish)
//	Redundant Function Calls!~
//var private Actor Master;
var protected Actor Master;
//var Actor Master;

final function SetMaster(Actor NM)
{
	Self.Master = NM;
}

final function SetTimer(float inRate, optional bool inbLoop, optional Name inTimerFunc='Timer')
{
	if(Self.Master != None)
		Self.Master.SetTimer(inRate, inbLoop, inTimerFunc, self);
}

final function ClearTimer(optional Name inTimerFunc='Timer')
{
	if(Self.Master != None)
		Self.Master.ClearTimer(inTimerFunc, self);
}

final function Spawn(
	class<actor>      SpawnClass,
	optional actor	  SpawnOwner,
	optional name     SpawnTag,
	optional vector   SpawnLocation,
	optional rotator  SpawnRotation,
	optional Actor    ActorTemplate,
	optional bool	  bNoCollisionFail)
{
	if(Self.Master != None)
		Self.Master.Spawn(SpawnClass, SpawnOwner, SpawnTag, SpawnLocation, SpawnRotation, ActorTemplate, bNoCollisionFail);
}

//---------------------------------------------------
static final function int Avg(int A, int B)
{
	return A + B / 2;
}

static final function float FAvg(float A, float B)
{
	return A + B / 2;
}

//Sign
//-1 : value is lower than 0
//0 : value is 0
//1 : value is higher than 0
static function int sign(float A)
{
	return clamp(int(A),-1,1);
}

//===================================================
event PostBeginPlay();