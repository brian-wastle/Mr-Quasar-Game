if keyboard_check_released(vk_enter) {
	mp_grid_destroy(global.twinStickGrid1);
	room_goto_next();
	exit;
}

//activate events specific to the current enemyWave
switch (enemyWave) {
    case 0:
		if (waveTimer >= 0 && waveTimer < 180) {
			postSpawnActivity = 0;
			waveTimer += 1;
		} else {
			waveTimer = -1;
			spawnState = 1;
		}
        break;
    case 1:
        if (waveTimer >= 0 && waveTimer < 300 && spawnState = 0) {
			if (array_length(enemyActiveArray[1]) = 0 && waveTrigger = 0) {
				instance_create_layer(1458,828,"Instances", obj_twinStickShooter_Powerup, {
				powerupType:0
				});
				waveTrigger = 1;
			}
			postSpawnActivity = 0;
			waveTimer += 1;
		} else if (waveTimer >= 0 && waveTimer = 300 && spawnState = 0) {
			waveTimer = 0;
			spawnState = 1;
		}
        break;
	case 2:
		if (waveTimer >= 0 && waveTimer < 300 && postSpawnActivity = 1) {
			do {
				waveTimer += 1;
			} until (waveTimer = 300);
		} else if (waveTimer = 300 && postSpawnActivity = 1) {
			if (array_length(enemyActiveArray[2]) = 1) {
				instance_create_layer(1458,828,"Instances", obj_twinStickShooter_Powerup, {
				powerupType:0
				});
			}
			waveTimer = 301;
		} else if (waveTimer = 301 && postSpawnActivity = 1) {
			var currentActivity = 0;
			for (var i = 0; i < 4; ++i) {
			    if (array_length(enemyActiveArray[i]) = 0) {
					currentActivity += 1;
				}
			}
			if currentActivity = 4 {
				doorShutTimer += 1;
				if doorShutTimer = 120 {
					doorShutTimer = 0;
					spawnState = 1;
				}
			}
		}
		break;
	case 3:
		if (waveTimer >= 0 && waveTimer < 300 && postSpawnActivity = 1) {
			do {
				waveTimer += 1;
			} until (waveTimer = 300);
		}  else if (waveTimer = 300 && postSpawnActivity = 1) {
			var currentActivity = 0;
			for (var i = 0; i < 4; ++i) {
			    if (array_length(enemyActiveArray[i]) = 0) {
					currentActivity += 1;
				}
			}
			if currentActivity = 4 {
				doorShutTimer += 1;
				if doorShutTimer = 120 {
					doorShutTimer = 0;
					spawnState = 1;
				}
			}
		}
		break;
}



//inherits spawn handler from parent object
event_inherited();