if keyboard_check_pressed(vk_enter) {
	mp_grid_destroy(global.twinStickGrid1);
	room_goto_next();
	exit;
}

mp_grid_clear_all(global.twinStickGrid1);
mp_grid_add_instances(global.twinStickGrid1, obj_twinStickShooter_boundaryLowParent, 1);

