//===================================================
//	Class: UT_MDI_Actor
//	Creation date: 13/12/2008 18:00
//	Last Updated: 14/04/2010 03:31
//	Contributors: 00zX
//---------------------------------------------------
//This class gets attached to actors for making adjustments.
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDI_Actor extends UT_MDI;

var array< class< Actor > > cUseforActors;

/** Make sure we have an owner and its the right type before moving on */
simulated event PostBeginPlay()
{
//	`logd("Owner:"$Owner,,'MDI_Weapon');

	if(Owner == None)
		Destroy();
	
	if(Allowed(Owner, true))
	{
		if(WorldInfo.NetMode != NM_Client)
			GetProps(Owner);

		SetTimer(UpdateRate, false, 'SetPropsTimer');
		SetTimer(DestroyTime, true, 'CheckOwner');
	}
}

function SetPropsTimer()
{
	SetProps(Owner);
}

/** Gets an Actors from the server */
reliable server function GetProps(Actor A);

/** Sets the client Actor derived from GetProps */
reliable client function SetProps(Actor A);

/** Searches an array of classes 'cUseforActors' and returns whether or not Get/Set Props is run for it. */
final function bool Allowed(Actor A, optional bool bUseforSubclasses=false)
{
	local class<Actor> UTAC;

	foreach cUseforActors(UTAC)
	{
		if(!bUseforSubclasses)
		{
			//if(A.IsA(UTAC))
			if(A.class == UTAC)
				return true;
		}
		else
		{
			if(ClassIsChildOf(A.Class, UTAC))
				return true;
		}
	}
	return false;
}

function CheckOwner()
{
	if(Owner == None)
	{
//		`logd("MDI: Info: "$self$".Destroy();",,'GameExp');
		Destroy();
	}
}

defaultproperties
{
	cUseforActors(0)=class'Actor'

	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}