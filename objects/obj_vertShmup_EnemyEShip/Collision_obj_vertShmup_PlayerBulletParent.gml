if enemyHealth > 0 {
	enemyHealth -= 8;
	instance_destroy(other);
}

if (enemyHealth <= 0) {
	if (deathState = 0) {
		deathState = 1;
		audio_play_sound(sfx_vertShmup_Explosion1, 5, false);
	}
	gunState = 4;
}
