

if (enemyHealth <= 0) {
	image_speed = .8;
}

if (image_index >= image_number -.5) {
	
	instance_destroy();
}


event_inherited();