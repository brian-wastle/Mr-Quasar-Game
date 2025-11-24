bulletTimer += 1;
y -= 1;

if (bulletTimer = intervals[intervalIndex]) {
	intervalIndex += 1;
	bulletTimer = 0;
	for (var i = 0; i < array_length(bulletAngles); ++i) {
	    instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
			speed:5, direction:bulletAngles[i]
		});
	}
	
}

if (intervalIndex = array_length(intervals)) {
	intervalIndex = 0;
}