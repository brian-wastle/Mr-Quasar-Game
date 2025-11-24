
var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
var centerX = x1 + ((x2-x1)/2);
var centerY = y1 + ((y2-y1)/2);

if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 400, y2+200)) { 
	instance_destroy(); 
	}
	

image_angle = -180 * bulletPositionY

if enemyType = 0 {
	bulletPositionX += 1;
	bulletPositionY = dsin( ((100 * pi)/60 * bulletPositionX ));
	y = yInitial + bulletPositionY * 100;
	
} else {
	bulletPositionX += 1;
	bulletPositionY = dsin( ((-100 * pi)/60 * bulletPositionX ));
	y = yInitial + bulletPositionY * 100;
	
}
	
	