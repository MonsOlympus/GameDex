//===================================================
//	Class: UT_MDB_AF_Obj
//	Creation date: 27/08/2009 02:54
//	Last updated: 02/09/2009 00:29
//	Contributors: 00zX
//---------------------------------------------------
//Object Arrays
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_AF_Obj extends UT_MDB_ArrayFunc
	abstract;

struct Checked extends CheckArray{
	var object Obj;
};

struct Sorted extends SortArray{
	var object Obj;
};

////
static final function ClearCheck(out Checked cObj)
{
	cObj.Obj=none;
	cObj.Idx=0;
	cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
}

static final function ClearSort(out Sorted cObj)
{
	cObj.Obj=none;
	cObj.Rank=0;
}

////

//static final function SortOA(out Check cObj);

//MergeObjArray
/*static final function array<object> MergeObjArray(out array<object> ObjArrayA, array<object> ObjArrayB, optional bool bCheckforDups)
{
	local array<object> tObjArray;
	local object tObj;

	foreach ObjArrayA(tObj)
		tObjArray.Additem(tObj);

	foreach ObjArrayA(tObj)
		tObjArray.Additem(tObj);

	return tObjArray;
}*/

//TODO: FIXMEDB B0RK3D!
/*
static final function AppendObjArray(out array<object> ObjArrayA, array<object> ObjArrayB, optional bool bCheckforDups)
{
	local object tObj;
	foreach ObjArrayA(tObj)
		ObjArrayA.Additem(tObj);
}*/

static final private function bool oContains(array<object> ObjA, object Obj, optional bool bCheckforDups)
{
	local object tObj;

	//Be careful of slowness, this is 3 for/each deep!
	if(bCheckforDups)
		CleanDups(ObjA);

	foreach ObjA(tObj)
		if(tObj == Obj) return true;
	return false;
}

/// Union  - of the sets A and B, denoted A \cup B, is the set whose members are members of at least one of A or B. The union of {1, 2, 3} and {2, 3, 4} is the set {1, 2, 3, 4}.
static final operator(122) array<object> cup (array<object> ObjA, array<object> ObjB)
{
//	local array<object> lObjA;
	local object tObjA,tObjB;

	foreach ObjA(tObjA)
		foreach ObjA(tObjB)
			if(tObjA != tObjB)
				ObjA.Additem(tObjA);
	return ObjA;
	//CleanArrayDups(ObjArrayA);
}
static final operator(122) array<float> cup (array<float> ObjA, array<float> ObjB)
{
}
/// Intersection -  of the sets A and B, denoted A \cap B, is the set whose members are members of both A and B. The intersection of {1, 2, 3} and {2, 3, 4} is the set {2, 3}.
static final operator(122) array<object> cap (array<object> ObjA, array<object> ObjB)
{
	local object tObjA,tObjB;

	foreach ObjA(tObjA)
		foreach ObjB(tObjB)
			if(tObjA == tObjB)
				ObjA.Additem(tObjA);
	return ObjA;
}

///Complement - of set A relative to set U, denoted \ A^c , is the set of all members of U that are not members of A. This terminology is most commonly employed when U is a universal set, as in the study of Venn diagrams. This operation is also called the set difference of U and A, denoted U \setminus A. The complement of {1,2,3} relative to {2,3,4} is {4}, while, conversely, the complement of {2,3,4} relative to {1,2,3} is {1}.
static final operator(122) array<object> - (array<object> ObjA, array<object> ObjB)
{
	local object tObjA,tObjB;

	foreach ObjA(tObjA)
		foreach ObjB(tObjB)
			if(tObjA == tObjB)
				ObjA.Removeitem(tObjA);

	return ObjA;
}

//Incorrect: will return 1 bool for all array values so on first match = true or false instead of iterator.
/*static final private function bool oContains(array<object> ObjArrayA, array<object> ObjArrayB)
{
	local array<object> tObjA,tObjB;

	foreach ObjArrayA(tObjA)
		foreach ObjArrayB(tObjB)
			if(tObjA == tObjB) return true;
	return false;
}*/

