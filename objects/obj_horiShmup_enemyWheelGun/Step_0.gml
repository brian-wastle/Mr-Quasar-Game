
var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
var centerX = x1 + ((x2-x1)/2);
var centerY = y1 + ((y2-y1)/2);


if (enemyEventTimer + 130 > obj_horiShmup_controlObject.eventTimer) {
	if (y < centerY) {
		y += 2;
	} else {
		y -= 2;
	}
}

if (enemyEventTimer + 100 < obj_horiShmup_controlObject.eventTimer) {
	image_speed = .5;
	if (image_index > image_number-1) {
		image_index = 3;
	}
}

if (enemyEventTimer + 180 = obj_horiShmup_controlObject.eventTimer) {
	for (var i=0; i < 8; i += 1;) {
	    instance_create_layer(x,y,"Instances",obj_horiShmup_enemyBullet0, {
		direction: i * 45,
		speed:10
		});
	}
}

if (enemyEventTimer + 200 < obj_horiShmup_controlObject.eventTimer) {
	
	if tempAngle < 8 {
		bulletTimer0 += 1;
		if (bulletTimer0 = 10) {
			instance_create_layer(x,y,"Instances",obj_horiShmup_enemyBullet0, {
				direction: tempAngle * 45,
				speed:10
			});
			tempAngle += 1;
			bulletTimer0 = 0;
		}
	}
}

if (enemyEventTimer + 320 = obj_horiShmup_controlObject.eventTimer) {
	for (var i=0; i < 8; i += 1;) {
	    instance_create_layer(x,y,"Instances",obj_horiShmup_enemyBullet0, {
		direction: i * 45,
		speed:10
		});
	}
}

if (enemyEventTimer + 200 < obj_horiShmup_controlObject.eventTimer) {
	if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 400, y2+200)) { 
	instance_destroy(); 
	}
}

if (enemyEventTimer + 360 < obj_horiShmup_controlObject.eventTimer) {
	if (y < centerY) {
		y -= 2;
	} else {
		y += 2;
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
	ds_list_destroy(bulletList);
	instance_destroy();
}