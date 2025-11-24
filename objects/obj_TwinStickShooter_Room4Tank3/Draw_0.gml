
if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, 0, c_white, 1 );
	shader_reset();
} else {
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, 0, c_white, 1 );
}