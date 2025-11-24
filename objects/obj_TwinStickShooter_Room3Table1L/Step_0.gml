

if (enemyHealth <= 0) {
	if (image_index < 9) {
		image_speed = 1;
	}  else {
		image_speed = 0;
	}
	
	if instance_exists(obj_TwinStickShooter_Room3Table1C) && instance_exists(obj_TwinStickShooter_Room3Table1R) {
		if (enemyHealth = 0 && obj_TwinStickShooter_Room3Table1C.enemyHealth = 0 && obj_TwinStickShooter_Room3Table1R.enemyHealth = 0) {
			image_speed = 1;
		}
	}
	
	if (image_index >= image_number - 1) {
		image_speed = 0;
	}
	
	if instance_exists(obj_TwinStickShooter_Room3Table1C) && instance_exists(obj_TwinStickShooter_Room3Table1R) {
		if ( image_index >= image_number - 1 && obj_TwinStickShooter_Room3Table1C.image_index >= obj_TwinStickShooter_Room3Table1C.image_number - 1 && obj_TwinStickShooter_Room3Table1R.image_index >= obj_TwinStickShooter_Room3Table1R.image_number - 1) {
			if (fadeTimer = 0 && fadeStatus = 0) {
				fadeTimer = 15 * fps;
				fadeStatus = 1;
			}
		}
	}
	if (fadeStatus = 1) {
		if (fadeOpacity <= .1 && !instance_exists(obj_TwinStickShooter_Room3Table1R) && !instance_exists(obj_TwinStickShooter_Room3Table1C)) {
			instance_destroy();
		}
		fadeOpacity *= .9;
	}
}


event_inherited();

