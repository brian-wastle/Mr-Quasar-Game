timer += 1;
if (timer >= 5) {
	instance_destroy();
}
image_speed = 0;
if (instance_exists(obj_horiShmup_player)) {
	x = obj_horiShmup_player.x + sprite_get_width(obj_horiShmup_player.sprite_index)-10;
	y = obj_horiShmup_player.y + instanceYDiff;
} else {
	x = obj_horiShmupClone.x + sprite_get_width(obj_horiShmupClone.sprite_index)-10;
	y = obj_horiShmupClone.y;
}
