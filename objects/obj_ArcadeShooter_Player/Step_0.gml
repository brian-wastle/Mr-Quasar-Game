 //actionstates
//0 - Still x
//1 - Walking x
//2 - Jumping  - button 1 x
//3 - Shoot

//13 - Die
//14 - Fall 


if !gamepad_is_connected(global.pad) {

	if (actionstate < 2 || actionstate = 4) {
		if (obj_ArcadeShooter_PlayerReticle.x < x) {
			directionOffset = -1;
		} else {
			directionOffset = 1;
		}
	}
	
	key_right = keyboard_check(ord("D"));
	key_left = keyboard_check(ord("A"));
	key_up = keyboard_check(ord("W"));
	key_down = keyboard_check(ord("S"));
	key_jump = keyboard_check(vk_space);
	key_block = keyboard_check(vk_shift);
	key_attack = mouse_check_button_pressed(mb_left);
	key_super = mouse_check_button_pressed(mb_right);
	
////////////////////////////////// Actionstate 0 - Still

	if (((!keyboard_check(ord ("W")) && !keyboard_check(ord ("A")) && !keyboard_check(ord ("S")) && !keyboard_check(ord ("D"))) || (key_up && key_down) || (key_left && key_right)) && actionstate < 2 ) {
		sprite_index = charArray[0,playerChar];
		if (hsp != 0 || vsp != 0) {
			hsp *= .7;
			vsp *= .7;

			if (hsp > 0 && hsp < 1 ) || (hsp < 0 && hsp > -1) {
				hsp = 0;
			}
			if (vsp > 0 && vsp < 1 ) || (vsp < 0 && vsp > -1) {
				vsp = 0;
			}
		}
		actionstate = 0;
	}

////////////////////////////////// Actionstate 1 - Walking

	if (((keyboard_check(ord ("W")) || keyboard_check(ord ("A")) || keyboard_check(ord ("S")) || keyboard_check(ord ("D"))) && !(key_up && key_down) && !(key_left && key_right)) && actionstate < 2 ) {
		actionstate = 1;
		image_speed = 1;
	}


	if actionstate = 1 {
		sprite_index = charArray[1,playerChar];
		
		if (key_right || key_left) && (hspWalk < hspMaxWalk) {
			hspWalk += .5;
			}
		if (key_right && key_left) || (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) || (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D"))) {
			hspWalk = 0;
			}
		hsp = (key_right - key_left) * hspWalk;
	}

////////////////////////////////// Actionstate 2 - Jumping

	if (keyboard_check_released(vk_space) || (actionstate = 2 || actionstate = 14)) && jumpStatus = 1 {
		jumpStatus = 2;
	}

	if keyboard_check_pressed(vk_space) && actionstate != 2 && actionstate != 14 {
		jumpStatus = 1;
	}

	if (key_jump && actionstate != 3 && jumpStatus < 2 ) { 
		hspJump = hsp;
		hsp = 0;
		vspJump = vsp;
		vsp = 0;
		zspJump = zspMaxJump;
		actionstate = 2;
		sprite_index = charArray[3,playerChar];
		image_index = 0;
		image_speed = 1;
	}

	if (actionstate = 2) {	
		if image_index >= 1.5 {
			image_speed = 0;
		}
		zspJump -= .75;

		//move vertically	
		if (zspJump > zspMaxJump) {
			zspJump = zspMaxJump;
		}
		zsp += zspJump;

		//move horizontally
		if key_right && (abs(hspJump) < hspMaxJump) {
			hspJump += .6;
		}
		if key_left && (abs(hspJump) < hspMaxJump) {
			hspJump -= .6;
		}
		hsp = hspJump;

		//move forward and backward
		if key_up && (abs(vspJump) < vspMaxJump) {
			vspJump -= .6;
		}
		if key_down && (abs(vspJump) < vspMaxJump) {
			vspJump += .6;
		}
		vsp = vspJump;
	}

////////////////////////////////// Actionstate 3 - Shoot
	if (actionstate < 2) {
		if (mouse_check_button_pressed(mb_left) && shotDelayTimer == 0) {
		    getShotPosition();
		}
		if (mouse_check_button(mb_left)) {
			bulletTimer += 1;
			if (bulletTimer >= shotDelayArray[bulletType]) {
				getShotPosition();
				bulletTimer = 0;
			}
		}
		if (mouse_check_button_released(mb_left)) {
			if (shotDelayTimer == 0) {
				shotDelayTimer = shotDelayArray[bulletType] - bulletTimer;
				bulletTimer = 0;
			}
		}
		if (shotDelayTimer > 0) {
			shotDelayTimer -= 1;
		}
	} else {
		bulletTimer = 0;
	}

function getShotPosition() {
	bulletOffsetX = bulletOffsetArray[playerChar][0];
	bulletOffsetY = bulletOffsetArray[playerChar][1];
	reticleDir = point_direction(x + bulletOffsetX, y - bulletOffsetY, obj_ArcadeShooter_PlayerReticle.x, obj_ArcadeShooter_PlayerReticle.y);
	bulletIncrement = point_distance(x + bulletOffsetX, y - bulletOffsetY, obj_ArcadeShooter_PlayerReticle.x, obj_ArcadeShooter_PlayerReticle.y);
	if (!instance_exists(obj_arcadeShooter_playerMuzzleFlash)) {
		instance_create_layer(x + hsp + lengthdir_x(bulletOffsetX + 12, reticleDir), y + vsp - bulletOffsetY + lengthdir_y(bulletOffsetX/1.5, reticleDir), "Instances", obj_arcadeShooter_playerMuzzleFlash);
	}
	instance_create_layer(x + hsp + lengthdir_x(bulletOffsetX, reticleDir), y + vsp - bulletOffsetY + lengthdir_y(bulletOffsetX/4, reticleDir), "Instances", bulletArray[bulletType], {
		destinationX: obj_ArcadeShooter_PlayerReticle.x,
		destinationY: obj_ArcadeShooter_PlayerReticle.y,
		pathDistance: bulletIncrement,
		speed:speedArray[bulletType],
	});
}




////////////////////////////////// Actionstate 14 - Falling
	if (actionstate == 2 && (zspJump <= 0)) {
		zspJump = 0;	
		actionstate = 14;
		if (hspJump = 0 && hspWalk != 0) {
			if (hsp > 0) {
				hspJump = hspWalk;
			}
			if (hsp < 0) {
				hspJump = hspWalk * -1;
			}
		}
	}

	if (actionstate == 14) {
		if (landingTimer == 0) {
			//move horizontally
			if (key_right && (abs(hspJump) < hspMaxJump)) {
				hspJump += .6;
			}
			if (key_left && (abs(hspJump) < hspMaxJump)) {
				hspJump -= .6;
			}
			hsp = hspJump;
		
			//move forward and backward
			if (key_up && (abs(vspJump) < vspMaxJump)) {
				vspJump -= .6;
			}
			if (key_down && (abs(vspJump) < vspMaxJump)) {
				vspJump += .6;
			}
			vsp = vspJump;
	
			//drop from jump height
			zspJump += 1;
	
			if (zspJump > 24) {
				zspJump = 24;
			}
		
			zsp -= zspJump;
		}
		
		
		
	if (landingTimer > 0) {
		image_index = 0;
		jumpStatus = 5;
		landingTimer -= 1;
	}
	if (landingTimer = 1) {
		airAttack = 0;
		landingTimer = 0;
		actionstate = 0;
	}
		
	}
	
////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	if (!key_jump && actionstate != 2 && actionstate != 14) {
		jumpStatus = 0;
	}




