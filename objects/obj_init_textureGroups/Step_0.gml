if (room == rm_loadingRoom && is_array(pendingGroups) && pendingRoom != noone) {
    // Keep the requested set alive while we wait
    tgRequire(pendingGroups);

    var ready = true;
    var n = array_length(pendingGroups);
    for (var i = 0; i < n; ++i) {
        if (!tgEnsureReady(pendingGroups[i])) {
            ready = false;
        }
    }

    if (ready) {
        var next = pendingRoom;
        pendingRoom   = noone;
        pendingGroups = [];
        room_goto(next);
    }
}
