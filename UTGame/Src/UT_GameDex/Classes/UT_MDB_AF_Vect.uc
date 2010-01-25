//===================================================
//	Class: UT_MDB_AF_Vect
//	Creation date: 31/08/2009 03:44
//	Last updated: 09/00/2009 02:48
//	Contributors: 00zX
//---------------------------------------------------
//Vector Arrays
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_AF_Vect extends UT_MDB_ArrayFunc
	abstract;

struct Check extends CheckArray{
	var vector b;
};

static final function Sort(out CheckArray cObj);


////
//midrange - returns the midrange of a float array (sorted?)
static final function vector Midrange(array<vector> V, optional vector VectL, optional Limits L)
{
	local vector tV;

	if(V.length-1 != 0)
	{
		tV.X=(V[V.length-1].X+V[0].X)/2.0;
		tV.Y=(V[V.length-1].Y+V[0].Y)/2.0;
		tV.Z=(V[V.length-1].Z+V[0].Z)/2.0;
	}
	else
	{
		tV.X=V[0].X/2.0;
		tV.Y=V[0].Y/2.0;
		tV.Z=V[0].Z/2.0;
	}

	return tV;
}

//extents - returns 2 vectors for the upper and lower limits of a vector array