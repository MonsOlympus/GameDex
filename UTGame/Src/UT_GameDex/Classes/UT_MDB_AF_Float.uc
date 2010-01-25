//===================================================
//	Class: UT_MDB_AF_Float
//	Creation date: 27/08/2009 02:54
//	Last updated: 02/09/2009 00:29
//	Contributors: 00zX
//---------------------------------------------------
//Float Arrays
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_AF_Float extends UT_MDB_ArrayFunc
	abstract;

struct Checked extends CheckArray{
	var float Obj;
};

struct Sorted extends SortArray{
	var float Obj;
};

struct ComplexFloat{
	var float Rem;	//Remainder
	var int Exp;	//this is the amount of times we have MaxFloat
};

struct Packet{
	var array<float> Obj;
};

//TODO: Time versions for speed!
//native final function Clock(out float time);
//native final function UnClock(out float time);

////
//Scientific Operators
/*static final operator(34) ComplexFloat e+ (float Value, int Exponent)
{
	local ComplexFloat CFloat;

	CFloat.Rem = abs(value);
	CFloat.Exp = 10*Exponent;

	return CFloat;
}

static final operator(34) ComplexFloat e- (float Value, int Exponent)
{
	local ComplexFloat CFloat;

	CFloat.Rem = abs(value);
	CFloat.Exp = 10*Exponent;

	return CFloat;
}

static final operator(24) bool == (ComplexFloat A, ComplexFloat B)
{
	if(A.Exp != B.Exp)
		return false;
	else if(A.Exp == B.Exp && A.Rem != B.Rem)
		return false;
	return true;
}

static final operator(24) bool > (ComplexFloat A, ComplexFloat B)
{
	if(A.Exp < B.Exp)
		return false;
	else if(A.Exp >= B.Exp && A.Rem < B.Rem)
		return false;
	return true;
}

static final operator(24) bool < (ComplexFloat A, ComplexFloat B)
{
	if(A.Exp > B.Exp)
		return false;
	else if(A.Exp <= B.Exp && A.Rem > B.Rem)
		return false;
	return true;
}*/

////
static final function ClearCheck(out Checked cObj)
{
	cObj.Obj=0.0;
	cObj.Idx=0;
	cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
}

static final function ClearSort(out Sorted cObj)
{
	cObj.Obj=0.0;
	cObj.Rank=0;
}

////
//Utility functions
static final function Sort(out array<float> ObjA, optional Limits L)
{
	local array<Sorted> sObjA;
	local Sorted sObj;
	local int i,j;

//	ClearSort(sObj);
	sObj.Obj=0.0;
	sObj.Rank=0;

	for(i=0;i<ObjA.length;i++){
//		if(i+1 < ObjA.length) ? j+=1 : j=i;
		if(i+1 < ObjA.length) j+=1;else j=i;

		if(ObjA[i] >= ObjA[j]){
			sObj.Obj=ObjA[i];
			sObj.Rank=i;
			sObjA.Additem(sObj);
		}
//		else
//			cObjA[j].DupsIdx.Additem(i);
	}

	//TODO: Optimize here, no need to duplicate array into the struct!
//	ClearSort(sObj);
	sObj.Obj=0.0;
	sObj.Rank=0;
	ObjA.remove(0,ObjA.length);
	for(i=0;i<sObjA.length;i++)
		ObjA[sObjA[i].Rank]=sObjA[i].Obj;
}

/*simulated function SortPRIArray()
{
	local int i,j;
	local PlayerReplicationInfo tmp;

	for (i=0; i<PRIArray.Length-1; i++)
	{
	for (j=i+1; j<PRIArray.Length; j++)
	{
		if( !InOrder( PRIArray[i], PRIArray[j] ) )
		{
			tmp = PRIArray[i];
			PRIArray[i] = PRIArray[j];
			PRIArray[j] = tmp;
		}
	}
	}
}*/

