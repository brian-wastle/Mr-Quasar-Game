if (timer < 6) {
    timer += 1;
} else {
	timer = 0;
	x += -12 * dir;
}

if (imageTimer < 8) {
    imageTimer += 1;
} else {
	imageTimer += 1;
	if (currentIndex < image_number - 1) {
	    currentIndex += 1;
	} else {
		instance_destroy();
	}
}