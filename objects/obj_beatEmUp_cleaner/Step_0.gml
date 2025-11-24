if (image_index >= image_number - .5) {
	instance_destroy();
}

if (instance_exists(obj_beatEmUp_vendingGuy)) {
    if (obj_beatEmUp_vendingGuy.currentIndex == 3 && obj_beatEmUp_vendingGuy.image_index >= 32) {
		image_index = 1;
	}
} else {
	cleanerState = 1;
}

if (cleanerState == 1 && timer > -1) {
    timer -= 1;
	if (timer >= 0) {
	    image_speed = 1;
	}
}