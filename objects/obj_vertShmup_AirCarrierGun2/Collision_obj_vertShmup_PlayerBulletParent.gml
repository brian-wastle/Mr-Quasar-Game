if enemyHealth > 0 {
	enemyHealth -= 10;
	instance_destroy(other);
}

if (enemyHealth <= 0 && image_index = 0) {
	audio_play_sound(sfx_vertShmup_Explosion4, 5, false);
	image_speed = 1;
}
