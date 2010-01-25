//===================================================
//	Class: UT_MDB	//Buffer
//	Creation date:	12/12/2008 19:56
//	Last Updated: 17/11/2009 04:08
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_MDB extends Object;


	//---------------------------------------------------
	//%PACKAGENAME%
	//UTMutator:		%GAMEEXPANSIONSUPERCLASS%
	//UT_MDB_GameExp:	%GAMEEXPANSIONCLASS%   (Class Name)
	//%LOGCLASSNAME% (Short Class Name)
	//---------------------------------------------------

/**
 * Breaks up a delimited string into elements of a string array.
 *
 * @param BaseString - The string to break up
 * @param Pieces - The array to fill with the string pieces
 * @param Delim - The string to delimit on
 * @param bCullEmpty - If true, empty strings are not added to the array
 */
//native static final function ParseStringIntoArray(string BaseString, out array<string> Pieces, string Delim, bool bCullEmpty);


/**
 * Returns the full path name of the specified object (including package and groups), ie CheckObject::GetPathName().
 */
//native static final function string PathName(Object CheckObject);

// Object handling.
//native static final function name GetEnum( object E, coerce int i );
//native static final function object DynamicLoadObject( string ObjectName, class ObjectClass, optional bool MayFail );
//native static final function object FindObject( string ObjectName, class ObjectClass );

//Returns the full path name of the specified object (including package and groups), ie CheckObject::GetPathName().
//native static final function string PathName(Object CheckObject);

// @return the name of the package this object resides in
//final function name GetPackageName()

// Configuration.
//native(536) final function SaveConfig();
//native static final function StaticSaveConfig();

/** Removes the values for all configurable properties in this object's class from the .ini file.
 * @param	PropertyName		if specified, only this property's value will be removed.
 */
//native(538) final function ClearConfig( optional string PropertyName );

/** Removes the values for all configurable properties in this object's class from the .ini file.
 * @param	PropertyName		if specified, only this property's value will be removed.
 */
//native static final function StaticClearConfig( optional string PropertyName );

// native static final function bool GetPerObjectConfigSections( class SearchClass, out array<string> out_SectionNames, optional Object ObjectOuter, optional int MaxResults=1024 );

//===================================================

//---------------------------------------------------
//Ordered Pairs - duples

struct bRange
{
	var() byte Min, Max;		//can find centerpoint
};

struct iRange
{
	var() int Min, Max;
};

// Used to generate random values between Min and Max
struct fRange
{
	var() float Min, Max;		//can find centerpoint
};

//===================================================

static final function int Avg(int A, int B)
{
	return A + B / 2;
}

static final function float FAvg(float A, float B)
{
	return A + B / 2;
}

//Sign
//-1 : value is lower than 0
//0 : value is 0
//1 : value is higher than 0
static function int sign(float A)
{
	return clamp(int(A),-1,1);
}

//===================================================