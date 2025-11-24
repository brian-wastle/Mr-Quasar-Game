if (image_index >= initialIndex + 4) {
    instance_destroy();
	exit;
}

if (instance_exists(owner)) { 
	x = owner.x + xOffset;
	y = owner.y + yOffset;
}

if (stateTimer[0] < 2) {
    stateTimer[0] += 1;
} else {
	stateTimer[0] = 0;
	image_index += 1;
}