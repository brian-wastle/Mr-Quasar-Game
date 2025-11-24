// enemyCount; number of enemies spawned, declared by control object on instantiation
// charIndexArray[]; index array of sprites based on enemy type, passed by control object to enemy object
// spawnSide; -1 for Left, 1 for Right, declared by control object on instantiation
// spawnPoint[]; list of indexes from spawnPointArray, declared by control object on instantiation

// enemyArray[0...enemyCount];
// currentEnemyId; uses getClosestEnemyToPlayer() to find which enemy is nearest to player

// Spawn enemy instances
if (nodeState == 0) {
	for (var i = 0; i < enemyCount; ++i) {
	    enemyArray[i] = instance_create_layer(currentXViewCenter + (spawnSide[i] * 1160), spawnPointArray[spawnPoint[i]], "Instances", obj_beatEmUp_enemy, {
			charIndex: charIndexArray[i]
		});
		initialArray[i] = enemyArray[i];
	};
	enemyArray = sortEnemiesByDistance(enemyArray);
	initialArray = sortEnemiesByDistance(initialArray);
	nodeState = 1;
}

// Set closest enemy to chase, and the rest to retreat
if (nodeState == 1) {
	nodeStatus = 0;
	with (enemyArray[0]) {
		if (enemyState == 0) {
			enemyState = 1;
			aggroState = 1;
		} else if (enemyState != 100) {
			other.nodeStatus += 1;
		}
	}
	for (var i = 1; i < array_length(enemyArray); ++i) {
		with (enemyArray[i]) {
			if (enemyState == 100) {
				freezeTimer = irandom_range(120,180);
			}
			 else if (enemyState != 100) {
				other.nodeStatus += 1;
			}
		}
	}
	if (nodeStatus == array_length(enemyArray)) {
		nodeStatus = 0;
	    nodeState = 2;
	}
}

// Track enemy health, resize enemyArray, clean-up object
for (var i = array_length(enemyArray) - 1;  i >= 0; --i) {
    if (enemyArray[i].enemyHealth <= 0) {
		var indexRef = array_get_index(initialArray, enemyArray[i]);
		array_delete(initialArray, indexRef, 1);
		array_delete(enemyArray, i, 1);
		array_delete(enemyAggroArray, indexRef, 1);
		sortEnemiesByDistance(enemyArray);
	}
}

if (array_length(enemyArray) == 0) {
	instance_destroy();
}