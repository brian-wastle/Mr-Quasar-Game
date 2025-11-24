image_speed				= 0;
depth					= -700;
stateTimer[0]			= 0;
spriteArray = [
	spr_runAndGun1_smallSmoke1, 
	spr_runAndGun1_smallSmoke2, 
	spr_runAndGun1_smallSmoke3,
	spr_runAndGun1_smallSmoke4,
	spr_runAndGun1_smallSmoke5,
	spr_runAndGun1_smallSmoke6
];
sprIndex				= irandom_range(0,2);
sprite_index			= spriteArray[sprIndex];
currentIndex			= 0;
var dir					= irandom_range(0,1);
facing					= (-1 + (2 * dir));				// returns -1 or 1;
