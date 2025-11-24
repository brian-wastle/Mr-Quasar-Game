if (enemyHealth <= 0) {
	image_speed = .7;
}

if image_index >= image_number - 1 {
	image_speed = 0; 
	image_index = image_number-1;
}


event_inherited();