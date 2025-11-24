y += .25;
if (baseIndex < 8) {
	baseIndex += 1;
}


if (bulletTimer < 4000) {
	if (bulletTimer > 100 && shockIndex < 5) {
		shockIndex += .2;
	}
	bulletTimer *= 1.1;
	
} else {
	opac *= .7;
	beamWidth *= .8;
	if (beamWidth < .33) {
		beamWidth = .33;
	}
	if (opac < .1) {
		instance_destroy();
	}
}



if (collision_rectangle(x-(39 * beamWidth), y + 31 + bulletTimer, x + (39 * beamWidth), y, obj_vertShmup_PlayerChar, 1, 1)) {
	if obj_vertShmup_PlayerChar.actionState != 10 {
		obj_vertShmup_PlayerChar.actionState = 10;
	}
}