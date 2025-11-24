if (enemyHealth <= 0) {
	image_speed = .5;
}


if (image_index >= image_number -.5) {
	image_speed = 0;
}

if (image_speed = 0 && enemyHealth > 0) {
	ds_list_clear(bulletList);
	collisionList = instance_place_list(x, y, obj_twinStickShooter_bulletParent, bulletList, 0);


	if collisionList > 0 {
	
		for (var i = 0; i < collisionList; ++i;) {
		
			var inst = ds_list_find_value(bulletList,i)
			var inst1 = inst.object_index;
		
				if ( inst1 = obj_twinStickShooter_playerBullet) {
						enemyHealth -= 10;
					}
		
		
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

} else {
	blinkVar = false;	
}