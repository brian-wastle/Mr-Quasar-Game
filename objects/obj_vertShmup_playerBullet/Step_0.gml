var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1, x2, y2)) { 
	instance_destroy(); 
}

if (ammoType = 0) {
	sprite_index = spr_vertShmup_PlayerBullet1;
	speed = 40;
}

if (ammoType = 1) {
	sprite_index = spr_vertShmup_PlayerBullet2;
	speed = 40;
}

if (ammoType = 2) {
	sprite_index = spr_vertShmup_PlayerBullet2;
	speed = 40;
}
