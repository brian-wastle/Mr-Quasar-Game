 //actionstates
//0 - Still 
//1 - Walking 
//2 - Jumping  - button 1 
//3 - Combo Attacks / Air Attacks - button 2 
//4 - Block - shoulder button
//5 - Super Attacks - button 3
//6 - Slide - button 4
//7 - Grab
//8 - Take Damage
//9 - Air Damage
//10 - Knock Down
//11 - Back Attack
//13 - Die
//14 - Fall

////DEBUG

if (keyboard_check_pressed(ord("Y"))) {
	x += 1000;
}

depth = -y;

// Hitstop
if (freezeTimer > 0) {
	freezeTimer--;
	return;
}

///////////////////// UNIFIED INPUT HANDLING /////////////////////
var useGamepad = gamepad_is_connected(global.pad); // or global.pad if you store pad index

if (useGamepad) {
    var haxis = gamepad_axis_value(0, gp_axislh);
    var vaxis = gamepad_axis_value(0, gp_axislv);

    // Deadzone
    analogX = (abs(haxis) > deadzone) ? haxis : 0;
    analogY = (abs(vaxis) > deadzone) ? vaxis : 0;

    key_jump   = gamepad_button_check_pressed(0, gp_face1);
    key_attack = gamepad_button_check_pressed(0, gp_face3);
    key_block  = gamepad_button_check(0, gp_face2);
    key_super  = gamepad_button_check_pressed(0, gp_face4);
} else {
    // Keyboard/Mouse controls (existing logic):
    key_right = keyboard_check(ord("D"));
    key_left  = keyboard_check(ord("A"));
    key_up    = keyboard_check(ord("W"));
    key_down  = keyboard_check(ord("S"));
    key_jump  = keyboard_check(vk_space);
    key_block = keyboard_check(vk_shift);
    key_attack= mouse_check_button_pressed(mb_left);
    key_super = mouse_check_button_pressed(mb_right);
}

// If you want to set directionOffset for BOTH keyboard & gamepad:
if (actionstate < 2 || actionstate == 4) {
	if (useGamepad) {
	    if (analogX > 0)  directionOffset = 1;
		if (analogX < 0) directionOffset = -1;
	} else {
		if (key_right) directionOffset = 1;
		if (key_left)  directionOffset = -1;
	}
}
	
////////////////////////////////// Actionstate 0 - Still


if (actionstate < 2 || (actionstate = 4 && !key_block)) {
	if (useGamepad) {
		if (analogX == 0 && analogY == 0) {
			sprite_index = charArray[0,playerChar];
				if (hsp != 0 || vsp != 0) {
					hsp *= .7;
					vsp *= .7;

					if (hsp > 0 && hsp < 1 ) || (hsp < 0 && hsp > -1) {
						hsp = 0;
					}
					if (vsp > 0 && vsp < 1 ) || (vsp < 0 && vsp > -1) {
						vsp = 0;
					}
				}
				actionstate = 0;
		}
	} else {
		if ((!keyboard_check(ord ("W")) && !keyboard_check(ord ("A")) 
		&& !keyboard_check(ord ("S")) && !keyboard_check(ord ("D"))) 
		|| (key_up && key_down) || (key_left && key_right)) {
		    sprite_index = charArray[0,playerChar];
			if (hsp != 0 || vsp != 0) {
				hsp *= .7;
				vsp *= .7;

				if (hsp > 0 && hsp < 1 ) || (hsp < 0 && hsp > -1) {
					hsp = 0;
				}
				if (vsp > 0 && vsp < 1 ) || (vsp < 0 && vsp > -1) {
					vsp = 0;
				}
			}
			actionstate = 0;
		}
	}
}

if (actionstate == 0) {
    image_speed = 1;
}
	
	
////////////////////////////////// Actionstate 1 - Walking

var isDigitalMove = key_left || key_right || key_up || key_down;
var isAnalogMove  = (abs(analogX) > 0.2) || (abs(analogY) > 0.2);

