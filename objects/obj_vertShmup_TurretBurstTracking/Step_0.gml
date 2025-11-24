y -= 1;

playerAngle = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);

function normalizeAngle(argument0) {
	var angle = argument0;
    if (angle > 180) {
        angle -= 360;
	}
    if (angle < -180) {
        angle += 360;
	}
    return angle;
}

function getShortestRotation(argument0, argument1) {
    var currentAngle = normalizeAngle(argument0);
    var targetAngle = normalizeAngle(argument1);
    var angleDifference = targetAngle - currentAngle;
    return normalizeAngle(angleDifference);
}

function rotateTurretToPlayer(argument0, argument1) {
    var targetAngle = playerAngle;
	var currentTurretAngle = argument0;
	var newTurretAngle = 0;
	var rotationSpeed = argument1;
    var angleDifference = getShortestRotation(currentTurretAngle, targetAngle);
    
    if (abs(angleDifference) < rotationSpeed) {
        newTurretAngle = targetAngle;
	} else {
        newTurretAngle = currentTurretAngle + sign(angleDifference) * rotationSpeed;
	}
    return newTurretAngle;
}

newTargetAngle = rotateTurretToPlayer(newTargetAngle, rotationSpeed);

bulletTimer += 1;

if (bulletTimer = intervals[intervalIndex]) {
	intervalIndex += 1;
	if (intervalIndex = array_length(intervals)) {
		intervalIndex = 0;
	}
	bulletTimer = 0;
	instance_create_layer(x,y,"Instances", obj_vertShmup_EnemyBullet1, {
		speed:bulletSpeed, direction:newTargetAngle
	});
}