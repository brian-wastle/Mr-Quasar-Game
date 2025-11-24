image_speed = 0;
stateTimer[0] = 0;

spriteArray = [
	spr_runAndGun_smExplosion1,
	spr_runAndGun_smExplosion2,
	spr_runAndGun_smExplosion3,
	spr_runAndGun_smExplosion4,
	spr_runAndGun_smExplosion5,
];
hitboxArray = [
	spr_runAndGun_smExplosion1HB,
	spr_runAndGun_smExplosion2HB,
	spr_runAndGun_smExplosion3HB,
	spr_runAndGun_smExplosion4HB,
	spr_runAndGun_smExplosion5HB
];

var thisIndex = irandom(4);
sprite_index = spriteArray[thisIndex];
mask_index = hitboxArray[thisIndex];

image_xscale = (irandom(1) * -2) + 1;			// -1 or 1 x scale for facing dir
image_yscale = (irandom(1) * -2) + 1;			// -1 or 1 y scale for facing dir
