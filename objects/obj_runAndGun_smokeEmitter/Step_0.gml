// 1. Follow the owner's feet (or vanish if owner died)
if (instance_exists(owner)) {
    x = owner.x;
    y = owner.bbox_bottom;
}
else
{
    active = false;
}

// 2. Spawn puffs while active
if (active) {

    var half = emitRate div 2;                  // integer half
    var extra = emitRate mod 2;                 // handles odd numbers

    // 1) Ground dust
    repeat (half) {
        spawnPuff(true);                        // ground = true
    }

    // 2) Rising smoke
    repeat (half + extra) {                      // makes total == emit_rate
        spawnPuff(false);                       // ground = false
    }
}

// 3. Auto-destroy once stopped *and* last puff is gone
if (!active && !instance_exists(obj_runAndGun_smokeParticle)) {
    instance_destroy();
}