static final function SplitObjArray(array<object> sArray, int atIdx, out array<object> oAA, out array<object> oAB)
{
	local int i,l;

	//Split the array at the indice, cannot be larger or equal than the array length
	if(sArray.length < atIdx)
	{
		for(i=0;i<atIdx;i++)
			oAA.Additem(sArray[i]);

		for(l=0;l>atIdx;l++)
			oAB.Additem(sArray[l]);
	}
}

static final function SampleObjArray(array<object> sArray, int atIdx, int forLength, out array<object> oAA)
{
	local int i,l;

	//Takes a sample from the array between atIdx and forLength, for eg
	//sArray.length = 10
	//atIdx=3
	//forLength=7
	if(sArray.length < atIdx+forLength)
	{
		for(l=0;l>atIdx;l++)
			for(i=0;i<forLength;i++)
				oAA.Additem(sArray[i]);
	}
	//IntoArray will be 4 elements long
}

static final function InsertIntoObjArray(array<object> InsertArray, int insertionIdx, out array<object> IntoArray, optional bool bCheckforDups)
{
	local object tObj;

	if(IntoArray.length >= insertionIdx)
	{
		foreach InsertArray(tObj)
		{
			IntoArray.Insertitem(insertionIdx, tObj);
			insertionIdx++;
		}
	}
}

/*static final function array<object> InsertIntoObjArray(array<object> InsertArray, int insertionIdx, array<object> IntoArray, optional bool bCheckforDups)
{
	local array<object> tArrayPartA, tArrayPartB, tOutArray;
	local object tObjA, tObjB, tObjI;

	if(IntoArray.length >= insertionIdx)
	{
		Interactions.Insert(0, 1);


	if(IntoArray.length >= insertionIdx)
	{
		SplitObjArray(IntoArray, insertionIdx,tArrayPartA,tArrayPartB);

		foreach tArrayPartA(tObjA)
			tOutArray.Additem(tObjA);

		foreach InsertArray(tObjI)
			tOutArray.Additem(tObjI);

		foreach tArrayPartB(tObjB)
			tOutArray.Additem(tObjB);

		return tOutArray;
	}
	return none;
}*/

static final function array<object> ShuffleObjArray(array<object> ObjA)
{

}

//Specific Duplicates!
//TODO: Class only dups
static final function CleanDups(out array<object> ObjA)
{
	local array<Checked> cObjA;
	local Checked cObj;
	local int i,j;

	ClearCheck(cObj);
	for(i=0;i<ObjA.length;i++)
	{
		for(j=0;j<cObjA.length;j++)
		{
			if(cObjA[j].Obj == ObjA[i])
				cObjA[j].DupsIdx.Additem(i);
			else
			{
				cObj.Obj=ObjA[i];					//Object
				cObj.Idx=i;								//Original Array Indice
				cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
				cObjA.Additem(cObj);					//Add to temp array
			}
		}
	}

	ObjA.remove(0,ObjA.length);
	foreach cObjA(cObj)
		ObjA.Additem(cObj.Obj);
}

static final function array<object> CleanArrayDups(array<object> ObjArray)
{
	local array<object> tObjArray;
	local array<Checked> cObjArray;
	local Checked cObj;
	local int i,j;

	//Find dups by linear check
	//could speed this up by using multithreading on each for,
	//perhaps add a reverser and check top to bottom as well as bottom to top similtaneously

	ClearCheck(cObj);
	for(i=0;i<ObjArray.length;i++)
	{
		for(j=0;j<cObjArray.length;j++)
		{
			if(cObjArray[j].Obj == ObjArray[i])
				cObjArray[j].DupsIdx.Additem(i);
			else
			{
				cObj.Obj=ObjArray[i];					//Object
				cObj.Idx=i;								//Original Array Indice
				cObj.DupsIdx.remove(0,cObj.DupsIdx.length);	//Just incase!
				cObjArray.Additem(cObj);					//Add to temp array
			}
		}
	}

	//Make new array to out!
	ClearCheck(cObj);
	foreach cObjArray(cObj)
		tObjArray.Additem(cObj.Obj);

	return tObjArray;
}
