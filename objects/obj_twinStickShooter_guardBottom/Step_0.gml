depth = (y * -1);

if (enemyHealth > 0) {
	
	//pushed by an explosion
	if pushDistance > 0 {
		if (path_exists(movementPath)) {
		path_end();
	}
		mp_grid_clear_rectangle(global.twinStickGrid1, bbox_left, bbox_top, bbox_right, bbox_bottom);
		if (!place_meeting(x + lengthdir_x(pushDistance/50,pushDirection), y + lengthdir_x(pushDistance/50,pushDirection), obj_twinStickShooter_boundaryLowParent)) {
			if (!place_meeting(x + lengthdir_x(pushDistance/50,pushDirection), y + lengthdir_x(pushDistance/50,pushDirection), obj_twinStickShooter_enemyParent)) {
				x += lengthdir_x(pushDistance/16,pushDirection);
				y += lengthdir_x(pushDistance/16,pushDirection);
			}
		}
		
		if pushDistance > 3 {
			pushDistance *= .95;
		} else {
			pushDistance = 0;
		}
		
		mp_grid_add_instances(global.twinStickGrid1, self, 1);
	} else {
		mp_grid_clear_rectangle(global.twinStickGrid1, bbox_left, bbox_top, bbox_right, bbox_bottom);
	
		if (distance_to_object(obj_TwinStickShooter_player) > 25) {
			if (mp_grid_path(global.twinStickGrid1, movementPath, x, y, obj_TwinStickShooter_player.x, obj_TwinStickShooter_player.y, 1)) {
				path_start(movementPath, 3, 0, 0);
				enemyTimer += 1;
				if (enemyTimer >= 120) {
					topInst.enemyState = 2;
					enemyTimer = 0;
				}
			}
		} else {
			topInst.enemyState = 1;
			enemyTimer = 0;
			path_end();
		}
		enemyDir = floor((direction - 22.5) / 45) + 1;
		imageIndexVar += image_speed/15;
		if (enemyDir != enemyDirPrevious || imageIndexVar > enemyDir * 2 + 1.8) {
			imageIndexVar = enemyDir * 2;
		}
		mp_grid_add_instances(global.twinStickGrid1, self, 1);
		image_index = imageIndexVar;
		enemyDirPrevious = enemyDir;
	}
} else {
	mp_grid_clear_cell(global.twinStickGrid1, floor(x / 30) - 250, floor(y /30) - 150);
	
	if (path_exists(movementPath)) {
		path_end();
		path_delete(movementPath);
	}
	
	//pushed by an explosion
	x += lengthdir_x(pushDistance/16,pushDirection);
	y += lengthdir_x(pushDistance/16,pushDirection);
	if pushDistance > 3 {
		pushDistance *= .95;
	} else {
		pushDistance = 0;
	}
	
	if (instance_exists(topInst)) {
		image_index = 0;
	}
	instance_destroy(topInst);
	sprite_index = spr_twinStickShooter_guardExplode;
	image_speed = 2;
	if (image_index >= image_number - .9) {
		array_pop(controlObject.enemyActiveArray[origin]);
		instance_destroy();
	}
}
if (instance_exists(topInst)) {
	topInst.blinkVar = 0;
}
blinkVar = 0;
