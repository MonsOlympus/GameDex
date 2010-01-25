//===================================================
//	Class: UT_MDB_ObjectList
//	Creation date: 24/08/2009 23:16
//	Last updated: 02/09/2009 00:34
//	Contributors: 00zX
//---------------------------------------------------
//Hybrid List - Contains a List of Objects
//This combines an array and linked list of objects,
//using a hook through an array of structs to find
//
//TODO: FIXME: No need for struct, just use array of Objects
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDB_ObjectList extends UT_MDB
	implements(iObjectList);
//	abstract;

/*struct ObjList{
	var object Obj;		//NextObj will always be Objs[i+1]
};
var protected array<ObjList> Objs;*/

var protected array<object> Objs;

/*struct CLObjList{
	var class<object> ClassLimitor;
	var array<ObjList> Objs;
};
var protected CLObjList ClassLimitedList;*/

var object owner;

var bool bAllowDuplicates;
//var bool bCallInitForSubObj;	//Will only work for objects of type GameRules

function init(){`logd(class.name$": Initalized!",,'ObjList');}

final function int Length(){return self.Objs.Length;}

function reset(){Objs.remove(0, self.Objs.Length);}

function Clear(){Objs.remove(0, self.Objs.Length);}

function bool isEmpty(){return (self.Objs.Length == 0) ? true : false;}

final function object Find(name ObjName)
{
	local object tObj;

	foreach self.Objs(tObj)
		if(tObj.name == ObjName)
			return tObj;

	return none;
}

final function bool Contains(object tObj)
{
	local int idx;
//	idx = self.Objs.Find('Obj', tObj);
	idx = self.Objs.Find(tObj);
	return (idx != INDEX_NONE) ? true : false;
}

final function int IndexOf(object tObj)
{
	local int idx;
//	idx = self.Objs.Find('Obj', tObj);
	idx = self.Objs.Find(tObj);
	return idx;
}

final function int NextIndex(object tObj)
{
	local int idx;
	idx=0;
	idx = IndexOf(tObj);
	return (idx != INDEX_NONE && self.Objs.Length < idx+1) ? INDEX_NONE : idx+1;
}

final function int PrevIndex(object tObj)
{
	local int idx;
	idx=0;
	idx = IndexOf(tObj);
	return (idx != INDEX_NONE && self.Objs.Length < idx-1) ? INDEX_NONE : idx-1;
}

//Allows object list to only contain classes of type (classLimitor)
final function limitclass(class<object> classLimitor)
{
	local object tObj;

	foreach self.Objs(tObj)
		if(tObj.class != classLimitor)
			self.Objs.removeitem(tObj);
//			self.Objs.remove(tObj);
}

//old array.add is via name?
final function Add(object Obj)
{
//	local object tObj;
//	local ObjList OList;

//	OList.Obj=tObj;
//	tObj=Obj;
//	if(Objs.length >= 1)
//		Objs[Objs.length-1].NextObj = testObj;
	self.Objs.AddItem(Obj);
}

final function Remove(object Obj)
{
	if(IndexOf(Obj) != INDEX_NONE)
		self.Objs.Remove(IndexOf(Obj), 1);
}

final function RemoveAt(int idx)
{
	//if(self.Objs[idx].Obj != none)
	if(self.Objs[idx] != none)
		self.Objs.Remove(idx,1);
}

final private function bool hasRange(int idx, int count)
{
	return (!isEmpty() && self.Objs.length >= idx+count) ? true : false;
}

final function RemoveRange(int idx, int count)
{
//	if(self.Objs[idx].Obj != none && self.hasRange(idx,count))
	if(self.Objs[idx] != none && self.hasRange(idx,count))
		self.Objs.Remove(idx,count);
}

//Getters
final function object GetObj(int idx)
{
//	return (self.Objs[idx].Obj != none) ? self.Objs[idx].Obj : none;
	return (self.Objs[idx] != none) ? self.Objs[idx] : none;
}

/*function Object getObject(string key)
{
	local int idx;
	idx = Objs.Find('key', key);
	return (idx > INDEX_NONE) ? self.Objs[idx].value : none;
}*/

final private function bool hasNext(object tObj)
{
	return (NextIndex(tObj) != INDEX_NONE && self.Objs.Length > 1) ? true : false;
}

final private function bool hasPrev(object tObj)
{
	return (PrevIndex(tObj) != INDEX_NONE) ? true : false;
}

final function object GetNext(object tObj)
{
//	`logd("InputObject: "$tObj$"["$IndexOf(tObj)$"] NextObject: "$self.Objs[NextIndex(tObj)].Obj$"["$NextIndex(tObj)$"]",,'ObjList');
	return (self.hasNext(tObj)) ? self.Objs[NextIndex(tObj)] : none;
	//return (self.hasNext(tObj)) ? self.Objs[NextIndex(tObj)].Obj : none;
}

