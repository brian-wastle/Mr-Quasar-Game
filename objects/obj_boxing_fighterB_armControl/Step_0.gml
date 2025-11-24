keyLeft = keyboard_check_pressed(vk_left);
keyRight = keyboard_check_pressed(vk_right);
enemyOffset = abs(obj_boxing_fighterB.x - obj_boxing_fighterA.x) > 150 ? 
	sign(obj_boxing_fighterB.x - obj_boxing_fighterA.x) : 0;
var turn = turnOffset * enemyOffset;
x = obj_boxing_fighterB.x + turn;
y = obj_boxing_fighterB.y;

//trigger punch states
if ((punchState = 0 && stateOverride = 0) && stateQueue != 0) {
	queueState = "closed";
    punchState = stateQueue;
	stateQueue = 0;
}

if (queueState = "open") {
    if (keyRight) {
	    stateQueue = 1;
	}
	if (keyLeft) {
	    stateQueue = 2;
	}
}

//idle punch state
if (punchState == 0) {
	childSpeed = subStateData.idleSpeedArray[0];
	switch (enemyOffset) {
		case 1:
		    currentRightPath = pathData.idle[3];
			currentLeftPath = pathData.idle[3];
		    break;
		case -1:
		    currentRightPath = pathData.idle[0];
			currentLeftPath = pathData.idle[0];
		    break;
		default:
		    currentRightPath = pathData.idle[1];
			currentLeftPath = pathData.idle[2];
		    break;
	}
}

// right jab state
if (punchState == 1) {	
	//set arm paths
	if (subState < 3) {
		switch (enemyOffset) {
			case 1:
				currentRightPath = pathData.jabRight[subState * 2 + 1];
				currentLeftPath = pathData.jabRight[subState * 2];
				break;
			case -1:
				currentRightPath = pathData.jabRight[subState * 2 + 7];
				currentLeftPath = pathData.jabRight[subState * 2 + 6];
				break;
			default:
				currentRightPath = pathData.jabRight[subState * 2 + 13];
				currentLeftPath = pathData.jabRight[subState * 2 + 12];
				break;
		}
	}
}

// left jab state
if (punchState == 2) {	
	//set arm paths
	if (subState < 3) {
		switch (enemyOffset) {
			case 1:
				currentRightPath = pathData.jabLeft[subState * 2 + 1];
				currentLeftPath = pathData.jabLeft[subState * 2];
				break;
			case -1:
				currentRightPath = pathData.jabLeft[subState * 2 + 7];
				currentLeftPath = pathData.jabLeft[subState * 2 + 6];
				break;
			default:
				currentRightPath = pathData.jabLeft[subState * 2 + 13];
				currentLeftPath = pathData.jabLeft[subState * 2 + 12];
				break;
		}
	}
}

if (punchState == 1 || punchState == 2) {
    if (stateTimer > 1) {
	    stateTimer -= 1;
	} else if (stateTimer = 1) {
		subState += 1;
		stateTimer -= 1;
	} else {
		if (subState < 2) {
			stateTimer = subStateData.jabTimerArray[subState];
			childSpeed = subStateData.jabSpeedArray[subState];
		} else if (subState = 2) {
			stateTimer = subStateData.jabTimerArray[subState];
			childSpeed = subStateData.jabSpeedArray[subState];
			queueState = "open";
		} else {
			subState = 0;
			punchState = 0;
		}
	}
}


// Handle override states passed from player object

//State 1 - slide
if (stateOverride == 1) {
	childSpeed = subStateData.idleSpeedArray[0];
	switch (enemyOffset) {
		case 1:
		    currentRightPath = pathData.slide[3];
			currentLeftPath = pathData.slide[3];
		    break;
		case -1:
		    currentRightPath = pathData.slide[0];
			currentLeftPath = pathData.slide[0];
		    break;
		default:
		    currentRightPath = pathData.slide[1];
			currentLeftPath = pathData.slide[2];
		    break;
	}
}

//State 2 - block
if (stateOverride == 2) {
	childSpeed = subStateData.idleSpeedArray[0];
	switch (enemyOffset) {
		case 1:
		    currentRightPath = pathData.block[0];
			currentLeftPath = pathData.block[3];
		    break;
		case -1:
		    currentRightPath = pathData.block[0];
			currentLeftPath = pathData.block[3];
		    break;
		default:
		    currentRightPath = pathData.block[1];
			currentLeftPath = pathData.block[2];
		    break;
	}
}

// Initiate active arm paths

path_start(currentRightPath, 0, 0, 0);
//right arm position
for (var i = 0; i < 6; ++i) {
	xOnPath = path_get_x(currentRightPath, pathPositionsArray[i]);
	yOnPath = path_get_y(currentRightPath, pathPositionsArray[i]);
	armDataRight[i].childSpeed = childSpeed;
	armDataRight[i].x = x + armOffset[0] + xOnPath;
	armDataRight[i].y = y - armOffset[1] + yOnPath;
}

path_start(currentLeftPath, 0, 0, 0);
//left arm position
for (var i = 0; i < 6; ++i) {
	xOnPath = path_get_x(currentLeftPath, pathPositionsArray[i]);
	yOnPath = path_get_y(currentLeftPath, pathPositionsArray[i]);
	armDataLeft[i].childSpeed = childSpeed;
	armDataLeft[i].x = x - armOffset[0] + xOnPath;
	armDataLeft[i].y = y - armOffset[1] + yOnPath;
}