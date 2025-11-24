if (stateTimer == currentDuration) {
	stateTimer = 0;
    switchState();
}

stateTimer += 1;