// Enemy States
// 100			- Appear on screen
// 0			- Idle
// 1			- Chase
// 2			- Walk up medium range
// 3			- Line up vertically
// 4			- Move in to attack
// 5			- Attack
// 6			- Take Damage
// 7			- KO'd
// 8			- Wait when player is stacked with enemies
// 9			- Avoid overlap with other enemies
// 10			- Detour to opposite side of player when required to attack
// 11			- Back away when too close to player
// 12			- Grabbed
// 13			- Dead



depth = -y;
dirOffset = (sign(obj_beatEmUp_player.x - x) != 0) ? sign(obj_beatEmUp_player.x - x) : dirOffset;
shakeOffset = 0;

// Handle hitflag detection
if (hitflag != 0) {
	playerHitflag = obj_beatEmUp_Player_hb.hitflag;
    if (hitflag != playerHitflag || (enemyState != 6 && enemyState != 7)) {
	    hitflag = 0;
	}
}

// Appear on screen
if (enemyState == 100) {
    if (point_distance(x, y, xGoal, yGoal) > 4) {
        mp_potential_step_object(xGoal, yGoal, 4, obj_beatEmUp_enemyParent);
    } else {
        enemyState = 0;
    }
} else {
    xGoal = obj_beatEmUp_player.x;
    yGoal = obj_beatEmUp_player.y;
	playerDist = point_distance(x, y, xGoal, yGoal);
}

// Damage Triggers
if (place_meeting(x, y, obj_beatEmUp_Player_hb) && enemyHealth > 0 && hitflag == 0 && enemyState != 13) {
	var player = obj_beatEmUp_player;
	var actionstate = player.actionstate;
	spikeFlag = 0;
	playerHitflag = obj_beatEmUp_Player_hb.hitflag;
	hitflag = playerHitflag;
	
	// If enemy is already in a damage stun lock
	if (enemyState == 6) {
		if (actionstate == 3) {
			// If player is in combo attack
			player.freezeTimer = 4;
			enemyHealth -= 20;
			attackStack += 1;
			freezeTimer = 40;
			if (player.image_index >= 22 && player.image_index < 23) {
				attackStack = 5;
			}
		} else if (player.airAttackState == 1) {
		// If player is in air attack 1
			var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
			if (zDiff < 144) {
				player.freezeTimer = 8;
				enemyHealth -= 20;
				attackStack += 1;
				freezeTimer = 40;
			} else {
				hitflag = 0;
			}
		} else if (player.airAttackState == 2) {
		// If player is in spike
			var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
			if (zDiff < 272) {
				player.freezeTimer = 8;
				enemyHealth -= 10;
			    enemyState = 7;            // Go directly to knockdown
				spikeFlag = 1;             // Mark that we’re spiked
				bounceFactor = .75;
				knockbackForce = -30;      // Negative => forcibly shoot downward
				knockbackDist = 0;         // No horizontal push, or set how you like
				knockbackState = 0;        // Reset the sub-state so it re-initializes
				freezeTimer = 0;           // So it goes immediately
				comboTimer = 0;
			} else {
				hitflag = 0;
			}
		}
			
	// If enemy is already KO'd
	} else if (enemyState == 7) {
		// If player is in combo attack and enemy is in the air -- juggle
		if (zsp > 72 && zsp < 176 && (knockbackState > 0 && knockbackState < 11) 
		&& actionstate == 3) {
			player.freezeTimer = 4;
			enemyHealth -= 10;
			knockbackDir = (x > obj_beatEmUp_player.x) ? 1 : -1;
			xVel = 12 * knockbackDir;
			zVel = 12;  
			knockbackDist = 12;
			knockbackForce = 12;
			knockbackState = 1;
			freezeTimer = 4;
		} else if ((knockbackState > 0 && knockbackState < 11) && player.airAttackState == 1) {
		// If player is in air attack 1
			var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
			if (zsp > 12 && zDiff < 12 && zDiff > -160) {
				player.freezeTimer = 8;
				enemyHealth -= 10;
				knockbackDir = (x > obj_beatEmUp_player.x) ? 1 : -1;
				xVel = 14 * knockbackDir;
				zVel = 8;  
				knockbackDist = 14;
				knockbackForce = 8;
				knockbackState = 1;
				freezeTimer = 8;
			} else {
				hitflag = 0;
			}
		} else if ((knockbackState > 0 && knockbackState < 11) && player.airAttackState == 2) {
		// If player is in spike
			var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
			if (zDiff < 128 && zDiff > 12) {
				xVel = 0;
				player.freezeTimer = 2;
				enemyHealth -= 10;
			    enemyState = 7;            // Go directly to knockdown
				spikeFlag = 1;             // Mark that we’re spiked
				bounceFactor = .75;
				knockbackForce = -45;      // Negative => forcibly shoot downward
				knockbackDist = 0;         // No horizontal push, or set how you like
				knockbackState = 0;        // Reset the sub-state so it re-initializes
				freezeTimer = 2;           // So it goes immediately
				comboTimer = 0;
			} else {
				hitflag = 0;
			}
		} else {
			hitflag = 0;
		}

	// If enemy is on their feet
	} else if (enemyState != 7) {
		// If player is in combo attack
		if (actionstate == 3) {
			player.freezeTimer = 4;
			enemyHealth -= 20;
		    enemyState = 6;
			comboTimer = 0;
		    freezeTimer = 30;
			// If player is in combo attack
			if (player.image_index >= 22 && player.image_index < 23) {
				attackStack = 5;
			}
		} else if (player.airAttackState == 1) {
		// If player is in air attack 1
			var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
			if (zDiff < 144) {
				player.freezeTimer = 8;
				enemyHealth -= 10;
				airkickFlag = 1;
			    enemyState = 6;
				comboTimer = 0;
			    freezeTimer = 30;
			} else {
				hitflag = 0;
			}
		} else if (player.airAttackState == 2) {
		// If player is in spike
			var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
			if (zDiff < 272) {
				player.freezeTimer = 2;
				enemyHealth -= 10;
			    enemyState = 7;            // Go directly to knockdown
				spikeFlag = 1;             // Mark that we’re spiked
				bounceFactor = .75;
				knockbackForce = -30;      // Negative => forcibly shoot downward
				knockbackDist = 0;         // No horizontal push, or set how you like
				knockbackState = 0;        // Reset the sub-state so it re-initializes
				freezeTimer = 2;           // So it goes immediately
				comboTimer = 0;
			} else {
				hitflag = 0;
			}
		}
	} else {
		hitflag = 0;
	}
}


