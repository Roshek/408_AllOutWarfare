_usewhitelist = false;
_admins = ["_SP_PLAYER_","76561198010042843","76561198010042843"];
// Change to true if you want to block non whitelisted players from using zeus slots, whitelist bellow :
// Replace "76561198010042843" by the steamID64 (google it) of the players you want to whitelist
// (keep "_SP_PLAYER_" for editor testing)

if (_usewhitelist) then {
	if (player == zeus1 || player == zeus2) then {
		if !(getPlayerUID player in _admins) then {
			failMission "END1";
		};
	};
};

// Safety
waitUntil {alive player};

// Disable negative score
player addEventHandler ["HandleRating", { if((_this select 1) < 0) then {0}; }];

// Disable player movement
//player enableSimulation false;

// Player fatigue
//if (paramsArray select 7 == 0) then {
//	player enableFatigue false;
//	player addEventhandler ["Respawn", {player enableFatigue false}];
//};

// BIS dynamic groups player side init
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

// Support requester
switch (paramsArray select 9) do
{
	case 0: {};
	case 1: {player synchronizeObjectsAdd [AOW_Support_Logistic];};
};

// Use saved loadout if it exist
_respawnloadout = profileNamespace getVariable "AOW_Respawn_Loadout_Check";
if (!isNil "_respawnloadout") then {
	[player, [profileNamespace, "AOW_Respawn_Loadout"]] call BIS_fnc_loadInventory;};

// Enable player movement
[] spawn {
	waitUntil {getMarkerColor "VVS1" != ""};
	sleep 1;
	player enableSimulation true;
	player switchMove "";
};

sleep 1;
player linkItem "ItemMap";
// If game just started then create base, if player jip or another player create base then teleport to base
if (player distance [0,0,0] < 1000 && isNil "baseFlagPole") then {
    waitUntil {!isNil "AOW_base_creation_player"};
    if (AOW_can_create_base && player == AOW_base_creation_player) then {
		AOW_can_create_base = false;
		publicVariable "AOW_can_create_base";
	    [] execVM "AOW_MissionCreator\BaseCreator\DialogBase.sqf";
	} else {
	hint localize "str_AOW_Respawn1";
	waitUntil {getMarkerColor "VVS1" != ""};
	player setPos [(getMarkerpos "respawn_west" select 0) + random 4 - random 4, (getMarkerpos "respawn_west" select 1) + random 4 - random 4,0];
	player setDir (markerDir "VVS1");
};
};
if (player distance [0,0,0] < 100 && !isNil "baseFlagPole") then {
	waitUntil {getMarkerColor "VVS1" != ""};
	player setPos [(getMarkerpos "respawn_west" select 0) + random 4 - random 4, (getMarkerpos "respawn_west" select 1) + random 4 - random 4,0];
	player setDir (markerDir "VVS1");
};