if (room == rm_loadingRoom && is_array(pendingGroups)) {
    // Kick off/align loaded groups to what's needed
    tgRequire(pendingGroups);
}