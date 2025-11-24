
if enemyHealth < 0 {
	with (obj_arcadeShooter_bloodControl) {
		ds_queue_enqueue(cellLowQueue, other.x)
	}
	with (obj_arcadeShooter_splatterControl) {
		ds_queue_enqueue(cellBackQueue, other.x)
	}
	instance_destroy();
}

	//////jump into screen/////////
	if (actionState = 0) {
		if (y < lineArray[lineIndex]) {
			x += xVelocity * xSide * -1;
			switch (initPos) {
			    case 0:
					xPos += .1;
					yPos = (2/9) * sqr(xPos) - (4/3) * xPos;
			        break;
			    case 1:
					xPos += .1;
					yPos = (1/3) * sqr(xPos) - xPos;
			        break;
				case 2:
					xPos += .1;
					yPos = (3/16) * sqr(xPos) - (3/2) * xPos;
			        break;
			}
		} else {
			image_index = 5;
			y = lineArray[lineIndex];
			poseIndex = 5;
			actionState = 1;
			xSide = 1;
		}
	}
	
	//////stand up/////////
	if (actionState = 1) {
		image_index += .25;
		poseIndex = image_index;
		if image_index >=  image_number - .5 {
			image_speed = 0;
			poseIndex = 0;
			enemyFace = faceArray[faceIndex].pistol;
			sprite_index = bodyStruct.pistol;
			actionState = 2;
		}
	}
	
	//////// shooting
	if (actionState = 2) {
		
		if shootingTimer < initialPause {
			destinationX = obj_ArcadeShooter_Player.x;
			destinationY = obj_ArcadeShooter_Player.y - 190
			shootingTimer += 1;
		}
		if (shootingTimer = initialPause) {
			if (triggerTimer < triggerPause) {
				image_index = 1;
				triggerTimer += 1;
			}
			if (triggerTimer = triggerPause ) {
				image_speed = 1;
				if (image_index = 2) {
					instance_create_layer(x,y,"Instances", obj_arcadeShooter_muzzleFlash);
					var min_speed = 5;
					var max_speed = 12;
					var max_distance = 700;
					bulletIncrement = point_distance(x - 39, y - 186, destinationX, destinationY);
					bulletSpeed = lerp(min_speed, max_speed, clamp(bulletIncrement / max_distance, 0, 1));
					
					instance_create_layer(x - 39, y - 186, "Instances", obj_ArcadeShooter_enemyBullet0, {
						destinationX: destinationX,
						destinationY: destinationY,
						pathDistance:bulletIncrement,
						speed:bulletSpeed,
					});
				}
				if (image_index >= image_number) {
					image_index = 0;
					image_speed = 0;
					shootingTimer = 0;
					initialPause = irandom_range(240,360);
					triggerTimer = 0;
				}
			}
		}
		poseIndex = image_index;
	}

	//////////////////// End Step ////////////////////////
	////////////Calculate position///////////////////////

	if (y < lineArray[0]) {
		y += yPos;
	} else {
		y = lineArray[0];
		ySpeed = 0;
	}
	
	



blinkVar = 0;