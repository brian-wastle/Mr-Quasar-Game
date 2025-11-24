var enemyX = obj_boxing_fighterA.x;
var queueState = obj_boxing_fighterB_armControl.queueState;
xOffset = abs(enemyX - x) > 150 ? sign(enemyX - x) : 0;
enemyPos = sign(obj_boxing_fighterA.x - x);
var accel = 0.4;
var decel = 0.3;
maxSpeed = 7;

if (!gamepad_is_connected(global.pad)) {
    keyA = keyboard_check(ord("A"));
    keyD = keyboard_check(ord("D"));
	keySpace = keyboard_check_pressed(vk_space);

// Handle left/right movement
    if (keyA && !keyD) {
        speed = max(speed - accel, -maxSpeed);
    }  else if (keyD && !keyA) {
        speed = min(speed + accel, maxSpeed);
    } else {
        if (speed > 0) speed = max(speed - decel, 0);
        else if (speed < 0) speed = min(speed + decel, 0);
    }

// Handle queueing stateOverride actions
	if (queueState == "open" || playerState = 2) {	
		//slide
		if (keySpace) {
			if ((enemyPos == 1 && keyD) || (enemyPos == -1 && keyA)) {
			    obj_boxing_fighterB_armControl.stateOverride = 1;
				obj_boxing_fighterB_armControl.queueState = "closed";
				playerState = 1;
				targetDir = enemyPos;
			}
		}

		//block
		if (playerState != 1) {
			if (keyA && enemyPos == 1) {
				obj_boxing_fighterB_armControl.stateOverride = 2;
				obj_boxing_fighterB_armControl.queueState = "closed";
				playerState = 2;
				targetDir = enemyPos;
			} else if (keyD && enemyPos == -1) {
				obj_boxing_fighterB_armControl.stateOverride = 2;
				obj_boxing_fighterB_armControl.queueState = "closed";
				playerState = 2;
				targetDir = enemyPos;
			} 
		}
	}
}


// State logic

//Slide state
if (playerState = 1) {
	cx += 1 / (slideTime * 60);
    cy = animcurve_channel_evaluate(channel, cx);
	speed = cy * targetDir * .6;
	if ( cx > .8 && obj_boxing_fighterB_armControl.queueState = "closed") {
		obj_boxing_fighterB_armControl.queueState = "open";
	}
	if (cx >= 1) {
	    playerState = 2;
		cx = 0;
		obj_boxing_fighterB_armControl.stateOverride = 2;
	}
}

//Block state
if (playerState = 2) {
	accel = accel/4;
	decel = decel/4;
	
	if (keyA && !keyD && enemyPos == 1) {
        speed = max(speed - accel, -maxSpeed/4);
    }  else if (keyD && !keyA && enemyPos == -1) {
        speed = min(speed + accel, maxSpeed/4);
    } else {
		playerState = 0;
		obj_boxing_fighterB_armControl.queueState = "open";
		obj_boxing_fighterB_armControl.stateOverride = 0;
    }
}

//Handle background scrolling

playerNearLeftEdge = (x <= roomLeftBound && speed < 0);
playerNearRightEdge = (x >= roomRightBound && speed > 0);

if ((playerNearLeftEdge || playerNearRightEdge) || playerState = 1) {
	var initialSign = sign(-speed);
	backgroundSpeed = -speed; 
	targetSpeed = abs(targetSpeed);
	var currentSpeed = min((targetSpeed * 1.05) + (targetSpeed + .01), maxScrollRate - maxSpeed)
	targetSpeed = currentSpeed * initialSign;
	layer_hspeed(layerId,-backgroundSpeed - targetSpeed);
} else {
	x += speed;
    backgroundSpeed = abs(backgroundSpeed) > .25 ? backgroundSpeed * .85 : 0;
	targetSpeed = abs(targetSpeed) > .25 ? targetSpeed * .96 : 0;	
	layer_hspeed(layerId, backgroundSpeed = 0 ? -targetSpeed : backgroundSpeed + targetSpeed);
}

// Sliding back to the center if not moving away

if (abs(x - centerX) > 250 && !(speed < 0 && x > centerX) && !(speed > 0 && x < centerX)) {
    // Slide towards center
    var slideSpeed = 0.01;
    x = lerp(x, centerX, slideSpeed);
}

x = clamp(x, roomLeftBound, roomRightBound);

switch (playerState) {
    case 1:
        sprite_index = slideArray[xOffset + 1];
        break;
	case 2:
        sprite_index = blockArray[xOffset + 1];
        break;
    default:
        sprite_index = spriteArray[xOffset + 1];
        break;
}
