var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);

if (!point_in_rectangle( x, y, x1, y1 - 500, x2, y2)) { 
	instance_destroy(); 
}

y += 1;

if (y > y1) {
	x += xSpeed * sign(x - 960);
	if (xSpeed < 8) {
		xSpeed *= 1.042;
	}
	ySpeed *= 1.05;
	y += ySpeed;
}

if (y > y1 + 500) {
	image_index = 1 + sign(x - 960);
}

//enemyDir = darctan2(-ySpeed, xSpeed);
enemyDir = point_direction(x,y,xprevious,yprevious) - 90;

if (enemyHealth <= 0) {
	instance_create_layer(x,y,"Instances",obj_vertShmup_Explosions);
	audio_play_sound(sfx_vertShmup_Explosion5, 5, false);
	instance_destroy();
}