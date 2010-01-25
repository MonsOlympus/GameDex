//===================================================
//	Class: UT_MDI_P_AntiCamp
//	Creation date: 16/03/2009 01:43
//	Last updated: 16/12/2008 01:43
//	Contributors: 00zX
//---------------------------------------------------
//This class gets attached to the pawn and makes adjustments.
//===================================================
class UT_MDI_WI_AntiCamp extends UT_MDI_WorldInfo;

//TODO: Spawn new actor, subclass and use those. Set Defaults... StaticClearConfig.

`include(MOD.uci)

//---------------------------------------------------
// Anti-Camper
struct LMSDataEntry
{
	var PlayerController	PC;
	var vector				LocationHistory[10];
	var int					NextLocHistSlot;
	var bool				bWarmedUp;
	var int					ReWarnTime;
};
var array<LMSDataEntry>	LMSData;

var float			CampThreshold;
var int				CamperWarnInterval;
var int				ReCamperWarnInterval;
var bool			bCamperAlarm;
//---------------------------------------------------

// Send camper warning
function SendCamperWarning(PlayerController Camper)
{
	local Controller C;//	local UTPlayerController C;

	//Humans only for now!
	foreach WorldInfo.AllControllers(class'Controller', C)
	{
		if(C != None)
		{
			// No one camps in the first 45 seconds
			if(WorldInfo.TimeSeconds - C.PlayerReplicationInfo.StartTime < 45)
				return;

			if(UTPlayerController(C) != None)
			{
				/*if(UTPlayerController(C) == Camper)
					UTPlayerController(C).ReceiveLocalizedMessage(class'Attrition.CamperMsg', 0);
				else
					UTPlayerController(C).ReceiveLocalizedMessage(class'Attrition.CamperMsg', 1, Camper.PlayerReplicationInfo);
				*/
			}
		}
	}
}

//TODO: IS GAMEINFO IN STATE MatchInProgress
//If So Start Timer!

// Camper-detector
State AntiCampActive
{
	simulated function BeginState(name PreviousStateName)
	{
		local GameInfo GI;

		GI = WorldInfo.Game;
		GI.IsInState('MatchInProgress');
//native(113) final function GotoState( optional name NewState, optional name Label, optional bool bForceEvents, optional bool bKeepStack );
		//SetTimer();
	}

	// GameInfo's already have a 1 second timer...
	function Timer()
	{
		local int i,j;
		local Box HistoryBox;		//TODO: Change to Sphere, vect+float(radius)
		local float MaxDim;
		local bool bSentWarning;
		local byte CampStage;
		local bool bStartCampPentalty;
		local int CampPentaltyFalloff;
		//local UT_PRI_Expansion PRI;

//		Super.Timer();

		// Do nothing else if camper alarm is off.
		if(!bCamperAlarm)
			return;

		i=0;
		while(i < LMSData.Length && !bSentWarning)
		{
			//Log( "Checking: "$LMSData[i].PC.PlayerReplicationInfo.PlayerName );

			//TODO: USE LINKED REPLICATION INFO
			if(LMSData[i].PC.PlayerReplicationinfo == None)
				return;

			//PRI = UT_PRI_Expansion(LMSData[i].PC.PlayerReplicationInfo);

			// If controller has expired (eg. left the game), remove the guard.
			if(LMSData[i].PC == None)
			{
				//Log("Expiring Camper Guard.");
				LMSData.Remove(i, 1);
			}
			else if(!LMSData[i].PC.PlayerReplicationinfo.bIsSpectator &&
					!LMSData[i].PC.PlayerReplicationinfo.bOnlySpectator /*&&
					!UTAttrition_PRI(PRI).bOutOfWeapons*/) // Spectators can't camp
			{
				if(LMSData[i].PC.Pawn == None)
					return;

				// Always update
				LMSData[i].LocationHistory[LMSData[i].NextLocHistSlot] = LMSData[i].PC.Pawn.Location;
				LMSData[i].NextLocHistSlot++;

				if(LMSData[i].NextLocHistSlot == 10)
				{
					LMSData[i].NextLocHistSlot = 0;
					LMSData[i].bWarmedUp = true;
				}

				//TODO: HISTORY CYLINDER/SPHERE?

				// If our history is full, work out how much player is moving about (find max AABB dimension).
				if(LMSData[i].bWarmedUp)
				{
					HistoryBox.Min.X = LMSData[i].LocationHistory[0].X;
					HistoryBox.Min.Y = LMSData[i].LocationHistory[0].Y;
					HistoryBox.Min.Z = LMSData[i].LocationHistory[0].Z;

					HistoryBox.Max.X = LMSData[i].LocationHistory[0].X;
					HistoryBox.Max.Y = LMSData[i].LocationHistory[0].Y;
					HistoryBox.Max.Z = LMSData[i].LocationHistory[0].Z;

					for(j=1; j<10; j++)
					{
						HistoryBox.Min.X = FMin(HistoryBox.Min.X, LMSData[i].LocationHistory[j].X );
						HistoryBox.Min.Y = FMin(HistoryBox.Min.Y, LMSData[i].LocationHistory[j].Y );
						HistoryBox.Min.Z = FMin(HistoryBox.Min.Z, LMSData[i].LocationHistory[j].Z );

						HistoryBox.Max.X = FMax(HistoryBox.Max.X, LMSData[i].LocationHistory[j].X );
						HistoryBox.Max.Y = FMax(HistoryBox.Max.Y, LMSData[i].LocationHistory[j].Y );
						HistoryBox.Max.Z = FMax(HistoryBox.Max.Z, LMSData[i].LocationHistory[j].Z );
					}

					// Find maximum dimension of box
					MaxDim = FMax(FMax(HistoryBox.Max.X - HistoryBox.Min.X, HistoryBox.Max.Y - HistoryBox.Min.Y), HistoryBox.Max.Z - HistoryBox.Min.Z);

					//Log("Box: "$HistoryBox.Max.X@HistoryBox.Max.Y@HistoryBox.Max.Z@HistoryBox.Min.X@HistoryBox.Min.Y@HistoryBox.Min.Z);
					//Log("Player: "$LMSData[i].PC.PlayerReplicationInfo.PlayerName$" MaxDim:"$MaxDim);

					// Dont warn the same person every second!
					if(MaxDim < CampThreshold && LMSData[i].ReWarnTime == 0 && !UTPawn(LMSData[i].PC.Pawn).InCombat())
					{
						//Log(LMSData[i].PC.PlayerReplicationInfo.PlayerName$" IS CAMPING! "$MaxDim);
						SendCamperWarning(LMSData[i].PC);

						if(CampStage == 1)
							LMSData[i].ReWarnTime = CamperWarnInterval;
						else
							LMSData[i].ReWarnTime = ReCamperWarnInterval;

						bSentWarning=true;
						CampStage++;

						if(CampStage >= 3)
						{
							CampPentaltyFalloff = 20;

							if(UTPawn(LMSData[i].PC.Pawn) != None)
								UTPawn(LMSData[i].PC.Pawn).Health -= CampPentaltyFalloff;

							bStartCampPentalty = true;
							CampStage = 0;
						}
					}
					else if(LMSData[i].ReWarnTime > 0){
						LMSData[i].ReWarnTime--;
					}else{
						CampStage = 0;
					}
/*					if(bStartCampPentalty && CampPentaltyFalloff >= 0)					{
						CampPentaltyFalloff -= 5;
						UTPawn(LMSData[i].PC.Pawn).Health -= CampPentaltyFalloff;
					}*/
				}

				i++;
			}
			else
				i++;
		}
	}
}




State AntiCampNotActive
{
	//End Timer, clean up and destroy!
}

defaultproperties
{
	//Camping Rules
	CampThreshold=512			//600
	CamperWarnInterval=8		//10
	ReCamperWarnInterval=3		//Starts taking health after the first re-warn
	bCamperAlarm=True			//False
}