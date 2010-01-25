//===================================================
//	Class: UT_MDB_NameStorage
//	Creation date: 11/09/2009 13:21
//	Last updated: 11/09/2009 13:21
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB_NameStorage extends UT_MDB_DataStorage
	config(DataStorage);
//	perobjectconfig;

struct Storage
{
	var name tag;
	var array<name> Data;
};
var private array<Storage> Store;
var config array<Storage> ConfigStore;
//var instanced array<Storage> iStore;

/**
 * Converts an array from the Storage to a DataSet.
 *
 * @param		ToSet		The Data from the storage to convert.
 * @return		true if successful.
 */
function bool ToDataSet(Storage ToSet){}

function Add(name tag, array<name> A)
{
	local Storage tStore;
	local name t;
	local int idx;

	idx = self.Store.find('tag', tag);
	if(idx == Index_None)
	{
		tStore.tag=tag;
		foreach A(t)
			tStore.Data.Additem(t);

		Store.Additem(tStore);
	}
//	if(tStore != none)
//		self.Store.Additem(tStore);
}

function Remove(name tag)
{
	local int idx;

	idx = self.Store.find('tag', tag);
	if(idx == Index_None)
		self.Store.Remove(idx,1);
}

function Update(name tag, array<name> A)
{
//	local name t;
	local int idx, j;

	idx = self.Store.find('tag', tag);
	if(idx != Index_None)
	{
		if(A.Length == self.Store[idx].Data.Length)
		{
			for(j=0;j<A.Length;j++)
				if(j < self.Store[idx].Data.Length)
					if(A[j] != self.Store[idx].Data[j])
						self.Store[idx].Data[j]=A[j];
				else
					self.Store[idx].Data.Additem(A[j]);
		}
		else if(A.Length < self.Store[idx].Data.Length)
		{
			self.Store[idx].Data.Remove(A.Length,self.Store[idx].Data.Length-A.Length);
			for(j=0;j<A.Length;j++)
				if(A[j] != self.Store[idx].Data[j])
					self.Store[idx].Data[j]=A[j];
		}
	}
}

function Save(name tag)
{
	local int idx;

	idx = self.Store.find('tag', tag);
	if(idx != Index_None)
		ConfigStore.additem(Self.Store[idx]);

	SaveConfig();
}

function array<name> Load(name tag)
{
	local int idx;

	idx = self.ConfigStore.find('tag', tag);
	if(idx != Index_None)
		return ConfigStore[idx].Data;
}