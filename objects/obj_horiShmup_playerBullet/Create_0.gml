image_speed = 0;
nearestEnemyInst = 0; // instance id of nearest enemy object for homing missles
tempPointDir = 0; //direction between instance and enemy
homingVar = 0;
if (instance_exists(obj_horiShmup_player)) {
	if (obj_horiShmup_player.homingBullets = 0) {
		sprite_index = spr_horiShmup_bullet0;
		homingVar = 0;
	} else {
		sprite_index = spr_horiShmup_bulletHoming;
		homingVar = 1;
	}
	image_index = obj_horiShmup_player.bulletSize;
	if (homingVar = 1) {
		if (instance_exists(obj_horiShmup_enemyParent)) {
		nearestEnemyInst = instance_nearest(x, y, obj_horiShmup_enemyParent);
		}
	}
}
