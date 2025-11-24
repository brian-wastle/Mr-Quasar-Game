if (instance_exists(obj_beatEmUp_vendingGuy) && obj_beatEmUp_vendingGuy.currentIndex == 2 && animState == 0) {
	animState = 1;
}

if (!instance_exists(obj_beatEmUp_vendingGuy)) {
	animState = 3;
}

if (instance_exists(obj_beatEmUp_vendingGuy) && animState == 1) {
	image_speed = 1;
	if (increment < 60) {
	    increment += 1;
	}  else {
		animState = 2;
	}
}

if (!instance_exists(obj_beatEmUp_vendingGuy) && animState == 3) {
	if (increment > 0) {
		sprite_index = spr_beatEmUp_vendingAlarmIdle;
	    increment -= 1;
	}  else {
		instance_destroy();
	}
}