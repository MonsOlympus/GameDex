//====================================================
//	Class: UT_MDB_GR_InfoAttachment
//	Creation Date: 13/04/2010 23:19
//	Last Updated: 13/04/2010 23:19
//	Contributors: 00zX
//----------------------------------------------------
//Moved InfoAttachments to UT_MDB_GameRules now there is a hook to CheckReplacement spawn through Master.Spawn();
//----------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//====================================================
class UT_MDB_GR_InfoAttachment extends UT_MDB_GameRules
	implements(MDIB_GR_CheckReplacement);

//TODO: Move to Provider?
struct ActorInfo
{
	var bool			bSpawnForSubClasses;
	var name			AttachedToActor;
	var class<UT_MDI>	AttachedInfo;			//It is possible 1 actor will have more than 1 attachment
};												//It would be faster in check replace to find next in an
var array<ActorInfo> InfoAttachments;			//AttachedInfo array rather than having a second or third entry

function bool CheckReplacement(Actor Other)
{
	local UT_MDI AttachedInfo;
	local int idx;

	//Spawn/Attach Info's
	if(Master != none && InfoAttachments.length >= 1)
	{
		idx = InfoAttachments.find('AttachedToActor', Other.class.name);
		if(idx != Index_None)
		{
			AttachedInfo = Master.Spawn(InfoAttachments[idx].AttachedInfo, Other);
			`logd("MDI: Info: "$AttachedInfo.name$" AttachedTo: "$InfoAttachments[idx].AttachedToActor$"."$Other,,'GameRules');
		}

		idx = InfoAttachments.find('bSpawnForSubClasses', true);
		if(idx != Index_None)
		{
			if(Other.IsA(InfoAttachments[idx].AttachedToActor))
			{
				AttachedInfo = Master.Spawn(InfoAttachments[idx].AttachedInfo, Other);
				`logd("MDI: Info: "$AttachedInfo.name$" AttachedTo: "$InfoAttachments[idx].AttachedToActor$"."$Other,,'GameRules');
			}
		}
	}
	return true;
}