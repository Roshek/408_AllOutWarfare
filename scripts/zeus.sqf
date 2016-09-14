while {true} do {
    sleep 5;

    if (!isnil "alpha1") then {
        AOW_Curator_1 addCuratorEditableObjects [allUnits,true];
        AOW_Curator_1 addCuratorEditableObjects [vehicles,true];
    };
    if (!isnil "alpha2") then {
        AOW_Curator_2 addCuratorEditableObjects [allUnits,true];
        AOW_Curator_2 addCuratorEditableObjects [vehicles,true];
    };
};