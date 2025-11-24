// Unload any texture groups we’ve kept loaded
for (var i = array_length(loadedGroups) - 1; i >= 0; --i) {
    texturegroup_unload(loadedGroups[i]);
}
loadedGroups  = [];
roomGroups    = {};   // if you want to fully clear registrations; otherwise keep
gameFlows     = [];   // only clear if you’re intentionally resetting flows
userFlows     = [];   // idem: keep if you persist/restore elsewhere

// Reset loader state
pendingRoom   = noone;
pendingGroups = [];
