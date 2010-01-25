//===================================================
//	Class: UT_MDI_DeflectorTwo
//	Creation date: 17/09/2009 01:30
//	Last updated: 17/09/2009 01:30
//	Contributors: 00zX
//===================================================
class UT_MDI_DeflectorTwo extends UT_MDI;

var()	bool						bInitiallyOn;
var() 	float						BoostPower, BoostDamping;
//var()	array<class<UTVehicle> >	AffectedVehicles;

var		bool 						bCurrentlyActive;
var		array<UTProjectile>			ProjList;

simulated event PostBeginPlay()
{
	bCurrentlyActive = bInitiallyOn;

	// ttp 113322: Make sure the box is always hidden
	CollisionComponent.SetHidden(true);

	Disable('Tick');
}

function Trigger( Actor Other, Pawn EventInstigator )
{
	bCurrentlyActive = !bCurrentlyActive;
}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	local bool bFound;
	local UTProjectile UTP;

	UTP = UTProjectile(Other);

	if(UTP != None && bCurrentlyActive)
		bFound = TRUE;

	if(bFound)
	{
		ProjList[ProjList.Length] = UTP;
		Enable('Tick');

		// If we have a sound to play, and not dedicated server, play it
//		if(WorldInfo.NetMode != NM_DedicatedServer && UTV.BoostPadSound != None)
//			PlaySound(UTV.BoostPadSound, TRUE, , , UTV.Location);
	}
}

event UnTouch(Actor Other)
{
	local int Idx;
	local UTProjectile UTP;

	UTP = UTProjectile(Other);
	if(UTP != None)
	{
		Idx = ProjList.Find(UTP);

		if(Idx >= 0)
			ProjList.Remove(Idx, 1);
	}
}

simulated function vector CalculateForce(vector ProjLocation, vector ProjVelocity)
{
/*	local vector X,Y,Z;
	local vector BoostForce, BoostNormal;

//	GetAxes(rotation, X, Y, Z);

//	BoostForce = X * BoostPower;
//	BoostNormal = Normal(BoostForce);

//	BoostForce -= BoostNormal * (CarVelocity dot BoostNormal) * BoostDamping;

//	return BoostForce;*/
}

function Tick(float DT)
{
	local vector CalculatedForce;
	local int i;

	if(ProjList.Length == 0)
		Disable('Tick');

	if(bCurrentlyActive)
	{
		for (i = 0; i < ProjList.Length; i++)
		{
			CalculatedForce = CalculateForce(ProjList[i].Location, ProjList[i].Velocity);
//			ProjList[i].Mesh.AddForce(CalculatedForce);
		}
	}
}

/*DefaultProperties
{
	Begin Object Class=ArrowComponent Name=ArrowComponent0
		ArrowColor=(R=0,G=255,B=128)
		ArrowSize=5.5
		AlwaysLoadOnClient=False
		AlwaysLoadOnServer=False
	End Object
	Components.Add(ArrowComponent0)

	Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0
		StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
		Materials(0)=Material'Envy_Effects.Energy.Materials.M_EFX_Energy_Loop_Scroll_01'
		CollideActors=True
		CastShadow=False
		HiddenGame=True
		bAcceptsLights=False
		BlockRigidBody=False
		BlockActors=False
		BlockZeroExtent=False
		BlockNonZeroExtent=TRUE
		Scale3D=(X=2.0,Y=1.0,Z=0.4)
		bUseAsOccluder=FALSE
	End Object
	CollisionComponent=StaticMeshComponent0
	Components.Add(StaticMeshComponent0)

	BoostPower=1500
	BoostDamping=0.01

	bCollideActors=True
	bAlwaysRelevant=true
	bMovable=true
	bWorldGeometry=false
	bInitiallyOn=true
}*/