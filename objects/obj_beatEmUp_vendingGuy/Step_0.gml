if (image_index >= image_number - .5) {
    if currentIndex <= 2 {
		currentIndex += 1;
		image_index = 0;
		sprite_index = spriteArray[currentIndex];
	} else {
		instance_destroy();
	}
}

if (obj_beatEmUp_player.x >= 1920 && animState == 0) {
	animState = 1;
}

if (animState == 1 && delayTimer > 0) {
	delayTimer -= 1;
} else if (animState == 1 && delayTimer == 0) {
	image_speed = 1;
}