
if (enemyHealth <= 0) {
	image_speed = .8;
	if ( image_index >= image_number - 1) {
		if (fadeTimer = 0 && fadeStatus = 0) {
			fadeTimer = 15 * fps;
			fadeStatus = 1;
		}
		image_speed = 0;
	}
	if (fadeStatus = 1) {
		if (fadeOpacity <= .1) {
			instance_destroy();
		}
		fadeOpacity *= .9;
	}
}

event_inherited();

