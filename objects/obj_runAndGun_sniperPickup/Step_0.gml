if (fadeState) {
    if (stateTimer[0] < 4) {
	    stateTimer[0] += 1;
	} else if (currentIndex < image_number - 1) {
		stateTimer[0] = 0;
		currentIndex += 1;
		if (currentIndex == 8) {
		    glowState = 1;
			obj_RunAndGun_Player.weaponType = 1;
			obj_RunAndGun_Player.weaponsHeld[1] = 1;
		}
	} else if (currentIndex = image_number - 1) {
		if (stateTimer[2] < 60) {
		    stateTimer[2] += 1;
		} else {
			cleanUp = 1;
			fadeState = 0;
			glowState = 0;
			stateTimer[0] = 0;
		}
		
	}
}


if (glowState) {
	if (glowAlpha < 1) {
	    glowAlpha *= 1.2;
	} else {
		glowAlpha = 1;
	}
}

if (glowState || cleanUp) {
    if (stateTimer[1] < 3) {
	    stateTimer[1] += 1;
	} else if (glowIndex < 11) {
		stateTimer[1] = 0;
		glowIndex += 1;
	} else if (glowIndex = 11) {
		stateTimer[1] = 0;
		glowIndex = 0;
	}
}

if (cleanUp) {
    stateTimer[0] += 1;
	stateTimer[0] *= 1.05;
	image_alpha = 1 - (1 * (stateTimer[0] / 100));
	glowAlpha = image_alpha;
	if (stateTimer[0] >= 100) {
		instance_destroy();
	}
		
}

if (currentIndex < 7) {
    if (cx < 1) {
	    cx += 1 / (2 * 60);
	} else {
		cx = 0;
		cx += 1 / (2 * 60);
	}
	cx += 1 / (2 * 60);
	cy = animcurve_channel_evaluate(channel, cx);
	yOffset = cy * 8;
}
