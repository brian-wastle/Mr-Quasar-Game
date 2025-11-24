var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1 - 100, y1, x2 + 400, y2)) { 
	instance_destroy(); 
}

image_speed = 0;
speed = -.5 * obj_horiShmup_controlObject.bgSpeedVar;


if (scrap_health <= 0) { 
	var tempScrapInt = irandom(99);
	if (tempScrapInt < 10) {
	instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
		powerupType: 0,
	});
	}
	if (tempScrapInt >= 10 && tempScrapInt < 20) {
	instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
		powerupType: 3,
	});
	}
	if (tempScrapInt >= 20 && tempScrapInt < 30) {
	instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
		powerupType: 4,
	});
	}
	
	instance_destroy();
}



if place_meeting(x,y,obj_horiShmup_playerBulletParent) {
	scrap_health -= 10;
	if (blinkVar = false) {
		blinkVar = true;
	} else {
		blinkVar = false;
	}
} else {
	blinkVar = false;
}