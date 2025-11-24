
if (enemyHealth <= 0 || ((instance_exists(obj_TwinStickShooter_Room5Computer) && obj_TwinStickShooter_Room5Computer.enemyHealth <= 0) || (!instance_exists(obj_TwinStickShooter_Room5Computer)))) {
	image_speed = .6;
	if ( image_index >= image_number - 1) {
		if (fadeTimer = 0 && fadeStatus = 0) {
			fadeTimer = 15 * fps;
			fadeStatus = 1;
		}
		image_speed = 0;
	}
	if (fadeStatus = 1) {
		if (fadeOpacity <= .12) {
			instance_destroy();
		}
		fadeOpacity *= .9;
	}
}

event_inherited();

