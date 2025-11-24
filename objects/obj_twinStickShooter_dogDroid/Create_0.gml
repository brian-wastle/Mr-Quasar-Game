enemyHealth = 100;
movementPath = path_add();
imageIndexVar = 0;
enemyTimer = 0;
enemyDirPrevious = 0;
blinkVar = 0;
enemyDir = 0;
enemyState = 0;
playerDir = 0;
playerDist = 0;
newPosition = {};
stateTimer = 0;
deathState = 0;
damageTimer = 0;


origin = 0; // spawn point (door) which created this object
controlObject = 0; //which room created this object

function calculateNewPosition(angle, distance) {
	var newX = x + distance * dcos(angle);
	var newY = y - distance * dsin(angle);

	return { newX: newX, newY: newY };
}

//every enemy has to have these in create event
pushDistance = 0;
pushDirection = 0;