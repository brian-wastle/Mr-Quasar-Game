if initTimer > 1 {
	initTimer -= 1;
} else {
	image_speed = 1;
	initTimer = 0;
}

if image_index >= image_number - 1 {
	image_speed = 0;
}