// Collision
if (place_meeting(x,y, obj_runAndGun_ParentOverlay) || 
(place_meeting(x,y, obj_runAndGun_ParentPlatform) && ySpeed > 0)) {
	var landingSpeedX = lengthdir_x(travelSpeed, playerDir);
	var landingSpeedY = lengthdir_y(travelSpeed, playerDir);
	if (thisExplosion == 0) {
	    thisExplosion = instance_create_layer(x,y,"Instances", obj_runAndGun_explosion);
		phase = 4;
	} else if (instance_exists(thisExplosion)) {
		if (thisExplosion.currentIndex >= 2) {
			instance_destroy();
		}
	}
}

// Launch and spin
if (phase == 0) {
	x += xSpeed;
	y += ySpeed;
	ySpeed += missileGrav;
	image_angle = (image_angle + spinSpeed) % 360;
	var startFalling = (ySpeed > -5);	// Zero Y speed is the peak of the jump, 
	if (startFalling) {					// negative integers are prior to peak
		if (global.difficulty < .5) {
		    playerX = obj_RunAndGun_Player.x;
			playerY = obj_RunAndGun_Player.y - 68;
			playerDir = point_direction(x, y, playerX, playerY);
		}
		phase = 1;
	}
} else if (phase == 1) {
	x += xSpeed;
	y += ySpeed;
	if (abs(xSpeed) > .01) {
	    xSpeed *= .98;
	} else {
		xSpeed = 0;
	}
	
	if (missileGrav > .1) {
		missileGrav *= .98;
	} else {
		missileGrav = .1;
	}
	ySpeed += missileGrav;
	
	// Rotation
	if (spinSpeed > 10) {
		spinSpeed *= .95;
	} else { 
		spinSpeed = 10;
		if (global.difficulty >= .5) {
		    playerX = obj_RunAndGun_Player.x;
			playerY = obj_RunAndGun_Player.y - 68;
			playerDir = point_direction(x, y, playerX, playerY);
		}
		phase = 2; 
		
	}
	image_angle = (image_angle + spinSpeed) % 360;
	
} else if (phase == 2) {
	x += xSpeed;
	y += ySpeed;
	if (image_angle + 90 < playerDir) {
		image_angle += spinSpeed;
	} else if (image_angle + 10 < playerDir) {
		spinSpeed *= .99;
		image_angle += spinSpeed;
	} else {
		image_angle = playerDir;
		phase = 3;
	} 
} if (phase == 3) {
	if (travelSpeed < 36) {
	    travelSpeed *= 1.15;
	} else {
		travelSpeed = 36;
	}
	if (stateTimer[0] < 2) {
	    stateTimer[0] += 1;
	} else {
		stateTimer[0] = 0;
		playerOffset += 10;
	}
	
	if (stateTimer[2] < 30) {
	    stateTimer[2] += 1;
		playerDir = point_direction(x, y, playerX, playerY + playerOffset);
	}
	
	xSpeed = lengthdir_x(travelSpeed, playerDir);
	ySpeed = lengthdir_y(travelSpeed, playerDir);
	x += xSpeed;
	y += ySpeed;
	image_angle = playerDir;
}

if (phase < 3) {
    stateTimer[1] += 1
	if (stateTimer[1] < 2) {
	    stateTimer[1] += 1;
	} else {
		stateTimer[1] = 0;
		currentIndex = 1 - currentIndex;
	}
} else if (phase == 3) {											// Ensure instance is destroyed
	if (stateTimer[3] < 300) {
	    stateTimer[3] += 1;
	} else {
		instance_destroy();
	}
	if (stateTimer[1] < 5) {
	    stateTimer[1] += 1;
	} else if (currentIndex < image_index - 2) {
		stateTimer[1] = 0;
		currentIndex += 1;
	} else if (currentIndex == image_index - 2) {
		stateTimer[1] = 0;
		currentIndex = 2;
	}
} else {
	currentIndex = image_index - 1;
}