// internal function for SortF
/*static private final function SortFArray(out array<float> ar, int low, int high)
{
	local int i,j,x,y;

	i = Low;
	j = High;
	x = ar[(Low+High)/2];

	do
	{
		while (ar[i] < x)
			i += 1;
		while (ar[j] > x)
			j -= 1;

		if (i <= j)
		{
			y = ar[i];
			ar[i] = ar[j];
			ar[j] = y;
			i += 1;
			j -= 1;
		}
	}
	until (i > j);

	if (low < j)
		SortFArray(ar, low, j);
	if (i < high)
		SortFArray(ar, i, high);
}*/

/*static final private function bool fContains(array<float> fA, array<float> fZ)
{
	local float TfA, TfZ;

	foreach fA(TfA)
		foreach fZ(TfZ)
			if(TfA == TfZ) return true;
	return false;
}*/

static final function array<float> Merge(array<float> ObjA, array<float> ObjB, optional bool bCheckforDups)
{
	local array<float> tObjA;
	local float tObj;

	foreach ObjA(tObj)		tObjA.Additem(tObj);
	foreach ObjB(tObj)		tObjA.Additem(tObj);

	return tObjA;
}

//TODO: Chew a monster array and spit out tiny parts for replication.
//NOTE: Static arrays only can be replicated! the PacketLength will be a const in effect.
/*struct ArrayPack
{
	array<float> Pick;
};
var array<ArrayPack> Packet;*/
//static final function array<array<float> > SplitToPackets(array<float> sA, int PackLength);

static final function SplitA(array<float> A, int atIdx, out array<float> oA, out array<float> oB)
{
	local int i,l;

	//Split the array at the indice, cannot be larger or equal to the array length
	if(A.length < atIdx)
	{
		for(i=0;i<atIdx;i++)
			oA.Additem(A[i]);

		for(l=0;l>atIdx;l++)
			oB.Additem(A[l]);
	}
}

//
static final function float SplitFind(float Obj, array<float> A, int numPak)
{
	local int idx, PakSize, DivM, PakCnt;

	idx=0;PakCnt=0;numPak=4;
	PakSize = A.length/numPak;
	DivM = Round(A.length-(A.length/numPak)*numPak);

	while(PakCnt < numPak && idx < PakSize)
	{
		if(idx == PakSize*PakCnt) PakCnt++;
		if(PakCnt == numPak) PakSize += DivM;
		if(Obj==A[idx]) return A[idx];
		idx++;
	}

	return 0;
}

static final function SplitToPak(array<float> A, int PakSize, out array<Packet> pakA)
{
	local int i, PakCnt;

	PakCnt=0;
	for(i=0;i<A.length;i++)
	{
		pakA[PakCnt].Obj.Additem(A[i]);

		if(PakCnt >= PakSize)
			PakCnt=0;
		else
			PakCnt++;
	}
}
static final function int FindPakIdx(float A, array<Packet> pakA)
{
	local int i, oi;

	for(i=0; i<pakA.length;i++)
		if(HasInPak(A,pakA[i],oi))
			return oi;

	return Index_None;
}

static final function bool HasInPak(float A, Packet pak, out int idx)
{
	idx=pak.Obj.find(A);
	return (idx!=Index_None) ? True : False;
}