// Idle
if (enemyState == 0) {
    image_speed = 1;
    sprite_index = spriteArray[charIndex][0];
    if (enemyState != previousState) {
        image_index += irandom_range(2, 4);
    }
    if (freezeTimer > 0) {
        freezeTimer -= 1;
    } else {
        enemyState = 1;
    }
}

// Chase
if (enemyState == 1) {
	sprite_index = spriteArray[charIndex][1];
	direction = point_direction(x, y, xGoal, yGoal);
    image_speed = 1;
	var xOffset = x - xGoal;
	var yOffset = y - yGoal;
	
    if (abs(xOffset) > 450 || abs(yOffset) > 75) {
        mp_potential_step_object(xGoal, yGoal, 4, obj_beatEmUp_enemyParent);
    } else {
        enemyState = 2;
    }
}

// Walk up medium range
if (enemyState == 2) {
	sprite_index = spriteArray[charIndex][1];
    image_speed = 1;
    var xDistance = dirOffset * 200;
    targetX = xGoal - xDistance;
    if (!place_free(targetX, yGoal)) {
        targetX = xGoal + xDistance;
    }
    if (point_distance(x, y, targetX, yGoal) >= 5 && point_distance(targetX, yGoal, xGoal, yGoal) <= point_distance(x, y, targetX, yGoal)) {
        mp_potential_step_object(targetX, yGoal, 3, obj_beatEmUp_enemyParent);
    } else {
        enemyState = 3;
    }
}

