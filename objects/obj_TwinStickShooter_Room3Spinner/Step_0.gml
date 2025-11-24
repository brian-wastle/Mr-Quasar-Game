

if (enemyHealth <= 0 || (instance_exists(obj_TwinStickShooter_Room3Table6) && obj_TwinStickShooter_Room3Table6.image_speed != 0)) {
	instance_destroy();
}


event_inherited();