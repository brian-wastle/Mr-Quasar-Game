owner		= obj_RunAndGun_Player.id;  // the hero instance that owns this emitter
emitRate	= 2;						// puffs per frame (tweak to taste)
emitTimer	= 0;
active		= true;						// set to false to begin wind-down

function spawnPuff(_ground) {
    var offX = irandom_range(-8,  8);
    var offY = irandom_range(-4,  12);
    if (!_ground) {                              // rising smoke starts a bit higher
        offY -= irandom_range(12, 16);
    }
    var puff = instance_create_layer(
        x + offX, y + offY, "Instances", obj_runAndGun_smokeParticle, {
			ground: _ground,
			floorY: y
		});
};