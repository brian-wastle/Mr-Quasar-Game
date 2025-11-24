
if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, 0, c_white, obj_TwinStickShooter_Room3Table3L.fadeOpacity );
	shader_reset();
} else {
	draw_sprite_ext( sprite_index, image_index, x, y, 1, 1, 0, c_white, obj_TwinStickShooter_Room3Table3L.fadeOpacity );
}

