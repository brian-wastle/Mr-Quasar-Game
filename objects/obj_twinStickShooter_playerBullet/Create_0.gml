depth = y * -1 -20;
bulletOffsetX = 0; 
bulletOffsetY = 0;//keep track of where bulletsmoke should be created

switch (direction) {
    case 0:
		sprite_index = spr_twinStickShooter_bullet0a;
		bulletOffsetX = bbox_right;
		bulletOffsetY = y;
        break;
	case 45:
		sprite_index = spr_twinStickShooter_bullet0b;
		bulletOffsetX = bbox_right;
		bulletOffsetY = bbox_top;
        break;
	case 90:
		sprite_index = spr_twinStickShooter_bullet0c;
		bulletOffsetX = x;
		bulletOffsetY = bbox_top;
        break;
	case 135:
		sprite_index = spr_twinStickShooter_bullet0d;
		bulletOffsetX = bbox_left;
		bulletOffsetY = bbox_top;
        break;
	case 180:
		sprite_index = spr_twinStickShooter_bullet0e;
		bulletOffsetX = bbox_left;
		bulletOffsetY = y;
        break;
	case 225:
		sprite_index = spr_twinStickShooter_bullet0f;
		bulletOffsetX = bbox_left;
		bulletOffsetY = bbox_bottom;
        break;
	case 270:
		sprite_index = spr_twinStickShooter_bullet0g;
		bulletOffsetX = x;
		bulletOffsetY = bbox_bottom;
        break;
	case 315:
		sprite_index = spr_twinStickShooter_bullet0h;
		bulletOffsetX = bbox_right;
		bulletOffsetY = bbox_bottom;
        break;
}