//===================================================
//	Class: UT_UIFE_Generic
//	Creation Date: 11/12/2007 22:21
//	Last Updated: 10/08/2008 23:11
//	Contributors: 00zX
//---------------------------------------------------
//Generic FrontEnd class for all Mutators to extend.
//*Takes care of button bar and callbacks.
//===================================================
class UT_UIFE_Generic extends UTUIFrontEnd;

//---------------------------------------------------
//var instanced UISafeRegionPanel pnlSafeRegion;
//---------------------------------------------------

var() string MutTitle;

//From CUSTOMIZEUT
// Check Setting Range Limits - Don't want any settings out of range (ini editing)
/*function float CheckSettingRange(float Setting,float MinValue,float DefaultValue,float MaxValue)
{
	if (Setting > MaxValue || Setting < MinValue)
	{
		//LogInternal("UTUI - Value Out Of Range"@"Setting MinValue:"@MinValue);
		//LogInternal("UTUI - Value Out Of Range"@"Setting Value:"@Setting);
		//LogInternal("UTUI - Value Out Of Range"@"Setting MaxValue:"@MaxValue);
		Setting = DefaultValue;
	}
	return Setting;
}
function OnAccept()
{
	// Player
	class'MutCustomizableUT.Mutator_UTCustomize'.default.CustomizedPlayer.fDodgeSpeed = CheckSettingRange(CustomizedPlayer.DodgeSpeed.GetValue(),300,600,900);
}
*/

/** Sets the title for this scene. */
function SetTitle()
{
	local string FinalStr;
	local UILabel TitleLabel;

	TitleLabel = GetTitleLabel();
	if ( TitleLabel != None )
	{
		if(TabControl == None)
		{
			FinalStr = Caps(MutTitle);
//			FinalStr = Caps(Localize("Titles", string(SceneTag), "UTGameUI"));
			TitleLabel.SetDataStoreBinding(FinalStr);
		}
		else
		{
			TitleLabel.SetDataStoreBinding("");
		}
	}
}

/** Sets up the scene's button bar. */
function SetupButtonBar()
{
	ButtonBar.Clear();
	ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Back>", OnButtonBar_Back);
	ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Accept>", OnButtonBar_Accept);
}

/** Callback for when the user wants to back out of this screen. */
function OnBack()
{
	CloseScene(self);
}

/** Callback for when the user accepts the changes. */
function OnAccept(){}

/** Buttonbar Callbacks. */
function bool OnButtonBar_Back(UIScreenObject InButton, int InPlayerIndex)
{
	OnBack();

	return true;
}

function bool OnButtonBar_Accept(UIScreenObject InButton, int InPlayerIndex)
{
	OnAccept();

	return true;
}

/** Provides a hook for unrealscript to respond to input using actual input key names (i.e. Left, Tab, etc.) */
function bool HandleInputKey(const out InputEventParameters EventParms)
{
	local bool bResult;

	bResult=false;

	if(EventParms.EventType==IE_Released)
	{
		if(EventParms.InputKeyName=='XboxTypeS_B' || EventParms.InputKeyName=='Escape')
		{
			OnBack();
			bResult=true;
		}
	}

	return bResult;
}
