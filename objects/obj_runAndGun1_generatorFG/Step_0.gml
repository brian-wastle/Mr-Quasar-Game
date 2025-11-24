if (generatorState == 0) {
	// Check state of generator
	var lightInstIndexL = lightInstL.image_index;
	var lightInstIndexR = lightInstR.image_index;

	// Activate laser
	if (lightInstIndexL + lightInstIndexR == 8) {
		generatorState = 1;
		instance_create_layer(880, 776, "Objects", obj_runAndGun1_generatorGlow);
		instance_create_layer(974, 852, "Objects", obj_runAndGun1_generatorZap);
		instance_create_layer(974, 888, "Objects", obj_runAndGun1_generatorZap, {
			xFacing: -1
		});
		instance_create_layer(974, 312, "Objects", obj_runAndGun1_laserBall);
		instance_create_layer(974, 312, "Objects", obj_runAndGun1_laserFlash);
	}
} else if (generatorState == 1) {
	if (!instance_exists(obj_runAndGun1_laserBall)) {
	    instance_create_layer(974, 312, "Objects", obj_runAndGun1_laserBlast);
		generatorState = 2;
	}
}