//Specific Duplicates!
//TODO: Class only dups
static final function CleanDups(out array<float> ObjA)
{
	local array<Checked> cObjA;
	local Checked cObj;
	local int i,j;

	ClearCheck(cObj);

	//FIXING! can save, array.length in searches
/*	for(i=0;i<ObjArray.length;i++)	{
		for(j=0;j<cObjArray.length;j++)		{
			if(cObjArray[j].Obj == ObjArray[i])
				cObjArray[j].DupsIdx.Additem(i);
			else			{
				cObj.Obj=ObjArray[i];					//Object
				cObj.Idx=i;								//Original Array Indice
				cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
				cObjArray.Additem(cObj);					//Add to temp array
			}
		}
	}*/

	for(i=0;i<ObjA.length;i++){
//		if(i+1 < ObjA.length) ? j+=1 : j=i;
		if(i+1 < ObjA.length) j+=1;else j=i;

		if(ObjA[i] != ObjA[j]){
			cObj.Obj=ObjA[i];								//Object
//			cObj.Idx=i;										//Original Array Indice
			cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
			cObjA.Additem(cObj);							//Add to temp array
		}else
			cObjA[j].DupsIdx.Additem(i);
	}


	ObjA.remove(0,ObjA.length);
	foreach cObjA(cObj)
		ObjA.Additem(cObj.Obj);
}

////
//Statistical functions

/* MaxA - finds the largest member of an array */
static final function float MaxA(array<float> ObjA, optional Limits L)
{
	local float cMax;
	local int idx;

	if(ObjA.length-1 > 0)
		for(idx = 0; idx < ObjA.length; idx++)
			if(ObjA[idx] > cMax)
				cMax=ObjA[idx];
	else
		cMax=ObjA[0];

	return cMax;
}

/* MinA - finds the smallest member of an array */
static final function float MinA(array<float> ObjA, optional Limits L)
{
	local float cMin;
	local int idx;

	if(ObjA.length-1 > 0)
		for(idx = 0; idx < ObjA.length; idx++)
			if(ObjA[idx] < cMin)
				cMin=ObjA[idx];
	else
		cMin=ObjA[0];

	return cMin;
}

/* MinMaxA - finds the smallest and largest members of an array */
static final function MinMaxA(array<float> ObjA,out float cMin, out float cMax, optional Limits L)
{
	local int idx;

	if(ObjA.length-1 > 0)
	{
		for(idx = 0; idx < ObjA.length; idx++)
		{
			if(ObjA[idx] > cMax)
				cMax=ObjA[idx];
			if(ObjA[idx] < cMin)
				cMin=ObjA[idx];
		}
	}
	else
	{
		cMin=ObjA[0];
		cMax=ObjA[0];
	}
}

/* MaxIndexA - finds the index of the largest member of an array
 * if there is more than one largest value then we choose the first
 */
static final function int MaxIndexA(array<float> ObjA, optional Limits L)
{
	local float cMax;
	local int idx, odx;

	if(ObjA.length-1 > 0)
		for(idx = 0; idx < ObjA.length; idx++)
			if(ObjA[idx] > cMax)
			{
				cMax=ObjA[idx];
				odx=idx;
			}
	else
		odx=0;

	return odx;
}

/* MaxIndexA - finds the index of the smallest member of an array
 * if there is more than one largest value then we choose the first
 */
static final function int MinIndexA(array<float> ObjA, optional Limits L)
{
	local float cMin;
	local int idx, odx;

	if(ObjA.length-1 > 0)
		for(idx = 0; idx < ObjA.length; idx++)
			if(ObjA[idx] < cMin)
			{
				cMin=ObjA[idx];
				odx=idx;
			}
	else
		odx=0;

	return odx;
}

/* MinMaxA - finds the smallest and largest members of an array */
static final function MinMaxIndexA(array<float> ObjA,out float odxA, out float odxB, optional Limits L)
{
	local float cMin, cMax;
	local int idx;

	if(ObjA.length-1 > 0)
	{
		for(idx = 0; idx < ObjA.length; idx++)
		{
			if(ObjA[idx] > cMax)
			{
				cMax=ObjA[idx];
				odxB=idx;
			}
			if(ObjA[idx] < cMin)
			{
				cMin=ObjA[idx];
				odxA=idx;
			}
		}
	}
	else
	{
		odxA=0;
		odxB=0;
	}
}

