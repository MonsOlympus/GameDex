//===================================================
//	Class: MDB_FloatStorage
//	Creation date: 06/03/2010 02:24
//	Last updated: 06/03/2010 14:29
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
interface MDB_FloatStorage extends MDB_DataStorage;

struct Storage
{
	var name tag;
	var array<float> Data;
};

function bool ToDataSet(Storage ToSet);

final function bool Contains(optional name tag='Default');

final function Add(array<float> A, optional name tag='Default');

final function Remove(optional out array<float> A, optional name tag='Default');

final function bool Trim(int B, optional int A=0, optional name tag='Default');

final function Cut(int Step, optional name tag='Default');

final function Clear(optional name tag='Default');

final function Compress(int Step, optional name tag='Default');

final function Update(array<float> A, optional name tag='Default');

final function bool Save(optional name tag='Default');

final function bool Load(out array<float> A, optional name tag='Default');