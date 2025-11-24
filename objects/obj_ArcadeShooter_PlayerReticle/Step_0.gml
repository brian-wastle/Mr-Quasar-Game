

if !gamepad_is_connected(global.pad) {
	x = mouse_x;
	if mouse_y > 0 && mouse_y < 700 {
		y = mouse_y;
	}


}

if gamepad_is_connected(global.pad) {
	var haxis = gamepad_axis_value(0, gp_axisrh);
	var vaxis = gamepad_axis_value(0, gp_axisrv);
	direction = point_direction(0, 0, haxis, vaxis);
	speed = point_distance(0 ,0, haxis, vaxis) * 15;

}



var camera_x1 = camera_get_view_x(view_camera[0]);
var camera_y1 = camera_get_view_y(view_camera[0]);
var camera_x2 = camera_x1 + camera_get_view_width(view_camera[0]);
var camera_y2 = camera_y1 + camera_get_view_height(view_camera[0]);
var centerX = (camera_x2 - camera_x1)/2 + camera_x1;
var centerY = (camera_y2 - camera_y1)/2 + camera_y1;

if (x >= camera_x2 - 60) {
	x = camera_x2 - 60;
}
if (x <= camera_x1 + 60) {
	x = camera_x1 + 60;
}

if (y >= 700) {
	y = 700;
}
if (y <= camera_y1 + 35) {
	y = camera_y1 + 35;
}