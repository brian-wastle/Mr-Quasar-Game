switch (objectState) {
    case 0:
        tapTimer -= 1;
        if (tapTimer == 0 && image_index == 0) {
            image_index = 1;
            tapTimer = 20;
        } else if (tapTimer == 0 && image_index == 1) {
            image_index = 0;
            tapTimer = round(random_range(2, 4) * 60);
        }
        if (obj_BeatEmUp_controlObject.levelProgress == 1) {
            objectState = 1;
            tapTimer = 0;
            sprite_index = spr_beatEmUp_pilot1b;
            image_index = 0;
            image_speed = 1.1;
        }
        break;

    case 1:
        if (image_index >= image_number - 1) {
            objectState = 2;
            sprite_index = spr_beatEmUp_pilot1c;
            image_index = 0;
            image_speed = 1.2;
        }
        break;

    case 2:
        if (image_index >= image_number - 1) {
            objectState = 3;
            sprite_index = spr_beatEmUp_pilot1d;
            image_index = 0;
            image_speed = 0;
            shakeOffset = 1;
            instance_create_layer(x, y, "Windows", obj_beatEmUp_jetSmoke, {
                image_index: 2,
                depth: 51
            });
            instance_create_layer(x, y, "Windows", obj_beatEmUp_jetSmoke, {
                depth: 49
            });
        }
        break;

    case 3:
        // Handle shake
        shakeTimer -= 1;
        if (shakeTimer <= 0) {
            shakeIncrement = max(5, shakeIncrement * 0.8);
            if (shakeIncrement == 5 && tapTimer == 0) {
                tapTimer = 60;
            }
            shakeTimer = shakeIncrement;
            shakeOffset = min(shakeOffset * 1.2, 4);
            shakeOffset *= -1;
        }
        exhaustIndex += 1 / fps * 15;
        // Handle state
        if (tapTimer > 0 && shakeIncrement == 5) {
            tapTimer -= 1;
            if (tapTimer == 1) {
                objectState = 4;
                tapTimer = 0;
                image_index = 1;
            }
        }
        break;
    case 4: // propulsion
		tapTimer += liftIncrement;
	    cx = animcurve_channel_evaluate(channelX, tapTimer);
		cy = animcurve_channel_evaluate(channelY, tapTimer);
		x += cx * 18;
		y = initialY - (cy * 300);
		if (tapTimer > .5) {
			puffTimer -= 1;
			if (puffTimer <= 0) {
				puffTimer = 7;
				instance_create_layer(x,y,"Windows", obj_beatEmUp_jetSmoke2, {
					sprite_index: spr_beatEmUp_puffSmoke
				});
			}
		}
	    break;
}

if (objectState == 4) {
	if (y - yprevious > 1) {
		image_index = 2;
	} else {
		image_index = 1;
	}
}

if (objectState == 4 && image_index != currentIndex ) {
	instance_create_layer(x, y, "Windows", obj_beatEmUp_jetSmoke2);
}

currentIndex = image_index;

if (y < -400) {
	instance_destroy();
}