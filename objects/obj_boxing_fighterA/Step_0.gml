    playerDir = obj_boxing_fighterB.xOffset;
    sprite_index = spriteArray[playerDir + 1]; // Match the direction player is facing
	var playerState = obj_boxing_fighterB.playerState;
    var target_x = obj_boxing_fighterB.x;
    var distance_to_player = abs(x - target_x);

    // Determine if the player is moving toward or away from this object
    playerMovingToward = (obj_boxing_fighterB.speed < 0 && x < target_x) || (obj_boxing_fighterB.speed > 0 && x > target_x);

    var room_left_bound = screenBuffer;
    var room_right_bound = room_width - screenBuffer;

    // Check if the player is near the edge of the screen
    player_near_left_edge = obj_boxing_fighterB.x <= room_left_bound + 100;
    player_near_right_edge = obj_boxing_fighterB.x >= room_right_bound - 100;

    // Check if the player is moving away from the tracker
    playerMovingAway = (obj_boxing_fighterB.speed > 0 && x < target_x) || (obj_boxing_fighterB.speed < 0 && x > target_x);

    // Manage sliding state
    if (!isSliding && distance_to_player < triggerDistance && playerMovingToward && 
        !(player_near_left_edge || player_near_right_edge)) {
        isSliding = true;
        slideStartTime = current_time; 
        targetSlidingX = (x < target_x) ? (target_x + offsetDistance) : (target_x - offsetDistance);
    }

    if (isSliding) {
        x = lerp(x, targetSlidingX, slideSpeed);
        x = clamp(x, room_left_bound, room_right_bound);
        if (distance_to_player > offsetDistance) {
            isSliding = false;
        } else if (current_time - slideStartTime >= switchDuration * 1000) {
            isSliding = false;
        }
    } else {
        // If not sliding, track the player position when outside the offset distance
        if (distance_to_player > offsetDistance && 
            !(player_near_left_edge || player_near_right_edge) &&
            !playerMovingAway) {
            // Smoothly track the player's position
            var targetSpeed = (target_x - x) * trackSpeed; // Calculate target speed towards player
            x += targetSpeed * (1 - trackSpeed); // Smoothly adjust the position
        }
    }
	
	
	if (playerState = 1) {
	    speed = -obj_boxing_fighterB.speed/2;
	} else {
		speed = 0;
	}

	if (player_near_left_edge) {
	    speed = 0.5;
	}
	if (player_near_right_edge) {
	    speed = -0.5;
	}
		
	if (x > 2200 && playerDir = 1) {
		x = -250;
	} else if ( x < -300 && playerDir = -1) {
		x = 2170;
	}