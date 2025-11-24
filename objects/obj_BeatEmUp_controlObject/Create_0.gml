
adminStatus = 0;
gameStatus = 1;
levelProgress = 0;

levelFrames = 0;
levelSecs = 0;
levelMins = 0;
levelHours = 0;

depth = -5000; //set above everything for drawing debug text


// enemyCount; number of enemies spawned, declared by control object on instantiation
// charIndexArray[]; index array of sprites based on enemy type, passed by control object to enemy object
// spawnSide; -1 for Left, 1 for Right, declared by control object on instantiation
// spawnPoint[]; list of indexes from spawnPointArray, declared by control object on instantiation
// spawnPointArray = [732, 800, 880, 950];  Y spawn coordinates used by obj_beatEmUp_enemyNode (for reference)
//instance_create_layer(x, y, "Instances", obj_beatEmUp_enemyNode, {
//		enemyCount: 3, 
//		charIndexArray: [0,0,0],
//		spawnSide: [-1, 1, -1],
//		spawnPoint: [1,2,3]
//	});

instance_create_layer(x, y, "Instances", obj_beatEmUp_enemyNode, {
		enemyCount: 1, 
		charIndexArray: [0],
		spawnSide: [-1],
		spawnPoint: [0]
	});