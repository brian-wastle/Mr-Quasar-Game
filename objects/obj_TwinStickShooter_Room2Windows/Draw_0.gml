if (windowTrigger = 1) {
	draw_sprite_ext(spr_TwinStickShooter_Room2LWindow,image_index,504,386,1,1,0,c_white,1);
	image_speed = .3;
	if image_index >= sprite_get_number(spr_TwinStickShooter_Room2LWindow) - 1 {
		image_index = 0;
		image_speed = 0;
		windowTrigger = 0;
		segueTimer = 15;
		windowSegue = 1;
	}
}

if (windowTriggerA = 1) {
	draw_sprite_ext(spr_TwinStickShooter_Room2RWindow,image_index,1356,386,1,1,0,c_white,1);
	image_speed = .3;
	if image_index >= sprite_get_number(spr_TwinStickShooter_Room2RWindow) - 1 {
		image_index = 0;
		image_speed = 0;
		windowTriggerA = 0;
	}
}
