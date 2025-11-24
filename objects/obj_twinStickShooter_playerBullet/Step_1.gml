
switch (direction) {
    case 0:
		sprite_index = spr_twinStickShooter_bullet0a;
		mask_index = spr_twinStickShooter_bullet0a_1;
		bulletOffsetX = bbox_right;
		bulletOffsetY = y;
        break;
	case 45:
		sprite_index = spr_twinStickShooter_bullet0b;
		mask_index = spr_twinStickShooter_bullet0b_1;
		bulletOffsetX = bbox_right;
		bulletOffsetY = bbox_top;
        break;
	case 90:
		sprite_index = spr_twinStickShooter_bullet0c;
		mask_index = spr_twinStickShooter_bullet0c_1;
		bulletOffsetX = x;
		bulletOffsetY = bbox_top;
        break;
	case 135:
		sprite_index = spr_twinStickShooter_bullet0d;
		mask_index = spr_twinStickShooter_bullet0d_1;
		bulletOffsetX = bbox_left;
		bulletOffsetY = bbox_top;
        break;
	case 180:
		sprite_index = spr_twinStickShooter_bullet0e;
		mask_index = spr_twinStickShooter_bullet0e_1;
		bulletOffsetX = bbox_left;
		bulletOffsetY = y;
        break;
	case 225:
		sprite_index = spr_twinStickShooter_bullet0f;
		mask_index = spr_twinStickShooter_bullet0f_1;
		bulletOffsetX = bbox_left;
		bulletOffsetY = bbox_bottom;
        break;
	case 270:
		sprite_index = spr_twinStickShooter_bullet0g;
		mask_index = spr_twinStickShooter_bullet0g_1;
		bulletOffsetX = x;
		bulletOffsetY = bbox_bottom;
        break;
	case 315:
		sprite_index = spr_twinStickShooter_bullet0h;
		mask_index = spr_twinStickShooter_bullet0h_1;
		bulletOffsetX = bbox_right;
		bulletOffsetY = bbox_bottom;
        break;
}