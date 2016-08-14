if !(isServer) exitWith {};
//
// Mission
//
if !("DefaultTask" call SHK_Taskmaster_isCompleted) then {
    ["DefaultTask","succeeded"] call SHK_Taskmaster_upd;
};
_missionType = [_this, 0, ""] call BIS_fnc_param;
//
// FIND MISSION SPOT
//
private ["_mapCenter"];
_mapCenter = getMarkerPos "TempTask";
fn_AOW_findMissionSpot = {[_mapCenter,0,0, false] call SHK_pos;};
//
// Delete Old
//
_missionDetails = switch (_missionType) do {
	case "AOW_Make_sabotage": {if (getMarkerColor "AOW_Sabotage1" != "") then {
	deleteMarker "AOW_Sabotage1"; deletevehicle AOW_TS1 };
};
    case "AOW_Make_assassinate": {if (getMarkerColor "AOW_Assassinate1" != "") then {
    deleteMarker "AOW_Assassinate1"; deletevehicle AOW_TA1};
};
    case "AOW_Make_fdestroy": {if (getMarkerColor "AOW_Fdestroy1" != "") then {
    deleteMarker "AOW_Fdestroy1"; deletevehicle AOW_TFD1};
};
    case "AOW_Make_destroy": {if (getMarkerColor "AOW_Destroy1" != "") then {
    deleteMarker "AOW_Destroy1"; deletevehicle AOW_TD1};
};
    case "AOW_Make_extraction": {if (getMarkerColor "AOW_Extraction1" != "") then {
    deleteMarker "AOW_Extraction1"; deletevehicle AOW_TE1};
};
    case "AOW_Make_capture": {if (getMarkerColor "AOW_Capture1" != "") then {
    deleteMarker "AOW_Capture1"; deletevehicle AOW_TC1};
};
    case "AOW_Make_disarm": {if (getMarkerColor "AOW_Disarm1" != "") then {
    deleteMarker "AOW_Disarm1"; deleteMarker "AOW_Disarm2"; "IED1" call REMOVE_IED_SECTION;};
};
    case "AOW_Make_assault": {
    {
    if ((_x isKindOf "Building" && (_x distance getMarkerPos "AOW_Assault1") < 100) || (_x isKindOf "thingX" && _x distance getMarkerPos "AOW_Assault1" < 100)) then {
    deleteVehicle _x;};} foreach allMissionObjects "All"; sleep 0.5; {if ((_x isKindOf "Building" && (_x distance getMarkerPos "AOW_Assault1") < 100) || (_x isKindOf "thingX" && _x distance getMarkerPos "AOW_Assault1" < 100)) then {
    deleteVehicle _x;};} foreach allMissionObjects "All";
    if (getMarkerColor "AOW_Assault1" != "") then {
    deleteMarker "AOW_Assault1"; deleteVehicle AssaultTrigger;};
};
};
//
// SABOTAGE
//
fn_AOW_spawnSabotageMission = {
	_Smarker = createMarker ["AOW_Sabotage1", call fn_AOW_findMissionSpot];
    _Smarker setMarkerType "hd_objective";
    _Smarker setMarkerColor "ColorBlack";
    _Smarker setMarkerText localize "str_AOW_Sabotage1";
    _Smarker setMarkerSize [1,1];

	_Sveh = ["Land_TTowerSmall_1_F"] call BIS_fnc_selectRandom;

	AOW_TS1 = createVehicle [_Sveh,[(getMarkerpos _Smarker select 0) + random 50 - random 50, (getMarkerpos _Smarker select 1) + random 50 - random 50,0],[], 0, "NONE"];

    if !("Task1" call SHK_Taskmaster_hasTask) then {
    	    ["Task1",localize "str_AOW_Sabotage1",localize "str_AOW_Sabotage2"] call SHK_Taskmaster_add;
    	} else {["Task1","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";
	waitUntil {sleep 1; !alive AOW_TS1};
	deleteMarker "AOW_Sabotage1";
    ["Task1","succeeded"] call SHK_Taskmaster_upd;
};
//
// FIND AND DESTROY
//
fn_AOW_spawnFdestroyMission = {
	_FDmarker = createMarker ["AOW_Fdestroy1", call fn_AOW_findMissionSpot];
	_FDmarker setMarkerType "hd_objective";
	_FDmarker setMarkerColor "ColorBlack";
	_FDmarker setMarkerText localize "str_AOW_Find1";
	_FDmarker setMarkerSize [1,1];

	_FDveh = ["Box_IND_Ammo_F","Box_IND_Wps_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"] call BIS_fnc_selectRandom;

	AOW_TFD1 = createVehicle [_FDveh,[(getMarkerpos _FDmarker select 0) + random 50 - random 50, (getMarkerpos _FDmarker select 1) + random 50 - random 50,0],[], 0, "NONE"];

    if !("Task2" call SHK_Taskmaster_hasTask) then {
    	    ["Task2",localize "str_AOW_Find1",localize "str_AOW_Find2"] call SHK_Taskmaster_add;
    	} else {["Task2","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";
	waitUntil {sleep 1; !alive AOW_TFD1};
	deleteMarker "AOW_Fdestroy1";
    ["Task2","succeeded"] call SHK_Taskmaster_upd;
};
//
// ASSASSINATE
//
fn_AOW_spawnAssassinateMission = {
	_Amarker = createMarker ["AOW_Assassinate1", call fn_AOW_findMissionSpot];
	_Amarker setMarkerType "hd_objective";
	_Amarker setMarkerColor "ColorBlack";
	_Amarker setMarkerText localize "str_AOW_Assassinate1";
	_Amarker setMarkerSize [1,1];

    _Aciv = createGroup civilian;
    "rhs_vdv_officer_armored" createUnit [ [(getMarkerpos _Amarker select 0) + random 50 - random 50, (getMarkerpos _Amarker select 1) + random 50 - random 50,0], _Aciv,"AOW_TA1 = this"];
    //AOW_TA1 disableAI "MOVE";

    if !("Task3" call SHK_Taskmaster_hasTask) then {
    	    ["Task3",localize "str_AOW_Assassinate1",localize "str_AOW_Assassinate2"] call SHK_Taskmaster_add;
    	} else {["Task3","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";
	waitUntil {sleep 1; !alive AOW_TA1};
	deleteMarker "AOW_Assassinate1";
	["Task3","succeeded"] call SHK_Taskmaster_upd;
};
//
// DESTROY
//
fn_AOW_spawnDestroyMission = {
    _Dmarker = createMarker ["AOW_Destroy1", call fn_AOW_findMissionSpot];
	_Dmarker setMarkerType "hd_objective";
	_Dmarker setMarkerColor "ColorBlack";
	_Dmarker setMarkerText localize "str_AOW_Destroy1";
	_Dmarker setMarkerSize [1,1];

	_Dveh = ["rhs_2s3_tv","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80","rhs_t80a","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_zsu234_aa","rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_prp3_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_sprut_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv"] call BIS_fnc_selectRandom;
	AOW_TD1 = createVehicle [_Dveh,[(getMarkerpos _Dmarker select 0) + random 50 - random 50, (getMarkerpos _Dmarker select 1) + random 50 - random 50,0],[], 0, "NONE"];
    AOW_TD1 setVariable["AOW_NoCleanUp",true];

    if !("Task4" call SHK_Taskmaster_hasTask) then {
    	    ["Task4",localize "str_AOW_Destroy1",localize "str_AOW_Destroy2"] call SHK_Taskmaster_add;
    	} else {["Task4","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";
	waitUntil {sleep 1; !alive AOW_TD1};
	deleteMarker "AOW_Destroy1";
	["Task4","succeeded"] call SHK_Taskmaster_upd;
};
//
// EXTRACTION
//
fn_AOW_spawnExtractionMission = {
	_Emarker = createMarker ["AOW_Extraction1", call fn_AOW_findMissionSpot];
	_Emarker setMarkerType "hd_objective";
	_Emarker setMarkerColor "ColorBlack";
	_Emarker setMarkerText localize "str_AOW_Extraction1";
	_Emarker setMarkerSize [1,1];

    _Eciv = createGroup civilian;
    "rhsusf_army_ocp_squadleader" createUnit [ [(getMarkerpos _Emarker select 0) + random 50 - random 50, (getMarkerpos _Emarker select 1) + random 50 - random 50,0], _Eciv,"AOW_TE1 = this"];
    AOW_TE1 disableAI "ANIM";

    if !("Task5" call SHK_Taskmaster_hasTask) then {
    	    ["Task5",localize "str_AOW_Extraction1",localize "str_AOW_Extraction2"] call SHK_Taskmaster_add;
    	} else {["Task5","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";

    [[AOW_TE1, ["Follow me","[AOW_TE1] join group (_this select 1);",[],6,false,true,"",""]],"AOW_fnc_addAction",true,true] spawn BIS_fnc_MP;

    waitUntil {sleep 1; group AOW_TE1 != _Eciv || !(alive AOW_TE1)};
    AOW_TE1 enableAI "ANIM";
	if !(alive AOW_TE1) exitWith {deleteMarker "AOW_Extraction1"; ["Task5","failed"] call SHK_Taskmaster_upd;};

	waitUntil {sleep 1; AOW_TE1 distance (markerPos "respawn_west") < 70 || !(alive AOW_TE1)};
	if !(alive AOW_TE1) exitWith {deleteMarker "AOW_Extraction1"; ["Task5","failed"] call SHK_Taskmaster_upd};

    deletevehicle AOW_TE1;
	deleteMarker "AOW_Extraction1";
	["Task5","succeeded"] call SHK_Taskmaster_upd;
};
//
// CAPTURE
//
fn_AOW_spawnCaptureMission = {
	_Cmarker = createMarker ["AOW_Capture1", call fn_AOW_findMissionSpot];
	_Cmarker setMarkerType "hd_objective";
	_Cmarker setMarkerColor "ColorBlack";
	_Cmarker setMarkerText localize "str_AOW_Capture1";
	_Cmarker setMarkerSize [1,1];

    _Cveh = ["rhs_tigr_3camo_vdv","rhs_tigr_ffv_vdv","rhs_tigr_ffv_3camo_vdv","rhs_tigr_m_test","rhs_uaz_open_vdv","RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","RHS_BM21_VDV_01","rhs_typhoon_vdv","rhs_gaz66o_vdv"] call BIS_fnc_selectRandom;
    AOW_TC1 = createvehicle [_Cveh,[(getMarkerpos _Cmarker select 0) + random 50 - random 50, (getMarkerpos _Cmarker select 1) + random 50 - random 50,0],[], 0, "NONE"];
    AOW_TC1 setVariable["AOW_NoCleanUp",true];

    if !("Task6" call SHK_Taskmaster_hasTask) then {
    	    ["Task6",localize "str_AOW_Capture1",localize "str_AOW_Capture2"] call SHK_Taskmaster_add;
    	} else {["Task6","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";
	waitUntil {sleep 1; AOW_TC1 distance (markerPos "respawn_west") < 70 || !(alive AOW_TC1)};
    if !(alive AOW_TC1) exitWith {deleteMarker "AOW_Capture1"; ["Task6","failed"] call SHK_Taskmaster_upd;};

    AOW_TC1 setfuel 0;
    sleep 5;
    deletevehicle AOW_TC1;
	deleteMarker "AOW_Capture1";
    ["Task6","succeeded"] call SHK_Taskmaster_upd;
};
//
// DISARM
//
fn_AOW_spawnDisarmMission = {
	_DISmarker = createMarker ["AOW_Disarm1", call fn_AOW_findMissionSpot];
	_DISmarker setMarkerShape "RECTANGLE";
	_DISmarker setMarkerBrush "Solid";
	_DISmarker setMarkerColor "ColorBlack";
	_DISmarker setMarkerSize [50,50];
	_DISmarker setMarkerAlpha 0;

    _DISmarker2 = createMarker ["AOW_Disarm2", getMarkerpos "AOW_Disarm1"];
	_DISmarker2 setMarkerType "hd_objective";
	_Dismarker2 setMarkerColor "ColorBlack";
	_Dismarker2 setMarkerText localize "str_AOW_Disarm1";

    _IEDnmbr = [2,3,4,5] call bis_fnc_selectRandom;
    _IEDcheck1 = 1;

    ["IED1",["AOW_Disarm1", _IEDnmbr, [0,10,60,30],["West","East","GUER","CIV"]]] call CREATE_IED_SECTION;

    if !("Task7" call SHK_Taskmaster_hasTask) then {
    	    ["Task7",localize "str_AOW_Disarm1",localize "str_AOW_Disarm2"] call SHK_Taskmaster_add;
    	} else {["Task7","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";
while {_IEDcheck1 > 0} do { sleep 1;
_IEDcheck1 = "IED1" call GET_REMAINING_IED_COUNT;
};

waitUntil {_IEDcheck1 == 0};
_IEDcheck2 = "IED1" call GET_IED_SECTION_INFORMATION;
_IEDdisarmed = _IEDcheck2 select 1;
_IEDexploded = _IEDcheck2 select 0;
if (_IEDexploded > _IEDdisarmed || _IEDexploded == _IEDdisarmed) then {
    ["Task7","failed"] call SHK_Taskmaster_upd;
	deleteMarker "AOW_Disarm1";
	deleteMarker "AOW_Disarm2";
	sleep 3;
	"IED1" call REMOVE_IED_SECTION;
};
if (_IEDexploded < _IEDdisarmed) then {
    ["Task7","succeeded"] call SHK_Taskmaster_upd;
	deleteMarker "AOW_Disarm1";
	deleteMarker "AOW_Disarm2";
	sleep 3;
	"IED1" call REMOVE_IED_SECTION;
};
};
//
// ASSAULT
//
fn_AOW_spawnAssaultMission = {
    _Asmarker = createMarker ["AOW_Assault1", call fn_AOW_findMissionSpot];
    _Asmarker setMarkerType "hd_objective";
    _Asmarker setMarkerColor "ColorBlack";
    _Asmarker setMarkerText localize "str_AOW_Assault1";
    _Asmarker setMarkerSize [1,1];

    _fobpool = ["audacity","bravery","courage","defiance","endurance"] call bis_fnc_selectRandom;

    _fobtemplate = [getMarkerPos "AOW_Assault1", random 360, call (compile (preprocessFileLineNumbers format ["AOW_MissionCreator\Compositions\%1.sqf", _fobpool]))] call BIS_fnc_ObjectsMapper;

    if !("Task8" call SHK_Taskmaster_hasTask) then {
            ["Task8",localize "str_AOW_Assault1",localize "str_AOW_Assault2"] call SHK_Taskmaster_add;
        } else {["Task8","created"] call SHK_Taskmaster_upd;};

    deleteMarker "TempTask";

    AssaultTrigger = createTrigger ["EmptyDetector", getMarkerPos "AOW_Assault1"];
    AssaultTrigger setTriggerArea [50,50,0,false];
    AssaultTrigger setTriggerActivation ["ANY","PRESENT",false];
    AssaultTrigger setTriggerStatements ["({isPlayer _x} count thisList) > 0","['Task8','succeeded'] call SHK_Taskmaster_upd; deleteMarker 'AOW_Assault1'; deletevehicle AssaultTrigger;",""];
    AssaultTrigger setTriggerTimeout [60, 60, 60, true];
};
//
// MAIN LOGIC
//
_missionDetails = switch (_missionType) do {
	case "AOW_Make_sabotage": {call fn_AOW_spawnSabotageMission;};
    case "AOW_Make_assassinate": {call fn_AOW_spawnAssassinateMission;};
    case "AOW_Make_fdestroy": {call fn_AOW_spawnFdestroyMission;};
    case "AOW_Make_destroy": {call fn_AOW_spawnDestroyMission;};
    case "AOW_Make_extraction": {call fn_AOW_spawnExtractionMission;};
    case "AOW_Make_capture": {call fn_AOW_spawnCaptureMission;};
    case "AOW_Make_disarm":  {call fn_AOW_spawnDisarmMission;};
    case "AOW_Make_assault": {call fn_AOW_spawnAssaultMission;};
};
