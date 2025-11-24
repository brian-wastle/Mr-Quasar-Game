image_speed = 0;
moverState = 1; //0 - stopped, 1 - moving, 2 - turning;
moveSpeed = 5;
minSpeed = 4;
dirState = 1;			// Current movement direction, -1 for Left
toSpeed = 48;			// Top speed right
backSpeed = 10;			// Top speed left
accelTo = 1.05;			// Accel right
accelBack = 1.05;		// Accel left
decel = .98;			// Decel rate
stateTimer[0] = 0;		// Mover delay while stopped
stateTimer[1] = 0;		// exhaust timer
toPath = path_runAndGun2_moversTo;
backPath = path_runAndGun2_moversBack;
pathSpeed = 4;
turnInit = 0;			// Whether turn path has begun
moverObj = noone;
bounds = {				// Boundaries for movement, includes when to slow down and also stop
	right: { low: 6300, high: 7648 },
	left:  { low: 4228, high: 3168 }
};
boundsBGView = 0;		// Whether mover should be drawn in foreground or BG

// Jet flame
exhaustIndex = 0;		// Track image index of exhaust sprite

if ((y - 128) % 280 == 0) {
    dirState = -1;
	image_index = image_number - 1;
}

moverObj = instance_create_layer(x,y,"crateMovers", obj_runAndGun_moverObj, {
	creatorID: id,
	sprite_index: sprite_index,
	dirState: dirState
});

function accelSpeed() {
	var topSpeed = dirState == 1 ? toSpeed : backSpeed;
	var thisAccel =  dirState == 1 ? accelTo : accelBack;
	if (moveSpeed * thisAccel < topSpeed) {
	    moveSpeed *= thisAccel;
	} else {
		moveSpeed = topSpeed;
	}
	x += moveSpeed * dirState;
}

function decelSpeed() {
	if (moveSpeed * decel > minSpeed) {
	   moveSpeed *= decel;
	} else {
		moveSpeed = minSpeed;
	}
	x += moveSpeed * dirState;
}
