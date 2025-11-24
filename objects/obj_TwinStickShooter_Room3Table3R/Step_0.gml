

if (enemyHealth <= 0) {
	if (image_index < 13) {
		image_speed = 1;
	}  else {
		image_speed = 0;
	}
	if (instance_exists(obj_TwinStickShooter_Room3Table3L)) {
		if (enemyHealth <= 0 && obj_TwinStickShooter_Room3Table3L.enemyHealth <= 0) {
			image_speed = 1;
		}
	}
	
	
	if (image_index >= image_number - 1) {
		image_speed = 0;
	}

	if (( instance_exists(obj_TwinStickShooter_Room3Table3L) && obj_TwinStickShooter_Room3Table3L.fadeOpacity <= .1 ) || (!instance_exists(obj_TwinStickShooter_Room3Table3L))) {
		instance_destroy();
	}
	
}


event_inherited();

