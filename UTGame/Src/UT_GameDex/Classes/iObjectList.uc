//===================================================
//	Class: iObjectList
//	Creation date: 26/08/2009 15:26
//	Last updated:26/08/2009 15:26
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
interface iObjectList;

struct ObjList
{
	var object Obj;
	//NextObj will always be Objs[i+1]
};

function init();

final function int Length();

/**
 * Reset the session's data. The ID will stay the same.
 */
function reset();

function Clear();

function bool isEmpty();

final private function bool hasRange(int idx, int count);

final function object Find(name ObjName);

final function bool Contains(object tObj);

final function int IndexOf(object tObj);

final function int NextIndex(object tObj);

final function int PrevIndex(object tObj);

/**
 * Add an object to the List/Array
 */
final function Add(object tObj);

/**
 * Remove the entry with the given key
 */
final function Remove(object tObj);

final function RemoveAt(int idx);

final function RemoveRange(int idx, int count);

/**
 * Get an object instance from this session.
 */
final function object GetObj(int idx);

//function Object getObject(string key);

final private function bool hasNext(object tObj);

final private function bool hasPrev(object tObj);

final function object GetNext(object tObj);

final function object GetPrev(object tObj);

final function object GetFirst();

final function object GetLast();

function SetPropForAllObj(name PropertyName, string NewValue);

function DumpLogForAllObj(name OListName);

//function SetSpecialForGameData(UT_MDB_GameDex GD);