var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (point_in_rectangle( x, y, x1 + 240, y1, x2 - 240, y2)) { 
	if enemyHealth > 0 {
		enemyHealth -= 30;
		instance_destroy(other);
	}
}




