if (!instance_exists(owner)) {
	instance_destroy(self);
	exit;
}

depth = (y * -1) - 100;

enemyDir = owner.enemyDir;

if enemyState = 0 {
	image_index = enemyDir * 6;
}

if enemyState = 1 {
	animationIndex += .3;
	image_index = enemyDir * 6 + animationIndex;
	if (image_index > enemyDir * 6 + 5.5) {
		animationIndex = 0;
	}
	with owner {
		if (path_exists(movementPath) && path_speed > 0) {
			other.enemyState = 0;
		}
	}
}

if enemyState = 2 {
	animationIndex += .3;
	image_index = enemyDir * 6 + animationIndex;
	if (image_index > enemyDir * 6 + 5.5) {
		enemyState = 0;
		animationIndex = 0;
	}
}


if (damageTimer < 30) {
	damageTimer += 1;
}