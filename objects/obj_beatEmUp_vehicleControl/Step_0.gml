if (obj_beatEmUp_player.x > 5242) {
    instance_destroy();
}

switch (actionState) {
    case 0:
        if (spawnTimer > 0) {
		    spawnTimer -= 1;
		} else {
			actionState = irandom_range(1,3);
			if (actionState == 1) {
			} else if (actionState == 2) {
				stateTimer = 45;
			} else if (actionState == 3) {
				stateTimer = 90;
			}
			spawnTimer = 250;
		}
        break;
	case 1:
		randomIndex = irandom_range(0,5);
		bikeRate = 1 + (irandom_range(1,4) * .01);
        instance_create_layer(3660, 583, "Vehicles", obj_beatEmUp_bgBikes, {
			speed: 5,
			rate: bikeRate,
			image_index: randomIndex
		})
		actionState = 0;
        break;
	case 2:
		if (stateTimer == 25) {
		    randomIndex = irandom_range(0,5);
			bikeRate = 1 + (irandom_range(2,4) * .01);
	        instance_create_layer(3660, 583, "Vehicles", obj_beatEmUp_bgBikes, {
				speed: 5,
				rate: bikeRate,
				image_index: randomIndex
			});
		} else if (stateTimer == 1) {
		    randomIndex = irandom_range(0,5);
	        instance_create_layer(3660, 583, "Vehicles", obj_beatEmUp_bgBikes, {
				speed: 5,
				rate: bikeRate,
				image_index: randomIndex
			});
		}
		stateTimer -= 1;
		if (stateTimer == 0) {
		    actionState = 0;
		}
        break;
	case 3:
		if (stateTimer == 80) {
		    randomIndex = irandom_range(0,5);
			bikeRate = 1 + (irandom_range(2,4) * .01);
	        instance_create_layer(3660, 583, "Vehicles", obj_beatEmUp_bgBikes, {
				speed: 5,
				rate: bikeRate,
				image_index: randomIndex
			});
		} else if (stateTimer == 63) {
		    randomIndex += 1;
	        instance_create_layer(3660, 582, "Vehicles", obj_beatEmUp_bgBikes, {
				speed: 5,
				rate: bikeRate,
				image_index: randomIndex
			});
		} else if (stateTimer == 25) {
		    randomIndex += 1;
			bikeRate = 1 + (irandom_range(2,4) * .01);
	        instance_create_layer(3660, 583, "Vehicles", obj_beatEmUp_bgBikes, {
				speed: 5,
				rate: bikeRate,
				image_index: randomIndex
			});
		}
		stateTimer -= 1;
		if (stateTimer == 0) {
		    actionState = 0;
		}
        break;
}

//cars
if (carTimer > 0) {
    carTimer -= 1;
} else {
	var carIndex = irandom_range(0,5);
	instance_create_layer(4444, 236, "Vehicles", obj_beatEmUp_bgCars, {
		image_index: carIndex
	});
	instance_create_layer(4474, 260, "Vehicles", obj_beatEmUp_bgCars, {
		image_index: carIndex + 1
	});
	carTimer = 70;
}