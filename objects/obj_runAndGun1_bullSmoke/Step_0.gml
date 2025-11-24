if (stateTimer[0] < 5) {
	stateTimer[0] += 1;
} else if (currentIndex < image_number - 1) {
	stateTimer[0] = 0;
	currentIndex += 1;
} else {
	instance_destroy();
}

x += 2 * smokeDir;