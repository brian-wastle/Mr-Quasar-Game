if (stateTimer[1] < 8) {
    stateTimer[1] += 1
} else {
	stateTimer[1] = 0;
	exhaustIndex = exhaustIndex < 2 ? exhaustIndex + 1 : 0;
}
// Camera's room coords
var cam = view_camera[0];
var viewX = camera_get_view_x(cam);
var viewW = camera_get_view_width(cam);
var viewRight  = viewX + viewW;
// State Sprites
switch (enemyState) {
    case 0: // mini/bg state
		// Initial speed
		targetVX = -8;
		// Adjust speed
		if (x < viewX  + viewW/2) {
			targetVX = -16;
		}
        if (x < viewX - 400) {
			// Stop, turn around, change sprite
		    enemyState = 1;
			image_index = 0;
			image_xscale = 1;
			targetVX = 0;
			xSpeed = 0;
			y = laneArray[laneIndex][1];
			mask_index = sprite_index;
		}
        break;
    case 1: // enter screen
		targetVX = lerp(6, 10, global.difficulty);
		if (x > viewX + 240) {
			image_index = 1;
		    targetVX = 0;
			easeFactor = .1;
		}
        if (image_index == 1 && xSpeed == 0) {
		    enemyState = 2;
			image_index = 2;
		}
        break;
	case 2: // take position
        if (stateTimer[0] < lerp(59, 23, global.difficulty)) {
		    stateTimer[0] += 1;
			if (stateTimer[0] > 7) {
				image_index = 3;
			}
		} else {
			enemyState = 3;
			stateTimer[0] = 0;
		}
        break;
	case 3: // fire
		var prevIndex = image_index;
		image_index = 4;
		
		if (stateTimer[0] < 143) {
		    stateTimer[0] += 1;
		} else {
			enemyState = 4;
			image_index = 5;
			stateTimer[0] = 0;
		}
		// Pause before shooting
		var pauseVal = lerp(59, 24, global.difficulty);
		if (stateTimer[0] < pauseVal || (stateTimer[0] > pauseVal + 8 && stateTimer[0] < pauseVal + 68) || stateTimer[0] > pauseVal + 76) {
			image_index = 3;
		}
		// Shoot on first frame of image_index = 4
		if (image_index == 4 && prevIndex != 4) {
		    instance_create_layer(x + 112, y - 56, "Instances", obj_runAndGun_EnemyBullet2, {
				speed:40,
				direction: 0
			});
		}
        break;
	case 4: // retreat
		targetVX = 8;
		easeFactor = .08;
        if (stateTimer[0] < 143) {
		    stateTimer[0] += 1;
		} else {
			enemyState = 5;
			stateTimer[0] = 0;
		}
		if (stateTimer[0] > shortDelay) {
		    image_index = 2;
			targetVX = 64;
			easeFactor = .01;
		}
		if (stateTimer[0] > shortDelay + 8) {
		    image_index = 1;
		}
		if (stateTimer[0] > shortDelay + 16) {
		    image_index = 0;
		}
        break;
	case 5: // destroy
        if (x > viewRight + 400) {
			instance_destroy();
		}
        break;
}
// Damage state overrides
if (hitFlag == 1) {
	if (enemyState != 6) {
	    previousState = enemyState;
	}
    enemyState = 6;
	stateTimer[2] = 0;
	image_index = 6;
	if (rifleCharge > 0) {
	    enemyHealth -= 100;
	} else {
		enemyHealth -= 20;
	}
}
// Take damage
if (enemyState == 6) {
	targetVX = 0;
	if (enemyHealth > 0) {
	    if (stateTimer[2] < 7) {
			stateTimer[2] += 1;
		} else {
			enemyState = previousState;
			stateTimer[2] = 0;
		}
	} else {
		enemyState = 7;
	}
}

// Death
if (enemyState == 7) {
	if (deathFlag == 0) {
	    deathFlag = 1;
		instance_create_layer(x + 72 * image_xscale, y, "Instances", obj_runAndGun_explosionSmall);
	}
	targetVX = 8;
	targetVY = 16;
}

// Reset hitFlag and apply movement
hitFlag = 0;
event_inherited();