final function object GetPrev(object tObj)
{
	return (self.hasPrev(tObj)) ? self.Objs[PrevIndex(tObj)] : none;
//	return (self.hasPrev(tObj)) ? self.Objs[PrevIndex(tObj)].Obj : none;
}

final function object GetFirst()
{
	return self.Objs[0];
//	return self.Objs[0].Obj;
}

final function object GetLast()
{
	return self.Objs[self.Objs.length];
//	return self.Objs[self.Objs.length].Obj;
}

/*final function class<object> GetType(object testObj)
{
	return (IndexOf(testObj) != INDEX_NONE) ? Objs[IndexOf(testObj)].Obj.super.class : none;
}*/

/** these accessors allow classes to implement an interface to setting certain property values without creating a dependancy
 * on that class, similarly to how IsA() allows checking for a class without creating a dependancy on it
 */
//function string GetSpecialValue(name PropertyName);
//function SetSpecialValue(name PropertyName, string NewValue);

function SetPropForAllObj(name PropertyName, string NewValue)
{
	local object tObj;
	//local int idx;

	//idx=0;
	foreach self.Objs(tObj)
	{
		//idx++;
		tObj.SetSpecialValue(PropertyName, NewValue);
		//if(UT_MDB_GameRules(tObj).GD != none)
		//	`logd(class.name$": ObjListItem"$idx$": "$UT_MDB_GameRules(tObj).GD,,'ObjectList');
	}
}

function DumpLogForAllObj(name OListName)
{
	local object tObj;
	local int idx;

	idx=0;
	foreach self.Objs(tObj)
	{
		idx++;
		`logd(OListName$": ListItem["$idx$"]: "$PathName(tObj),,'ObjList');
	}
}

//TODO: Make Generic version of this function using 'Owner' as a variable
//all objects contained in this list will contain an 'Owner' variable
/*function SetSpecialForGameData(UT_MDB_GameDex GD)
{
	local object tObj;
	local int idx;

	idx=0;
	foreach self.Objs(tObj)
	{
		idx++;
		//if(UT_MDB_GameRules(tObj) != none)
		if(tObj.IsA('UT_MDB_GameRules'))
		{
			UT_MDB_GameRules(tObj).GD=GD;
			`logd("ListItem["$idx$"]: GameData: "$PathName(UT_MDB_GameRules(tObj).GD),,'ObjList');
		}
	}
}*/

function SetSpecialGR()
{
	local object tObj;

	foreach self.Objs(tObj)
		UT_MDB_GameRules(tObj).SetNextGR();
}

function SetMasterGR(UT_GR_Info mGR)
{
	local object tObj;

	foreach self.Objs(tObj)
		UT_MDB_GameRules(tObj).MasterGR=mGR;
}

public function string getValue(int idx)
{
	return (self.Objs[idx] != none) ? self.Objs[idx].GetSpecialValue('Value') : "none";
}

public function string getType(int idx)
{
	return (self.Objs[idx] != none) ? self.Objs[idx].GetSpecialValue('DT') : "none";
}