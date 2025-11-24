 //actionStates
//0 - Still x
//1 - Movement
//2 - Shooting
//3 - Bombs
//10 - Death

///////DEBUG
if (keyboard_check_pressed(ord("P"))) {
	y += 100;
}
if (keyboard_check_pressed(ord("O"))) {
	y -= 100;
}




y -= 1;

if !gamepad_is_connected(global.pad) {
	//initalize

	key_right = keyboard_check(ord("D"));
	key_left = keyboard_check(ord("A"));
	key_up = keyboard_check(ord("W"));
	key_down = keyboard_check(ord("S"));

	////////////////////////////////// actionState 0 - Still

	if (!keyboard_check(ord ("W")) && !keyboard_check(ord ("A")) && !keyboard_check(ord ("S")) && !keyboard_check(ord ("D")) && actionState != 10)
		{
		if hsp != 0
			{
			hsp = 0;
			}
			if vsp != 0
			{
			vsp = 0;
			}
		actionState = 0;
		}
	
	////////////////////////////////// actionState 1 - Movement

	if (keyboard_check(ord ("W")) || keyboard_check(ord ("A")) || keyboard_check(ord ("S")) || keyboard_check(ord ("D"))) && actionState < 2
		{actionState = 1;}

	if actionState = 1 {
		if (key_left) {
			hsp = -8;
		};
		if (key_right) {
			hsp = 8;
		};
		if (key_up) {
			vsp = -8;
		};
		if (key_down) {
			vsp = 8;
		};
		if (key_up && key_left) {
			hsp = -6;
			vsp = -6;
		};
		if (key_up && key_right) {
			hsp = 6;
			vsp = -6;
		};
		if (key_down && key_left) {
			hsp = -6;
			vsp = 6;
		};
		if (key_down && key_right) {
			hsp = 6;
			vsp = 6;
		};
	
		if (key_left && key_right) {
			hsp = 0;
		};
		if (key_up && key_down) {
			vsp = 0;
		};
	}

	////////////////////////////////// actionState 2 - Fire Bullet
	
	if (actionState != 10) {
		if mouse_check_button_pressed(mb_left) {		
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			audio_play_sound(sfx_vertShmup_Laser1, 10, false);
			bulletTimer = 0;
			if (powerUp = 1) {
				instance_create_layer(x - 79, y, "Instances", obj_vertShmup_playerBullet, {
					ammoType: 1,
					direction: 100
				});
				instance_create_layer(x + 79, y, "Instances", obj_vertShmup_playerBullet, {
					ammoType: 1,
					direction: 80
				});
			}
		}

		if mouse_check_button(mb_left) {
			bulletTimer += 1;
		}
		if mouse_check_button_released(mb_left) {
			bulletTimer = 0;
			powerUpTimer = 0;
		}
	
		if (bulletTimer > bulletInterval) {
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			audio_play_sound(sfx_vertShmup_Laser1, 10, false);
			if (powerUp = 1) {
				instance_create_layer(x - 79, y, "Instances", obj_vertShmup_playerBullet, {
					ammoType: 1,
					direction: 100
				});
				instance_create_layer(x + 79, y, "Instances", obj_vertShmup_playerBullet, {
					ammoType: 1,
					direction: 80
				});
			}
			powerUpTimer += 1;
			if (powerUpTimer = 100) {
				powerUpTimer = 0;
			}
			bulletTimer = 0;
		}
		
	}
	

	////////////////////////////////// actionState = 10 - Death
	
	if (actionState = 10) {
		if (deathTimer = 0) {
			var vx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
			var vy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 + 300;
			x = vx;
			y = vy;
		}
		deathTimer += 1;
		playerOpacity = (deathTimer mod 5) / 6;
		
		if deathTimer >= 40 {
			//movement
			if (key_left) {
				hsp = -8;
			};
			if (key_right) {
				hsp = 8;
			};
			if (key_up) {
				vsp = -8;
			};
			if (key_down) {
				vsp = 8;
			};
			if (key_up && key_left) {
				hsp = -6;
				vsp = -6;
			};
			if (key_up && key_right) {
				hsp = 6;
				vsp = -6;
			};
			if (key_down && key_left) {
				hsp = -6;
				vsp = 6;
			};
			if (key_down && key_right) {
				hsp = 6;
				vsp = 6;
			};
	
			if (key_left && key_right) {
				hsp = 0;
			};
			if (key_up && key_down) {
				vsp = 0;
			}
			
			if (hsp != 0) {
				if ((!keyboard_check(ord ("A")) && (hsp < 0)) || (!keyboard_check(ord ("D")) && (hsp > 0))) {
					hsp = 0;
				}
			}
	
			if (vsp != 0) {
				if ((!keyboard_check(ord ("W")) && (vsp < 0)) || (!keyboard_check(ord ("S")) && (vsp > 0))) {
					vsp = 0;
				}
			}
	
			var camera_x1 = camera_get_view_x(view_camera[0]);
			var camera_y1 = camera_get_view_y(view_camera[0]);
			var camera_x2 = camera_x1 + camera_get_view_width(view_camera[0]);
			var camera_y2 = camera_y1 + camera_get_view_height(view_camera[0]);
	
			if ((x + hsp > (camera_x2 - 282)) || (x + hsp < camera_x1 + 282)) {
				hsp = 0;
			}
			if ((y + vsp > (camera_y2)) || (y + vsp < camera_y1)) {
				vsp = 0;
			}
	
			x = x + hsp;
			y = y + vsp;
		}
		
		if deathTimer >= 120 {
			playerOpacity = 1;
			deathTimer = 0;
			actionState = 0;
		}
	}
	
	////////////////////////////////// End Step

	//activate shield obj when shield is attained
	//if (shieldStatus = 1 && !instance_exists(obj_horiShmup_playerShield)) {
	//	instance_create_layer(x,y, "Instances", obj_horiShmup_playerShield);
	//}

	if (actionState = 1) {
	
		if (hsp != 0) {
			if ((!keyboard_check(ord ("A")) && (hsp < 0)) || (!keyboard_check(ord ("D")) && (hsp > 0))) {
				hsp = 0;
			}
		}
	
		if (vsp != 0) {
			if ((!keyboard_check(ord ("W")) && (vsp < 0)) || (!keyboard_check(ord ("S")) && (vsp > 0))) {
				vsp = 0;
			}
		}
	
		var camera_x1 = camera_get_view_x(view_camera[0]);
		var camera_y1 = camera_get_view_y(view_camera[0]);
		var camera_x2 = camera_x1 + camera_get_view_width(view_camera[0]);
		var camera_y2 = camera_y1 + camera_get_view_height(view_camera[0]);
	
		if ((x + hsp > (camera_x2 - 282)) || (x + hsp < camera_x1 + 282)) {
			hsp = 0;
		}
		if ((y + vsp > (camera_y2)) || (y + vsp < camera_y1)) {
			vsp = 0;
		}
	
		x = x + hsp;
		y = y + vsp;
	}
}