//Average - which is the arithmetic mean,
///and is calculated by adding a group of numbers and then dividing by the count of those numbers.
///For example, the average of 2, 3, 3, 5, 7, and 10 is 30 divided by 6, which is 5.
static final function float AvgA(array<float> ObjA, optional Limits L)
{
	//local ComplexFloat CSumProd;
	local float SumProd;
	local int idx;

	//NOTE: SumProd could easily go outside of the 'type' range
	//as an eg, adding the max float +0.01 will return the maximum float will it not?
	//there needs to be special types which can be rounded

	//One solution would be to have the MaxFloat Value multiplied by an int value
	//every time the SumProd goes over MaxFloat.
	//The SumProd would end up being a remainer.
	//For Then, SumProd = SumProd + MaxFloat*ExpInt;
	//The Avg, Return float((SumProd+MaxFloat*ExpInt)/Obj.Length);

	//The Avg however would never end up over the MaxFloat
	//even if all Floats in the array were = MaxFloat the avg would be
	//equal to the maximum float value.

	//NOTE: The Exp cannot be greater than MaxInt.
	//I dont think its possible for arrays to be that larger than MaxInt but
	//the Exp must be less than Array.length.

	/*
	CSumProd.Rem = 0.0;
	for(idx = 0; idx < ObjA.length; idx++)
	{
		//Maxfloat: 3.4+10**38
		//Maxfloat: 3.403*10**38
		if((CSumProd.Rem + ObjA[idx]) >= 3.4+10**38){
			CSumProd.Exp += 1;
			CSumProd.Rem=0;
		}
		//MinFloat: 1.5-10**45
		//Minfloat: -3.403*10**38
		else if((CSumProd.Rem + ObjA[idx]) <= 1.5-10**45){
			CSumProd.Exp -= 1;
			CSumProd.Rem=0;
		}
		else
			CSumProd.Rem += ObjA[idx];
	}
	//FIXME: this doesnt take into account properly the negative Exponents.
	return float(NewSumProd.Rem+((3.4+10**38)*NewSumProd.Exp)/Obj.Length);
	*/

	SumProd = 0.0;
	for(idx = 0; idx < ObjA.length; idx++)
		SumProd += ObjA[idx];

	return SumProd / ObjA.length;	// this should return max float at worst@!
}
/*
double
FUNCTION (gsl_stats, mean) (const BASE data[], const size_t stride, const size_t size)
{
  // Compute the arithmetic mean of a dataset using the recurrence relation
  // mean_(n) = mean(n-1) + (data[n] - mean(n-1))/(n+1)

  long double mean = 0;
  size_t i;

  for (i = 0; i < size; i++)
	{
	  mean += (data[i * stride] - mean) / (i + 1);
	}

  return mean;
}*/

//Geometric Mean - magnitude of all variables in the array?
static final function float GeoMean(array<float> ObjA, optional Limits L)
{
	local float SumProd;
	local int idx;

	SumProd = 1.0;
	for(idx=0;idx<ObjA.length;idx++)
		SumProd *= ObjA[idx];

	// This calculation will not fail with negative elements.
	return Sign(SumProd) *Abs(SumProd) ^ 1.0/ObjA.Length;
}

//TrimMean
//calculates the mean taken by excluding a percentage of data points from the top and
//bottom tails of a data set. You can use this function when you wish to exclude outlying
//data from your analysis.
static final function TrimMean(out array<float> ObjA, float Pct)
{
//If percent < 0 or percent > 1, TRIMMEAN returns the #NUM! error value.

//TRIMMEAN rounds the number of excluded data points down to the nearest multiple of 2.
//If percent = 0.1, 10 percent of 30 data points equals 3 points. For symmetry, TRIMMEAN
//excludes a single value from the top and bottom of the data set.

	//get percentage from array.length
//	ObjA.length-2/2;

}

//STDEV - Estimates standard deviation based on a sample.
///The standard deviation is a measure of how widely values are dispersed from the average value (the mean).
static final function float STDev(array<float> ObjA, optional Limits L)
{
	local float AMean, Dev;
	local float tObj;

	//2 for/each deep!
	AMean=AvgA(ObjA);
	Dev=0.0;
	foreach ObjA(tObj)
		if(tObj > Dev)
			Dev = Abs(tObj);

	return Dev;
}

