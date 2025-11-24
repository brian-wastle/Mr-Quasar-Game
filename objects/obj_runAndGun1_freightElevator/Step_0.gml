if (y > 988) { // raise elevator
    
	
	if (y % 40 = 0) {
		y -= 8;
	} else {
		y -= 1;
	}
	
	
	
}  else if (stateTimer[0] < 20) { //pause
    stateTimer[0] += 1;
} else {
	obj_runAndGun1_pitCover.state = 2;
	y = 988;
}

if (instance_exists(obj_runAndGun1_ragingBull)) { // destroy elevator object when door shuts
	obj_runAndGun1_ragingBull.x = x;
    obj_runAndGun1_ragingBull.y = y;
}