// Line up vertically outside
if (enemyState == 3) {
	sprite_index = spriteArray[charIndex][1];
    image_speed = 1;
    var distToGoal = point_distance(x, y, xGoal, yGoal);
    if (distToGoal > 170) {
        direction = point_direction(x, y, xGoal, yGoal);
        mp_potential_step_object(xGoal, yGoal, 2, obj_beatEmUp_enemyParent);
    } else if (abs(x - xGoal) > 350) {
        enemyState = 2;
    } else {
        enemyState = 4;
    }
}

//Close-in for attack
if (enemyState == 4) {
	sprite_index = spriteArray[charIndex][1];
    image_speed = 1;
    var xDistance = dirOffset * 150;
    targetX = xGoal - xDistance;
    if (point_distance(x, y, targetX, yGoal) >= 5 && 
	point_distance(targetX, yGoal, xGoal, yGoal) <= point_distance(x, y, targetX, yGoal)) {
        mp_potential_step_object(targetX, yGoal, 3, obj_beatEmUp_enemyParent);
    } else if ((x < xGoal - 140 || x > xGoal + 140) && (y < yGoal + 8 && y > yGoal - 8)) {
        enemyState = 5;
		sprite_index = spriteArray[charIndex][3];
		image_index = 0;
    } else {
		enemyState = 11;
	}
}

// Attack
if (enemyState == 5) {
	if (hbFlag == 0) {
	    hitboxInst = instance_create_layer(x, y, "Instances", obj_beatEmUp_enemyHitbox, {
			parentId: id,
			dirOffset: dirOffset
		});
		hbFlag = 1;
	}
	
	direction = point_direction(x, y, xGoal, yGoal);
	image_speed = 0;
	var timerLimit = 2;
	comboTimer += 1;
	// Set timer for each frame
	switch (image_index) {
		case 0:
			timerLimit = 12;
			break;
		case 1:
			timerLimit = 8;
			break;
		case 5:
			timerLimit = 4;
			break;
		default:
			timerLimit = 2;
			break;
	}

	// Transition between frames
	if (comboTimer == timerLimit) {
		comboTimer = 0;
		if (image_index >= image_number - 1) {
		    enemyState = 0;
			freezeTimer = 60;
			hbFlag = 0;
		} else {
			image_index += 1;
		}
	}
}

// Take Damage
if (enemyState == 6) {
    image_speed = 0;
    sprite_index = spriteArray[charIndex][2];
    image_index = 0;
	
    if (freezeTimer > 0) {
        freezeTimer -= 1;
    } else {
        attackStack = 0;
        freezeTimer = 30;
        enemyState = 0;
    }
	// Attack Stack
	if (attackStack = 2) {
	    image_index = 1;
	} else if (attackStack >= 4) {
		enemyState = 7;
		freezeTimer = 0;
		image_index = 0;
		attackStack = 0;
	}
}

