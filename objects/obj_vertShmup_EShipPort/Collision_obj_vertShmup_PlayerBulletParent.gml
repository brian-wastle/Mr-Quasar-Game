if enemyHealth > 0 {
	enemyHealth -= 15;
	instance_destroy(other);
}

if (enemyHealth <= 0 && image_index = 0) {
	image_speed = 1;
	gunState = 3;
}
