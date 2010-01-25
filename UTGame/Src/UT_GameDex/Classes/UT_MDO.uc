//===================================================
//	Class: UT_MDO
//	Creation date: 29/08/2009 08:39
//	Last updated: 29/08/2009 08:39
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//	http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//===================================================
class UT_MDO extends UT_MDB;

/*var protected UT_MDB_ObjectList OList;
var UT_MDO_Element.DataType DataType;

public function int Length()
{
	return OList.Length();
}

public static function init(object owner,UT_MDO_Element.DataType DataType)
{
	if(OList == none)
	{
		OList = new(owner)class'UT_MDB_ObjectList';
		OList.owner = self;
		`logd("ObjectList:"$OList.name$" Initialized for: "$OList.owner,,'DataObjectList');
	}
}

public static function add(UT_MDO_Element Value)
{
	if(GetType(Value)== self.DataType)
		OList.Add(Value);
	else
		`logd("",,'DataObjectList');
}

public static function UT_MDO_Element get(int idx)
{
	return OList.GetObj(idx);
}

public static function string getValue(int idx, out UT_MDO_Element.DataType DataType)
{
	DataType= UT_MDO_Element.DataType(self.OList.getType(idx));
	return self.OList.getValue(idx);
}

/*public static function getValue(int idx)
{
	local int toInt;
	OList.getValue(idx);
}*/

private function int returnInt()
{

}*/
