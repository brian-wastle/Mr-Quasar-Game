if (stateTimer[0] < 4) {
    stateTimer[0] += 1;
} else if (currentIndex < image_number - 1) {
	currentIndex += 1;
	stateTimer[0] = 0;
} else if (currentIndex == image_number - 1) {
	currentIndex = 9;
	stateTimer[0] = 0;
}

x = owner.x;
y = owner.y;
xOffset = owner.xOffset;

if (owner.headSprite == spr_RunAndGun_PlayerProneRifleFire || owner.headSprite == spr_RunAndGun_PlayerProneRifle) {
	y += 92;
	x += 48 * xOffset;
}

if (owner.headSprite == spr_runAndGun_PlayerJumpRifleR) {
	y -= 12;
}

if (owner.weaponType != 1) {
    instance_destroy();
}