if (doorState = 1) {
	image_speed = 1;
	if (image_index > image_number - 1) {
		image_speed = 0;
		doorState = 0;
	}
}

if (doorState = 2) {
	image_speed = -1;
	if (image_index < .5) {
		image_speed = 0;
	}
}


//mask_index = spr_twinStickShooter_EmptyDoorMask;