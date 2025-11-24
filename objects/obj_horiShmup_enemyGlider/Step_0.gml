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

enemyEventTimer += 1;

if (x > obj_horiShmup_player.x) {
	if (y > obj_horiShmup_player.y && direction > 140) {
		direction -= 2;
		image_angle -= 2;
		bulletTimer += 1;
		if bulletTimer = 10 {
			instance_create_layer(x,y,"Instances",obj_horiShmup_enemyBullet0, {
				direction:direction,
				speed:14
			});
			bulletTimer = 0;
		}
	}
	if (y < obj_horiShmup_player.y && direction < 220) {
		direction += 1;
		image_angle += 1;
	}
} else {
	if direction > 180 {
		direction -= 1;
		image_angle -= 1;
	}
	if direction < 180 {
		direction += 1;
		image_angle += 1;
	}
}

if direction > directionPrevious {
	speed += ((direction - 180)/80)
}
if direction < directionPrevious {

}

if (speed < 4) {
	speed = 4;
}
directionPrevious = direction;


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