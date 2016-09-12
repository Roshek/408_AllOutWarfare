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


//Markers
[] spawn {
while{not isnull Alpha1} do {"MAlpha1" setmarkerpos getpos Alpha1; sleep 1;};
};
[] spawn {
while{not isnull Alpha2} do {"MAlpha2" setmarkerpos getpos Alpha2; sleep 1;};
};
[] spawn {
while{not isnull Bravo1} do {"MBravo1" setmarkerpos getpos Bravo1; sleep 1;};
};
[] spawn {
while{not isnull Bravo2} do {"MBravo2" setmarkerpos getpos Bravo2; sleep 1;};
};


// Various Scripts
[] execVM "eos\OpenMe.sqf";
[] execVM "briefing.sqf";

// SHK Taskmaster
[[["DefaultTask",localize "str_AOW_Flag1",localize "str_AOW_Flag2",true]],[]] execvm "scripts\shk_taskmaster.sqf";

// Dynamic Weather
if (paramsArray select 3 != 5) then {[] execVM "scripts\randomWeather2.sqf"};

// QuickSilver fatigue
if (paramsArray select 7 == 2) then {[] execVM "scripts\QS_Fatigue.sqf"};

// Ambiant Combat
if (paramsArray select 11 != 0) then {[] execVM "LV\useambient.sqf";};

// Init variables
AOW_Checkbox = false;
AOW_Checkbox_ASORVS = false;
AOW_Selected_Spawner = 0;