
if (!point_in_rectangle( x, y, x1 - 100, y1-200, x2 + 500, y2+200)) { 
	instance_destroy(); 
	}
	
	
	
if (enemyType = 0) {
	if (enemyEventTimer <= 100) {
	enemyEventTimer += 1;
	speed = 5;
	image_index = 0;
	}


	if (enemyEventTimer > 100 && enemyEventTimer < 140) {
		enemyEventTimer += 1;
		speed *= .95;
		if (speed < 1) {
			speed = 1;
		};
		image_index = 2
	}


	if (enemyEventTimer >= 140 && enemyEventTimer < 141) {
		direction -= 1;
		if direction = 90 {
			enemyEventTimer += 1;
		}
		image_index = 1;
	}


	if (enemyEventTimer >= 141 && enemyEventTimer <= 500) {
		enemyEventTimer += 1;
		speed = 0;
		if (ySpeed >= 4 || ySpeed <= -4) {
			slowdownTimer += 1;
		}
		if (y < obj_horiShmup_player.y) {
			if (slowdownTimer > 50) {
				directionState = 1;
				slowdownTimer = 0;
			}
		}
		if (y > obj_horiShmup_player.y) {
			if (slowdownTimer > 50) {
				directionState = -1;
				slowdownTimer = 0;
			}
		}
		if directionState = 1 {
			ySpeed += .5;
		}
		if directionState = -1 {
			ySpeed -= .5;
		}

		if ySpeed > 5 {
			ySpeed = 5;
		}
		if ySpeed < -5 {
			ySpeed = -5;
		}
		image_index = 0;
		if singleFire = 1 {
			enemyBulletTimer += 1;
			if (enemyBulletTimer = 30) {
				instance_create_layer(x,y,"Instances", obj_horiShmup_enemyBullet0, {
					direction:180,
					speed:10
				});
				enemyBulletTimer = 0;
				bulletEvent += 1;
				if bulletEvent = 3 {
					singleFire = 0;
					bulletEventTimer = 0;
					bulletEvent = 0;
				}
			}
		} else {
			rapidEventTimer += 1;
			if (rapidEventTimer > 30) {
				if (bulletEventTimer < 15) {
				bulletEventTimer += 1;
					if bulletEventTimer % 5 = 0 {
						ySpeed = 0;
						instance_create_layer(x,y,"Instances", obj_horiShmup_enemyBullet0, {
						direction:180,
						speed:10
						});
					}
				}
	
			}
			if (rapidEventTimer > 75) {
				singleFire = 1;
				rapidEventTimer = 0;
				bulletEventTimer = 0;
			}
		}
			y += ySpeed;
	}


	if (enemyEventTimer >=  500) {
		if ySpeed > 0 {
			ySpeed -= .5
		}
		if ySpeed < 0 {
			ySpeed += .5
		}
		if (ySpeed > -1 || ySpeed < 1) {
			ySpeed = 0;
		}
		if (ySpeed = 0) {
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

if (enemyType = 1) {
	if spawn = 0 {
		spawn = 1;
		blueHealth = 750;
	}
	
	if (enemyEventTimer <= 100) {
		enemyEventTimer += 1;
		if (xSpeed > -1) {
			xSpeed = -1;
		}
		if (ySpeed < 1) {
			ySpeed = 1;
		}
		
		if xSpeed > -5 {
			xSpeed *= 1.05;
		}
		if ySpeed < 2 {
			ySpeed *= 1.05;
		}
	
		if (xSpeed < -5) {
			xSpeed = -5;
		}
		if (ySpeed > 2) {
			ySpeed = 2;
		}
	}
	
	if (enemyEventTimer > 100 && enemyEventTimer <= 160) {
		enemyEventTimer += 1;
		
		if xSpeed < 0 {
			xSpeed *= .95;
		}
		if ySpeed > 0 {
			ySpeed *= .95;
		}
	
		if (xSpeed > -.5) {
			xSpeed = 0;
		}
		if (ySpeed < .5) {
			ySpeed = 0;
		}
	}
	
	if (enemyEventTimer > 160 && enemyEventTimer <= 260) {
		enemyEventTimer += 1;
		if chargeEffect = 0 {
			instance_create_layer(x,y,"Effects_Rear", obj_horiShmup_enemyCharge);
			chargeEffect = 1;
		}
	}
	
	if (enemyEventTimer > 260 && enemyEventTimer <= 400) {
		enemyEventTimer += 1;
		bulletEventTimer += 1;
		
		if bulletEventTimer % 5 = 0 {
			instance_create_layer(x-30, y,"Instances",obj_horiShmup_enemyTracingBullet, {
				direction:180,
				speed:10,
				enemyType:0
			})
			instance_create_layer(x-30, y,"Instances",obj_horiShmup_enemyTracingBullet, {
				direction:180,
				speed:10,
				enemyType:1
			})
		}
	}
	
	
	if (enemyEventTimer > 400 && enemyEventTimer <= 420) {
		enemyEventTimer += .5;
		bulletEventTimer = 0;
	}
	
	x += xSpeed;
	y += ySpeed;
	
	if (enemyEventTimer > 420) {
		enemyEventTimer += 1;
		
		
		if (xSpeed < .5) {
			xSpeed = .5;
		}
		if (ySpeed > -.25) {
			ySpeed = -.25;
		}
		
		if xSpeed < 5 {
			xSpeed *= 1.05;
		}
		if ySpeed > -3 {
			ySpeed *= 1.05;
		}
	
		if (xSpeed > 5) {
			xSpeed = 5;
		}
		if (ySpeed < -3) {
			ySpeed = -3;
		}
		
		x += xSpeed;
		y += ySpeed;
		
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