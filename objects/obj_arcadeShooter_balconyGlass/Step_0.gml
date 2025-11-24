if (enemyHealth = 100) {
	image_index = 0;
} else if (enemyHealth <= 80 && enemyHealth > 50) {
	image_index = 1;
} else if (enemyHealth <= 50 && enemyHealth > 20) {
	image_index = 2;
} else if (enemyHealth <= 20 && enemyHealth > 0) {
	image_index = 3;
} else if (image_index < image_number - 1){
	image_speed = .5;
} else {
	image_speed = 0;
}

