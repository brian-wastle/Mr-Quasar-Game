if (currentIndex != 0) {
	if (image_index > image_number - .5) {
	    currentIndex = 0;
		image_index = 0;
	}
}

if (currentIndex == 0) {
	delayTimer -= 1;
	if (delayTimer <= 0) {
	    currentIndex = irandom_range(1,3);
		image_index = 0;
		delayTimer = irandom_range(120,160);
	};
}

sprite_index = spriteArray[currentIndex];