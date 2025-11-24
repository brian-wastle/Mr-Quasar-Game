if (place_meeting(x,y,obj_runAndGun2_fallingTrigger)) {
    active = 1;
}

if (active == 1 && platformType == 0) {
    for (var i = 0; i < array_length(platform_def); ++i) {
		instance_destroy(platforms[i]);
	    var p = instance_create_layer(x, y, "FallingShelfPlatforms", obj_RunAndGun2_fallingMask);
	    p.owner = id;
	    p.local = platform_def[i];
	    platforms[i] = p;
	}
	instance_destroy(obj_runAndGun2_fallingTrigger);
	platformType = 1;
}

if (image_angle < -90) {
	instance_destroy();
}

