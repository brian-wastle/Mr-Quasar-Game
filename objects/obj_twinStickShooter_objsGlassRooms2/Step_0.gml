
if (image_index < 5) {
	image_index = (-1/10 * enemyHealth) -3
}

if (image_index >= 5) {
	image_speed = 1;
}

if (image_index >= image_number -.5) {
	
	instance_destroy();;
	instance_create_layer(x,y,"Instances",obj_twinStickShooter_objsGlassRooms4, {
		image_index:image_number,
		image_speed:0
	})
}

if (image_speed = 0) {
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
	
	ds_list_clear(rocketList);
	collisionList2 = instance_place_list(x, y, obj_twinStickShooter_rocketParent, rocketList, 0);
	if collisionList2 > 0 {
		for (var i = 0; i < collisionList2; ++i;) {
			var inst = ds_list_find_value(rocketList,i)
			var inst1 = inst.object_index;
			if ( inst1 = obj_twinStickShooter_rocketSmoke0) {
				enemyHealth -= 10;
			}
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