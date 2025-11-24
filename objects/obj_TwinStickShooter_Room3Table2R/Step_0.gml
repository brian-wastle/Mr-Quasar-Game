

if (enemyHealth <= 0) {
	if (image_index < 12) {
		image_speed = 1;
	}  else {
		image_speed = 0;
	}
	if (instance_exists(obj_TwinStickShooter_Room3Table2L)) {
		if (enemyHealth <= 0 && obj_TwinStickShooter_Room3Table2L.enemyHealth <= 0) {
			image_speed = 1;
		}
	}
	
	
	if (image_index >= image_number - 1) {
		image_speed = 0;
	}

	if (( instance_exists(obj_TwinStickShooter_Room3Table2L) && obj_TwinStickShooter_Room3Table2L.fadeOpacity <= .1 ) || (!instance_exists(obj_TwinStickShooter_Room3Table2L))) {
		instance_destroy();
	}
	
}



event_inherited();