//////////////////////////// Actionstate 1 - Walking

	if (actionstate = 1) {
		if (hspWalk > hspMaxWalk) {
			hspWalk = hspMaxWalk;
		}
	
		if (hsp > hspMaxWalk) {
			hsp = hspMaxWalk;
		}
		if (hsp < (hspMaxWalk * -1)) {
			hsp = hspMaxWalk * -1;
		}
	}

	y = y + vsp;

	x = x + hsp;		
	if (x < 130) {
		x = 130;
	}	
	if (x > 2270) {
		x = 2270;
	}
	
/////////////////////////// Actionstate 14 - Falling
		
	if ((zsp <= 0) && actionstate = 14 && jumpStatus = 2) { 
		landingTimer = 10;
		if (playerChar = 2) {
			landingTimer = 15;
		}
		hspJump = 0;
		hsp = 0;
		vspJump= 0;
		vsp = 0;
		zspJump = 0;
		zsp = 0;
		image_index = 0;
	}


} 








if gamepad_is_connected(global.pad) {
	
//actionstates
//0 - Still x
//1 - Walking x
//2 - Jumping  - button 1 x
//3 - Shoot
//4 - Dodge
//5 - Super Attacks - button 3
//6 - Slide
//7 - Grab
//8 - Take Damage
//9 - Air Damage
//10 - Knock Down

//13 - Die
//14 - Fall 
	haxis = gamepad_axis_value(0, gp_axislh);
	vaxis = gamepad_axis_value(0, gp_axislv);
	
	

	if (actionstate < 2 || actionstate = 4) {
		if (obj_ArcadeShooter_PlayerReticle.x < x) {
			directionOffset = -1;
		} else {
			directionOffset = 1;
		}
	}
	
	
	
////////////////////////////////// Actionstate 0 - Still

	if ((haxis <= .2 && haxis >= -.2) && (actionstate < 2)) {
		sprite_index = charArray[0,playerChar];
		speed = 0;
		actionstate = 0;
	}
	
	
////////////////////////////////// Actionstate 1 - Walking

	if ((haxis >= .2 || haxis <= -.2) && (actionstate < 2 )) {
		actionstate = 1;
		image_speed = 1;
	}


	if actionstate = 1 {
		sprite_index = charArray[1,playerChar];
		direction = point_direction(0, 0, haxis, 0);
		speed = point_distance(0 ,0, haxis, 0) * 7;
		
		if (directionOffset = 1 && direction = 180) {
			image_speed = -1;
		}
		if (directionOffset = -1 && direction = 0) {
			image_speed = -1;
		}
		
	}
	
	
////////////////////////////////// Actionstate 2 - Jumping

	
	if  (actionstate != 4 && jumpStatus = 1) {
		jumpStatus = 2;
	}
		
	
	if (gamepad_button_check_pressed(global.pad,gp_face1) && jumpStatus = 0 && actionstate != 2 && actionstate != 14) {
		jumpStatus = 1;
	}
	
	if (gamepad_button_check_pressed(global.pad,gp_face1) && jumpStatus = 2 && (actionstate = 2 || actionstate = 14)) {
		jumpStatus = 3;
	}
	
	if (gamepad_button_check(global.pad,gp_face1) && actionstate != 3 && actionstate != 4 && jumpStatus < 2 ) { 
		zspJump = zspMaxJump;
		actionstate = 2;
		tempOffset = directionOffset;
		sprite_index = charArray[4,playerChar];
		image_index = 0;
		image_speed = 1;
	}
	
	if (gamepad_button_check_pressed(global.pad,gp_face1) && (actionstate = 2 || (actionstate = 14 && zsp > 100)) && jumpStatus = 3 ) { //double jump
		zspJump = zspMaxDoubleJump;
		actionstate = 2;
		if haxis < 0 {
			tempOffset = -1;
			directionOffset = -1;
		}
		if haxis > 0 {
			tempOffset = 1;
			directionOffset = 1;
		}
		jumpStatus = 4
		sprite_index = charArray[4,playerChar];
		image_index = 0;
		image_speed = 1;
	}
	
	if (actionstate = 2) {	
		if image_index >= 1.5 {
			image_speed = 0;
		}
		zspJump -= .9;
	
		zsp += zspJump;
		direction = point_direction(0, 0, haxis, 0);
		speed = point_distance(0 ,0, haxis, 0) * 5;
	
	}
	
////////////////////////////////// Actionstate 3 - Shoot


	if actionstate < 2 {
		
		if (gamepad_button_check_pressed(global.pad,gp_shoulderrb) && shotDelayTimer == 0) {
			bulletOffsetX = bulletOffsetArray[playerChar][0];
			bulletOffsetY = bulletOffsetArray[playerChar][1];
			bulletIncrement = point_distance(x,y, obj_ArcadeShooter_PlayerReticle.x, obj_ArcadeShooter_PlayerReticle.y);
			instance_create_layer(x + (bulletOffsetX * directionOffset),y - bulletOffsetY,"Instances",bulletArray[bulletType], {
				destinationX: obj_ArcadeShooter_PlayerReticle.x,
				destinationY: obj_ArcadeShooter_PlayerReticle.y,
				pathDistance: bulletIncrement,
				speed:speedArray[bulletType],
			});
		}
	
		if gamepad_button_check(global.pad,gp_shoulderrb) {
			bulletTimer += 1;
			if (bulletTimer >= shotDelayArray[bulletType]) {
				bulletOffsetX = bulletOffsetArray[playerChar][0];
				bulletOffsetY = bulletOffsetArray[playerChar][1];
				bulletIncrement = point_distance(x,y, obj_ArcadeShooter_PlayerReticle.x, obj_ArcadeShooter_PlayerReticle.y);
				instance_create_layer(x + (bulletOffsetX * directionOffset),y - bulletOffsetY,"Instances",bulletArray[bulletType], {
					destinationX: obj_ArcadeShooter_PlayerReticle.x,
					destinationY: obj_ArcadeShooter_PlayerReticle.y,
					pathDistance:bulletIncrement,
					speed:speedArray[bulletType],
				});
				bulletTimer = 0;
			}
		}
		if gamepad_button_check_released(global.pad,gp_shoulderrb) {
			if (shotDelayTimer == 0) {
					shotDelayTimer = shotDelayArray[bulletType] - bulletTimer;
					bulletTimer = 0;
			}
		}
		if (shotDelayTimer > 0) {
			shotDelayTimer -= 1;
		}
	} else {
		bulletTimer = 0;
	}

	

////////////////////////////////// Actionstate 4 - Roll

	if (actionstate < 2 && gamepad_button_check(global.pad,gp_face2)) {
		actionstate = 4;
		sprite_index = charArray[3,playerChar];
		image_speed = 1;
		image_index = 0;
		speed = 14;
		if (haxis <= -.2) {
			tempOffset = -1;
		} else if (haxis >= .2) {
			tempOffset = 1;
		} else {
			tempOffset = directionOffset;
		}
	}

	if (actionstate = 4) {
		
		if image_index > 4 {
			speed *= .96;
		}
		if (image_index > image_number - 1) {
			speed = 0;
		}
		
		if (tempOffset = 1) {
			direction = 0;
			directionOffset = 1;
		} else if (tempOffset = -1) {
			direction = 180;
			directionOffset = -1;
		}
		if (image_index >= image_number) {
			actionstate = 0;
		}
	}



////////////////////////////////// Actionstate 14 - Falling


	if (actionstate = 2 && (zspJump <= 0)) {
		zspJump = 0;	
		actionstate = 14;
	}

	if actionstate = 14 {
		if landingTimer = 0 {
			
			zspJump += 1;
	
			if zspJump > 24
				{zspJump = 24;}
		
			zsp -= zspJump;
		}

		if landingTimer > 0 {
			image_index = 0;
			speed = 0;
			jumpStatus = 5;
			landingTimer -= 1;
		}
		if landingTimer = 1 {
			landingTimer = 0;
			actionstate = 0;
		}
		
	}
	
	
	


	////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	if (!gamepad_button_check(global.pad,gp_face1) && actionstate != 2 && actionstate != 14) {
		jumpStatus = 0;
	}

	//////////////////////////// Actionstate 1 - Walking

	if (actionstate = 1) {
		if (haxis < .2 && haxis > -.2) {
			haxis = 0;
		}
		if (vaxis < .2 && vaxis > -.2) {
			vaxis = 0;
		}
	
	}

	/////////////////////////// Actionstate 14 - Falling
		
	if ((zsp <= 0) && actionstate = 14 && jumpStatus >= 2 && landingTimer = 0) { 
		landingTimer = 10;
		if (playerChar = 2) {
			landingTimer = 15;
		}
		zspJump = 0;
		zsp = 0;
		image_index = 0;
	}
	
	if (x < 130) {
		x = 130;
	}	
	if (x > 2270) {
		x = 2270;
	}
	
	
}

//set torso sprites
if (actionstate < 2 || actionstate = 3) {
	torsoArrayX = point_distance(x,0,obj_ArcadeShooter_PlayerReticle.x,0);
	torsoArrayX = round(torsoArrayX / 170);
	if (torsoArrayX > 3) {
		torsoArrayX = 3
	}
	
	torsoArrayY = point_distance(0,1080,0,obj_ArcadeShooter_PlayerReticle.y);
	torsoArrayY = round(torsoArrayY / 140) - 3;
	if (torsoArrayY < 0) {
		torsoArrayY = 0;
	}
	if (torsoArrayY > 3) {
		torsoArrayY = 3
	}
	
	torsoIndex = torsoArrayX + (torsoArrayY * 4);
}


if (actionstate < 2) {
	if ((image_index >= 2 && image_index < 3) || (image_index >= 5 && image_index < 6)) {
		stepOffset = 8;
	} else {
		stepOffset = 0;
	}
}