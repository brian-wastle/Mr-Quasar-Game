if initTimer > 1 {
	opac = 0;
	initTimer -= 1;
} else {
	image_speed = 1;
	opac = 1;
	initTimer = 1;
}


if image_index >= image_number - 1 {
	image_index = 0;
	image_speed = 0;
	opac = 0;
	initTimer = 450;
}