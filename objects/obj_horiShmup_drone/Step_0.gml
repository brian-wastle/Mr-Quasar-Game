if (instance_exists(obj_horiShmup_player)) {
	if (point_distance(x, y,obj_horiShmup_player.x, obj_horiShmup_player.y) > 80) {
	    move_towards_point(obj_horiShmup_player.x, obj_horiShmup_player.y, 10);
	} else {
		speed = 0;
	}
}


if mouse_check_button_pressed(mb_left) {
			instance_create_layer(x + sprite_get_width(sprite_index), y, "Instances", obj_horiShmup_playerBullet, {
				speed:40,
				direction: 0,
			});
			instance_create_layer(x + sprite_get_width(sprite_index)-10, y, "Instances", obj_playerMuzzle, {
			});
			bulletTimer = 0;

} 

if mouse_check_button(mb_left) {
	bulletTimer += 1;
}

if mouse_check_button_released(mb_left) {
	bulletTimer = 0;
}

if (bulletTimer > 5) {
	instance_create_layer(x + sprite_get_width(sprite_index), y, "Instances", obj_horiShmup_playerBullet, {
				speed:40,
				direction: 0,
			});
			instance_create_layer(x + sprite_get_width(sprite_index)-10, y, "Instances", obj_playerMuzzle, {
			});
			bulletTimer = 0;
}