
// Rotate
if (active == 1) {	
	fallDist = min(fallDist * 1.045, 3);
	var shelfAngle = normalizeAngle(image_angle);
	var initX = x + lengthdir_x(edgeRightPx, shelfAngle);
	var initY = y + lengthdir_y(edgeRightPx, shelfAngle);
	var topRightX = initX + lengthdir_x(edgeLenPx, shelfAngle + 90);
	var topRightY = initY + lengthdir_y(edgeLenPx, shelfAngle + 90);
	// No collision at start of event?
	var currentCollision = collision_line(initX, initY, topRightX, topRightY, obj_runAndGun_fallingShelfRear,1,1);
	if (currentCollision == noone) {
		var nextX = x + lengthdir_x(edgeRightPx, shelfAngle - fallDist);
		var nextY = y + lengthdir_y(edgeRightPx, shelfAngle - fallDist);
		var nextTopX = nextX + lengthdir_x(edgeLenPx, shelfAngle - fallDist + 90);
		var nextTopY = nextY + lengthdir_y(edgeLenPx, shelfAngle - fallDist + 90);
		var nextCollision = collision_line(nextX, nextY, nextTopX, nextTopY, obj_runAndGun_fallingShelfRear,1,1);
		if (nextCollision == noone) {
			image_angle -=  fallDist;
		} else {
			if (variable_instance_exists(nextCollision, "active") && nextCollision.active == 0) {
			     nextCollision.active = 1;
			}
			// If there was a collision at fallDist, check backwards in 1/10 increments of fallDist for collision
			// and move to the largest increment with no collision
			for (var j = 0; j < 9; ++j) {
				var maxFallRange = fallDist - fallDist/10;
				var fallIncrement = fallDist/10;
				var tryAngle = shelfAngle - maxFallRange + fallIncrement * j;
				var incrementalX = x + lengthdir_x(edgeRightPx, tryAngle);
				var incrementalY = y + lengthdir_y(edgeRightPx, tryAngle);
				var incTopX = incrementalX + lengthdir_x(edgeLenPx, tryAngle + 90);
				var incTopY = incrementalY + lengthdir_y(edgeLenPx, tryAngle + 90);
				var incCollision = collision_line(incrementalX, incrementalY, incTopX, incTopY, obj_runAndGun_fallingShelfRear,1,1);
				if (incCollision == noone) {
					image_angle -= shelfAngle - tryAngle;
					break;
				}
			}
		}
	}
	// If shelf is already in collision, is it clear below? slide down : perpendicular away from image_angle
	slideLen = irandom_range(1,2);
	var dirTarget = normalizeAngle(image_angle - 90);
	var diff       = diffAngle(270, dirTarget); // how far to rotate DOWN toward TARGET
	var signStep  = (diff >= 0) ? 1 : -1;
	// Try straight down first
	if (checkEdgeCollision(270)) {
		x += lengthdir_x(slideLen, 270);
		y += lengthdir_y(slideLen, 270);
	} else {
		// Sweep in 5 degree steps from down toward (image_angle - 90)
		var moved = false;

		for (var step = sweepStepDeg; step < abs(diff); step += sweepStepDeg) {
			var nextDir = normalizeAngle(270 + signStep * step);
			if (checkEdgeCollision(nextDir)) {
			    x += lengthdir_x(slideLen, nextDir);
			    y += lengthdir_y(slideLen, nextDir);
			    moved = true;
			    break;
			}
		}
		// If you can't slide at all, slide perpendicular to image_angle.
		if (!moved) {
			x += lengthdir_x(slideLen, dirTarget);
			y += lengthdir_y(slideLen, dirTarget);
		}
	}
}