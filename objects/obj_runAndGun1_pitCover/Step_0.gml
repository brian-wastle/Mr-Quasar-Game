
// Opening/ Closing state
if (stateTimer[0] < 5 && (state == 3 || state == 2)) {
	    stateTimer[0] += 1;
	} else {
		stateTimer[0] = 0;
		if (state == 3) {
			mask_index = spr_blank;
		    if (currentIndex < image_number - 1) {
				currentIndex += 1;
			} else {
				state = 1;
			}
		} else if (state == 2) {
			if (currentIndex > 0) {
				currentIndex -= 1;
			} else {
				state = 0;
				if (instance_exists(obj_runAndGun1_freightElevator)) {
				    instance_destroy(obj_runAndGun1_freightElevator);
				}
			}
		}
	}