//midrange (without sort) - returns the midrange of a float array
static final function int Midrange(array<float> ObjA, optional Limits L)
{
	local float SumProd;
	local int idx;

	SumProd = 0.0;
	for(idx = 0; idx < ObjA.length; idx++)
		SumProd += ObjA[idx];

	return SumProd / 2.0;
}

//midrange (with sort) - returns the midrange of a float array
//static final function int Midrange(array<float> ObjA, optional Limits L)
//{
//	return (ObjA[ObjA.length-1]+ObjA[0])/2.0;// (ObjA[ObjA.length-1]+ObjA[0])/2.0;
//}

//Median - which is the middle number of a group of numbers;
///that is, half the numbers have values that are greater than the median,
///and half the numbers have values that are less than the median.
///For example, the median of 2, 3, 3, 5, 7, and 10 is 4.
static final function float Median(array<float> ObjA, optional Limits L)
{
	local int i;
	i=ObjA.length % 2;
	return (i == 0) ? (ObjA[ObjA.length/2] + ObjA[ObjA.length/2-1])/2.0 : ObjA[ObjA.length/2];
}

//returns a full array of medians
static final function array<float> MedianA(array<float> ObjA, optional Limits L)
{
	local array<float> tObjA;
	local int i,j;

	if(ObjA.length==1)
		Median(ObjA);
	else if(ObjA.length > 1){
		for(i=0;i<ObjA.length;i++){
			if(i+1 < ObjA.length){
				j+=1;
				tObjA.additem((ObjA[j/2]+ObjA[i/2])/2);
			}else{
				j=i;
				tObjA.additem((ObjA[i/2]+ObjA[j/2-1])/2);
			}
		}
	}
	return tObjA;
}

/*
double
FUNCTION(gsl_stats,median_from_sorted_data) (const BASE sorted_data[],
											 const size_t stride,
											 const size_t n)
{
  double median ;
  const size_t lhs = (n - 1) / 2 ;
  const size_t rhs = n / 2 ;

  if (n == 0)
	return 0.0 ;

  if (lhs == rhs)
	{
	  median = sorted_data[lhs * stride] ;
	}
  else
	{
	  median = (sorted_data[lhs * stride] + sorted_data[rhs * stride])/2.0 ;
	}

  return median ;
}*/

//Mode - which is the most frequently occurring number in a group of numbers.
///For example, the mode of 2, 3, 3, 5, 7, and 10 is 3.
static final function float Mode(array<float> ObjA, optional Limits L)
{
	local array<Checked> cObjA;
	local float cMode;
	local Checked cObj;
	local int i,j;

//	Clear(cObj);
/*	for(i=0;i<ObjArray.length;i++)	{
		for(j=0;j<ObjArray.length;j++)		{
			if(cObjArray[j].F == ObjArray[i])
				cObjArray[j].DupsIdx.Additem(i);
			else			{
				cObj.Obj=ObjArray[i];
				cObj.Idx=i;
				cObj.DupsIdx.remove(0,cObj.DupsIdx.length);
				cObjArray.Additem(cObj);
			}
		}
	}*/

	for(i=0;i<ObjA.length;i++){
//		if(i+1 < ObjA.length) ? j+=1 : j=i;
		if(i+1 < ObjA.length) j+=1;else j=i;

		if(ObjA[i] != ObjA[j]){
			cObj.Obj=ObjA[i];							//Object
//			cObj.Idx=i;										//Original Array Indice
			cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
			cObjA.Additem(cObj);						//Add to temp array
		}else
			cObjA[j].DupsIdx.Additem(i);
	}

	ClearCheck(cObj);
	foreach cObjA(cObj)
		if(cObj.DupsIdx.length > cMode)
			cMode = cObj.DupsIdx.length;

	return cMode;
}

