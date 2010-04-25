//===================================================
//	Class: UT_UIDP_Factories
//	Creation Date: 12/03/2010 22:41
//	Last Updated: 12/03/2010 22:41
//	Contributors: 00zX
//---------------------------------------------------
//	Attribution-Noncommercial-Share Alike 3.0 Unported
//	http://creativecommons.org/licenses/by-nc-sa/3.0/
//===================================================
class UT_UIDP_Factories extends UTUIResourceDataProvider
	PerObjectConfig;

/** Friendly name for the Factory, taken from the associated class or provider? */
var config localized string FriendlyName;

//var config string FactoryType;

/** The Factory class path */
var config string FactoryClassPath;

/** The Associated Class (vehicle, inventory item, etc */
var config string AttachedClassPath;
