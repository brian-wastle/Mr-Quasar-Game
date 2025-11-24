var camX = camera_get_view_x(view_camera[0]);
var camW = camera_get_view_width(view_camera[0]);

camMiddleX = (camX + camX + camW)/2;

instanceDistance = x - camMiddleX;
if (instanceDistance > 1400) {
	instanceDistance = 1400;
}
if (instanceDistance < -1400) {
	instanceDistance = -1400;
}

spriteOffset = (instanceDistance/1400) * -60;