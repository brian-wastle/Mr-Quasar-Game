image_speed				= 0;
depth					= -800;
stateTimer[0]			= 0;
spriteArray = [
	spr_runAndGun1_shootSmoke1, 
	spr_runAndGun1_shootSmoke2, 
	spr_runAndGun1_shootSmoke3
];
sprIndex				= irandom_range(0,2);
sprite_index			= spriteArray[sprIndex];
currentIndex			= 0;
var dir					= irandom_range(0,1);
facing					= (-1 + (2 * dir));				// returns -1 or 1;