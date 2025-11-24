if (spawnState = 1) {
	if spawnStateTrigger = 0 {
		for (var i = 0; i < array_length(waveArray[enemyWave]); ++i) {
			doorStateArray[waveArray[enemyWave][i].position].doorState = 1;	
		}
		spawnStateTrigger = 1;
	}
	spawnTimer += 1;
	if spawnTimer >= 30 {
		var terminateLoop = 0;
		for (var i = 0; i < 4; ++i) {
		    if (enemyQueueArray[(i * 2) + 1] > 0) {
				var newInst = instance_create_layer(spawnPointArray[i][spawnPosition].xSpawn, spawnPointArray[i][spawnPosition].ySpawn, "Instances", enemyQueueArray[i * 2]);
				newInst.controlObject = obj_TwinStickShooter_Room1Control;
				newInst.origin = i;
				array_push(enemyActiveArray[i], newInst);
				enemyQueueArray[i * 2 + 1] -= 1;
				spawnPosition += 1;
				if (spawnPosition > 2) {
					spawnPosition = 0;
				}
				spawnTimer = 0;
			} else { 
				terminateLoop += 1;	
			}
		}
		if terminateLoop = 4 
		{
			postSpawnActivity = 1;
			spawnState = 0;
			spawnStateTrigger = 0;
			spawnTimer = 0;
			enemyQueueArray = [0, 0, 0, 0, 0, 0, 0, 0];
			enemyWave += 1;
			loadEnemyQueue();
			waveTimer = 0;
			waveTrigger = 0;
		}
	}
}

if (spawnState = 0) {
		if (obj_twinStickShooter_TopDoor.image_index > 0) {
			stateTimer0 += 1;
			if stateTimer0 >= 200 {
				obj_twinStickShooter_TopDoor.doorState = 2;
				stateTimer0 = 0;
			}
		}
		if (obj_twinStickShooter_RightDoor.image_index > 0) {
			stateTimer1 += 1;
			if stateTimer1 >= 200 {
				obj_twinStickShooter_RightDoor.doorState = 2;
				stateTimer1 = 0;
			}
		} 
		if (obj_twinStickShooter_LeftDoor.image_index > 0) {
			stateTimer2 += 1;
			if stateTimer2 >= 200 {
				obj_twinStickShooter_LeftDoor.doorState = 2;
				stateTimer2 = 0;
			}
		}
}