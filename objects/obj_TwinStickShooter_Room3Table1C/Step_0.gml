

if (enemyHealth <= 0) {
	if (image_index < 9) {
		image_speed = 1;
	}  else {
		image_speed = 0;
	}
	if (instance_exists(obj_TwinStickShooter_Room3Table1L) && instance_exists(obj_TwinStickShooter_Room3Table1R)) {
		if (enemyHealth = 0 && obj_TwinStickShooter_Room3Table1L.enemyHealth = 0 && obj_TwinStickShooter_Room3Table1R.enemyHealth = 0) {
			image_speed = 1;
		}
	}
	
	
	if (image_index >= image_number - 1) {
		image_speed = 0;
	}

	if (( instance_exists(obj_TwinStickShooter_Room3Table1L) && obj_TwinStickShooter_Room3Table1L.fadeOpacity <= .1 ) || (!instance_exists(obj_TwinStickShooter_Room3Table1L))) {
		instance_destroy();
	}
	
}


event_inherited();