// KO'd
if (enemyState == 7) {
	sprite_index = spriteArray[charIndex][2];
    image_speed = 0;
	if (freezeTimer > 0) {
	    freezeTimer--;
		exit;
	}
	knockbackTimer += 1;
    // Initial/mid-air knockback setup
    if (knockbackState == 0) {
	    knockbackDir = (x > obj_beatEmUp_player.x) ? 1 : -1;

		if (knockbackForce == 0 && knockbackDist == 0) {
		    xVel = 12 * knockbackDir; 
		    zVel = 12;  // Max Z height
		} else {
			xVel = knockbackDist * knockbackDir; 
		    zVel = knockbackForce;  
		}
		
		if (spikeFlag == 1) {
            xVel = 0; // or maybe a small horizontal push
            zVel = knockbackForce; // e.g. -12
        }

	    knockbackState = 1;
	// First Bounce
	} else if (knockbackState == 1) {
		if (knockbackTimer <= 15 && bounceCount == 0) {
		    image_index = 2;
		} else if (knockbackTimer <= 30){
			image_index = 5;
			var dirIndex = (dirOffset - 1) / -2;
			mask_index = maskArray[0][dirIndex];
		} else {
			image_index = 3;
		}
	    x += xVel;
	    zsp += zVel;
	    zVel -= zGravity;
	    var viewX = camera_get_view_x(view_camera[0]);
	    var viewW = camera_get_view_width(view_camera[0]);
	    // Check if enemy is past edge of view
	    if (x < viewX || x > viewX + viewW) {
	        if (x < viewX) {
	            x = viewX;
	        } else {
	            x = viewX + viewW;
	        }
	        edgeSlamOldVel = xVel;
	        xVel = 0;
	        freezeTimer = 8;
	        knockbackState = 11;
	    }
	    // Collision with the ground
		if (zsp < 4) {
		    image_index = 4;
		}
		
	    if (zsp <= 0) {
	        zsp = 0;
			knockbackTimer = 0;
			bounceCount += 1;
	        knockbackState = 2;
	    }
	// Following bounces
	} else if (knockbackState == 2) {
	    // Start a smaller bounce
		bounceFactor = .5;
	    zVel = -zVel * bounceFactor;  // e.g. 50% of previous
	    if (abs(zVel) < 2) {
	        // If the bounce is too small, skip to “slide”
	        knockbackState = 3;
	    } else {
	        // We still have some bounce left—go back to “in air” logic
	        knockbackState = 1;
	    }
	// Slide state
	} else if (knockbackState == 3) {
	    image_index = 6;
		x += xVel;
	    // Apply friction or slow down
	    xVel *= 0.9; // or a friction constant

	    // If velocity is small, stop sliding
	    if (abs(xVel) < 0.2) {
	        xVel = 0;
	        // Return to default or death
	        if (enemyHealth > 0) {
				enemyState = 0;
			} else {
				enemyState = 13;
			} 
			spikeFlag = 0;
			knockbackForce = 0;
			knockbackDist = 0;
			knockbackTimer = 0;
	        knockbackState = 0;
			bounceFactor= 0.5;
			bounceCount = 0;
			mask_index = maskArray[1];
		}
	// Collide with walls
	} else if (knockbackState == 11) {
	    // Decrement freezeTimer
	    if (freezeTimer > 0) {
	        freezeTimer--;
	    }
	    // Control shake effect
	    shakeTimer += 1;
	    if (shakeTimer % 2 == 0) { 
	        image_xscale = -image_xscale; 
			if (mask_index == spr_beatEmUp_lrgEnemyCollision) {
			    mask_index = spr_beatEmUp_lrgEnemyCollision2;
			} else {
				mask_index = spr_beatEmUp_lrgEnemyCollision;
			}
	    }
	    // When freezeTimer runs out, flip velocity and resume
	    if (freezeTimer <= 0) {
	        // Reverse velocity to bounce back
	        xVel = -edgeSlamOldVel * 1.1;

	        // Ensure movement direction is properly reversed
	        knockbackDir = sign(xVel);

	        // Return to in-air knockback
	        knockbackState = 1;
	        shakeTimer = 0;
	    }
	}
}


// Wait when player is stacked with enemies
if (enemyState == 8) {
    var b = 80;
    var a = 4.5 * b;
    var angleStart = point_direction(xGoal, yGoal, x, y);
    for (var i = 0; i <= 180; i += 10) {
        var sweepAngleCW = degtorad(angleStart + i);
        targetX = xGoal + a * cos(sweepAngleCW);
        targetY = yGoal + b * sin(sweepAngleCW);
        if (place_free(targetX, targetY)) {
            foundPosition = 1;
            break;
        }
        var sweepAngleCCW = degtorad(angleStart - i);
        targetX = xGoal + a * cos(sweepAngleCCW);
        targetY = yGoal + b * sin(sweepAngleCCW);
        if (place_free(targetX, targetY)) {
            foundPosition = 1;
            break;
        }
    }
    if (foundPosition && point_distance(x,y,targetX,targetY) > 40) {
        mp_potential_step_object(targetX, targetY, 3, obj_beatEmUp_enemyParent);
    } else {
        freezeTimer = 60;
        enemyState = 0;
		foundPosition = 0;
    }
}

