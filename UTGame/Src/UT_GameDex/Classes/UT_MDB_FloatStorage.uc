//===================================================
//	Class: UT_MDB_FloatStorage
//	Creation date: 11/09/2009 11:43
//	Last updated: 06/03/2010 14:42
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_FloatStorage extends UT_MDB_DataStorage
	implements(MDB_FloatStorage)
	config(DataStorage);
//	perobjectconfig;

var private array<Storage> LocalStore;
var config array<Storage> ConfigStore;
//var instanced array<Storage> iStore;

//Converts an array from the Storage to a DataSet.
function bool ToDataSet(Storage ToSet);

final function bool Contains(optional name tag='Default')
{
	local int idx;

	idx = self.LocalStore.find('tag', tag);
	if(idx == Index_None)
		return true;
	else return false;
}

//Assign: Append Array to Data Storage
final function Add(array<float> A, optional name tag='Default')
{
	local Storage TempStore;
	local float t;
	local int idx;

	idx = self.LocalStore.find('tag', tag);
	if(idx == Index_None)
	{
		TempStore.tag=tag;
		foreach A(t)
			TempStore.Data.Additem(t);

		self.LocalStore.Additem(TempStore);
	}
}

//UnAssign: Remove a Set of Value's from the Local Data Storage
final function Remove(optional out array<float> A, optional name tag='Default')
{
	local int idx;

	idx = self.LocalStore.find('tag', tag);
	if(idx != Index_None)
		self.LocalStore.Remove(idx,1);
}

//UnAssign: Trims a Set of Value's from the Local Data Storage
final function bool Trim(int B, optional int A=0, optional name tag='Default')
{
	local int idx;

	idx = self.LocalStore.find('tag', tag);
	if(idx != Index_None)
	{
		if(A == 0)
			self.LocalStore[idx].Data.Length = B;
		else
		{
			if(A < B)
			{
				if(self.LocalStore[idx].Data.Length > B)
					self.LocalStore[idx].Data.Remove(A,B-A);
				else return false;
			}
			else
			{
				if(self.LocalStore[idx].Data.Length > A)
					self.LocalStore[idx].Data.Remove(B,A-B);
				else return false;
			}
		}
		return true;
	}
	else return false;
}

//Slice?
//UnAssign: Trims a Set of Value's from the Local Data Storage
final function Cut(int Step, optional name tag='Default')
{
	local array<float> A;
	local int idx, j, tStep;

	idx = self.LocalStore.find('tag', tag);
	if(idx != Index_None)
	{
		tStep=0;
		for(j = 0;j < self.LocalStore[idx].Data.Length; j++)
		{
			tStep++;
			if(tStep != Step)
				A.Additem(self.LocalStore[idx].Data[j]);
			else
				tStep=0;
		}
		self.LocalStore[idx].Data.Remove(0,self.LocalStore[idx].Data.Length);
//		self.LocalStore[idx].Data.Additem(A);
//		self.LocalStore.Remove(idx,1);
//		self.LocalStore.Additem(A);
	}
}

//UnAssign: Remove a Set of Value's from the Local and Config Data Storage
final function Clear(optional name tag='Default')
{
	local int idx;

	idx = self.LocalStore.find('tag', tag);
	if(idx != Index_None)
		self.LocalStore.Remove(idx,1);

	idx = ConfigStore.find('tag', tag);
	if(idx != Index_None)
	{
		ConfigStore.Remove(idx,1);
		SaveConfig();
	}
}

//ReAssign: Overwrites current values if found or Appends where no values are found
final function Compress(int Step, optional name tag='Default')
{
	local array<float> A;
	local int idx, j, tStep, tSum;

	idx = self.LocalStore.find('tag', tag);
	if(idx != Index_None)
	{
		tStep=0;
		for(j = 0;j < self.LocalStore[idx].Data.Length; j++)
		{
			tStep++;
			if(tStep != Step)
				tSum += tSum;
			else
			{
				A.Additem(tSum/2);
				tSum=0;
				tStep=0;
			}
			//TODO: Condition for last remaining
		}
		self.LocalStore[idx].Data.Remove(0,self.LocalStore[idx].Data.Length);
//		self.LocalStore[idx].Data.Additem(A);
	}
}

//ReAssign: Overwrites current values if found or Appends where no values are found
final function Update(array<float> A, optional name tag='Default')
{
//	local float t;
	local int idx, j;

	idx = self.LocalStore.find('tag', tag);
	if(idx != Index_None)
	{
		if(A.Length == self.LocalStore[idx].Data.Length)
		{
			for(j = 0; j < A.Length; j++)
				if(j < self.LocalStore[idx].Data.Length)
					if(A[j] != self.LocalStore[idx].Data[j])
						self.LocalStore[idx].Data[j] = A[j];
				else
					self.LocalStore[idx].Data.Additem(A[j]);
		}
		else if(A.Length < self.LocalStore[idx].Data.Length)
		{
			self.LocalStore[idx].Data.Remove(A.Length,self.LocalStore[idx].Data.Length-A.Length);
			for(j=0; j < A.Length; j++)
				if(A[j] != self.LocalStore[idx].Data[j])
					self.LocalStore[idx].Data[j] = A[j];
		}
	}
}

//Append: If the same tag is found in both a full compare is run and only certain values are updated.
//ReAssign
/*final function bool Save(optional name tag='Default'){}*/

//Save: Compares Local Store and Config Store to see if they contain matching tags.
//Overwrite:
final function bool Save(optional name tag='Default')
{
	local int idx, odx;

	idx = self.LocalStore.find('tag', tag);
	if(idx == Index_None)
	{
		odx = ConfigStore.find('tag', tag);
		if(odx != Index_None)
			ConfigStore.Remove(odx,1);

		ConfigStore.additem(self.LocalStore[idx]);
		SaveConfig();
		return true;
	}else return false;
}

//Load: Compares Local Store and Config Store to see if they contain matching tags.
//Update: Local Store with Config Store and outs to Array.
final function bool Load(out array<float> A, optional name tag='Default')
{
	local int idx, odx;

	idx = ConfigStore.find('tag', tag);
	if(idx != Index_None)
	{
		odx = self.LocalStore.find('tag', tag);
		if(odx != Index_None)
			self.LocalStore.Remove(odx,1);

		self.LocalStore.Additem(ConfigStore[idx]);

		return true;
	}else return false;
}
