if (enemyHealth > 0) {
	bulletTimer += 1;

	if (bulletTimer = 120) {
		bulletTimer = 0;
		var tempAngle = 0;
		var randomInt = irandom_range(25,40);
		for (var i = 0; i < 360; ++i) {
			if (i = tempAngle + randomInt) {
				tempAngle = i;
				randomInt = irandom_range(25,40);
				instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyAirTankRing, {
				speed:3, direction:i
				});
			}
		}
	}
}





if (enemyHealth <= 0) {
	if (sprite_index != spr_vertShmup_EnemyAirTankWreck) {
		audio_play_sound(sfx_vertShmup_Explosion2, 10, false);
	}
	sprite_index = spr_vertShmup_EnemyAirTankWreck;
}




var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1 - 2000, x2, y2 + 2000)) { 
	instance_destroy(); 
}