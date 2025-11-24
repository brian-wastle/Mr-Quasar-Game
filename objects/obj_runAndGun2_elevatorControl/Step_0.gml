// Reset empty sprite queue
if (array_length(spriteQueue) < 2 ) {
    spriteQueue = array_shuffle(list);
}

// Queue new elevators, and brake all elevators on a loop
//if (spawnTimer < 600) {
//    spawnTimer += 1;
//} else if (spawnTimer == 600 && loopCount < 1) {
//	loopCount += 1;
//	spawnTimer = 1;
//	var nextSpriteUp = array_shift(spriteQueue);
//	var thisUpId = instance_create_layer(5066, 1182, "Elevators", obj_runAndGun2_elevator, {
//		sprite_index: nextSpriteUp,
//		elevatorDir: -1,
//		creatorId: id
//	})
//	array_push(currentElevators, thisUpId);
//} else if (spawnTimer == 600 && loopCount == 1) {
//	if (elevLoop == 0) {
//	    var nextSpriteDown = array_shift(spriteQueue);
//         var thisDownId = instance_create_layer(5710, -66, "Elevators", obj_runAndGun2_elevator, {
//			sprite_index: nextSpriteDown,
//			elevatorDir: 1,
//			creatorId: id
//		})
//		array_push(currentElevators, thisDownId);
//		elevLoop = 1;
//	} else if (elevLoop == 1) {
//		for (var i = 0; i < array_length(currentElevators); ++i) {
//			currentElevators[i].brakeFlag = 1;
//		}
//		elevLoop = 2;
//	} else if (elevLoop == 2) {
//		if (brakeTimer < 200) {
//			brakeTimer += 1;
//		} else {
//			brakeTimer = 1;
//			for (var i = 0; i < array_length(currentElevators); ++i) {
//				currentElevators[i].brakeFlag = 0;
//				elevLoop = 0;
//				spawnTimer = 1;
//				loopCount = 0;
//			}
//		}
//	}
//}

if (spawnTimer < 600) {
    spawnTimer += 1;
} else if (spawnTimer == 600) {
	if (elevLoop == 0) {
		// Queue up a sprite and spawn the next elevator
		var nextSprite = array_shift(spriteQueue);
		if (loopCount == 0) {
			// Left
			var thisUpId = instance_create_layer(5066, 1182, "Elevators", obj_runAndGun2_elevator, {
				sprite_index: nextSprite,
				elevatorDir: -1,
				shadowOffset: 0,
				creatorId: id
			})
			array_push(currentElevators, thisUpId);
		} else if (loopCount == 1) {
			// Right
	         var thisDownId = instance_create_layer(5710, -66, "Elevators", obj_runAndGun2_elevator, {
				sprite_index: nextSprite,
				elevatorDir: 1,
				shadowOffset: 1,
				creatorId: id
			})
			array_push(currentElevators, thisDownId);
		}
		// Alternate spawn side
		loopCount = loopCount == 0 ? 1 : 0;
		// Brake sequence continues to end of event
		for (var i = 0; i < array_length(currentElevators); ++i) {
			currentElevators[i].brakeFlag = 1;
		}
		elevLoop = 1;
	} else if (elevLoop == 1) {
		if (brakeTimer < 120) {
			brakeTimer += 1;
		} else {
			brakeTimer = 1;
			for (var i = 0; i < array_length(currentElevators); ++i) {
				currentElevators[i].brakeFlag = 0;
				elevLoop = 0;
				spawnTimer = 1;
			}
		}
	}
}