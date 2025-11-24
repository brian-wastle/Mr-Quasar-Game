switch (currentIndex) {
    case 0:
        triggerTimer += 1;
		if (triggerTimer == 120) {
		    currentIndex += 1;
			sprite_index = tvSprites[currentIndex];
			image_index = 0;
		}
        break;
	case 1:
	case 2:
	case 3:
	case 4:
	case 5:
		if (currentIndex == 2) {
			if (image_index >= 40) {
			    tvLeft.currentIndex = 1;
				tvRight.currentIndex = 1;
			}
			if (image_index >= 55) {
			    tvLeft.image_speed = 1.5;
				tvRight.image_speed = 1.5;
			}
			if (image_index >= 60) {
				if (sparkInst == 0) {
				    sparkInst = instance_create_layer(974, 320, "Objects", obj_runAndGun1_tvEffect2);
				}
			}
		}
        if (image_index >= image_number - 1.5) {
			currentIndex += 1;
			sprite_index = tvSprites[currentIndex];
			image_index = 0;
			if (currentIndex == 5) {
			    tvLeft.currentIndex = 2;
				tvRight.currentIndex = 2;
				tvLeft.image_speed = 1;
				tvRight.image_speed = 1;
			}
		}     
        break;
}