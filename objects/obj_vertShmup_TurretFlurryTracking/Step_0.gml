y -= 1;

if (shootingState = 0) {
	bulletTimer += 1;
	if (bulletTimer >= bulletInterval) {
		bulletTimer = 0;
		shootingState = 1;
	}
}

if (shootingState = 1) {
	playerDirection = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);
	shootingState = 2;
}

if (shootingState = 2) {
	if (clipCapacity > 0) {
		shotDirection = playerDirection + irandom_range(-6,6);
		instance_create_layer(x,y,"instances",obj_vertShmup_EnemyBullet1, {
			speed: bulletSpeed, direction: shotDirection
		});
		shotDirection = playerDirection + irandom_range(-3,3);
		instance_create_layer(x,y,"instances",obj_vertShmup_EnemyBullet1, {
			speed: bulletSpeed, direction: shotDirection
		});
		clipCapacity -= 1;
	} else {
		shootingState = 0;
		clipCapacity = reloadAmount;
	}
}
