var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
var centerX = x1 + ((x2-x1)/2);
var centerY = y1 + ((y2-y1)/2);
if (!point_in_rectangle( x, y, x1 - 100, y1-300, x2 + 500, y2+500)) { 
	instance_destroy(); 
	}

enemyEventTimer += 1;
image_angle = direction;


if (enemyType = 0 || enemyType = 1) {
	if (enemyEventTimer > 150 && enemyEventTimer < 170) {
		direction += 9;
	}

	if (enemyEventTimer > 290 && enemyEventTimer < 310) {
		direction -= 9;
	}
} 

if (enemyType = 2 || enemyType = 3) {
	if (enemyEventTimer < 760) {
		speed = 6;
		direction -= .45;
	}
}

ds_list_clear(bulletList);
collisionList = instance_place_list(x, y, obj_horiShmup_playerBulletParent, bulletList, 0);

if collisionList > 0 {
	
	for (var i = 0; i < collisionList; ++i;) {
		var inst = ds_list_find_value(bulletList,i);
		var inst1 = inst.object_index;
		
		if ( inst1 = obj_horiShmup_playerBullet) {
			enemyHealth -= 7;
		};
		if ( inst1 = obj_horiShmup_droneBullet) {
			enemyHealth -= 7;
		};
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
	if (enemyType = 1) {
		instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
			powerupType: 2,
		});
	}
	if (enemyType = 3) {
		instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
			powerupType: 2,
		});
	}
	instance_destroy();
}