if gamepad_is_connected(global.pad) {
	//initalize

	haxis = gamepad_axis_value(0, gp_axislh);
	vaxis = gamepad_axis_value(0, gp_axislv);
	var camera_x1 = camera_get_view_x(view_camera[0]);
	var camera_y1 = camera_get_view_y(view_camera[0]);
	var camera_x2 = camera_x1 + camera_get_view_width(view_camera[0]);
	var camera_y2 = camera_y1 + camera_get_view_height(view_camera[0]);
	
	
	////////////////////////////////// actionState 0 - Idle
	
	if (actionState = 0) {
		speed = 0;
	}
	
	if ((haxis != 0 || vaxis != 0) && actionState != 10) {
		actionState = 1;
	} else if (actionState != 10) {
		actionState = 0;
	}
	
	////////////////////////////////// actionState 1 - Movement
	
	if (actionState = 1) {
		direction = point_direction(0, 0, haxis, vaxis);
		speed = point_distance(0 ,0, haxis, vaxis) * 8;
		if (x > camera_x2 - 282) {
			x = xPrev;
		}
		
		if (x < camera_x1 + 282) {
			x = xPrev;
		}
		
		if (y > camera_y2) {
			y = yPrev;
		}
		
		if (y < camera_y1) {
			y = yPrev;
		}
	}
	
	////////////////////////////////// actionState 2 - Fire Bullet
	
	if (actionState != 10) {
		if gamepad_button_check_pressed(global.pad, gp_face1) {		
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			bulletTimer = 0;
		}

		if gamepad_button_check(global.pad, gp_face1) {
			bulletTimer += 1;
		}
		if gamepad_button_check_released(global.pad, gp_face1) {
			bulletTimer = 0;
		}
	
		if (bulletTimer > bulletInterval) {
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_playerBullet, {
				direction: 90,
				ammoType: bulletType
			});
			instance_create_layer(x - 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			instance_create_layer(x + 27, y, "Instances", obj_vertShmup_PlayerMuzzle1);
			bulletTimer = 0;
		}
	}
	
	////////////////////////////////// actionState 10 - Death
	
	if (actionState = 10) {
		if (deathTimer = 0) {
			speed = 0;
			var vx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
			var vy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 + 300;
			x = vx;
			y = vy;
		}
		deathTimer += 1;
		playerOpacity = (deathTimer mod 5) / 6;
		
		if deathTimer >= 40 {
			direction = point_direction(0, 0, haxis, vaxis);
			speed = point_distance(0 ,0, haxis, vaxis) * 8;
		}
		
		if deathTimer >= 120 {
			playerOpacity = 1;
			deathTimer = 0;
			actionState = 0;
		}
	}
	
	xPrev = x;
	yPrev = y - 1.5;
			

	
	
	



	////////////////////////////////// actionState 2 - Fire Bullet
	//if gamepad_button_check_pressed(global.pad,gp_face3) {
	//	if (numOfGuns % 2 == 1) { //even # of guns

	//		for (var i=0; i <= numOfGuns; i += 1;) {
		
	//			if (numOfGunsSwitch = 1) {
	//				alternatingVar *= -1;
	//				numOfGunsSwitch = 0;
	//			} else {
	//				alternatingVar += 40
	//				alternatingVar *= -1;
	//				numOfGunsSwitch = 1;
	//			}
	//			if instance_exists(obj_horiShmup_drone) {
	//				instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_droneBullet, {
	//				speed:40,
	//				direction: 0,
	//			});
	//			} else {
	//				instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
	//				speed:40,
	//				direction: 0,
	//			});
	//			}
			
	//			instance_create_layer(x + sprite_get_width(sprite_index)-10, y + alternatingVar, "Instances", obj_playerMuzzle, {
	//				instanceYDiff: alternatingVar
	//			});
	//			bulletTimer = 0;
	//		}	
	//	numOfGunsSwitch = 0;
	//	alternatingVar = 0;
	//	}

	//if (numOfGuns % 2 == 0) { //odd # of guns
	//	for (var i=0; i <= numOfGuns; i += 1;) {
	//		instance_create_layer(x + sprite_get_width(sprite_index),y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
	//			speed:40,
	//			direction: 0
	//		});
	//		instance_create_layer(x + sprite_get_width(sprite_index)-10,y + alternatingVar,"Instances", obj_playerMuzzle, {
	//			instanceYDiff: alternatingVar
	//		});
	//		bulletTimer = 0;
		
	//		if (numOfGunsSwitch = 1) {
	//			alternatingVar *= -1;
	//			numOfGunsSwitch = 0;
	//		} else {
	//			alternatingVar += 60
	//			alternatingVar *= -1;
	//			numOfGunsSwitch = 1;
	//		}
	//	}	
	//	numOfGunsSwitch = 0;
	//	alternatingVar = 0;
	//	}
	//}

	//if gamepad_button_check(global.pad, gp_face3) {
	//	bulletTimer += 1;
	//}

	//if gamepad_button_check_released(global.pad, gp_face3) {
	//	bulletTimer = 0;
	//}

	//if (bulletTimer > 5) {
	//	if (numOfGuns % 2 == 1) { //even # of guns

	//		for (var i=0; i <= numOfGuns; i += 1;) {
		
	//			if (numOfGunsSwitch = 1) {
	//				alternatingVar *= -1;
	//				numOfGunsSwitch = 0;
	//			} else {
	//				alternatingVar += 40
	//				alternatingVar *= -1;
	//				numOfGunsSwitch = 1;
	//			}
		
	//			instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
	//				speed:40,
	//				direction: 0
	//			});
	//			instance_create_layer(x + sprite_get_width(sprite_index)-10, y + alternatingVar, "Instances", obj_playerMuzzle, {
	//				instanceYDiff: alternatingVar
	//			});
	//			bulletTimer = 0;
	//		}	
	//		numOfGunsSwitch = 0;
	//		alternatingVar = 0;
	//	}

	//	if (numOfGuns % 2 == 0) { //odd # of guns
	//		for (var i=0; i <= numOfGuns; i += 1;) {
	//			instance_create_layer(x + sprite_get_width(sprite_index),y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
	//				speed:40,
	//				direction: 0
	//			});
	//			instance_create_layer(x + sprite_get_width(sprite_index)-10,y + alternatingVar,"Instances", obj_playerMuzzle, {
	//				instanceYDiff: alternatingVar
	//			});
	//			bulletTimer = 0;
		
	//			if (numOfGunsSwitch = 1) {
	//				alternatingVar *= -1;
	//				numOfGunsSwitch = 0;
	//			} else {
	//				alternatingVar += 60
	//				alternatingVar *= -1;
	//				numOfGunsSwitch = 1;
	//			}
	//		}	
	//		numOfGunsSwitch = 0;
	//		alternatingVar = 0;
	//	}
	//}

	////////////////////////////////// End Step



	//activate shield obj when shield is attained
	//if (shieldStatus = 1 && !instance_exists(obj_horiShmup_playerShield)) {
	//	instance_create_layer(x,y, "Instances", obj_horiShmup_playerShield);
	//}

}

if (bulletType = 0) {
	bulletInterval = 10;
} else if (bulletType = 1) {
	bulletInterval = 5;
}
else if (bulletType = 2) {
	bulletInterval = 3;
}
