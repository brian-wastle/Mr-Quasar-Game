var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);

if (!point_in_rectangle( x, y, x1 - 300, y1 - 1000, x2 + 300, y2 + 300)) { 
	instance_create_layer(x,y,"Instances",obj_vertShmup_Explosions);
	instance_destroy(); 
}
 if (enemyHealth <= 0) {
	audio_play_sound(sfx_vertShmup_Explosion5, 5, false);
	instance_destroy();
 }



if (y > y1 + 300) {

	x += (10 + xSpeed) * xIndex;


	if (abs(x - 960) < 800) { //somewhere between -960 and 960 instead of 0 and 1920, so this says: if plane is less than 500 from center
		y += ySpeed;
		if (ySpeed < 15) {
			ySpeed *= 1.09;
		}
		if (xSpeed < 16) {
			xSpeed *= 1.2;	
		}
	}

}