if (obj_RunAndGun_Player.x > 12000 && scientistState == 0) {
	scientistState = 1;
}

switch (scientistState) {
	case 1:
		currentFrame += frameSpeed;
        if (currentFrame == image_number) {
		    currentFrame -= 2;
		}
		
		if (instance_exists(obj_textbox) && obj_textbox.currentPage = obj_textbox.totalPages - 1) {
		    scientistState = 2;
		}
		break;
    case 2:
		if (sprite_index != spr_runAndGun1_scientist1Fear) {
		    sprite_index = spr_runAndGun1_scientist1Fear;
			currentFrame = 0;
		}
		currentFrame += frameSpeed;
        if (currentFrame == image_number) {
			frameSpeed = .15;
		    currentFrame = 1;
		}
        break;
    case 3:
	//first line
		if (sprite_index != spr_runAndGun1_scientist1Interrupt) {
		    sprite_index = spr_runAndGun1_scientist1Interrupt;
			currentFrame = 0;
			frameSpeed = .2;
			obj_textEngine.scene = 2;
		}
        if (currentFrame < 4) {
		    currentFrame += frameSpeed;
		} else if (currentFrame >= 4 && currentFrame < 6) {
			if (stateTimer[0] < 12) {
			    stateTimer[0] += 1;
			} else {
				currentFrame += shiverFrame;
				shiverFrame *= -1;
				stateTimer[0] = 0;
			}
			if (!instance_exists(obj_textbox)) {
			    scientistState = 4;
				obj_textEngine.scene = 3;
				obj_runAndGun1_miniboss.enemyState = 3;
			}
		}
		break;
	case 4: 
		if (currentFrame < 10) {
		    currentFrame += .2;
		} else {
			// shivering loop
			if (stateTimer[0] < 6) {
			    stateTimer[0] += 1;
			} else {
				currentFrame += shiverFrame;
				shiverFrame *= -1;
				stateTimer[0] = 0;
			}
			if (obj_runAndGun1_miniboss.enemyState == 4) {
			    if (stateTimer[1] < 90) {
				    stateTimer[1] += 1;
				} else {
					stateTimer[1] = 0;
					scientistState = 2;
				}
			}
		}
		break;
	case 9:
		if (sprite_index != spr_runAndGun1_scientist1Button) {
		    sprite_index = spr_runAndGun1_scientist1Button;
			currentFrame = 0;
			frameSpeed = .2;
		}
		
		if (currentFrame < 19) {
		    currentFrame += frameSpeed * 2;
		} else {
			if (obj_runAndGun1_miniboss.enemyState != 11) {
			    obj_runAndGun1_miniboss.enemyState = 11;
			}
			currentFrame += frameSpeed;
		}
		if (currentFrame >= image_number - 1) {
		    instance_destroy();
		}
		break;
}