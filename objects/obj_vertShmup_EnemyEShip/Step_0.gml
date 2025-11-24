y += .25;

var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);



switch (gunState) {
	case -1: //spawn state
        if (y >= y1 + 250) {
			gunState = 0;
		}
        break;
    case 0: //break
        breakTimer += 1;
		if (breakTimer = 120) {
			breakTimer = 0;
			gunState = 1;
		}
        break;
	case 1: //charging
        chargeIndex += .2;
		
		if chargeIndex = 10 {
			instance_create_layer(x,y,"Instances",obj_vertShmup_EShipShock);
		}
		if chargeIndex = 16 {
			gunState = 3;
		}
        break;
	case 2: //firing
		bulletTimer -= .25;
		chargeIndex = bulletTimer/2;	
		if (bulletTimer = 0) {
			gunState = 0;
			bulletTimer = 32;
		}
        break;
	case 3: //create bullet
		instance_create_layer(x,y + 9,"Instances", obj_vertShmup_EShipWave);
		gunState = 2;
        break;
	case 4: //broken
		sprite_index = spr_vertShmup_EShipDestroyed;
		if (image_index >= image_number - 1) {
			image_speed = 0;
		}
		bulletTimer = 0;
		chargeIndex = 0;
		break;
}

