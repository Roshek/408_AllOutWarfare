//
// ---------------------------------------- AOW V 2.8b ----------------------------------------------------
//

// Disable save/load that breaks scripts
enableSaving [false, false];

// Be sure that jip players wont have the initial base creation dialog
if (isNil "AOW_can_create_base") then {AOW_can_create_base = true;};

// Custom functions
call compile preprocessFile "functions.sqf";

// SHKpos and IEDs
call compile preprocessfile "SHK_pos\shk_pos_init.sqf";
[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};

//SThud
STHud_NoSquadBarMode = true;
STUI_Occlusion = false;

//AI radio
enableRadio false;

// Various Scripts
[] execVM "eos\OpenMe.sqf";
[] execVM "briefing.sqf";

// SHK Taskmaster
[[["DefaultTask",localize "str_AOW_Flag1",localize "str_AOW_Flag2",true]],[]] execvm "scripts\shk_taskmaster.sqf";

// Dynamic Weather
if (paramsArray select 3 != 5) then {[] execVM "scripts\randomWeather2.sqf"};

// Ambiant Combat
if (paramsArray select 11 != 0) then {[] execVM "LV\useambient.sqf";};

// Init variables
AOW_Checkbox = false;
AOW_Checkbox_ASORVS = false;
AOW_Selected_Spawner = 0;