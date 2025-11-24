if (enemyHealth > 0) {
	image_angle = 0;
}

if (enemyHealth <= 0) {
	image_angle = 270 + point_direction(x, y, xprevious, yprevious);
}


if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, image_angle, c_white, 1 );
	shader_reset();
} else {
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, image_angle, c_white, 1 );
}

