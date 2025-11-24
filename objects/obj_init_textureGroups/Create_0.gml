loadedGroups  = [];		// Texture groups held in memory
roomGroups    = {};		// Room/texture group key pairs
gameFlows     = [];		// Level order based on game mode
userFlows     = [];		// User's progress based on game mode
activeFlow    = undefined;
pendingRoom   = noone;
pendingGroups = [];
alwaysKeep    = [];

// Force dynamic texture groups into explicit mode once per run
if (!variable_global_exists("textureGroupsExplicit")) {
    global.textureGroupsExplicit = false;
}
if (!global.textureGroupsExplicit) {
    texturegroup_set_mode(true, false);
    global.textureGroupsExplicit = true;
}

function tgEnsureReady(groupName) {
    if (!is_string(groupName)) return false;

    if (texture_is_ready(groupName)) return true;

    var textures = texturegroup_get_textures(groupName);
    if (!is_array(textures)) return false;

    var len = array_length(textures);
    var allReady = true;

    for (var i = 0; i < len; ++i) {
        var tex = textures[i];
        if (!texture_is_ready(tex)) {
            texture_prefetch(tex);
            allReady = false;
        }
    }

    return allReady && texture_is_ready(groupName);
}

// Texture groups
function tgRegister(_room, groupsArray) {
    roomGroups[$ _room] = groupsArray;
}
function tgGroupsFor(_room) {
    if (variable_struct_exists(roomGroups, _room)) {
        var arr = roomGroups[$ _room];
        return is_array(arr) ? arr : [];
    }
    return [];
}
function tgRequire(groupsNeeded) {
    // unload unneeded
    for (var i = array_length(loadedGroups) - 1; i >= 0; --i) {
        var g = loadedGroups[i];
        if (!array_contains(groupsNeeded, g)) {
            texturegroup_unload(g);
            loadedGroups = array_delete(loadedGroups, i, 1);
        }
    }
    // load missing
    for (var j = 0; j < array_length(groupsNeeded); ++j) {
        var name = groupsNeeded[j];
        if (!array_contains(loadedGroups, name)) {
            if (texturegroup_load(name) == 0) {
                loadedGroups[array_length(loadedGroups)] = name;
            }
        }
    }
}

// Queue next room and hop to loading room
function goToRoomViaLoader(_room) {
    pendingRoom   = _room;
    pendingGroups = tgGroupsFor(_room);
    room_goto(rm_loadingRoom);
}

// Flows
function _flowFindIndex(arr, _name) {
    var n = array_length(arr);
    for (var i = 0; i < n; ++i) if (arr[i].name == _name) return i;
    return -1;
}

// Set level order by game mode
function flowRegister(_name, flowSpec) {
    var rec = { name: _name, spec: flowSpec, cursor: [-1, -1] };

    // register/overwrite in gameFlows
    var gi = _flowFindIndex(gameFlows, _name);
    if (gi >= 0) gameFlows[gi] = rec; else gameFlows[array_length(gameFlows)] = rec;

    // create/overwrite the user copy
    var ui = _flowFindIndex(userFlows, _name);
    // fresh cursor for user copy at compile/start
    var userRec = { name: _name, spec: flowSpec, cursor: [-1, -1] };
    if (ui >= 0) userFlows[ui] = userRec; else userFlows[array_length(userFlows)] = userRec;
}

function flowStart(_name) {
    var fi = _flowFindIndex(gameFlows, _name);
    if (fi < 0) return;
    gameFlows[fi].cursor = [-1, -1];
    activeFlow = _name;
    flowNext(_name);
}

// Advance within gameFlows. Use userFlows later for persistence hooks.
function flowNext(_name) {
    var fi = _flowFindIndex(gameFlows, _name);
    if (fi < 0) return false;

    var rec    = gameFlows[fi];
    var spec   = rec.spec;
    var cursor = rec.cursor;
    if (array_length(spec) == 0) return false;

    var i = cursor[0], j = cursor[1];

    // First entry: i=0, j=0 via loader
    if (i == -1) {
        i = 0; j = 0;
        rec.cursor = [i, j];
        var first = is_array(spec[i]) ? spec[i][0] : spec[i];
        goToRoomViaLoader(first);
        return true;
    }

    var chunk = spec[i];
    var clen  = is_array(chunk) ? array_length(chunk) : 1;

    // Intra-level fast jump
    if (j + 1 < clen) {
        j += 1;
        rec.cursor = [i, j];
        var roomInLevel = is_array(chunk) ? chunk[j] : chunk;
        room_goto(roomInLevel);
        return true;
    }

    // Next level via loader
    i += 1;
    if (i >= array_length(spec)) return false; // finished
    j = 0;
    rec.cursor = [i, j];
    var nextFirst = is_array(spec[i]) ? spec[i][0] : spec[i];
    goToRoomViaLoader(nextFirst);
    return true;
}

// Read/write the user's copy without touching gameFlows driving logic.
function userFlowGetCursor(_name) {
    var ui = _flowFindIndex(userFlows, _name);
    return (ui >= 0) ? userFlows[ui].cursor : undefined;
}
function userFlowSetCursor(_name, cursor2) {
    var ui = _flowFindIndex(userFlows, _name);
    if (ui >= 0 && is_array(cursor2) && array_length(cursor2) == 2) {
        userFlows[ui].cursor = [cursor2[0], cursor2[1]];
        return true;
    }
    return false;
}
function userFlowGetSpec(_name) {
    var ui = _flowFindIndex(userFlows, _name);
    return (ui >= 0) ? userFlows[ui].spec : undefined;
}


// Level/Texture group register
tgRegister(rm_runAndGun1, ["RunAndGunTex"]);
tgRegister(rm_runAndGun2, ["RunAndGunTex"]);
tgRegister(rm_horiShmup,  ["HoriShmupTex"]);
tgRegister(rm_vertShmup,  ["VertShmupTex"]);
tgRegister(rm_beatEmUp1,  ["BeatEmUpTex"]);
//tgRegister(rm_beatEmUp2,  ["BeatEmUpTex"]);
tgRegister(rm_arcadeRacer,  ["ArcadeRacerTex"]);
tgRegister(rm_twinStickShooter1,  ["TwinStickShooterTex"]);
tgRegister(rm_twinStickShooter2,  ["TwinStickShooterTex"]);
tgRegister(rm_twinStickShooter3,  ["TwinStickShooterTex"]);
tgRegister(rm_twinStickShooter4,  ["TwinStickShooterTex"]);
tgRegister(rm_twinStickShooter5,  ["TwinStickShooterTex"]);
tgRegister(rm_boxing_ring,  ["BoxingTex"]);
tgRegister(rm_arcadeShooter,  ["ArcadeShooterTex"]);
//tgRegister(rm_platformer,  ["PlatformerTex"]);

// Game mode order
flowRegister("singlePlayer", [ [rm_runAndGun2, rm_runAndGun2], rm_horiShmup ]);
