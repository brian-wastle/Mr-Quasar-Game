if (enemyHealth > 0) {
	switch (gunState) {
	    case 0:
	        breakTimer += 1;
	        break;
		case 1:
			// Calculate the direction to the player
			playerAngle = point_direction(x, y, obj_vertShmup_PlayerChar.x, obj_vertShmup_PlayerChar.y);

			// Normalize angle to the range [0, 360) while maintaining angle sign for precise rotation
			function normalizeAngle(angle) {
			    angle = angle % 360;
			    if (angle < -180) angle += 360;
			    if (angle > 180) angle -= 360;
			    return angle;
			}

			// Get the smallest angle difference between currentAngle and targetAngle
			function getShortestRotation(currentAngle, targetAngle) {
			    var difference = targetAngle - currentAngle;
			    if (difference > 180) {
			        difference -= 360;
			    } else if (difference < -180) {
			        difference += 360;
			    }
			    return difference;
			}

			// Rotate the turret towards the player
			function rotateTurretToPlayer(currentTurretAngle, rotationSpeed) {
			    var angleDifference = getShortestRotation(currentTurretAngle, playerAngle);
			    return currentTurretAngle + sign(angleDifference) * rotationSpeed; // Incrementally adjust angle
			}

			// Update the turret's angle
			newTargetAngle = rotateTurretToPlayer(newTargetAngle, rotationSpeed);

			// Alignment threshold for firing
			var alignmentThreshold = rotationSpeed * 10; // Adjust this based on rotation speed and desired alignment precision
			
			gunOffsetX = lengthdir_x(17,newTargetAngle);
			gunOffsetY = lengthdir_y(17,newTargetAngle);
			
			if (abs(getShortestRotation(newTargetAngle, playerAngle)) < alignmentThreshold) {
			    instance_create_layer(x, y, "Instances", obj_vertShmup_EnemyBullet1, {
			        speed: 4,
			        direction: newTargetAngle
			    });
			    gunState = 0; // Reset gun state if needed
			}
	        break;
	}
	
	if breakTimer = 120 {
		gunState = 1;
		breakTimer = 0;
	}
	
}

if (image_index >= image_number - 1) {
	image_speed = 0;
	}
	
y += .25;


var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1 - 2000, x2, y2 + 200)) { 
	instance_destroy(); 
}