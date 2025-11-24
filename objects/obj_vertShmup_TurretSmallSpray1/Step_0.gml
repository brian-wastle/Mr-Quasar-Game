y -= 1;

if (shootingState = 0) {
	bulletTimer += 1;
	if (bulletTimer >= intervals[intervalIndex]) {
		bulletTimer = 0;
		intervalIndex += 1;
		if (intervalIndex = array_length(intervals)) {
			intervalIndex = 0;
		}
		shootingState = 1;
	}
}

if (shootingState = 1) {
	playerDirection = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);
	shootingState = 2;
}

if (shootingState = 2) {
	for (var i = 0; i < 8; ++i) {
		shotOffset = abs(shotOffset) + 1;
		if (i mod 2 = 0) {
			shotOffset *= -1;
		}
		instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed: bulletSpeed, direction: playerDirection + shotOffset
		});
	}

	instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed: bulletSpeed, direction: playerDirection + 30
	});

	instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed: bulletSpeed, direction: playerDirection - 30
	});
	shotOffset = 0;
	shootingState = 0;
}