////
//Standardize
//Returns a normalized value from a distribution characterized by mean and standard deviation.
static final function float Standardize(float ObjA, float Avg, float Dev)
{
	if(Dev > 0)
		return (ObjA - Dev / Avg);
	else
		return 0;
}

/*
static double
FUNCTION(compute,variance) (const BASE data[], const size_t stride, const size_t n, const double mean);

static double
FUNCTION(compute,tss) (const BASE data[], const size_t stride, const size_t n, const double mean);

static double
FUNCTION(compute,variance) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  // takes a dataset and finds the variance

  long double variance = 0 ;

  size_t i;

  // find the sum of the squares
  for (i = 0; i < n; i++)
	{
	  const long double delta = (data[i * stride] - mean);
	  variance += (delta * delta - variance) / (i + 1);
	}

  return variance ;
}

static double
FUNCTION(compute,tss) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  // takes a dataset and finds the sum of squares about the mean

  long double tss = 0 ;

  size_t i;

  // find the sum of the squares
  for (i = 0; i < n; i++)
	{
	  const long double delta = (data[i * stride] - mean);
	  tss += delta * delta;
	}

  return tss ;
}


double
FUNCTION(gsl_stats,variance_with_fixed_mean) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  const double variance = FUNCTION(compute,variance) (data, stride, n, mean);
  return variance;
}

double
FUNCTION(gsl_stats,sd_with_fixed_mean) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  const double variance = FUNCTION(compute,variance) (data, stride, n, mean);
  const double sd = sqrt (variance);

  return sd;
}



double
FUNCTION(gsl_stats,variance_m) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  const double variance = FUNCTION(compute,variance) (data, stride, n, mean);

  return variance * ((double)n / (double)(n - 1));
}

double
FUNCTION(gsl_stats,sd_m) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  const double variance = FUNCTION(compute,variance) (data, stride, n, mean);
  const double sd = sqrt (variance * ((double)n / (double)(n - 1)));

  return sd;
}

double
FUNCTION(gsl_stats,variance) (const BASE data[], const size_t stride, const size_t n)
{
  const double mean = FUNCTION(gsl_stats,mean) (data, stride, n);
  return FUNCTION(gsl_stats,variance_m)(data, stride, n, mean);
}

double
FUNCTION(gsl_stats,sd) (const BASE data[], const size_t stride, const size_t n)
{
  const double mean = FUNCTION(gsl_stats,mean) (data, stride, n);
  return FUNCTION(gsl_stats,sd_m) (data, stride, n, mean);
}


double
FUNCTION(gsl_stats,tss_m) (const BASE data[], const size_t stride, const size_t n, const double mean)
{
  const double tss = FUNCTION(compute,tss) (data, stride, n, mean);

  return tss;
}

double
FUNCTION(gsl_stats,tss) (const BASE data[], const size_t stride, const size_t n)
{
  const double mean = FUNCTION(gsl_stats,mean) (data, stride, n);
  return FUNCTION(gsl_stats,tss_m)(data, stride, n, mean);
}*/


