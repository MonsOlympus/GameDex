//===================================================
//	Class: UT_MDI	//Buffer
//	Creation date:	22/06/2008 10:11
//	Last updated: 15/03/2010 21:40
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI extends Info;

const DestroyTime = 25;	//10
const UpdateRate = 0.01;

//TODO: This might be called at different times, such as
//*when a player picks up an item		|Last Duration of Item (InventoryManager.HasItem)
//*when a player first spawns 			|Last Until Death (Destroy)
//										|Last Entire Match (ModifyPlayer)

var Inventory LinkedTo;
var bool bDestroyWithOwner;
var bool bInitOnMapStart;
var bool bTickable;

/* list of currently active timers*/
/*
struct native TimerData{
	var bool			bLoop;
	var Name			FuncName;
	var float			Rate, Count;
	var Object			TimerObj;
};var const array<TimerData>			Timers;
*/
simulated event PostBeginPlay()
{
	if(Owner == None)
		Destroy();

	if(bTickable)
		Enable('tick');
}

simulated event Tick(float DeltaTime)
{
	if(Owner == None ||	 !bTickable)
		Disable('tick');
}

//var const bool bNetOwner;         // Player owns this actor.

// double click move direction.
/*enum EDoubleClickDir
{
	DCLICK_None,
	DCLICK_Left,
	DCLICK_Right,
	DCLICK_Forward,
	DCLICK_Back,
	DCLICK_Active,
	DCLICK_Done
};*/

//TODO: Triple click - UC style contex?

/** The ticking group this actor belongs to */
//var const ETickingGroup TickGroup;

/** Changes the ticking group for this actor */
//native final function SetTickGroup(ETickingGroup NewTickGroup);

// SetRelativeRotation() sets the rotation relative to the actor's base
//native final function bool SetRelativeRotation( rotator NewRotation );
//native final function bool SetRelativeLocation( vector NewLocation );
//native final function noexport SetHardAttach(optional bool bNewHardAttach);

/**
 * Adds a component to the actor's components array, attaching it to the actor.
 * @param NewComponent - The component to attach.
 */
//native final function AttachComponent(ActorComponent NewComponent);

/**
 * Removes a component from the actor's components array, detaching it from the actor.
 * @param ExComponent - The component to detach.
 */
//native final function DetachComponent(ActorComponent ExComponent);

/*
native(280) final function SetTimer(float inRate, optional bool inbLoop, optional Name inTimerFunc='Timer', optional Object inObj);
native final function ClearTimer(optional Name inTimerFunc='Timer', optional Object inObj);
native final function bool IsTimerActive(optional Name inTimerFunc='Timer', optional Object inObj);
native final function float GetTimerCount(optional Name inTimerFunc='Timer', optional Object inObj);
native final function float GetTimerRate(optional name TimerFuncName = 'Timer', optional Object inObj);
*/