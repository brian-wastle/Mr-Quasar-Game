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
	if (image_index < 4) {
		image_index += 1
	} else {
		bulletTimer += 1;
		if (bulletTimer = 140) {
			gunState = 2;
		}
	}
	
}

if (gunState = 2) {
	if bulletTimer = 141 {
		playerAngle = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);
		instance_create_layer(x,y,"Instances",obj_vertShmup_EnemyBullet1, {
			speed:4, direction: playerAngle
		});
	}
	bulletTimer += 1;
	if (bulletTimer = 160) {
		gunState = 0;
		bulletTimer = 0;
	}
}

if (gunState = 3) {
	if (deathState = 0) {
		deathState = 1;
		audio_play_sound(sfx_vertShmup_Explosion5, 5, false);
	}
	
	image_index = 5;
}