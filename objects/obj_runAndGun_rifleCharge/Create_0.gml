stateTimer[0] = 0;
currentIndex = 0;
initY = y;
owner = obj_RunAndGun_Player.id;
xOffset = 1;

if (owner.headSprite == spr_RunAndGun_PlayerProneRifleFire || owner.headSprite == spr_RunAndGun_PlayerProneRifle) {
	y = initY + 92;
} else {
	y = initY;
};