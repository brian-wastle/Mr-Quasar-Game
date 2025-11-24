event_inherited();

switch (direction) {
    case 0:
        image_index = 0;
        break;
	case 180:
        image_index = 1;
        break;
}

if (obj_RunAndGun_Player.headSprite == spr_RunAndGun_PlayerProneRifleFire) {
	y+= 92;
}
