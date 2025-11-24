

if obj_beatEmUp_player.x > 6640 {
	image_speed = 1;
}

if (image_index > image_number - 1 && animateTimer = 0) {
	animateTimer = 60;
}

if (animateTimer > 0) {
	image_speed = 0;
	if animateTimer > 1 {
		animateTimer -= 1;
	}
	if animateTimer = 1 {
		image_speed = -1;
	}
}

if (animateTimer = 1 && image_index < 1) {
	instance_destroy();
}

