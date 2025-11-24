

switch (state) {
	case 1:
        image_speed = .5;
        break;
	case 2:
		image_speed = -.5;
		break;
    case 0:
        if (animTimer > 0) {
			animTimer -= 1;
			if (animTimer = 1) {
				animTimer = 60;
				state = 1;
			}
		}
		image_speed = 0;
        break;
	
        
}

if (image_index = 0) {
	state = 0;
}

if (image_index = image_number) {
	state = 2;
}

