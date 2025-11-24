if enemyHealth > 0 {
	enemyHealth -= 15;
	instance_destroy(other);
}

if (enemyHealth <= 0 && image_index = 0) {
	audio_play_sound(sfx_vertShmup_Explosion5, 5, false);
	image_speed = 1;
	gunState = 3;
}
