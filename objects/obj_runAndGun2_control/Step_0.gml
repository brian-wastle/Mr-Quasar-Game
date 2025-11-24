if (obj_RunAndGun_Player.x > 2630) {
    active = 1;
} else {
	active = 0;
}

if (active) {
	// Handle cleanup of movers
	if (array_length(moverArray) > 0) {
		cleanUpMovers(500,2000);
	}
	switch (controlState) {
	    case 0:	// boarding
			if (array_length(moverArray) == 0) {
				// Spawn movers on a short delay
			    stateFunction(0, boardingCB);
			}
			// Lock camera on control object 
			if (obj_RunAndGun_Player.x > 3080 && obj_runAndGun_camera.targetObj != id) {
				x = 3888;
			    obj_runAndGun_camera.targetObj = id;
			}
			// Change state
			if (obj_RunAndGun_Player.x > 3888) {
			    stateTimer[0] = 0;
				controlState = 1;
				targetMover = findCameraTarget();
			}
	        break;
	    case 1:	// align camera with target mover each step
			if (!instance_exists(targetMover)) {
				targetMover = findCameraTarget();
			}
			// Camera will just follow this control object
			if (x < 7100) {
				if (instance_exists(targetMover) && targetMover.x > 4200) {
					x = targetMover.x - 260;
				}
			} else {
				x = 7100;
			}
			// If player is off movers, and movers are heading back, advance state
			if (obj_RunAndGun_Player.x > 7484) {
				var moversArrived = 0;
			    for (var i = 0; i < array_length(moverArray); ++i) {
				    if (moverArray[i].dirState == -1) {
					    moversArrived += 1;
					}
				}
				if (moversArrived == array_length(moverArray)) {
				    controlState = 2;
					var cam = view_camera[0];
					var vx = camera_get_view_x(cam);
					var vw = camera_get_view_width(cam);
					instance_create_layer(vx + vw + 250,360,"Instances", obj_runAndGun_flyingBike);
				}
			}
	        break;
		case 2:
		// Trigger helicopter
		
		// Manually trigger shelf collapse
			if (keyboard_check_pressed(ord("L"))) {
				instance_create_layer(7480,804,"Instances",obj_runAndGun2_fallingTrigger);
			    controlState = 3;
			}
			break;
		case 3:
			// Move camera towards boss platform
			if (moveSpeed < maxSpeed) {
			    moveSpeed += .1;
				moveSpeed *= accel;
			}
			if (x < 9700) {
			    x += moveSpeed;
			} else if (x < 10680) {
			    if (!sd_active) {
			        sd_active = true;
			        sd_x.v = moveSpeed;
			    }
			    x = soft_damp1d_step(x, 10696, sd_x);
			    moveSpeed = sd_x.v;
			} else {
			    // Reached/after the stop
			    x = 10680;
			    moveSpeed = 0;
			    sd_active = false;
				controlState = 4;
			}
			break;
		case 4:
			if (obj_RunAndGun_Player.x >= x) {
			    obj_runAndGun_camera.targetObj = obj_RunAndGun_Player;
			}
			
			if (obj_RunAndGun_Player.x >= 11620) {
				x = 11620;
			    obj_runAndGun_camera.targetObj = id;
			}
			break;
	}
} else {
	// Handle mover clean-up
	if (array_length(moverArray)) {
	    cleanUpMovers(500,2000);
	}
}

x = round(x / 4) * 4;
y = round(y / 4) * 4;
