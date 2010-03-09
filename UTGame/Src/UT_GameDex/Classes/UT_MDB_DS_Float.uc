//===================================================
//	Class: UT_MDB_DS_Float
//	Creation date: 29/03/2009 00:00
//	Ported date: 10/09/2009 01:48
//	Last Updated: 06/03/2010 00:33
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_DS_Float extends UT_MDB_DataSet;

struct Point
{
	var name	N;					//Quantifier
	var	float	D;					//Field D->0=0->D
};

struct DataSet
{
	var name tag;					//Unique Identifier
	var array<float> Data;
	var int oldLen;					//Old Data.Length for change comparison
	var array<Point> NDPoint;		//Will store mean, avg, variance, etc
};
var DataSet DSet;

//var int				SampleSize;

////
//Init -
final function Init(array<float> inData, optional name tag='Default')
{
//	local Point P;
	local int i;
	local float tSum, tProd;
	local float cMin, cMax;

	for(i=0;i < inData.Length;i++)
	{
		DSet.Data.Additem(inData[i]);
		tSum += inData[i];
		tProd *= inData[i];

		if(inData[i] > cMax)
			cMax=inData[i];
		if(inData[i] < cMin)
			cMin=inData[i];
	}

	Let(tSum, 'Sum');
	Let(tProd, 'Product');
	Let(cMin, 'Minimum');
	Let(cMax, 'Maximum');
	DSet.oldLen=DSet.Data.Length;
}

simulated function Clear()
{
	local DataSet cSet;
	DSet=cSet;
}

// Append: Update Assigned with new array value
final function Update(float A, optional name tag='Default')
{
	DSet.Data.Additem(A);

	if(!SetData(GetData('Sum') + A, 'Sum'))
		`logd("Append: Failed @ Sum!",,tag);

	if(!SetData(GetData('Product') * A, 'Product'))
		`logd("Append: Failed @ Product!",,tag);

	if(GetData('Minimum') > A)
		if(!SetData(A, 'Minimum'))
			`logd("Append: Failed @ Minimum!",,tag);

	if(GetData('Maximum') < A)
		if(!SetData(A, 'Maximum'))
			`logd("Append: Failed @ Maximum!",,tag);
}

simulated function UpdateData(float A, optional name tag='Default')
{
	local array<int> idx;

	idx[0] = DSet.NDPoint.Find('N', 'Sum');
	if(idx[0] > -1) DSet.NDPoint[idx[0]].D+=A;
	idx[1] = DSet.NDPoint.Find('N', 'Product');
	if(idx[1] > -1) DSet.NDPoint[idx[1]].D*=A;

	idx[2] = DSet.NDPoint.Find('N', 'Minimum');
	if(idx[2] > -1) if(DSet.NDPoint[idx[2]].D>A) DSet.NDPoint[idx[2]].D=A;
	idx[3] = DSet.NDPoint.Find('N', 'Maximum');
	if(idx[3] > -1) if(DSet.NDPoint[idx[3]].D<A) DSet.NDPoint[idx[3]].D=A;

	idx[4] = DSet.NDPoint.Find('N', 'Mean');
	if(idx[4] > -1) DSet.NDPoint[idx[4]].D=DSet.NDPoint[idx[0]].D/DSet.Data.Length;

	idx[5] = DSet.NDPoint.Find('N', 'GeoMean');
	if(idx[5] > -1) DSet.NDPoint[idx[5]].D = Sign(DSet.NDPoint[idx[1]].D) *Abs(DSet.NDPoint[idx[1]].D) ^ 1.0/DSet.Data.Length;

}

simulated function bool SetData(float A, name me)
{
	local int idx;

	idx = DSet.NDPoint.find('N', me);
	if(idx > -1){
		DSet.NDPoint[idx].D=A;
		return true;
	}
	else return false;
}

simulated function float GetData(name me)
{
	local int idx;
	idx = DSet.NDPoint.Find('N', me);
	return (idx != INDEX_NONE) ? DSet.NDPoint[idx].D : 0.0f;
}

simulated function float GetAvg()
{
	return DSet.NDPoint[GetIdx('Average')].D;
}

//Arithimetic Mean
simulated function SetAvg()
{
	Let(DSet.NDPoint[GetIdx('Sum')].D/DSet.Data.Length, 'Average');
	//return DSet.NDPoint[GetIdx('Sum')]/Data.Length;
}

//Geometric Mean
simulated function SetMean()
{
	local float iProd;

	iProd = DSet.NDPoint[GetIdx('Product')].D;
	Let(Sign(iProd) *Abs(iProd) ^ 1.0/DSet.Data.Length, 'GeoMean');
}

//Standard Deviation
/*simulated function SetSTDev()
{
	local float aMean, tDev;

	if(GetIdx('Average') == Index_None)
		SetAvg();

	aMean = DSet.NDPoint[GetIdx('Average')].D;
	if(
}*/


////
//It doesnt matter what you call variable, the name is there for us!
//final function Let(float E,out name be)
final function Let(float E, name be)
{
	local Point P;

	P.D=E;
	P.N=be;
	DSet.NDPoint.Additem(P);
}

/* Associative array
:ASSIGN - Bind a new key to a new value
:REASSIGN - Or if key is found update it*/
/*final function Add(Point x)
{
	local Point P;
	local int idx;

	idx = DSet.NDPoint.find('N', x.N);
	if(idx > -1){
		P.D=E;
		P.N=be;
	}else{
		DSet.NDPoint.Additem(P);
	}
}*/

final function Point Get(name me)
{
	local Point P;
	local int idx;

	idx = DSet.NDPoint.Find('N', me);
	if(idx != INDEX_NONE)
		return DSet.NDPoint[idx];

	return P;
}

final function int GetIdx(name me)
{
	local int idx;

	idx = DSet.NDPoint.Find('N', me);
	return idx;
}

final function Rel(name me)
{
	local int idx;

	idx = DSet.NDPoint.Find('N', me);
	if(idx != INDEX_NONE)
		DSet.NDPoint.Removeitem(DSet.NDPoint[idx]);
}

defaultproperties
{
	//SampleSize=5
}