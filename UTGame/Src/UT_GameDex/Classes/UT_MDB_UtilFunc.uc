//===================================================
//	Class: UT_MDB_UtilFunc
//	Creation date: 09/09/2009 07:38
//	Last Updated: 10/09/2009 01:04
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_UtilFunc extends UT_MDB;

const PI2		= 6.2831853071795864;
/* sqrt(pi) */
const SQRTPI	= 1.7724538509055160;//27929816748334


//---------------------------------------------------
//Ordered Pairs - duples

/*struct bRange
{
	var() byte Min, Max;		//can find centerpoint
};

struct iRange
{
	var() int Min, Max;
};*/

struct iWeightedRange
{
	var() float StartPoint;
	var() int LinearRange;	//symetrical
};

// Used to generate random values between Min and Max
/*struct fRange
{
	var() float Min, Max;		//can find centerpoint
};*/

struct fWeightedRange
{
	var() float StartPoint;
	var() float LinearRange;	//symetrical
};

struct WeightedRange
{
	var float CenterPoint;
	var float MaxDeviation;
};

struct fRate
{
	var() float Amount, Interval;
};

// A point or direction vector in 2d space.
/*struct immutable Vector2D{
	var() float X, Y;
};
*/
//Magnitude (0,0)->(X,Y)

//Length=A->B=B->A
struct LineSegment
{
	var() float A, B;	//StartPoint, FinalPoint
};

struct LineSegment2D
{
	var() vector2D A, B;
};

struct Cubic
{
	var() vector2D Va, Vb;
};

//Spline control point
struct SplineCtrPt
{
	var vector p; //location
	var vector t; //tangent
};

//---------------------------------------------------
//Truples

// Vector of Ranges
struct fRangeVector
{
	var() fRange X;
	var() fRange Y;
	var() fRange Z;
};

//---------------------------------------------------
//Spline Cubic
struct SplineCubic
{
	var vector A,B,C,D;
	var float length; //Length ESTIMATE
};

//---------------------------------------------------
//Input

/** Digital Button Triple Click - Expansion from EDoubleClickDir */
//MB4 = Jump
enum ESingleClickDir
{
	TCLICK_None,		//Does not include jumps after dodging
	SCLICK_Left,		//^^< | VV< | >>< | <<<
	SCLICK_Right,		//^^> | VV> | >>> | <<>
	SCLICK_Forward,		//^^^ | VV^ | >>^ | <<^
	SCLICK_Back,		//^^V | VVV | >>V | <<V
	TCLICK_Active,
	TCLICK_Done,
};


/** Digital Button - Double Click */
enum EDoubleMouseClick
{
	DBCLICK_RMB,
	DBCLICK_MMB,
	DBCLICK_LMB,
	DBCLICK_MB4,
	DBCLICK_MB5,	//Scroll?X
	DBCLICK_MB6,	//Scroll?Y
	DBCLICK_MB7,	//Sensitivity UP
	DBCLICK_MB8,		//Sensitivity Down
};

/*	Scroller support*/

struct STripleClickDir
{
	var() EDoubleClickDir DCD;
	var() ESingleClickDir TCD;
};

//Input:Mouse
/*struct SDoubleMouseClick
{
	var() EDoubleClickDir DCD;
	var() EMouseButton MB;
};*/

//---------------------------------------------------

// Returns true if the given vectors are aproximately equal.
static final operator(24) bool ~=(vector A, vector B)
{
	return((A.x ~= B.x ) && (A.y ~= B.y) && (A.z ~= B.z));
}

static final function bool VectAproxEqual(vector A, vector B, float Allowance)
{
	return (	Abs(A.x-B.x) < Allowance &&
				Abs(A.y-B.y) < Allowance &&
				Abs(A.z-B.z) < Allowance );
}

// Returns vector perpendicular to given vector, ignoring z component.
static final function vector PerpendicularXY(vector V)
{
	local vector VOut;

	VOut.x = -V.y;
	VOut.y =  V.x;

	return VOut;
}

//TODO: Unreal2: Port PointInSphere!
/*
static final function bool IsLocationInSphere(
	vector SphereOrigin,
	float SphereRadius,
	vector TestLocation	)
{
	local bool bLocationInActorSphere;
	local vector Difference;
	local float ObjectDistance;

	//Log( "::Util::IsLocationInSphere" );
	Difference = TestLocation - SphereOrigin;
	ObjectDistance = VSize( Difference );

	//Log( "		ObjectDistance " $ ObjectDistance );
	//Log( "		SphereRadius " $ SphereRadius );
	//is the pawn close enough to the Item location
	bLocationInActorSphere = ( ObjectDistance <= SphereRadius );

	//Log( "::Util::IsLocationInSphere returning " $ bLocationInActorSphere );
	return bLocationInActorSphere;
}*/

//TODO: PARIAH: Port!


/*
  SeeSaw (xmatt)
  Desc: Discontinous positive function that first rises linearly up to y=1.0, then decreases linearly to y=0
	M		Slope of increase and decrease
	x		Where you are on the x-axis
  Assumptions:	x >= 0
				0 <= m < = PI/2
*/
//native(265) static final function     float SeeSaw ( float M, float x );

/*
  FakePIDResponse (xmatt)
  Desc: This minics the impulse response of a second order system. During R [s] there is a positive linear
		increase to the value 1.0, then a decaying ( or constant amplitude oscillating ) sinusoid takes over.
	R		Approximate risetime
	D		Decay of the oscillation
	x		Where you are on the x-axis
  Assumptions:	R > 0
				A >= 0
				x >= 0
*/
//native(268) static final function     float FakePIDResponse( float R, float A, float w, float D, float x );

/*
	Approx2DLength (xmatt)

	Desc: Approximate length of a 2D vector by approximating
	sqrt(X^2+Y^2) with the linear combination A*max(|X|,|Y|) + B*min(|X|,|Y|) + correction factor
	Note: Gets less precise with small numbers
*/
//native(228) static final function float Approx2DLength( vector A );

/*
	Approx2DSafeNormal (xmatt)

	Desc: Approximate normal of a 2D vector by using Approx2DLength
	Note: Gets less precise with small numbers
*/
//native(238) static final function float Approx2DSafeNormal( vector A );

/////////////
/*
CircularAddToDesired (xmatt)
Desc: Add to an angle but have it not pass a desired value
Note: This is done in PhysRotation, but I think it'd be useful to have it here
A - current
B - desired
C - delta
*/
//native		static final function int CircularAddToDesired( int A, int B, int C );

/*
CircularInterpToDesired (xmatt)
Desc: Add to an angle but have it not pass a desired value
Note: Charles had it in PlayerController, but I think it'd be useful to have it here
A - current
B - desired
C - alpha
*/
//native		static final function int CircularInterpToDesired( int A, int B, float C );

/*
SmallestAngle(xmatt)
Desc: The smallest angle between the angle of two rotators' component
*/
//native		static final function int SmallestAngle( int A, int B );