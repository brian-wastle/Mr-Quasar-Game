

switch (enemyState) {
    case 1:
		if ((currentIndex < 10 && stateTimer[0] < 5) || (currentIndex >= 10 && stateTimer[0] < 15)) {
		    stateTimer[0] += 1;
		} else {
			currentIndex += 1;
			stateTimer[0] = 0;
		}
		if (currentIndex = image_number) {
		    currentIndex -= 3;
		}
		// change state on scene end
		if (!instance_exists(obj_textbox)) {
		    enemyState = 2;
			currentIndex = image_number - 1;
			stateTimer[0] = 0;
			obj_runAndGun1_scientist.scientistState = 3;
		}
        break;
	case 2:
		if (sprite_index != spr_runAndGun1_bossReact1) {
		    sprite_index = spr_runAndGun1_bossReact1;
			currentIndex = 0;
		}
		
		if (currentIndex < 4) {
		    if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		} else if (currentIndex < 8 ) {
			if (stateTimer[0] < 3) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			if (stateTimer[1] < 30) {
			    stateTimer[1] += 1;
			} else {
				if (stateTimer[0] < 10) {
					stateTimer[0] += 1;
				} else {
					stateTimer[0] = 0;
					currentIndex += 1;
				}
				if (currentIndex == image_number) {
				    currentIndex -= 4;
					stateTimer[1] = 0;
				}
			}
		}
		break;
	case 3:
		if (sprite_index != spr_runAndGun1_bossReact2) {
		    sprite_index = spr_runAndGun1_bossReact2;
			currentIndex = 0;
		} 
			
		if (currentIndex < 3) {
		    if (stateTimer[0] < 10) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			var indexDelay = currentIndex % 2 == 0? 3 : 5;
			
			if (stateTimer[0] < indexDelay) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
			if (currentIndex == image_number) {
				currentIndex = 3;
			}
		if (obj_textEngine.boxIndex > obj_textEngine.totalBoxes) {
			enemyState = 4;
			currentIndex = 2;
			stateTimer[0] = 0;
		}
		}
		
		break;
	case 4:
		if (sprite_index != spr_runAndGun1_bossReact3) {
		    sprite_index = spr_runAndGun1_bossReact3;
			currentIndex = 0;
		}
		if (currentIndex < 5) {
		    if (stateTimer[0] < 6) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			var indexDelay = currentIndex % 2 == 0? 45 : 15;
			
			if (stateTimer[0] < indexDelay) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
			if (currentIndex == image_number) {
				currentIndex = 5;
			}
		}
		if (!instance_exists(obj_textbox)) {
			enemyState = 5;
			stateTimer[0] = 0;
			obj_textEngine.scene = 4;
		}
		break;
	case 5:
		if (sprite_index != spr_runAndGun1_bossReact4) {
		    sprite_index = spr_runAndGun1_bossReact4;
			currentIndex = 0;
		}
		if (currentIndex < 10) {
		    if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			var indexDelay = currentIndex % 2 == 0? 45 : 15;
			
			if (stateTimer[0] < indexDelay) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
			if (currentIndex == image_number) {
				currentIndex = 10;
			}
		}
		if (obj_textEngine.boxIndex > obj_textEngine.totalBoxes) {
			enemyState = 6;
			stateTimer[0] = 0;
			stateTimer[1] = 0;
		}
		break;
	case 6:
	
		if (sprite_index != spr_runAndGun1_bossReact5 && stateTimer[1] == 0) {
		    sprite_index = spr_runAndGun1_bossReact5;
			currentIndex = 0;
			stateTimer[1] = 1;
		}
		
		if ( currentIndex < image_number - 1) {
		    if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		}  else {
			if (sprite_index == spr_runAndGun1_bossReact5) {
			    sprite_index = spr_runAndGun1_bossReact6;
			} else if (sprite_index = spr_runAndGun1_bossReact6) {
				currentIndex = 0;
			} 
		}
		
		// transition to next state
		if (sprite_index == spr_runAndGun1_bossReact6 && 
		currentIndex == image_number - 1 &&
		obj_textbox.currentPage == obj_textbox.totalPages - 1) {
			stateTimer[1] = 0;
			stateTimer[0] = 0;
		    enemyState = 7;
		}
		break;
	case 7:
		if (sprite_index != spr_runAndGun1_bossReact7) {
		    sprite_index = spr_runAndGun1_bossReact7;
			currentIndex = 0;
			obj_runAndGun1_pitCover.state = 3;
			instance_create_layer(13020, 1308, "Objects", obj_runAndGun1_freightElevator); // Spawn 8 px below screen
		}
		if (currentIndex < 11) {
		    if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else {
			var indexDelay = currentIndex % 2 == 0? 10 : 50;
			
			if (stateTimer[0] < indexDelay) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
			if (currentIndex == image_number) {
				currentIndex = 11;
			}
		}

		if (!instance_exists(obj_textbox)) {
			if (stateTimer[1] < 120) {
			    stateTimer[1] += 1;
			} else if (currentIndex >= 11) {
			    stateTimer[1] = 0;
				enemyState = 8;
				stateTimer[0] = 0;
			} 
		}
		break;
	case 8:
		if (sprite_index != spr_runAndGun1_bossReact8) {
			sprite_index = spr_runAndGun1_bossReact8;
			currentIndex = 0;
		}
		if (currentIndex < image_number - 1) {
			if (stateTimer[0] < 5) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		}  else {
			enemyState = 9;				
		}
		break;
	case 9:
		if (sprite_index != spr_runAndGun1_bossReact9) {
			sprite_index = spr_runAndGun1_bossReact9;
			obj_textEngine.scene = 5;
			currentIndex = 0;
		}
			
		if (currentIndex < image_number - 1) {
			if (stateTimer[0] < 6) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		} else {
			if (!instance_exists(obj_textbox)) {
				enemyState =  10;
				obj_textEngine.scene = 6;
				stateTimer[0] = 0;
				stateTimer[1] = 0;
			} else {
				if (stateTimer[1] < 90) {
					stateTimer[1] += 1;
				} else {
					stateTimer[0] = 0;
					stateTimer[1] = 0;
					currentIndex = 5;
				}
			}
		}
		break;
	case 10:
		if (sprite_index != spr_runAndGun1_bossReact10) {
			sprite_index = spr_runAndGun1_bossReact10;
			currentIndex = 0;
		}
			
		if (currentIndex < image_number - 1) {
			if (stateTimer[0] < 5) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else {
			if (stateTimer[1] < 90) {
				stateTimer[1] += 1;
			} else {
				stateTimer[0] = 0;
				stateTimer[1] = 0;
				currentIndex = 11;
				
				if (!instance_exists(obj_textbox) &&
				obj_runAndGun1_scientist.scientistState != 9) {
					obj_runAndGun1_scientist.scientistState = 9;
					enemyState = 11;
				}
			}
			
		}
		break;
	case 11: 
		if (sprite_index != spr_runAndGun1_bossReact11) {
			sprite_index = spr_runAndGun1_bossReact11;
			currentIndex = 0;
			with (obj_runAndGun_camera) {
				scrCameraFollow(obj_runAndGun1_control);
			}
		}
		
		if (currentIndex < image_number - 1) {
			if (stateTimer[0] < 5) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		}
		if (!instance_exists(obj_runAndGun1_scientist) && currentIndex == image_number - 1) {
		    enemyState = 12;
			stateTimer[0] = 0;
		}
		break;
	case 12:
		if (sprite_index != spr_runAndGun1_bossTransform) {
			sprite_index = spr_runAndGun1_bossTransform;
			currentIndex = 0;
		}
		
		if (currentIndex < image_number - 1) {
			if (stateTimer[0] < 5) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		} else {
			enemyState = 13;
			stateTimer[0] = 0;
		}
		break;
	// Transition to boss' idle state

	case 13:
		if (sprite_index != spr_runAndGun1_bossIntro2) {
			sprite_index = spr_runAndGun1_bossIntro2;
			currentIndex = 0;
			x -= 296;
		}
		
		if (currentIndex < image_number - 1) {
			if (stateTimer[0] < 5) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		} else if (currentIndex == image_number - 1) {
			stateTimer[0] += 1;
			if (stateTimer[0] == 30) {
				instance_create_layer(x,y,"Objects", obj_runAndGun1_miniboss2);
				instance_destroy();
			}
		}
		break;
}

if (obj_RunAndGun_Player.x > 12200 && enemyState == 0) {
	enemyState = 1;						
	obj_textEngine.scene = 1;			
	with (obj_runAndGun_camera) {
	    scrCameraFocus(
	        12720,
	        .1,		//room_height / 2, etc.
	        1					// zoom_levels[1]
	    );
	}
}