spriteArray = [
	spr_runAndGun_bulletImpactUp, 
	spr_runAndGun_bulletImpactUpRight, 
	spr_runAndGun_bulletImpactRight, 
	spr_runAndGun_bulletImpactDownRight, 
	spr_runAndGun_bulletImpactDown
];
image_speed = 0;
depth = -77;
sprite_index = spriteArray[dirIndex];
image_xscale = impactOffset;
image_index = initialIndex;
if (instance_exists(owner)) {
    xOffset = x - owner.x;
	yOffset = y - owner.y;
	x = owner.x + xOffset;
	y = owner.y + yOffset;
}

stateTimer[0] = 0;
