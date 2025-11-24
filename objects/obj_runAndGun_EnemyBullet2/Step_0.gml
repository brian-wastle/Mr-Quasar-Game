if (stateTimer[0] < 120) {
	stateTimer[0] += 1;
} else {
	stateTimer[0] = 0;
	instance_destroy();
	exit;
}