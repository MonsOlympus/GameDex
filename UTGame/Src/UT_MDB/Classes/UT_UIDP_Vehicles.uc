/**
* Provides data for a UT3 vehicle.
*
* Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
*/
class UT_UIDP_Vehicles extends UTUIResourceDataProvider
	PerObjectConfig;

//Could get this from TeamProvider!
enum VehicleTeam
{
	VT_None,
	VT_Axon,
	VT_Necris,
	VT_Liandri
};

/** The Vehicle class path */
var config string ClassName;

/** The VehicleFactory class path */
var config string FactoryClassName;

/** optional flags separated by pipes | that can be parsed by the UI as arbitrary options (for example, to exclude weapons from some menus, etc) */
var config string Flags;

var config VehicleTeam Team;

/** Friendly name for the vehicle */
var config localized string FriendlyName;

/** Description for the vehicle */
var config localized string Description;

/** String reference to the 3rd person mesh for this weapon.  This mesh is used in the UI. */
var config string MeshReference;

defaultproperties
{
   bSearchAllInis=True
//   Name="Default__UTUIDataProvider_Vehicle"
//   ObjectArchetype=UTUIResourceDataProvider'UTGame.Default__UTUIResourceDataProvider'
}