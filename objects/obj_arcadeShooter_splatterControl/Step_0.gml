
//if cell touches an enemy and a bullet pop item

//accept values in an array from enemy objects when they die

//when the array length is longer than 0, advance the sprite associated with that cell

if (ds_queue_size(cellBackQueue) > 0) {
	currentBackPosition = ds_queue_dequeue(cellBackQueue);
	for (var i = 0; i < 2; ++i) {
		var tempPos = cellArrayBack[i][2];
		if (tempPos >= 3) {
			tempPos += .2;
		} else if (currentBackPosition >= cellArrayBack[i][0][0] && currentBackPosition <= cellArrayBack[i][0][1]) {
			if (obj_ArcadeShooter_Player.bulletType = 1) {
				tempPos += 1;
			} else if (obj_ArcadeShooter_Player.bulletType > 1) {
				tempPos += 1.5;	
			}
		}
		array_set(cellArrayBack[i], 2, tempPos);
	}
}

if (ds_queue_size(cellFrontQueue) > 0) {
	currentFrontPosition = ds_queue_dequeue(cellFrontQueue);
	for (var i = 0; i < 2; ++i) {
		var tempPos = cellArrayFront[i][2];
		if (tempPos >= 3) {
			tempPos += .2;
		} else if (currentFrontPosition >= cellArrayFront[i][0][0] && currentFrontPosition <= cellArrayFront[i][0][1]) {
			if (obj_ArcadeShooter_Player.bulletType = 1) {
				tempPos += 1;
			} else if (obj_ArcadeShooter_Player.bulletType > 1) {
				tempPos += 1.5;	
			}
		}
		array_set(cellArrayFront[i], 2, tempPos);
	}
}

if (ds_queue_size(cellHighQueue) > 0) {
	currentHighPosition = ds_queue_dequeue(cellHighQueue);
	for (var i = 0; i < 5; ++i) {
		var tempPos = cellArrayHigh[i][2];
		if (tempPos >= 3) {
			tempPos += .2;
		} else if (currentHighPosition >= cellArrayHigh[i][0][0] && currentHighPosition <= cellArrayHigh[i][0][1]) {
			if (obj_ArcadeShooter_Player.bulletType = 1) {
				tempPos += 1;
			} else if (obj_ArcadeShooter_Player.bulletType > 1) {
				tempPos += 1.5;	
			}
		}
		array_set(cellArrayHigh[i], 2, tempPos);
	}
}