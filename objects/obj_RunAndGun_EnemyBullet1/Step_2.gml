event_inherited();


if (stateTimer[0] < 180) {
    stateTimer[0] += 1;
} else {
	instance_destroy();
}