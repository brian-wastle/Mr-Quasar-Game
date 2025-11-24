if (objState == 0) {
	if (stateTimer[0] < 12) {
	    stateTimer[0] += 1;
	} else if (loadingIndex < 3) {
		stateTimer[0] = 0;
		loadingIndex += 1;
	} else {
		stateTimer[0] = 0;
		loadingIndex = 0;
	}
	
    if (fillPhase[0] < 320) {
	    fillPhase[0] += 2;
	} else if (fillPhase[1] < 320) {
		fillPhase[1] += 2;
	} else if (fillPhase[2] < 320) {
		fillPhase[2] += 2;
	}
} else {
	if (loadingAlpha > .1) {
	    loadingAlpha *= .94;
	} else {
		loadingAlpha = 0;
	}
	currentHealth = obj_runAndGun1_ragingBull.enemyHealth;	
	bullPhase = floor((currentHealth / totalHealth) * 3);
	var phaseHealth = currentHealth - bullPhase * 1000;
	barLength = 320 * (phaseHealth/1000);
}

