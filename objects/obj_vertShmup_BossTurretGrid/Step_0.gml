bulletTimer += 1;
depth = -5;
y -= 1.5;

if (bulletTimer = 100) {
	for (var i = 250; i >= -70; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer > 100 && bulletTimer < 280 && bulletTimer mod 10 = 0) {
	instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed:1.5, direction:170
	});
}

if (bulletTimer = 280) {
	for (var i = 170; i >= -150; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer > 280 && bulletTimer < 460 && bulletTimer mod 10 = 0) {
	instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed:1.5, direction:20
	});
}

if (bulletTimer = 460) {
	for (var i = 340; i >= 20; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer > 460 && bulletTimer < 640 && bulletTimer mod 10 = 0) {
	instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed:1.5, direction:-70
	});
}

if (bulletTimer = 640) {
	for (var i = 250; i > -70; i -= 5) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:1.5, direction:i
		});
	}
}

if (bulletTimer = 780) {
	instance_create_layer(x,y + 30,"Instances",obj_vertShmup_EnemyLaserCharge);
}