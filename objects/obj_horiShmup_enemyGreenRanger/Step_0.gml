

if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 500, y2+200)) { 
	instance_destroy(); 
	}



if (enemyType = 0) {
	if (enemyEventTimer <= 100) {
		enemyEventTimer += 1;
		speed = 4;
		image_index = 0;
	}

	if (enemyEventTimer > 100 && enemyEventTimer < 140) {
		enemyEventTimer += 1;
		speed *= .95;
		if (speed < 1) {
			speed = 1;
		};
		image_index = 2
	}

	if enemyDir = 1 {
		if (enemyEventTimer >= 140 && enemyEventTimer < 141) {
			direction += 1;
			if direction = 270 {
				enemyEventTimer += 1;
			}
			image_index = 1;
		}
	} else {
		if (enemyEventTimer >= 140 && enemyEventTimer < 141) {
			direction -= 1;
			if direction = 90 {
				enemyEventTimer += 1;
			}
			image_index = 1;
		}
	}

	if (enemyEventTimer >= 141) {
		enemyEventTimer += 1;
		speed *= 1.06;
		if (speed > 6) {
			speed = 6;
		}
		image_index = 0;
		enemyBulletTimer += 1;
		if (enemyBulletTimer = 20) {
			instance_create_layer(x,y,"Instances", obj_horiShmup_enemyBullet0, {
				direction:180,
				speed:10
			});
			enemyBulletTimer = 0;
		}
	}
} else { 
	
	if (enemyEventTimer <= 100) {
		enemyEventTimer += 1;
		speed = 4;
		image_index = 0;
	}
	
	if (enemyEventTimer > 100 && enemyEventTimer < 140) {
		enemyEventTimer += 1;
		speed *= .95;
		if (speed < 1) {
			speed = 0;
		};
		image_index = 2
	}
	
	if (enemyEventTimer >= 140 && enemyEventTimer < 320) {
		enemyEventTimer += 1;
		bulletTimer += 1;
		enemyBulletTimer += 1;
		image_index = 1;
		if bulletTimer = 24 {
			for (var i=0; i < 10; i += 1;) {
			    instance_create_layer(x,y,"Instances",obj_horiShmup_enemyBullet0, {
				direction: i * 15 + 115,
				speed:6
				});
			}
			enemyBulletTimer = 0;
		}	
		if enemyBulletTimer = 24 {
			for (var i=0; i < 10; i += 1;) {
			    instance_create_layer(x,y,"Instances",obj_horiShmup_enemyBullet0, {
				direction: i * 15 + 105,
				speed:6
				});
			}
			bulletTimer = 0;
		}	
	}
	
	if (enemyEventTimer >= 320) {
		enemyEventTimer += 1;
		direction = 0;
		if (speed < 0.5) {
		speed = .5
		}
		speed *= 1.06;
		if (speed > 6) {
			speed = 6;
		}
		image_index = 2
		
	}
}

ds_list_clear(bulletList);
collisionList = instance_place_list(x, y, obj_horiShmup_playerBulletParent, bulletList, 0);


if collisionList > 0 {
	
	for (var i = 0; i < collisionList; ++i;) {
		
		var inst = ds_list_find_value(bulletList,i)
		var inst1 = inst.object_index;
		
			if ( inst1 = obj_horiShmup_playerBullet) {
					enemyHealth -= 7;
				}
		
			if ( inst1 = obj_horiShmup_droneBullet) {
				enemyHealth -= 7;
			};
		
		instance_destroy(inst);
		
    }
	
	if (blinkVar = false) {
		blinkVar = true;
	} else {
		blinkVar = false;
	}
} else {
	blinkVar = false;
}

if (enemyHealth <= 0) { 
	/*
	var tempScrapInt = irandom(99);
	if (tempScrapInt < 20) {
		instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
			powerupType: 0,
		});
	}
	*/
	instance_destroy();
}