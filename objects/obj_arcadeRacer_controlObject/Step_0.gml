var i, p;
//initialize
step = 1/fps;


//player death
if (flyState = 0) {
	if ((playerX < -1000 || playerX > 1000) && deathState = 0) {
		deathState = 1;
		if (playerX < -800) {
			deathSide = 0;
		} else if (playerX > 800) {
			deathSide = 1;
		}
	}
}


for(var n = startPosTest + 12; n >= startPosTest + 7; n-=1) {	
	if (flyState = 0 && array_length(segments[n, sg.vehicle]) != 0) {
		for (var j = 0; j < array_length(segments[n, sg.vehicle]); ++j) {
		    if (segments[n, sg.vehicle][j].xCoordinate - 100  <= playerX + 80 && segments[n, sg.vehicle][j].xCoordinate + 100 >= playerX - 80) {
				deathState = 1;
				deathSide = 2;
			}
		}
	}
}


//calculate movement on x/y axis

if (currentPos >= trackSize) {
	currentPos = 0;
	position = 0;
}
potential = round(increase(position, step * myspeed, trackSize * segmentLength));

if (potential != 0) {
	position = potential;
}

if (deathState = 0 && playerControl = 1) {
	if flyState = 0 {
		if (keyboard_check(ord("W"))) {
		    myspeed = myspeed + (accel * step);
		} else {
		    myspeed = myspeed + ( decel * step);
			if myspeed < 10 {
				myspeed = 0;
			}
		}
		if(keyboard_check(vk_space)) {
		    myspeed = myspeed + (braking * step);
		}
	
		if(keyboard_check(ord("A"))) {
			x_speed = (x_speed - speedModX - elevationMod) * .95; // minus
			if (keyboard_check(vk_space)) {
				x_speed = x_speed - ((speedModX - elevationMod) * 2);
			}
		} else if(keyboard_check(ord("D")) ) {
			x_speed = (x_speed + speedModX + elevationMod) * .95; // plus
			if (keyboard_check(vk_space)) {
				x_speed = x_speed + ((speedModX + elevationMod) * 2) ;
			}
		}
		
		if (!keyboard_check(ord("A")) && !keyboard_check(ord("D"))) || (keyboard_check(ord("A")) && keyboard_check(ord("D"))) {
			if abs(x_speed) > 0 {
				x_speed *= .90;
			} else if abs(x_speed) > .25 {
				x_speed = 0;
			}
		}
	speedModX = myspeed/8000;
	speedModY = myspeed/10000;
	}
	
	if (flyState = 1) {
		myspeed = maxSpeed/2;
		if (keyboard_check(ord("W"))) {
			y_speed -= speedModY; // minus
		} else if (keyboard_check(ord("S")) ) {
		    y_speed += speedModY; // plus
		}
		if (keyboard_check(ord("A"))) {
		   x_speed -= speedModX; // minus
		} else if(keyboard_check(ord("D")) ) {
		    x_speed += speedModX; // plus
		}
		if (!keyboard_check(ord("A")) && !keyboard_check(ord("D"))) || (keyboard_check(ord("A")) && keyboard_check(ord("D"))) {
			if abs(x_speed) > 0 {
				x_speed *= .90;
			} else if abs(x_speed) > .25 {
				x_speed = 0;
			}
		}
		if (!keyboard_check(ord("W")) && !keyboard_check(ord("S"))) || (keyboard_check(ord("W")) && keyboard_check(ord("S"))) {
			if abs(y_speed) > 0 {
				y_speed *= .90;
			} else if abs(y_speed) > .25 {
				y_speed = 0;
			}
		}	
		x_speed = clamp(x_speed,-20,20);
		y_speed = clamp(y_speed,-20,20);
		speedModX = myspeed * .00008;
		speedModY = myspeed * .00008;
	}
}




if ((speedModX < .04 || speedModX = -.04) && myspeed < 4) {
	speedModX = 0;
}
if ((speedModY < .04 || speedModY = -.04) && myspeed < 4) {
	speedModY = 0;
}



if (x_speed > 70) {
	x_speed = 70;
} else if (x_speed < -70) {
	x_speed = -70
}

if (y_speed > 50) {
	y_speed = 50;
} else if (y_speed < -50) {
	y_speed = -50
}


//player slow down when they drive off the road

