// Dirstate = 1 for Right, -1 for Left
//End anchors, x coords
//3168
//7648

switch (moverState) {
    case 0:										// Stopped
		
		if (stateTimer[0] < 120) {						// Rest for 2 seconds
			stateTimer[0] += 1;
		} else {
			stateTimer[0] = 0;
			moverState = 1;								// Switch to next state
			moveSpeed = 4;
		}
        break;
	case 1:										// Moving
		// Spawn exhaust
		if (stateTimer[1] < 15) {						// Rest for 2 seconds
			stateTimer[1] += 1;
		} else {
			stateTimer[1] = 0;
			var exhaustInst = instance_create_layer(x + (-72 * dirState), y - 12, "crateMovers", obj_runAndGun_crateMoverRing, {
				dir:dirState
			});
		}
		// Determine speed and blend mode from dirState and position
		var checkpoints = (dirState == 1) ? bounds.right : bounds.left;
		var nearEnd = (dirState == 1) ? bounds.left : bounds.right;
		var nextX = x + dirState * moveSpeed;
		// Normalize comparisons by multiplying both sides by dirState
		// "a < b" becomes "-a < -b", or "a > b"
		if (dirState * nextX < dirState * checkpoints.low) {
			accelSpeed();
			if (dirState == -1 && x < nearEnd.low) {
			    if (boundsBGView > 0) {
				    boundsBGView -= .2;
					boundsBGView *= .95;
				} else {
					if (moverObj == noone) {
					    moverObj = instance_create_layer(x,y,"crateMovers", obj_runAndGun_moverObj, {
							creatorID: id,
							sprite_index: sprite_index,
							dirState: dirState
						});
					}
					boundsBGView = 0;
				}
			}
		} else if (dirState * nextX < dirState * checkpoints.high) {
			decelSpeed();
			if (dirState == -1) {
			    if (boundsBGView < 100) {
				    boundsBGView += .1;
					boundsBGView *= 1.05
				} else {
					boundsBGView = 100;
				}
				if ( moverObj != noone) {
					instance_destroy(moverObj);
					moverObj = noone;
				}
			}
		} else {
			x = checkpoints.high;
			moveSpeed = 0;
			moverState = 2;
			dirState *= -1;
			stateTimer[1] = 0;
		}
        break;
	case 2:										// Turning Around
		if (dirState == 1 && boundsBGView > 0) {
		    boundsBGView -= .2;
			boundsBGView *= .98;
		} else if (dirState == -1 && boundsBGView < 100) {
			boundsBGView += .2;
			boundsBGView *= 1.2;
		}
		switch (turnInit) {
		    case 0:
		        if (path_index != -1) {
					path_end();
				} else {
					if (moverObj != noone) {
					    instance_destroy(moverObj);
						moverObj = noone;
					}
					var turnPath = dirState == -1? toPath : backPath;
				    path_start(turnPath, pathSpeed, 0, 0);
					turnInit = 1;
				}
				exhaustIndex = 0;
		        break;
			case 1:
				// Determine image_index from dirState and path_position
				image_index = ((dirState == 1) ? (1 - path_position) : path_position) * (image_number - .5);
		        if (path_position > .5) {
				    depth = dirState == 1 ? -450 : -250;
				}
				if (path_position == 1) {
				    path_end();
					x = dirState == -1 ? 7648 : 3168;	// Re-align mover
					turnInit = 0;
					moverState = 0;
					// Spawn mover
					if (dirState == 1 && moverObj == noone) {
					    moverObj = instance_create_layer(x,y,"crateMovers", obj_runAndGun_moverObj, {
							creatorID: id,
							sprite_index: sprite_index,
							dirState: dirState
						});
					}
				}
		        break;
		}
        break;
}

x = round(x / 4) * 4;
y = round(y / 4) * 4;
