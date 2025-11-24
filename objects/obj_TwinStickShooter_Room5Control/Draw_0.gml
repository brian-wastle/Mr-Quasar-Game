if !gamepad_is_connected(global.pad) {
	draw_sprite_ext(spr_twinStickShooter_cursor, image_index, mouse_x, mouse_y, 1, 1 ,0, c_white, .3);
}