waveTimer += 1;

if (waveTimer = 60) {
	instance_create_layer(xSideArray[0],enemyYStartArray[1],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 0,
		poseIndex: 4,
		initPos:1,
		xVelocity: enemyXSpeedArray[2],
		lineIndex:0
	});
}


if (waveTimer = 90) {
	instance_create_layer(xSideArray[1],enemyYStartArray[0],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 3,
		poseIndex: 2,
		initPos:0,
		xVelocity: enemyXSpeedArray[4],
		lineIndex:0
	});
}

if (waveTimer = 120) {
	instance_create_layer(xSideArray[0],enemyYStartArray[2],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 2,
		poseIndex: 0,
		initPos:2,
		xVelocity: enemyXSpeedArray[1],
		lineIndex:0
	});
}

if (waveTimer = 150) {
	instance_create_layer(xSideArray[1],enemyYStartArray[1],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 1,
		poseIndex: 1,
		initPos:1,
		xVelocity: enemyXSpeedArray[4],
		lineIndex:0
	});
}

if (waveTimer = 180) {
	instance_create_layer(xSideArray[0],enemyYStartArray[0],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 0,
		poseIndex: 3,
		initPos:0,
		xVelocity: enemyXSpeedArray[3],
		lineIndex:0
	});
}

if (waveTimer = 210) {
	instance_create_layer(xSideArray[1],enemyYStartArray[0],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 3,
		poseIndex: 4,
		initPos:0,
		xVelocity: enemyXSpeedArray[0],
		lineIndex:0
	});
}

if (waveTimer = 240) {
	instance_create_layer(xSideArray[1],enemyYStartArray[2],"Instances", obj_arcadeShooter_enemyJumpSoldier, {
		faceIndex: 1,
		poseIndex: 2,
		initPos:2,
		xVelocity: enemyXSpeedArray[1],
		lineIndex:0
	});
}