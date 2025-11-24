if (enemyHealth > 0) {
	if enemyState = 0 {
		mp_grid_clear_rectangle(global.twinStickGrid1, bbox_left, bbox_top, bbox_right, bbox_bottom);
		stateTimer += 1;
		image_speed = 1;
		enemyDir = floor((direction - 45) / 90) + 1;
		playerDir = point_direction(x,y,obj_TwinStickShooter_player.x, obj_TwinStickShooter_player.y)
		playerDist = distance_to_point(obj_TwinStickShooter_player.x, obj_TwinStickShooter_player.y);
		newPosition = calculateNewPosition(playerDir, playerDist + 150);
		if (distance_to_object(obj_TwinStickShooter_player) > 1) {
			if (mp_grid_path(global.twinStickGrid1, movementPath, x, y, obj_TwinStickShooter_player.x, obj_TwinStickShooter_player.y, 0)) {
				path_start(movementPath, 2, 0, 0);
			}
		} else {
			path_end();
		}
		switch (enemyDir) {
			case 1:
		        sprite_index = spr_twinStickShooter_dogDroidUp;
		        break;
			case 2:
		        sprite_index = spr_twinStickShooter_dogDroidRight;
		        break;
			case 3:
		        sprite_index = spr_twinStickShooter_dogDroidDown;
		        break;
			default:
		        sprite_index = spr_twinStickShooter_dogDroidLeft;
		        break;
		}
		if (stateTimer > 120 && distance_to_object(obj_TwinStickShooter_player) < 150) {
			if (path_exists(movementPath)) {
				path_end();
			}
			if (mp_linear_path_object(movementPath, newPosition.newX, newPosition.newY, 3, obj_twinStickShooter_boundaryLowParent)) {
				enemyDir = floor((direction - 45) / 90) + 1;
				enemyState = 1;
				image_index = 0;
			} else {
				stateTimer = 0;
				mp_grid_path(global.twinStickGrid1, movementPath, x, y, obj_TwinStickShooter_player.x, obj_TwinStickShooter_player.y, 0);
				path_start(movementPath, 2, 0, 0);
				
			}
			
		}
		mp_grid_add_instances(global.twinStickGrid1, self, 1);
	}
	if (enemyState = 1) {
		mp_grid_clear_rectangle(global.twinStickGrid1, bbox_left, bbox_top, bbox_right, bbox_bottom);
		switch (enemyDir) {
			case 1:
		        sprite_index = spr_twinStickShooter_dogDroidJumpUp;
		        break;
			case 2:
		        sprite_index = spr_twinStickShooter_dogDroidJumpRight;
		        break;
			case 3:
		        sprite_index = spr_twinStickShooter_dogDroidJumpDown;
		        break;
			default:
		        sprite_index = spr_twinStickShooter_dogDroidJumpLeft;
		        break;
		}
		if (image_index < 4) {
			image_speed = 1;
		}
		if (image_index >= 4 && path_position = 0 && mp_linear_path_object(movementPath, newPosition.newX, newPosition.newY, 3, obj_twinStickShooter_boundaryLowParent)) {
			path_start(movementPath, 10, 0, 0);
			image_speed = 3;
		}
		if (image_index >= 6) {
			image_speed = 0;
		}
		if (path_position >= .9) {
			image_speed = .3;
			mp_grid_add_instances(global.twinStickGrid1, self, 1);
			path_end();
		}
		if image_index >= image_number - .5 {
			path_end();
			mp_grid_add_instances(global.twinStickGrid1, self, 1);
			stateTimer = 0;
			enemyState = 0;
		}
		if (place_meeting(x, y, obj_twinStickShooter_boundaryLowParent)) {
			path_end();
			mp_grid_add_instances(global.twinStickGrid1, self, 1);
			stateTimer = 0;
			enemyState = 0;
		}
	}
} else {
	if (path_exists(movementPath) && path_speed > 0) {
		path_end();
		path_delete(movementPath);
	}
	if deathState = 0 {
		sprite_index = spr_twinStickShooter_dogDroidDeath;
		image_index = 0;
		image_speed = 2;
		deathState = 1;
	}
	if image_index >= image_number -.5 {
		array_pop(controlObject.enemyActiveArray[origin]);
		instance_destroy();
	}
}
blinkVar = 0;

if (damageTimer < 60) {
	damageTimer += 1;
}