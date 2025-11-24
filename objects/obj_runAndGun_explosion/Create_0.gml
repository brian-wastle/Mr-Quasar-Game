depth = -560;
image_speed = 0;
stateTimer[0] = 0;

spriteArray = [
	spr_runAndGun_explosion1,
	spr_runAndGun_explosion2,
	spr_runAndGun_explosion3
];
hitboxArray = [
	spr_runAndGun_explosion1HB,
	spr_runAndGun_explosion2HB,
	spr_runAndGun_explosion3HB
];
var thisIndex = irandom(2);
sprite_index = spriteArray[thisIndex];
mask_index = hitboxArray[thisIndex];
var randomNum = irandom(1);
xScale = (randomNum * -2) + 1;			// -1 or 1 xScale for facing dir
image_xscale = xScale;