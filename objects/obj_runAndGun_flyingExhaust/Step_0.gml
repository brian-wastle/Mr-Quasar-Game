if (stateTimer[0] < 4) {
    stateTimer[0] += 1;
} else {
	if currentIndex < image_number - 1 {
		currentIndex += 1;
	} else {
		currentIndex = 0;
	}
	stateTimer[0] = 0;
}