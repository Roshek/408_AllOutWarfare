// The server pick a player who will locate the base
[] execVM "missionStart.sqf";

// BIS dynamic groups server side init
["Initialize"] call BIS_fnc_dynamicGroups;

// Add every spawned unit to zeus editable objects
[] execVM "scripts\zeus.sqf";

// Time acceleration
if (paramsArray select 2 != 0) then {
		setTimeMultiplier (paramsArray select 2);
};