//TODO: Covariance
/*
static double
FUNCTION(compute,covariance) (const BASE data1[], const size_t stride1,
							  const BASE data2[], const size_t stride2,
							  const size_t n,
							  const double mean1, const double mean2)
{
  // takes a dataset and finds the covariance

  long double covariance = 0 ;

  size_t i;

  // find the sum of the squares
  for (i = 0; i < n; i++)
	{
	  const long double delta1 = (data1[i * stride1] - mean1);
	  const long double delta2 = (data2[i * stride2] - mean2);
	  covariance += (delta1 * delta2 - covariance) / (i + 1);
	}

  return covariance ;
}

double
FUNCTION(gsl_stats,covariance_m) (const BASE data1[], const size_t stride1,
								  const BASE data2[], const size_t stride2,
								  const size_t n,
								  const double mean1, const double mean2)
{
  const double covariance = FUNCTION(compute,covariance) (data1, stride1,
														  data2, stride2,
														  n,
														  mean1, mean2);

  return covariance * ((double)n / (double)(n - 1));
}

double
FUNCTION(gsl_stats,covariance) (const BASE data1[], const size_t stride1,
								const BASE data2[], const size_t stride2,
								const size_t n)
{
  const double mean1 = FUNCTION(gsl_stats,mean) (data1, stride1, n);
  const double mean2 = FUNCTION(gsl_stats,mean) (data2, stride2, n);

  return FUNCTION(gsl_stats,covariance_m)(data1, stride1,
										  data2, stride2,
										  n,
										  mean1, mean2);
}*/

/*
gsl_stats_correlation()
  Calculate Pearson correlation = cov(X, Y) / (sigma_X * sigma_Y)
This routine efficiently computes the correlation in one pass of the
data and makes use of the algorithm described in:

B. P. Welford, "Note on a Method for Calculating Corrected Sums of
Squares and Products", Technometrics, Vol 4, No 3, 1962.

This paper derives a numerically stable recurrence to compute a sum
of products

S = sum_{i=1..N} [ (x_i - mu_x) * (y_i - mu_y) ]

with the relation

S_n = S_{n-1} + ((n-1)/n) * (x_n - mu_x_{n-1}) * (y_n - mu_y_{n-1})
*/

/*
double
FUNCTION(gsl_stats,correlation) (const BASE data1[], const size_t stride1,
								 const BASE data2[], const size_t stride2,
								 const size_t n)
{
  size_t i;
  long double sum_xsq = 0.0;
  long double sum_ysq = 0.0;
  long double sum_cross = 0.0;
  long double ratio;
  long double delta_x, delta_y;
  long double mean_x, mean_y;
  long double r;


  // * Compute:
  // * sum_xsq = Sum [ (x_i - mu_x)^2 ],
  // * sum_ysq = Sum [ (y_i - mu_y)^2 ] and
  // * sum_cross = Sum [ (x_i - mu_x) * (y_i - mu_y) ]
  // * using the above relation from Welford's paper

  mean_x = data1[0 * stride1];
  mean_y = data2[0 * stride2];

  for (i = 1; i < n; ++i)
	{
	  ratio = i / (i + 1.0);
	  delta_x = data1[i * stride1] - mean_x;
	  delta_y = data2[i * stride2] - mean_y;
	  sum_xsq += delta_x * delta_x * ratio;
	  sum_ysq += delta_y * delta_y * ratio;
	  sum_cross += delta_x * delta_y * ratio;
	  mean_x += delta_x / (i + 1.0);
	  mean_y += delta_y / (i + 1.0);
	}

  r = sum_cross / (sqrt(sum_xsq) * sqrt(sum_ysq));

  return r;
}*/
/*
double
FUNCTION(gsl_stats,skew) (const BASE data[], const size_t stride, const size_t n)
{
  const double mean = FUNCTION(gsl_stats,mean)(data, stride, n);
  const double sd = FUNCTION(gsl_stats,sd_m)(data, stride, n, mean);
  return FUNCTION(gsl_stats,skew_m_sd)(data, stride, n, mean, sd);
}

double
FUNCTION(gsl_stats,skew_m_sd) (const BASE data[],
							   const size_t stride, const size_t n,
							   const double mean, const double sd)
{
  // takes a dataset and finds the skewness

  long double skew = 0;
  size_t i;

  // find the sum of the cubed deviations, normalized by the sd.

  // we use a recurrence relation to stably update a running value so
  // there aren't any large sums that can overflow

  for (i = 0; i < n; i++)
	{
	  const long double x = (data[i * stride] - mean) / sd;
	  skew += (x * x * x - skew) / (i + 1);
	}

  return skew;
}*/