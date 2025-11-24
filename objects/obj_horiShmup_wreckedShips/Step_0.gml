var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);


if (!point_in_rectangle( x, y, x1 - 100, y1 - 1000, x2 + 2500, y2 + 1000)) { 
	instance_destroy(); 
}


image_speed = 0;
speed = -.5 * obj_horiShmup_controlObject.bgSpeedVar;