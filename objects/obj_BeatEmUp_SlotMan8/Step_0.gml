if (image_index >= image_number - 1 && initTimer = 0) {
	image_speed = 0;
	initTimer = 208;
}

if (initTimer > 0) {
	initTimer -= 1;
	if (initTimer = 1) {
		image_index = 0;
		initTimer = 0;
		image_speed = .5;
	}
}