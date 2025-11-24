var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);

if (y > 10600) {
	instance_destroy();
}

yWave += 1;
y += 1.25;

image_index = 1 + round(xWave);
xWave = 1 * dsin(1.5 * yWave);
x = xInitial + (xWave * 200);

if (enemyHealth <= 0) {
	instance_create_layer(x,y,"Instances",obj_vertShmup_Explosions);
	audio_play_sound(sfx_vertShmup_Explosion5, 5, false);
	instance_destroy();
}