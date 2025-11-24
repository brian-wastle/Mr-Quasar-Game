switch (objectState) {
    case 0:
        if (!instance_exists(obj_beatEmUp_lookoutKid)) {
		    image_speed = 1;
		}
		if (image_index >= image_number - 1) {
			objectState = 1;
			sprite_index = spr_beatEmUp_oldMan1a;
		}
        break;
	case 1:
        if (image_index >= image_number - 1) {
			objectState = 2;
			sprite_index = spr_beatEmUp_oldMan1b;
			image_index = 9;
		}
        break;
	case 2:
        image_speed = 1;
        break;
}


