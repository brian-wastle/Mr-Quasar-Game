if (obj_beatEmUp_player.x > 7643 && image_index == 0) {
	init = 1;
}

if (init == 1) {
	
	indexCount += 1;
	var timerAmount = 6;
	
	if (indexCount >= timerAmount) {
	    indexCount = 0;
		image_index += 1;
	}
	
	if (image_index == image_number - 1) {
		init = 0;
	}

}