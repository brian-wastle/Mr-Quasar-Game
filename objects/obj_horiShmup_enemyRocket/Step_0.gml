
if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 500, y2+200)) { 
	instance_destroy(); 
	}
	
	
enemyEventTimer += 1;

	
if ( enemyEventTimer < 60) {
	speed = 5;
}

if (enemyEventTimer >= 60 && enemyEventTimer < 90) {
	speed *= .95;
}

if (enemyEventTimer >= 90 && enemyEventTimer < 370) {
	speed *= 1.05;
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