

if (enemyHealth <= 0) {
	if (path_index = -1 && initPath = 0) {
		path_start(path_TwinStickShooter_Room3ExtinguisherPath, 40, path_action_stop, 0);
		initPath = 1;
		depth = -4000;
	}
	
	if (path_position > 0 && path_position < .98) {
		if (smokeTimer = 0) {
			angleRandom = (point_direction(x, y, xprevious, yprevious) + irandom_range(-45,45));
			instance_create_layer(x + lengthdir_x(10,angleRandom),y + lengthdir_y(10,angleRandom) ,"Instances",obj_TwinStickShooter_Room3ExtinguisherSmoke);
			smokeTimer = 1;
		}
		
		
		if (smokeTimer > 0) {
			smokeTimer -= 1;
		}
		
		
		
	}
	
	if (path_position >= .98) {
		path_end();
		image_speed = .8;
	}
}

if (image_index >= image_number - 1) {
	instance_destroy();
}



event_inherited();

