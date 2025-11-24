
if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, 0, c_white, fadeOpacity );
	shader_reset();
} else {
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, 0, c_white, fadeOpacity );
}

