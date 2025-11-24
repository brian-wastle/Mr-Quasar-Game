

if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 500, y2+200)) { 
	instance_destroy(); 
	}



if (enemyType = 0) {
	if (enemyEventTimer <= 100) {
		enemyEventTimer += 1;
		speed = 5;
		image_index = 0;
	}

	if (enemyEventTimer > 100 && enemyEventTimer < 120) {
		enemyEventTimer += 1;
		speed *= .95;
		if (speed < 1) {
			speed = 1;
		};
		image_index = 2
	}


	if (enemyEventTimer >= 120 && enemyEventTimer < 480) {
		enemyEventTimer += 1;
		speed = 0;
	
	
		if (ySpeed >= 4 || ySpeed <= -4) {
			slowdownTimerY += 1;
		}
	
	
		if (y < obj_horiShmup_player.y) {
			if (slowdownTimerY > 50) {
				directionStateY = 1;
				slowdownTimerY = 0;
			}
		}
	
		if (y > obj_horiShmup_player.y) {
			if (slowdownTimerY > 50) {
				directionStateY = -1;
				slowdownTimerY = 0;
			}
		}
	
		if directionStateY = 1 {
			ySpeed += .5;
		}
	
		if directionStateY = -1 {
			ySpeed -= .5;
		}

	
		if ySpeed > 5 {
			ySpeed = 5;
		}
		if ySpeed < -5 {
			ySpeed = -5;
		}

		//////////////
		if (xSpeed >= 4 || xSpeed <= -4) {
			slowdownTimerX += 1;
		}
	
	
		if (x < obj_horiShmup_player.x + 300 || x < 1000) {
			if (slowdownTimerX > 50) {
				directionStateX = 1;
				slowdownTimerX = 0;
			}
		}
	
		if (x > obj_horiShmup_player.x + 500) {
			if (slowdownTimerX > 50) {
				directionStateX = -1;
				slowdownTimerX = 0;
			}
		}
	
		if directionStateX = 1 {
			xSpeed += .5;
		}
	
		if directionStateX = -1 {
			xSpeed -= .5;
		}

	
		if xSpeed > 5 {
			xSpeed = 5;
		}
		if xSpeed < -5 {
			xSpeed = -5;
		}
	
		if (x > obj_horiShmup_player.x + 200 &&  y > obj_horiShmup_player.y - 150 && y < obj_horiShmup_player.y + 150) {
			enemyBulletTimer += 1;
			if (enemyBulletTimer >= 20) {
				instance_create_layer(x,y,"Instances", obj_horiShmup_enemyBullet0, {
					direction:180,
					speed:10
				});
				enemyBulletTimer = 0;
			}
		} else {
			enemyBulletTimer = 0;
		}
	
	
		image_index = 0;
		x += xSpeed;
		y += ySpeed;
	
	}

	if (enemyEventTimer >= 480) {
	
		if xSpeed > 0 {
			xSpeed -= .5
		}
		if xSpeed < 0 {
			xSpeed += .5
		}
		if ySpeed > 0 {
			ySpeed -= .5
		}
		if ySpeed < 0 {
			ySpeed += .5
		}
		if (xSpeed > -1 || xSpeed < 1) {
			xSpeed = 0;
		}
		if (ySpeed > -1 || ySpeed < 1) {
			ySpeed = 0;
		}
	
		if (xSpeed = 0 && ySpeed = 0) {
			direction = 45;
			if (speed = 0) {
				speed = .1;
			}
			if speed > 8 {
				speed = 8;
			}
			speed *= 1.05
		
		}
	}

} else {
	
	if (enemyEventTimer <= 100) { //fly in from right
		enemyEventTimer += 1;
		speed = 5;
		image_index = 0;
	}

	if (enemyEventTimer > 100 && enemyEventTimer < 120) { //slow down to a stop
		enemyEventTimer += 1;
		speed *= .95;
		if (speed < 1) {
			speed = 1;
		};
		image_index = 2
	}


	if (enemyEventTimer >= 120 && enemyEventTimer < 480) { //trace player and fire when within a certain range
		enemyEventTimer += 1;
		
		image_index = 0;
	}

	if (enemyEventTimer >= 480) { //slow down until xSpeed and ySpeed are both zero, then use speed and direction variable to leave screen after shooting
	
		if xSpeed > 0 {
			xSpeed -= .5
		}
		if xSpeed < 0 {
			xSpeed += .5
		}
		if ySpeed > 0 {
			ySpeed -= .5
		}
		if ySpeed < 0 {
			ySpeed += .5
		}
		if (xSpeed > -1 || xSpeed < 1) {
			xSpeed = 0;
		}
		if (ySpeed > -1 || ySpeed < 1) {
			ySpeed = 0;
		}
	
		if (xSpeed = 0 && ySpeed = 0) {
			direction = 45;
			if (speed = 0) {
				speed = .1;
			}
			if speed > 8 {
				speed = 8;
			}
			speed *= 1.05
		
		}
	}
	
	
}




ds_list_clear(bulletList);
collisionList = instance_place_list(x, y, obj_horiShmup_playerBulletParent, bulletList, 0);


if collisionList > 0 {
	
	for (var i = 0; i < collisionList; ++i;) {
		
		var inst = ds_list_find_value(bulletList,i)
		var inst1 = inst.object_index;
		
			if ( inst1 = obj_horiShmup_playerBullet) {
					enemyHealth -= 7;
				}
		
			if ( inst1 = obj_horiShmup_droneBullet) {
				enemyHealth -= 7;
			};
		
		instance_destroy(inst);
		
    }
	
	if (blinkVar = false) {
		blinkVar = true;
	} else {
		blinkVar = false;
	}
} else {
	blinkVar = false;
}

if (enemyHealth <= 0) { 
	/*
	var tempScrapInt = irandom(99);
	if (tempScrapInt < 20) {
		instance_create_layer(x,y,"Instances",obj_horiShmup_powerup, {
			powerupType: 0,
		});
	}
	*/
	instance_destroy();
}