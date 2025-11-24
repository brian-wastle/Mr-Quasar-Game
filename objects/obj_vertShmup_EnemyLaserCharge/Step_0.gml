var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1, x2, y2)) { 
	instance_destroy(); 
}

y -= 1;

if (laserTimer = laserEnd) {
	image_speed = -1;
}

if (sprite_index = spr_vertShmup_EnemyLaserTop && laserTimer >= laserEnd && image_index < 1) {
	instance_destroy();
}

if (sprite_index = spr_vertShmup_EnemyLaserCharge && laserTimer < laserEnd && image_index > image_number - 1) {
	sprite_index = spr_vertShmup_EnemyLaserTop;
}

if (sprite_index = spr_vertShmup_EnemyLaserTop && laserTimer < laserEnd && image_index > image_number - 1) {
	image_speed = 0;
	laserTimer += 1;
}



