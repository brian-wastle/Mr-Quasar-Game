event_inherited();
//exhaustOffset = [{x1, y1}, {x2, y2}, {x3, y3}];
//instance_create_layer(x,y, "Instances", obj_runAndGun_flyingVehicle);
hitFlag = 1;
xFacing = 1; // facing right, or -1 for left
image_speed = 0;
currentIndex = 0;
exhaustOffsets = [];

stateTimer[0] = 0;

// Exhaust/Rings tracking
flameArray = [];			// array for 3 exhaust positions
ringArrays = [[],[],[]];	// arrays for each exhaust positions' rings and offsets for each ring

truckSprites = [
	spr_runAndGun_jetTruck, 
	spr_runAndGun_jetTruckWorker, 
	spr_runAndGun_jetBike,
	spr_runAndGun_jetBikeWorker,
	spr_runAndGun_jeep
];

sprite_index = truckSprites[charIndex];

exhaustArrays = [
	[	// jetTruckWorker / jetTruck
		{xPos: 28, yPos: 180},
		{xPos: 160, yPos: 192},
		{xPos: 212, yPos: 188},
	],
	[	// jetBikeWorker / jetBike
		{xPos: 22, yPos: 112},
		{xPos: 106, yPos: 124},
		{xPos: 158, yPos: 124},
	],
	[	// jeep
		{xPos: 22, yPos: 180},
		{xPos: 98, yPos: 188},
		{xPos: 174, yPos: 180},
	]
];



if (sprite_index == spr_runAndGun_jetTruckWorker || sprite_index == spr_runAndGun_jetBikeWorker) {
    image_index = irandom(4);
}

switch (sprite_index) {
    case spr_runAndGun_jetTruck:
	case spr_runAndGun_jetTruckWorker:
        exhaustOffsets = exhaustArrays[0];
		bobSpeedMain = 0.06;
        break;
	case spr_runAndGun_jetBike:
	case spr_runAndGun_jetBikeWorker:
        exhaustOffsets = exhaustArrays[1];
		bobSpeedMain = 0.08;
        break;
	case spr_runAndGun_jeep:
        exhaustOffsets = exhaustArrays[2];
		bobSpeedMain = 0.07;
        break;
}

// Create exhaust
for (var i = 0; i < 3; ++i) {
	var flame = instance_create_layer(x + exhaustOffsets[i].xPos * xFacing, y + exhaustOffsets[i].yPos,"Instances", obj_runAndGun_flyingExhaust, {ownerId: id});
	array_push(flameArray, flame);
}