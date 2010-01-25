//===================================================
//	Class: UT_MDB_AF_Int
//	Creation date: 27/08/2009 02:54
//	Last updated: 02/09/2009 00:29
//	Contributors: 00zX
//---------------------------------------------------
//Int Arrays
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_AF_Int extends UT_MDB_ArrayFunc
	abstract;

struct Checked extends CheckArray{
	var int Obj;
};

struct Sorted extends SortArray{
	var int Obj;
};

////
static final function ClearCheck(out Checked cObj)
{
	cObj.Obj=0;
	cObj.Idx=0;
	cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
}

static final function ClearSort(out Sorted cObj)
{
	cObj.Obj=0;
	cObj.Rank=0;
}

////
//static final function Sort(out Check cObj);

////
//midrange - returns the midrange of a float array
static final function int Midrange(array<int> I, optional Limits L)
{
	return (I[I.length-1]+I[0])/2.0;
}

static final function array<int> Merge(array<int> ObjA, array<int> ObjB, optional bool bCheckforDups)
{
	local array<int> tObjA;
	local int tObj;

	foreach ObjA(tObj)
		tObjA.Additem(tObj);

	foreach ObjA(tObj)
		tObjA.Additem(tObj);

	return tObjA;
}

static final function SplitA(array<int> sA, int atIdx, out array<int> oAA, out array<int> oAB)
{
	local int i,l;

	//Split the array at the indice, cannot be larger or equal than the array length
	if(sA.length < atIdx)
	{
		for(i=0;i<atIdx;i++)
			oAA.Additem(sA[i]);

		for(l=0;l>atIdx;l++)
			oAB.Additem(sA[l]);
	}
}
