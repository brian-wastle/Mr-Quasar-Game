if (stateTimer[0] < 4) {
    stateTimer[0] += 1;
} else if (image_index < image_number - 1) {
	stateTimer[0] = 0;
	image_index += 1;
} else {
	instance_destroy();
}