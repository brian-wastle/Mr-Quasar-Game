y += .25;

var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1 - 2000, x2, y2 + 1000)) { 
	instance_destroy(); 
}

testVar.x = x;
testVar.y = y - 252;