if ((isDigitalMove || isAnalogMove) && (actionstate < 2 || (actionstate == 4 && !key_block))) {
	actionstate = 1;
	image_speed = 1;
}


if (actionstate == 1) {
	sprite_index = charArray[1, playerChar];
	// 1) If the analog stick is being pushed, do analog movement
	if (abs(analogX) > 0.2 || abs(analogY) > 0.2) {
	    hsp = analogX * hspMaxWalk;
	    vsp = analogY * vspMaxWalk;
	} else {
	    if ((key_right || key_left) && (hspWalk < hspMaxWalk)) {
	        hspWalk += 0.5;
	    }
	    if ((key_right && key_left) ||
	        (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) ||
	        (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D")))) {
	        hspWalk = 0;
	    }
	    hsp = (key_right - key_left) * hspWalk;

	    if ((key_up || key_down) && (vspWalk < vspMaxWalk)) {
	        vspWalk += 0.5;
	    }
	    if ((key_up && key_down) ||
	        (keyboard_check_released(ord("S")) && keyboard_check_pressed(ord("W"))) ||
	        (keyboard_check_released(ord("W")) && keyboard_check_pressed(ord("S")))) {
	        vspWalk = 0;
	    }
	    vsp = (key_down - key_up) * vspWalk;
	}
}

////////////////////////////////// Actionstate 2 - Jumping
	
if (key_jump && actionstate != 2 && actionstate != 14 && actionstate != 3 && actionstate != 7 && jumpStatus < 2 ) { 
	jumpStatus = 2;
	hspJump = hsp;
	hsp = 0;
	vspJump = vsp;
	vsp = 0;
	zspJump = zspMaxJump;
	actionstate = 2;
	sprite_index = charArray[3,playerChar];
	image_index = 0;
	image_speed = 1;
}
	
if (actionstate == 2) {	
	if (image_index >= 2) {
		if (airAttackState == 0) {
			if (zspJump < 13) {
				image_index = 3;
			} else {
				image_index = 2;
			}
			image_speed = 0;
		}
		zspJump -= .75;
	
		//move vertically	
		if (zspJump > zspMaxJump) {
			zspJump = zspMaxJump;
		}
		zsp += zspJump;
		
		//move horizontally
		if ((!useGamepad && key_right) || (useGamepad && analogX > 0)) && (abs(hspJump) < hspMaxJump) {
			hspJump += .6;
		}
		if ((!useGamepad && key_left) || (useGamepad && analogX < 0)) && (abs(hspJump) < hspMaxJump) {
			hspJump -= .6;
		}
		hsp = hspJump;
		vsp = 0;
	}
}
	
////////////////////////////////// Actionstate 3 - Attack Combo

if (actionstate == 3) {
				
	var timerLimit = 4;
	comboTimer += 1;
		
	if (image_index > 5 && image_index < 9) {
		timerLimit = 2;
	} 
		
	if (image_index > 10 && image_index < 15) {
		timerLimit = 2;
	}
		
	if (image_index > 16 && image_index < 21) {
		timerLimit = 2;
	}
				
	if (comboTimer == timerLimit) {
		comboTimer = 0;
		image_index += 1;
	}

	switch (image_index) {
		case 3:
		case 6:
		case 12:
		case 17:
			if (key_attack) {
				if (directionOffset == 1 && ((!useGamepad && key_left) || (useGamepad && analogX < 0))) {
					backAttackState = 1;
				} else if (directionOffset == -1 && ((!useGamepad && key_right) || (useGamepad && analogX > 0))) {
					backAttackState = -1;
				} else {
				attackQueue = 1;
				}
			}
			if (backAttackState != 0) {
				attackQueue = 0;
				actionstate = 11;
				returnIndex = image_index;
			} else {
				if (attackQueue == 1 && comboTimer == 0) {
					attackQueue = 0;
				} else if (attackQueue == 0 && comboTimer == 0) {
					sprite_index = charArray[0,playerChar];
					actionstate = 0;
				}
			}
			break;
		case 9:
		case 15:
		case 22:
			timerLimit = 8;
			break;
		case image_number: 
			sprite_index = charArray[0,playerChar];
			actionstate = 0;
			attackQueue = 0;
			backAttackState = 0;
		default:
			if (key_attack) {
				if (directionOffset == 1 && ((!useGamepad && key_left) || (useGamepad && analogX < 0))) {
					backAttackState = 1;
				} else if (directionOffset == -1 && ((!useGamepad && key_right) || (useGamepad && analogX > 0))) {
					backAttackState = -1;
				} else {
				attackQueue = 1;
				}
			}
			break;
	}
		
	if (image_index > 21) {	
		x += directionOffset * 4;
	}
		
		
		//Activate jump cancel
	if (key_jump && image_index > 9 && image_index != 15 && image_index < 22) {
		actionstate = 2;					  // Switch to the jump action
		sprite_index = charArray[3, playerChar];
		image_index = 0;					  // Start jump animation at frame 0
		image_speed = 1;					  // Let the jump animation play
		jumpStatus = 1;					   // So it uses the jumping logic in your step event
		zspJump = zspMaxJump;				 // Immediately set jump speed
		attackQueue = 0;					  // State clean-up
		comboTimer = 0;
	}
}

if (actionstate < 2 && key_attack) {
	actionstate = 3;
	sprite_index = charArray[2, playerChar];
	image_index = 0;
	image_speed = 0;
	hsp = 0;
	vsp = 0;
}
	
////////////////////////////////// Air Attacks

if (sprite_index = charArray[3,playerChar] && key_attack && jumpStatus == 2 && (image_index < 4 || image_index > 5)) {
	// Forward Air Attack
	//if (key_left || key_right || key_up || key_down) {
		if (actionstate == 2 || (actionstate == 14 )) {
			if (useGamepad) {
			    if (analogY > .7 && abs(analogX) < .3) {
				    airAttackState = 2;
					sprite_index = charArray[8, playerChar];
					image_index = 0;
					image_speed = 1;
				} else {
					image_index = 3;
					image_speed = 1;
					airAttackState = 1;
				}
			} else {
				if (!key_down) {
				    image_index = 3;
					image_speed = 1;
					airAttackState = 1;
				} else {
					airAttackState = 2;
					sprite_index = charArray[8, playerChar];
					image_index = 0;
					image_speed = 1;
				}
			}
		}

		if playerChar = 2 {
			if (!instance_exists(obj_beatEmUp_PlayerRobotSmoke)) {
				instance_create_layer(x,y,"Instances",obj_beatEmUp_PlayerRobotSmoke);
			}
			if (directionOffset == 1) {
				hspJump += 8;
			} else {
				hspJump -= 8;
			}
			
		}
		
		
//} 
	
// Neutral Air attack
//else if (!key_left && !key_right && !key_up && !key_down) {
//	image_index = 3;
//	if playerChar = 2 {
//		if (!instance_exists(obj_beatEmUp_PlayerRobotSmoke)) {
//			instance_create_layer(x,y,"Instances",obj_beatEmUp_PlayerRobotSmoke);
//		}
//		if (directionOffset = 1) {
//			hspJump += 4;
//		} else {
//			hspJump -= 4;
//		}
			
//	}
//}
}


////////////////////////////////// Actionstate 4 - Block

if (actionstate < 2 && key_block) {
	actionstate = 4;
	hspWalk = 0;
	vspWalk = 0;
	hsp = 0;
	vsp = 0;
}

if (actionstate == 4) {
	sprite_index = charArray[2,playerChar];
	image_index = 1;
	image_speed = 0;
}
	
	
////////////////////////////////// Actionstate 7 - Grab

if (actionstate == 7) {
	image_speed = 0;
	hsp = 0;
	vsp = 0;
	var currentForward = grabForwardState;
	if (key_attack && grabBack == 0 && grabAnim == 0) {
		if (!useGamepad && ((directionOffset == -1 && key_right) || (directionOffset == 1 && key_left)))
		|| (useGamepad && ((directionOffset == -1 && analogX > 0) || (directionOffset == 1 && analogX < 0))) {
			grabBack = 1;
			grabTimer = 0;
			sprite_index = charArray[7,playerChar];
			image_index = 0;
		} else {
			grabForwardState += 1;
		}
	}

	if (grabBack == 1) {
		var timerLimit = 4;
		grabTimer += 1;
		if (image_index < 4) {
			timerLimit = 4;
		} else if (image_index >= 4 && image_index < 6) {
			timerLimit = 6;
		} else if (image_index >= 6 && image_index < 7) {
			timerLimit = 3
		} else if (image_index == 7) {
			if (!instance_exists(obj_beatEmUp_slamEffect)) {
				instance_create_layer(x + 132 * -directionOffset, y, "Instances", obj_beatEmUp_slamEffect);
			}
			timerLimit = 8;
		}
		
		if (image_index == image_number - 1 && grabTimer == timerLimit) {
			grabTimer = 0;
			grabBack = 0;
			grabForwardState = 0;
			actionstate = 0;
			sprite_index = charArray[0,playerChar];
			directionOffset *= -1;
		}
		
		if (grabTimer == timerLimit) {
			grabTimer = 0;
			image_index += 1;
		}

	} else if (currentForward != grabForwardState) {
		if (grabForwardState < 4) {
			image_index = 1;
			grabAnim = 1;
		} else {
			image_index = 7;
			grabAnim = 2;
		}
	} 
	
	if (grabAnim == 1) {
		var timerLimit = 4;
		grabTimer += 1;
		
		if (image_index == 4) {
			timerLimit = 8;
		} else if (image_index >= 2 && image_index < 4) {
			timerLimit = 3;
		}
		
		if (image_index == 6 && grabTimer == timerLimit) {
			grabTimer = 0;
			grabAnim = 0;
		}
		
		if (grabTimer == timerLimit) {
			grabTimer = 0;
			image_index += 1;
		}
	} else if (grabAnim == 2) {
		var timerLimit = 4;
		grabTimer += 1;
		
		if (image_index >= 11 && image_index < 14) {
			timerLimit = 3;
		} else if (image_index == 9) {
			timerLimit = 8;
		} else if (image_index == 14) {
			timerLimit = 12;
		}
		
		if (image_index == image_number - 1 && grabTimer == timerLimit) {
			grabTimer = 0;
			grabForwardState = 0;
			grabAnim = 0;
			grabBack = 0;
			actionstate = 0;
			sprite_index = charArray[0,playerChar];
		}
		
		if (grabTimer == timerLimit) {
			grabTimer = 0;
			image_index += 1;
		}
	}
}



////////////////////////////////// Actionstate 8 - Take Damage

if (actionstate == 8) {
	sprite_index = charArray[4,playerChar]; 
	image_speed = 0;

	// Decrement iFrameTimer
	if (iFrameTimer > 0) {
		iFrameTimer--;
	}
	// Decrement damageTimer
	if (damageTimer > 0) {
		damageTimer--;
	} else {
		// Once damageTimer hits 0, reset the stack, go back to idle
		attackStack = 0;
		actionstate = 0;
		sprite_index = charArray[0,playerChar];
		image_index = 0;
	}

	// Attack Stack logic
	if (attackStack == 2) {
		if (knockbackDir == 1) {
			image_index = 1;
		} else {
			image_index = 0;
		}
	} else if (attackStack >= 3) {
		// Go to knockdown state
		actionstate = 10; 
		damageTimer = 0;
		image_index = 2;
		attackStack = 0;
	}

	// Lessen the horizontal push each step to simulate friction
	hsp *= 0.9;
	x += hsp;
}



////////////////////////////////// Actionstate 9 - Air Damage
if (actionstate == 9) {
	// Set your damage sprite (the same one you use for knockdown or a unique one)
	sprite_index = charArray[4,playerChar]; 
	// If your sprite has multiple frames for air flailing, set image_index accordingly
	image_speed = 0; 

	// Simulate a knock-up or juggle
	// Gravity
	zspJump -= 0.7;	// tweak to adjust fall speed
	zsp += zspJump;	// apply to your "z" variable
	// Horizontal friction
	hspJump *= 0.95;   
	hsp = hspJump;  
 
	// Once the player "lands," transition to knockdown or ground damage
	if (zsp <= 0) {
		zsp = 0;

		// If you want an immediate knockdown after air damage:
		actionstate = 10; 
		// Reset or pick a sub-image for the knockdown
		image_index = 0;

		// Optionally reset or keep attackStack, etc.
		// attackStack = 0;  // if you want them to recover fresh from a new state
	}
}



////////////////////////////////// Actionstate 10 - Knockdown
if (actionstate == 10) {
	hsp = 0;
	// Use your knockdown/damage sprite
	// e.g. charArray[4, playerChar] or a dedicated “knockdown” sprite
	sprite_index = charArray[4, playerChar];
	image_speed = 0;

	// Increase knockbackTimer each step
	knockbackTimer += 1;

	switch (knockbackState) {
		case 0:
			xVel = 12 * knockbackDir; 
			zVel = 12;	// Max Z height for the bounce
			knockbackState = 1;
			break;
		case 1:
			// Animate via knockbackTimer if you have different frames
			if (knockbackTimer <= 15) {
				image_index = 2; // Example “in-air, rising up”
			} else  {
				image_index = 3; // Example “in-air, coming down”
			}
			// Move horizontally
			x += xVel;
			// Move vertically
			zsp += zVel;
			// Gravity
			zVel -= zGravity;
			// Check edge-of-screen collision
			var viewX = camera_get_view_x(view_camera[0]);
			var viewW = camera_get_view_width(view_camera[0]);
			if (x < viewX || x > viewX + viewW) {
				// We slam into the side
				if (x < viewX) {
					x = viewX;
				} else {
					x = viewX + viewW;
				}
				edgeSlamOldVel = xVel;
				xVel = 0;
				freezeTimer = 8;	   // Pause/hitstop
				knockbackState = 11;   // Go to “edge slam” sub-state
			}

			// If we are close to the ground
			if (zsp < 4) {
				image_index = 4; // almost landed
			}

			// Once we actually pass “0” or below, we land
			if (zsp <= 0) {
				zsp = 0;
				knockbackTimer = 0;
				knockbackState = 2; // Next bounce logic
			}
			break;

		// 2) Following bounces
		case 2:
			image_index = 5;
			// Start a smaller bounce
			zVel = -zVel * bounceFactor;
			if (abs(zVel) < 2) {
				knockbackState = 3;
			} else {
				knockbackState = 1;
			}
			break;

		// 3) Slide state
		case 3:
			x += xVel;
			// Apply friction
			xVel *= 0.9;
			// If velocity is small, stop sliding
			if (abs(xVel) >= 0.2) {
				image_index = 6;
			} else {
				xVel = 0;
				if (playerHealth > 0) {
					image_speed = 1;
					iFrameTimer = 1;
					if (image_index >= image_number - 1) {
						image_speed = 0;
						iFrameTimer = 0;
						actionstate = 0;
						// Reset knockback variables for the next time
						knockbackTimer = 0;
						knockbackState = 0;
					}
				} else {
					iFrameTimer = 1;
					image_speed = 0;
					actionstate = 13; // “Dead” state
				}
			}
			break;
		// 11) Collide with walls
		case 11:
			// Reverse velocity to bounce back
			xVel = -edgeSlamOldVel;
			// Ensure movement direction is reversed
			knockbackDir = sign(xVel);
			// Return to in-air knockback
			knockbackState = 1;
			break;
	}
}

////////////////////////////////// Actionstate 11 - Back Attack

if (actionstate == 11) {
    sprite_index = charArray[5, playerChar]; 
    image_speed = 1;
    
    if (key_attack) {
        attackQueue = 1;
    }
    
    if (image_index >= image_number - 1) {
		if ((!useGamepad && ((directionOffset == 1 && key_left) || (directionOffset == -1 && key_right)))
		|| (useGamepad && ((directionOffset == 1 && analogX < 0) || (directionOffset == -1 && analogX > 0)))) {
	        directionOffset *= -1;
	    }
        comboTimer = 0;
        actionstate = 3;
        backAttackState = 0;
        image_speed = 0;
        sprite_index = charArray[2, playerChar]; 
        image_index = returnIndex - 1;
    }
}

////////////////////////////////// Actionstate 14 - Falling


if (actionstate == 2 && (zspJump <= 0)) {
	zspJump = 0;	
	actionstate = 14;
	if hspJump = 0 && hspWalk != 0 {
		if hsp > 0 {
			hspJump = hspWalk;
		}
		if hsp < 0 {
			hspJump = hspWalk * -1;
		}
	}
}

if (actionstate == 14) {
	if (landingTimer == 0) {
		if (airAttackState == 0) {
			image_index = 6;
		}
			
		//move horizontally
		if ((!useGamepad && key_right) || (useGamepad && analogX > 0)) && (abs(hspJump) < hspMaxJump)
			{
			hspJump += .6;
			}
		if ((!useGamepad && key_left) || (useGamepad && analogX < 0)) && (abs(hspJump) < hspMaxJump)
			{
			hspJump -= .6;
			}
		hsp = hspJump;
		vsp = 0;
	
		//drop from jump height
		zspJump += 1;
	
		if zspJump > 24
			{zspJump = 24;}
			
		if (key_down && zsp > 0) {
            // Tweak the “-1” to taste for how strong the fast-fall is
            fastFall += 1; 
        }
		
		if (airAttackState == 2) {
		    fastFall = 24;
		}
		
		zsp -= zspJump + (fastFall);
	}

	if landingTimer > 0 {
		sprite_index = charArray[3, playerChar]; 
		image_index = 7;
		fastFall = 0;
		jumpStatus = 3;
		landingTimer -= 1;
	}
	if landingTimer == 1 {
		airAttackState = 0;
		landingTimer = 0;
		jumpStatus = 0;
		actionstate = 0;
	} 
		
}


////////////////////////////////// Clean-up  //////////////////////////////////////////////////////////////////////////////////////////////////////////

//if (!key_jump && actionstate != 2 && actionstate != 14) {
//	jumpStatus = 0;
//}

if x - 20 < camera_get_view_x(view_camera[0]) {
	x = camera_get_view_x(view_camera[0]) + 20;
}
	
// Enemy collision handling/ grab
if (place_meeting(x, y, obj_beatEmUp_enemyParent)) {
	var colList = ds_list_create();
	var instCount = instance_place_list(x, y, obj_beatEmUp_enemyParent, colList, 0);
	for (var i = 0; i < instCount; ++i) {
		var currentInst = colList[| i];
		if (zsp == 0 && actionstate < 2 && 
		currentInst.enemyState != 5 && currentInst.enemyState != 7 && currentInst.enemyState != 13 &&
		((currentInst.x < x && currentInst.x > x - 52 && directionOffset == -1) || 
		(currentInst.x > x && currentInst.x < x + 52 && directionOffset == 1)) &&
		(currentInst.y < y + 6 || currentInst.y > y - 6)) {
			actionstate = 7;
			sprite_index = charArray[6,playerChar];
			image_speed = 0;
			image_index = 0;
			currentInst.enemyState = 12;
			currentInst.freezeTimer = 0;
			currentInst.sprite_index = currentInst.spriteArray[currentInst.charIndex][4];
			currentInst.image_index = 0;
			currentInst.attackStack = 0;
			currentInst.image_speed = 0;
			currentInst.y = y + 1;
		} else if (actionstate != 7 && currentInst.enemyState != 6) {
			//apply_push(currentInst, 2);
		}
	}
	ds_list_destroy(colList);
}

//////////////////////////// Actionstate 1 - Walking

if (actionstate == 1) {
	if hspWalk > hspMaxWalk {
		hspWalk = hspMaxWalk;
	}
	
	if hsp > hspMaxWalk {
		hsp = hspMaxWalk;
	}
	if hsp < (hspMaxWalk * -1) {
		hsp = hspMaxWalk * -1;
	}
	
	if vspWalk > vspMaxWalk {
		vspWalk = vspMaxWalk;
	}
	if vsp > vspMaxWalk {
		vsp = vspMaxWalk;
	}
	if vsp < vspMaxWalk * -1 {
		vsp = vspMaxWalk * -1;
	}
	
}

y = y + vsp;
if y < 700 {
	y = 700;
}
if y > 1075 {
	y = 1075;
}
x = x + hsp;		
	
//////////////////////////// Actionstate 3 - Attack Combo
	
if (actionstate != 3 && comboTimer != 0) {
	comboTimer = 0;
}
	
	
/////////////////////////// Actionstate 14 - Falling
		
if ((zsp <= 0) && actionstate == 14 && jumpStatus == 2) { 
	landingTimer = 10;
	if (playerChar = 2) {
		landingTimer = 15;
	}
	airAttackState = 0;
	hspJump = 0;
	hsp = 0;
	vspJump= 0;
	vsp = 0;
	zspJump = 0;
	zsp = 0;
	image_index = 7;
	image_speed = 0;
}

// (zsp / 231.25) 0 to 1
shadowSize = 1 * (1-(zsp / 231.25));
if (shadowSize < .5) {
	shadowSize = .5;
}

if ((actionstate == 2 || actionstate == 14) && jumpStatus == 2) {
	if (airAttackState == 1 && image_index >= 5) {
	    image_index = 5;
		image_speed = 0;
	} else if (airAttackState == 2 && image_index >= 2) {
		image_index = 2;
		image_speed = 0;
	}
	
}

// Check if player's hurtbox collides with enemy's hitbox
var enemyInst = instance_place(x, y, obj_beatEmUp_enemyHitbox);

if (enemyInst != noone && iFrameTimer == 0 && actionstate != 2 && actionstate != 14 && (actionstate < 8 || actionstate > 10)) {
	playerHealth -= 20;					// Apply damage
	actionstate = 8;					// Set state
	iFrameTimer = 8;					// i frames
	damageTimer = 24;					// Timer for state length
	// Instance’s x position for knockback/damage sprite image index
	knockbackDir = sign(x - enemyInst.x) = 1 ? 1 : -1;
	hsp = knockbackDir * 4;  
	sprite_index = charArray[4, playerChar];
	if (knockbackDir == -1) {
		image_index = 1;
	} else {
		image_index = 0;
	}
	image_speed  = 0;
	hsp = 0;
	vsp = 0;
	instance_destroy(enemyInst);
} else if (enemyInst != noone && iFrameTimer == 0 && actionstate == 8) {
	// Combo hits
	attackStack += 1;
	playerHealth -= 20;
	iFrameTimer = 8;
	damageTimer = 24;
	knockbackDir = sign(x - enemyInst.x) = 1 ? 1 : -1;
	hsp = knockbackDir * 6;
	if (knockbackDir == -1) {
		image_index = 1;
	} else {
		image_index = 0;
	}
	hsp = 0;
	vsp = 0;
	instance_destroy(enemyInst);
}

x = round(x);
y = round(y);