// Avoid overlapping with other enemies
if (enemyState == 9) {
    sprite_index = spriteArray[charIndex][1]; // Set appropriate sprite
    image_speed = 1;

    // Vector toward player
    var vPlayerX = obj_beatEmUp_player.x - x;
    var vPlayerY = obj_beatEmUp_player.y - y;
    var vPlayerLength = point_distance(0, 0, vPlayerX, vPlayerY);
    var vPlayer = [vPlayerX / vPlayerLength, vPlayerY / vPlayerLength]; // Normalized vector to player

    // Avoidance vector
    var vAvoidX = 0;
    var vAvoidY = 0;

    // Use instance_place_list to detect overlapping enemies
    var collisionList = ds_list_create();
    var numCollisions = instance_place_list(x, y, obj_beatEmUp_enemyParent, collisionList, 0);

    // Calculate avoidance vector based on nearby enemies
    if (numCollisions > 0) {
        for (var i = 0; i < numCollisions; i++) {
            var otherInst = collisionList[| i];
            if (otherInst.id != id) { // Ignore self
                var dx = x - otherInst.x;
                var dy = y - otherInst.y;
                var dist = point_distance(0, 0, dx, dy);
                if (dist > 0) {
                    vAvoidX += dx / dist;
                    vAvoidY += dy / dist;
                }
            }
        }
    }
    ds_list_destroy(collisionList); // Clean-up

    // Normalize the avoidance vector
    var vAvoidLength = point_distance(0, 0, vAvoidX, vAvoidY);
    if (vAvoidLength > 0) {
        vAvoidX /= vAvoidLength;
        vAvoidY /= vAvoidLength;
    }
    var vAvoid = [vAvoidX, vAvoidY]; // Final avoidance vector

    // Combine vectors
    var moveX = vPlayer[0] + vAvoid[0];
    var moveY = vPlayer[1] + vAvoid[1];
    var moveLength = point_distance(0, 0, moveX, moveY);
    moveX /= moveLength;
    moveY /= moveLength;

    // Step toward combined direction
    var moveSpeed = 3;
    mp_potential_step(x + moveX * moveSpeed, y + moveY * moveSpeed, moveSpeed, 0);

    // Return to normal behavior if no overlapping enemies
    if (vAvoidLength == 0) {
        enemyState = 1; // Back to chasing
    }
}

// Detour around the player when xGoal is blocked
if (enemyState == 10) {
    sprite_index = spriteArray[charIndex][1];
    image_speed = 1;

    if (!targetSet) {
        var verticalDirection = (yGoal > 860)? -1 : 1;
        targetY = obj_beatEmUp_player.y + (verticalDirection * 75);
        targetX = x; // Store initial X position when the state begins
        targetSet = 1;
		finalTargetX = targetX + ((playerDist + 200) * dirOffset);
    }
	
    // Move into position vertically first
    if (abs(y - targetY) > 16) {
        mp_potential_step_object(targetX, targetY, 3, obj_beatEmUp_enemyParent);
    } else {
        // Move horizontally once in position
        mp_potential_step_object(finalTargetX, y, 3, obj_beatEmUp_enemyParent);

        // Once 200px past the initial position, return to normal behavior
		
        if (abs(x - finalTargetX) < 40) {
            enemyState = 0;
			freezeTimer = 60;
            targetSet = 0;
        }
    }
}


//Back away and re-align with player when too close to attack
if (enemyState == 11) {
	sprite_index = spriteArray[charIndex][1];
    image_speed = 1;
    var xDistance = dirOffset * 150;
    targetX = xGoal - xDistance;
    if (point_distance(x, y, targetX, yGoal) >= 5) {
        mp_potential_step_object(targetX, yGoal, 2, obj_beatEmUp_enemyParent);
    } else if ((x < xGoal - 140 || x > xGoal + 140) && (y < yGoal + 8 && y > yGoal - 8)) {
        enemyState = 5;
		sprite_index = spriteArray[charIndex][3];
		image_index = 0;
    }
}



