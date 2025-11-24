if !gamepad_is_connected(global.pad) {

	if mouse_check_button_pressed(mb_left) {
		instance_create_layer(x + sprite_get_width(sprite_index),y,"Instances", obj_horiShmup_playerBullet, 
		{
			speed:40,
			direction: 0
		});
		instance_create_layer(x + sprite_get_width(sprite_index)-10,y,"Instances", obj_playerMuzzle);
		bulletTimer = 0;
	}

	if mouse_check_button(mb_left) {
		bulletTimer += 1;
	}

	if mouse_check_button_released(mb_left) {
		bulletTimer = 0;
	}

	if (bulletTimer > 5) {
		instance_create_layer(x + sprite_get_width(sprite_index),y,"Instances", obj_horiShmup_playerBullet, 
		{
			speed:50,
			direction: 0
		});
		instance_create_layer(x + sprite_get_width(sprite_index)-10,y,"Instances", obj_playerMuzzle);
		bulletTimer = 0;
	}
}

if gamepad_is_connected(global.pad) {
	if gamepad_button_check_pressed(global.pad, gp_face3) {
		instance_create_layer(x + sprite_get_width(sprite_index),y,"Instances", obj_horiShmup_playerBullet, 
		{
			speed:40,
			direction: 0
		});
		instance_create_layer(x + sprite_get_width(sprite_index)-10,y,"Instances", obj_playerMuzzle);
		bulletTimer = 0;
	}

	if gamepad_button_check(global.pad, gp_face3) {
		bulletTimer += 1;
	}

	if gamepad_button_check_released(global.pad, gp_face3) {
		bulletTimer = 0;
	}

	if (bulletTimer > 5) {
		instance_create_layer(x + sprite_get_width(sprite_index),y,"Instances", obj_horiShmup_playerBullet, 
		{
			speed:50,
			direction: 0
		});
		instance_create_layer(x + sprite_get_width(sprite_index)-10,y,"Instances", obj_playerMuzzle);
		bulletTimer = 0;
	}
}