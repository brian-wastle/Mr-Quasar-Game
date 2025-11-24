y -= 1.5;
bulletTimer += 1;


if (beamState = 0 && bulletTimer >= 100 && bulletTimer <= 750 && bulletTimer mod 50 = 0) {
	stateTimer = bulletTimer;
	beamState = 1;
	beamAngle = irandom(18) * 20;
}

if (beamState = 1 && bulletTimer < stateTimer + 49) {
	if (bulletTimer mod 5 = 0) {
		instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:6, direction:beamAngle
		});
	}
} else {
	beamState = 0;
}

if (bulletTimer = 100) {
	for (var i = 250; i >= -70; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer = 280) {
	for (var i = 170; i >= -150; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer = 460) {
	for (var i = 340; i >= 20; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer = 640) {
	for (var i = 250; i > -70; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer = 730) {
	instance_create_layer(x,y + 30,"Instances",obj_vertShmup_EnemyLaserCharge);
}