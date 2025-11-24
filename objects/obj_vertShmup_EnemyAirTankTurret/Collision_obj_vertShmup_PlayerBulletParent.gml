enemyHealth -= 4;

if (enemyHealth > 0 ) {
	instance_destroy(other);
}

var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1 - 500, x2, y2 + 200)) { 
	instance_destroy(); 
}