// Handle movement target interruptions/overlaps
if ((enemyState > 0 && enemyState < 5) || enemyState == 10) {
    var enemyOverlapLeft = place_meeting(xGoal - 150, yGoal, obj_beatEmUp_enemyParent);
	var enemyOverlapRight = place_meeting(xGoal + 150, yGoal, obj_beatEmUp_enemyParent);
	
	var enemyOverlapCenter = place_meeting(x, y, obj_beatEmUp_enemyParent);

	if  (enemyOverlapLeft && enemyOverlapRight) {
		enemyState = 8;
	}
	
	if (enemyOverlapCenter) {
	    enemyState = 9;
	}
	
	if ((x < xGoal && enemyOverlapLeft) || (x > xGoal && enemyOverlapRight)) {
		enemyState = 10;
	}
	
	if (enemyState == 10 && ((x < xGoal && !enemyOverlapLeft) || (x > xGoal && !enemyOverlapRight))) {
	    enemyState = 0;
		freezeTimer = 60;
        targetSet = 0;
	}
}

// Get grabbed
if (enemyState == 12) {
	image_speed = 0;
	x = obj_beatEmUp_player.x;
	y = obj_beatEmUp_player.y;
	if (obj_beatEmUp_player.grabBack == 1) {
	    if (freezeTimer == 0) {
			image_index = obj_beatEmUp_player.image_index;
			if (image_index = image_number - 1) {
			    freezeTimer = 6;
			}
		} else {
			if (freezeTimer > 1) {
			    freezeTimer -= 1;
			} else {
				x += 104 * dirOffset;
				freezeTimer = 0;
				sprite_index = spriteArray[charIndex][2];
				image_index = 2;
				enemyState = 7;
				enemyHealth -= 30;
				knockbackForce = 19;
				knockbackDist = 3;
			}
		}
	}
	
	if (obj_beatEmUp_player.grabAnim == 1) {
	    if (obj_beatEmUp_player.image_index == 4) {
			enemyHealth -= 1;
			zsp = 8;
		} else {
			zsp = 0;
		}
	}
	if (obj_beatEmUp_player.grabAnim == 2) {
		if (obj_beatEmUp_player.image_index == 13) {
		    freezeTimer = 0;
			x += 24 * -dirOffset;
			sprite_index = spriteArray[charIndex][2];
			image_index = 2;
			enemyHealth -= 30;
			enemyState = 7;
			knockbackForce = 18;
			knockbackDist = 18;
		}
	}
}


//Death
if (enemyHealth <= 0 && enemyState != 7 && enemyState != 13) {
    enemyState = 7;
	freezeTimer = 0;
}

if (enemyState == 13) {
    if (currentOpac < .1) {
		instance_destroy();
	}
}


///// Clean-up

// Flashing sprite / fade-out
if (enemyState == 6 || enemyState == 7 || enemyState = 13) {
	shakeTimer += 1;
	if (enemyState == 6 || (enemyState == 7 && knockbackState == 11)) {
	    shakeOffset = 2;
		switch (enemyState) {
		    case 6:
				if (shakeTimer % 5 == 0) {
					shakeDir *= -1;
					shakeOffset *= shakeDir;
				}
				if (shakeTimer % 5 == 2) {
					shakeDir *= -1;
					shakeOffset *= shakeDir;
				}
		        break;
			case 7:
		        if (shakeTimer % 3 == 0) {
				    shakeDir *= -1;
					shakeOffset *= shakeDir;
				}
				if (shakeTimer % 3 == 2) {
				    shakeDir *= -1;
					shakeOffset *= shakeDir;
				}
		        break;
		}
	} else if (enemyState == 13) {
		if (shakeTimer % 2 == 0) {
		    if (currentOpac == finalOpac) {
				currentOpac = .7;
				finalOpac *= .7;
			} else {
				currentOpac = finalOpac;
			}
		}
	}

} else {
	currentOpac = 1;
	shakeOffset = 0;
	shakeTimer = 0;
}


// Shadow Size
shadowSize = 1 * (1-(zsp / 231.25));
	if (shadowSize < .5) {
		shadowSize = .5;
	}
	
previousState = enemyState;
