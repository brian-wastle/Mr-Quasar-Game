if (brakeFlag != 1) {
	brakeTimer = 1;
	if (accel < 10) {
	    accel += .25;
	}
	y += (elevatorDir * .25) * accel/10;

	if (y > 1200 || y < -100) {
		var arrRef = creatorId.currentElevators;
		var func = function(_element, _index) {
		    return (_element == id);
		}
		var _index = array_find_index(arrRef, func);
		array_delete(arrRef, _index, 1);
	    instance_destroy();
	}
} else {
	accel = 0;
	if (brakeTimer < 60) {
	    brakeTimer += 1;
		y += (elevatorDir * -1) * (.125 * (1 - brakeTimer/60));
	}
}