//===================================================
//	Class: UT_MDB_ArrayFunc
//	Creation date: 27/08/2009 02:54
//	Last updated: 31/08/2009 03:53
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_ArrayFunc extends UT_MDB
	abstract;

struct CheckArray{
	var int Idx;
	var array<int> DupsIdx; //DupsCnt = DupsIdx.length
};

struct SortArray{
	var int Rank;
};

struct Limits
{
	var int upper;
	var int lower;
};

var bool bIsTest;

////
//

//native(191) static final function	float Exp   ( float A );

//const E = 2.71828182845904;
//const MAXFLOAT = 3.40282347e+38F
/*
#define M_E		2.7182818284590452354
#define M_LOG2E		1.4426950408889634074
#define M_LOG10E	0.43429448190325182765
#define M_LN2		0.69314718055994530942
#define M_LN10		2.30258509299404568402
#define M_PI		3.14159265358979323846
#define M_TWOPI         (M_PI * 2.0)
#define M_PI_2		1.57079632679489661923
#define M_PI_4		0.78539816339744830962
#define M_3PI_4		2.3561944901923448370E0
#define M_SQRTPI        1.77245385090551602792981
#define M_1_PI		0.31830988618379067154
#define M_2_PI		0.63661977236758134308
#define M_2_SQRTPI	1.12837916709551257390
#define M_SQRT2		1.41421356237309504880
#define M_SQRT1_2	0.70710678118654752440
#define M_LN2LO         1.9082149292705877000E-10
#define M_LN2HI         6.9314718036912381649E-1
#define M_SQRT3	1.73205080756887719000
#define M_IVLN10        0.43429448190325182765 // 1 / log(10)
#define M_LOG2_E        0.693147180559945309417
#define M_INVLN2        1.4426950408889633870E0  // 1 / log(2)
*/
////
//Generic Types
//static final function array<T> MergeObjArray(array<T> ObjArrayA, array<T> ObjArrayB, optional bool bCheckforDups);

//COMBIN(number,number_chosen)
//If number < 0, number_chosen < 0, or number < number_chosen, COMBIN returns the #NUM! error value.

//PERMUT(number,number_chosen)
//Returns the number of permutations for a given number of objects that can be selected from number objects.
//A permutation is any set or subset of objects or events where internal order is significant.
//Permutations are different from combinations, for which the internal order is not significant.
//Use this function for lottery-style probability calculations.
//If number <=0 or if number_chosen < 0, PERMUT returns the #NUM! error value.
//if number < number_chosen, PERMUT returns the #NUM! error value.



//INTERCEPT(known_y's,known_x's)
//SLOPE

//COVAR(array1,array2)
//the sample means AVERAGE(array1) and AVERAGE(array2), and n is the sample size.

//TTEST(array1,array2,tails,type)
//TDIST(x,degrees_freedom,tails)
//TINV(probability,degrees_freedom)

//LINEST(known_y's,known_x's,const,stats)
//y = mx + b
//y = m1x1 + m2x2 + ... + b

//LOGEST(known_y's,known_x's,const,stats)
//y = b*m^x
//y = (b*(m1^x1)*(m2^x2)*_)

//LOGINV(probability,mean,standard_dev)

defaultproperties
{
	bIsTest=false;
}