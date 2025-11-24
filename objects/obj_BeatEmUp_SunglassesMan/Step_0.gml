

if obj_beatEmUp_player.x > 6434 {
	image_speed = 1.3;
}

if image_index > 28 {
	image_speed = .8;
}

if (image_index >= image_number - 2) {
	instance_destroy();
}

