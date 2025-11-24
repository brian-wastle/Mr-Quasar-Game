if (windowTimer = 0 && initSequence = 0) {
	windowTimer = irandom_range(20,30) * fps;
	initSequence = 1;
}

if (windowTimer > 0) {
	windowTimer -= 1;
	if (windowTimer = 1) {
	windowTrigger = 1;
}
}



if (windowSegue = 1) {
	segueTimer -= 1;
	if (segueTimer = 0) {
		windowTriggerA = 1;
		windowSegue = 0;
	}
}