// Enemy Codes for charIndex
// 0 - Yellowjacket
// 1 - Yellowjacket w/ Knife
depth = -1000;
nodeState = 0; // Track state of node, similar to actionState and enemyState vars in those objects
nodeStatus = 0; // Granular state tracking
stateTimer = 0;

// enemyCount; number of enemies spawned, declared by control object on instantiation
// charIndexArray[]; index array of sprites based on enemy type, passed by control object to enemy object
// spawnSide; -1 for Left, 1 for Right, declared by control object on instantiation
// spawnPoint[]; list of indexes to spawnPointArray, declared by control object on instantiation

currentXViewCenter = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2);
yViewCenter = 540; // Y view Center;

spawnPointArray = [732, 800, 880, 950]; // Y spawn coordinates
enemyArray = array_create(enemyCount);
initialArray = array_create(enemyCount);
enemyAggroArray = array_create(enemyCount);
currentEnemyId = 0; //keeps track of attacking instance;
idleEnemyCount = enemyCount - 1;

function sortEnemiesByDistance(enemyArray) {
	if (array_length(enemyArray) <= 1) {
        return enemyArray;
    }
    array_sort(enemyArray, function(a, b) {
        var distA = point_distance(a.x, a.y, obj_beatEmUp_player.x, obj_beatEmUp_player.y);
        var distB = point_distance(b.x, b.y, obj_beatEmUp_player.x, obj_beatEmUp_player.y);
        return distA - distB;
    });
    return enemyArray;
}