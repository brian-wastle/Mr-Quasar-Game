
var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
var centerX = x1 + ((x2-x1)/2);
var centerY = y1 + ((y2-y1)/2);
if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 500, y2+200)) { 
	instance_destroy(); 
	}


if (direction > 90 && direction <= 172) {
	image_index = 0;
}

if (direction > 172 && direction <= 178) {
	image_index = 1;
}

if (direction > 178 && direction < 182) {
	image_index = 2;
}

if (direction > 182 && direction <= 188) {
	image_index = 3;
}

if (direction > 188 && direction <= 270) {
	image_index = 4;
}

//starting location and general direction (up or down)

if (x > 1700) {
	speed = 6;
}

if (x <= 1700) {
	divePlaneTimer += 1;
	speed = 6 + (divePlaneTimer * .325);
}


if divePlaneType = -1 {
	direction -= (.1 * (divePlaneTimer * .035));
}
if divePlaneType = 1 {
	direction += (.1 * (divePlaneTimer * .035));
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