if ((playerX < -615 || playerX > 615) && deathState = 0 && flyState = 0) {
	
	//create smoke
	if (startPosTest < 9100) {
		smokeCount += 1;
		if (smokeCount >= step * 8) {
			if (playerX < -615) {
				if (array_length(segments[startPosTest + 15, sg.smokeL]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeL], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX + 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
			if (playerX < -715) {
				if (array_length(segments[startPosTest + 15, sg.smokeR]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeR], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX - 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
		
			if (playerX > 615) {
				if (array_length(segments[startPosTest + 15, sg.smokeL]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeL], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX + 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
			if (playerX > 715) {
				if (array_length(segments[startPosTest + 15, sg.smokeR]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeR], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX - 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
			smokeCount = 0;
		}
	}
	
	
	//slow down car
	sandCount +=.02;
	if (sandCount > 1) {
		sandCount = 1;
	}
	myspeed *= 1 - sandCount*step;
	
} else {
	if (sandCount > 0) {
		sandCount = 0;
	}
	if (smokeCount > 0) {
		smokeCount = 0;
	}
}


myspeed = clamp (myspeed, 0, maxSpeed);

//move player
if (deathState = 0) {
	playerX += x_speed;
	playerY += y_speed;
	if (flyState = 1) {
		playerX = clamp(playerX,200,width - 200);
		playerY = clamp(playerY,200,height - 200);
	}
	
	
	
	currentPos = potential / segmentLength;

	startPosTest = currentPos;

	startPosTest = floor(currentPos);
}



if (deathState = 1) {
	sprite_index = spr_ArcadeRacer_PlayerCarCrash;
	image_speed = 1;
	crashIndex += .5
	if (playerX < -900) {
		playerX = -900;
	} else if (playerX > 900) {
		playerX = 900;
	} else {
		playerX = playerX;
	}
	
	if (image_index >= image_number - 1) {
		image_speed = 0;
	}
	
	if (image_index > 5) {
		//create smoke
	if (startPosTest < 9100) {
		smokeCount += 1;
		if (smokeCount >= step * 8) {
			if (playerX < -615) {
				if (array_length(segments[startPosTest + 15, sg.smokeL]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeL], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX + 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
			if (playerX < -715) {
				if (array_length(segments[startPosTest + 15, sg.smokeR]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeR], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX - 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
		
			if (playerX > 615) {
				if (array_length(segments[startPosTest + 15, sg.smokeL]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeL], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX + 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
			if (playerX > 715) {
				if (array_length(segments[startPosTest + 15, sg.smokeR]) = 0) {
					array_push(segments[startPosTest + 15, sg.smokeR], {sprite:spr_ArcadeRacer_CarSmoke1, imageIndex:irandom(2), xCoordinate:playerX - 100, yCoordinate:0, zCoordinate:(startPosTest + 15) * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				}
			}
			smokeCount = 0;
		}
	}
	}
	myspeed = myspeed + (braking * (step/2));
	if (myspeed < 0) {
			myspeed = 0;
			x_speed = 0;
			deathState = 2;
			if (deathSide = 0) {
				targetX = -400;
			} else if (deathSide = 1) {
				targetX = 400;
			} else {
				targetX = 0;
			}
		}
	myspeed *= (1 - sandCount*step) * .98;
	currentPos = potential / segmentLength;

	startPosTest = currentPos;

	startPosTest = floor(currentPos);
}

if (deathState = 2) {
	speedModX = 0;
	crashIndex = 0;
	sprite_index = spr_ArcadeRacer_PlayerCar;
	image_index = 0;
	x_speed = 0;
	
	if (playerX > targetX + 20) {
		playerX -= 8;
	} else if (playerX < targetX - 20) {
		playerX += 8;
	} else {
		deathState = 0;
		image_speed = 0;
	}
}



//checkpoints

//checkpoint 1

//checkpoint 2
if (startPosTest >= 16400 && startPosTest <= 17500) {
		playerControl = 0;
	} else {
		playerControl = 1;
	}
if (playerControl = 0 && (startPosTest >= 16400 && startPosTest <= 17400)) {
	x_speed = 0;
	if (playerX < -1 || playerX > 1) {
		if (abs(playerX) > 1) {
			playerX *= .98
		}
		if (abs(playerX) <= 1) {
			playerX = 0;
		}
	}
	if (myspeed > 12000) {
		myspeed = myspeed + (( decel * step) * 2);
		myspeed = floor(myspeed);
	}
	if (myspeed < 11000) {
		myspeed = myspeed + (accel * step);
		myspeed = floor(myspeed);
	}
	
	if (startPosTest >= 16800) {
		if (playerY > height/2 + 200) {
			playerY -= 1;
		}
	}
}
if (flyState = 0 && startPosTest > 17400) {
	flyState = 1;
	x_speed = 0;
	y_speed = 0;
	if (playerX != width/2 || playerY != height/2) {
		playerX = width/2;
		playerY = height/2 + 200;
	}
}

//scroll bg
if (startPosTest >= 50) {
	if (segments[startPosTest-20, sg.curve] < 0) {
		var tempBg = layer_get_id("Background")
		var tempBgX = layer_get_x(tempBg)
		layer_x(tempBg, tempBgX - (segments[startPosTest, sg.curve] * 10))
	}

	if (segments[startPosTest-20, sg.curve] > 0) {
		var tempBg = layer_get_id("Background")
		var tempBgX = layer_get_x(tempBg)
		layer_x(tempBg, tempBgX - (segments[startPosTest, sg.curve] * 10))
	}
}



//debug

if (keyboard_check_pressed(ord("I"))) {
	position = potential + 10000;
}

if (keyboard_check_pressed(ord("O"))) {
	position = potential + 50000;
}

if (keyboard_check_pressed(ord("P"))) {
	position = potential + 100000;
}

if (keyboard_check_pressed(ord("J"))) {
	position = potential - 10000;
}

if (keyboard_check_pressed(ord("K"))) {
	position = potential - 50000;
}

if (keyboard_check_pressed(ord("L"))) {
	position = potential - 100000;
}