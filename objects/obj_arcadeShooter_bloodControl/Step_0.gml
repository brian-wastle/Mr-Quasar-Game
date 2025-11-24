
//if cell touches an enemy and a bullet pop item

//accept values in an array from enemy objects when they die

//when the array length is longer than 0, advance the sprite associated with that cell

if (ds_queue_size(cellLowQueue) > 0) {
	currentLowPosition = ds_queue_dequeue(cellLowQueue);
	for (var i = 0; i < 7; ++i) {
	    if (currentLowPosition >= cellArrayLow[i][0][0] && currentLowPosition <= cellArrayLow[i][0][1]) {
			var tempPos = cellArrayLow[i][2];
			if (obj_ArcadeShooter_Player.bulletType = 1) {
				tempPos += 1;
			} else if (obj_ArcadeShooter_Player.bulletType > 1) {
				tempPos += 1.5;	
			}
			array_set(cellArrayLow[i], 2, tempPos);
		}
	}
}
if (ds_queue_size(cellHighQueue) > 0) {
	currentHighPosition = ds_queue_dequeue(cellHighQueue);
	for (var i = 0; i < 3; ++i) {
	    if (currentHighPosition >= cellArrayHigh[i][0][0] && currentHighPosition <= cellArrayHigh[i][0][1]) {
			var tempPos = cellArrayHigh[i][2];
			if (obj_ArcadeShooter_Player.bulletType = 1) {
				tempPos += 1;
			} else if (obj_ArcadeShooter_Player.bulletType > 1) {
				tempPos += 1.5;	
			}
			array_set(cellArrayHigh[i], 2, tempPos);
		}
	}
}