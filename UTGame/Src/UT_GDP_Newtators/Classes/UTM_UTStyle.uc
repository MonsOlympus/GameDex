//===================================================
//	Class: UTM_UTStyle
//	Creation date: 13/09/2009 03:29
//	Last updated: 05/03/2010 22:58
//	Contributors: 00zX
//---------------------------------------------------
//TODO: Will Become UTM_Hardcore?!
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UTM_UTStyle extends UT_MDB_GameExp
	config(GDP_Newtators);

var config bool		bHardcore,
					bDualEnforcers,
					bNoDoubleJump,
					bNoWallDodge,
					bNoHelmet,
					bNoShieldDrops;

function GetServerDetails(out GameInfo.ServerResponseLine ServerState)
{
	local ActorInfo tInfo;
	local int i, idx;

	i = ServerState.ServerInfo.Length;

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "UT Style";
	ServerState.ServerInfo[i++].Value = "v0.8";

	if(bHardcore && bDualEnforcers && bNoDoubleJump && bNoWallDodge && bNoHelmet)
	{
		idx = GroupNames.find("POWERUPS");
		if(idx != INDEX_NONE)
			GroupNames.Additem("POWERUPS");

		idx = GroupNames.find("JUMPING");
		if(idx != INDEX_NONE)
			GroupNames.Additem("JUMPING");

		ImpartedDmgScale=1.25;

		tInfo.bSpawnForSubClasses=False;
		tInfo.AttachedToActor='UTWeap_Enforcer';
		tInfo.AttachedInfo=class'UT_GameDex.UT_MDI_W_EnforcerDual';
		InfoAttachments.Additem(tInfo);

		if(PClass != class'UT_GameDex.UTOnePawn')
			PClass=class'UT_GameDex.UTOnePawn';

		ServerState.ServerInfo.Length = i+1;
		ServerState.ServerInfo[i].Key = "Hardcore";
		ServerState.ServerInfo[i++].Value = "classic!";
	}
	else
	{
		if(bHardcore)
		{
			ImpartedDmgScale=1.25;

			ServerState.ServerInfo.Length = i+1;
			ServerState.ServerInfo[i].Key = "Hardcore";
			ServerState.ServerInfo[i++].Value = string(bHardcore);
		}
		else
		{
			ImpartedDmgScale=1.0;
		}

		if(bDualEnforcers)
		{
			tInfo.bSpawnForSubClasses=False;
			tInfo.AttachedToActor='UTWeap_Enforcer';
			tInfo.AttachedInfo=class'UT_GameDex.UT_MDI_W_EnforcerDual';
			InfoAttachments.Additem(tInfo);

			ServerState.ServerInfo.Length = i+1;
			ServerState.ServerInfo[i].Key = "Dual Enforcers";
			ServerState.ServerInfo[i++].Value = string(bDualEnforcers);
		}

		if(bNoDoubleJump)
		{
			idx = GroupNames.find("JUMPING");
			if(idx != INDEX_NONE)
				GroupNames.Additem("JUMPING");

			if(PClass != class'UT_GameDex.UTOnePawn')
				PClass=class'UT_GameDex.UTOnePawn';

			ServerState.ServerInfo.Length = i+1;
			ServerState.ServerInfo[i].Key = "No Double-Jump";
			ServerState.ServerInfo[i++].Value = string(bNoDoubleJump);
		}
		else
		{
			idx = GroupNames.find("JUMPING");
			if(idx != INDEX_NONE)
				GroupNames.removeitem("JUMPING");
		}

		if(bNoWallDodge)
		{
			idx = GroupNames.find("JUMPING");
			if(idx != INDEX_NONE)
				GroupNames.Additem("JUMPING");

			if(PClass != class'UT_GameDex.UTOnePawn')
				PClass=class'UT_GameDex.UTOnePawn';

			ServerState.ServerInfo.Length = i+1;
			ServerState.ServerInfo[i].Key = "No Wall-Dodge";
			ServerState.ServerInfo[i++].Value = string(bNoWallDodge);
		}
		else
		{
			idx = GroupNames.find("JUMPING");
			if(idx != INDEX_NONE)
				GroupNames.removeitem("JUMPING");
		}

		if(bNoHelmet)
		{
			idx = GroupNames.find("POWERUPS");
			if(idx != INDEX_NONE)
				GroupNames.Additem("POWERUPS");

			ServerState.ServerInfo.Length = i+1;
			ServerState.ServerInfo[i].Key = "No Helmet";
			ServerState.ServerInfo[i++].Value = string(bNoHelmet);
		}
		else
		{
			idx = GroupNames.find("POWERUPS");
			if(idx != INDEX_NONE)
				GroupNames.removeitem("POWERUPS");
		}

		if(bNoShieldDrops)
		{

		}
	}
}

defaultproperties
{
//	GroupNames(0)="POWERUPS"
//	GroupNames(1)="JUMPING"

	bHardcore=True
	bDualEnforcers=True
	bNoDoubleJump=True
	bNoWallDodge=True
	bNoHelmet=True

	Begin Object Class=UT_MDB_GR_UTOne Name=UT_MDB_GR_UTOne0
	End Object
	GR=UT_MDB_GR_UTOne0

//	ItemsToReplace(0)=(OldClassName="UTJumpBoots",NewInvType=class'UT_GameDex.UTSingleJumpBoots')

/*	Begin Object Class=UT_MDB_ItemReplacer Name=UT_MDB_FactoryReplacer0
		FactoriesSet[0]=(FactoryGroup=FT_Powerup,ReplacedFactory='',ReplacedWithFactory='',ReplacedWithFactoryPath="UT_GDP_Newtators.UTSingleJumpBoots")
	End Object
	FD=UT_MDB_FactoryReplacer0*/
}