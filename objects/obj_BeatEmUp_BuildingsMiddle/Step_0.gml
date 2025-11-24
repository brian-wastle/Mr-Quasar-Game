
var camX = camera_get_view_x(view_camera[0]);
var camW = camera_get_view_width(view_camera[0]);

camMiddleX = (camX + camX + camW)/2;

instanceDistance = x - camMiddleX;
if (instanceDistance > 1000) {
	instanceDistance = 1000;
}
if (instanceDistance < -1000) {
	instanceDistance = -1000;
}

spriteOffset = (instanceDistance/1000) * -27;
