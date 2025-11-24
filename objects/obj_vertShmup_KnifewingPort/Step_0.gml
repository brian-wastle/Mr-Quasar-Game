y += .25;


if (gunState = 0) {
	bulletTimer += 1;
	if (bulletTimer = 120) {
		gunState = 1;
	}
	
	if (image_index > 0) {
		image_index -= .5;
	}
	
}

if (gunState = 1) {
	if (image_index < 2) {
		image_index += 1
	} else {
		bulletTimer += 1;
		if (bulletTimer = 150) {
			gunState = 2;
		}
	}
}

if (gunState = 2) {
	if bulletTimer = 151 {
		playerAngle = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);
		instance_create_layer(x,y,"Instances",obj_vertShmup_EnemyBullet1, {
			speed:4, direction: playerAngle
		});
	}
	bulletTimer += 1;
	if (bulletTimer = 180) {
		gunState = 0;
		bulletTimer = 0;
	}
}

if (gunState = 3) {
	image_index = 3;
}