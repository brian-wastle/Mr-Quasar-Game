list = [
	spr_runAndGun2_elevator1,
	spr_runAndGun2_elevator2,
	spr_runAndGun2_elevator3,
	spr_runAndGun2_elevator4,
	spr_runAndGun2_elevator5,
	spr_runAndGun2_elevator6,
	spr_runAndGun2_elevator7,
	spr_runAndGun2_elevator8,
	spr_runAndGun2_elevator9
];

spriteQueue = array_shuffle(list);
currentElevators = [];	// All elevators on screen

spawnTimer = 1;			// Timer for spawning elevators
brakeTimer = 1;			// Timer for braking elevators
elevLoop = 0;			// Allows elevators to brake
loopCount = 0;

// Generate pre-existing elevators
for (var i = 0; i < 4; ++i) {
	var offset = (300 * i);
	var nextSpriteDown = array_pop(spriteQueue);
	var yPosDown = -66 + offset;
	var thisDownId = instance_create_layer(5710, yPosDown, "Elevators", obj_runAndGun2_elevator, {
		sprite_index: nextSpriteDown,
		elevatorDir: 1,
		creatorId: id
	})
	array_push(currentElevators, thisDownId);
	
    var nextSpriteUp = array_pop(spriteQueue);
	var yPosUp = 1182  - 150 - offset;
	var thisUpId = instance_create_layer(5066, yPosUp, "Elevators", obj_runAndGun2_elevator, {
		sprite_index: nextSpriteUp,
		elevatorDir: -1,
		creatorId: id
	})
	array_push(currentElevators, thisUpId);
	
	if (array_length(spriteQueue) == 0) {
	    spriteQueue = array_shuffle(list);
	}
}