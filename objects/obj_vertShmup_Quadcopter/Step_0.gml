var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);

if (x < -200 || x > 2120) { 
	instance_destroy(); 
}

if (gunState = 0 && (floor(y) = floor(y1) + 200)) {
	gunState = 1;
}

//if (abs(x - 960) < 800) { //somewhere between -960 and 960 instead of 0 and 1920, so this says: if plane is less than 500 from center
//	if (xSpeed < 16) {
//		xSpeed *= 1.2;	
//	}
//}

switch (gunState) {
	case 0:
	    break;
	case 1:
		y -= ySpeed;
		x += xSpeed * xIndex;
		if (abs(x - 960) < 700) {
			xSpeed *= .975;	
			if (xSpeed < .1) {
				xSpeed = 0;
				gunState = 2;
			}
		}
		break;
	case 2:
		if (loopTimer = 4) {
			break;
		}
		if (shootingState = 0) {
			bulletTimer += 1;
			if (bulletTimer >= bulletInterval) {
				loopTimer += 1;
				bulletTimer = 0;
				shootingState = 1;
			}
		}

		if (shootingState = 1 && obj_vertShmup_PlayerChar.y > y + 100) {
			playerDirection = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);
			shootingState = 2;
		}

		if (shootingState = 2) {
			if (clipCapacity > 0) {
				shotDirection = playerDirection + irandom_range(-6,6);
				instance_create_layer(x - 52,y + 42,"instances",obj_vertShmup_EnemyBullet1, {
					speed: bulletSpeed, direction: shotDirection
				});
				shotDirection = playerDirection + irandom_range(-3,3);
				instance_create_layer(x - 52,y + 42,"instances",obj_vertShmup_EnemyBullet1, {
					speed: bulletSpeed, direction: shotDirection
				});
				clipCapacity -= 1;
			} else {
				shootingState = 0;
				clipCapacity = reloadAmount;
			}
		}
		break;
}