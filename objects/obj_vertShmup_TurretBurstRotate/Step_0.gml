y -= 1;
currentAngle += rotationSpeed;

if (currentAngle mod incrementAngle = 0) {
	for (var i = 0; i < (360/shotAngles); ++i) {
	    instance_create_layer(x + lengthdir_x(20,currentAngle + (shotAngles * i)), y + lengthdir_y(20, currentAngle + (shotAngles * i)), "Instances", obj_vertShmup_EnemyBullet1, {
			speed: 5, direction: currentAngle + (shotAngles * i)
		});
		lastAngle = currentAngle;
	}
}

for (var i = 1; i < bulletIncrement; ++i) {
	if (currentAngle = lastAngle + (bulletAngle * i)) {
		for (var j = 0; j < (360/shotAngles); ++j) {
		    instance_create_layer(x + lengthdir_x(20,currentAngle + (shotAngles * j)), y + lengthdir_y(20, currentAngle + (shotAngles * j)), "Instances", obj_vertShmup_EnemyBullet1, {
				speed: 5, direction: currentAngle + (shotAngles * j)
			});
		}
	}
}     