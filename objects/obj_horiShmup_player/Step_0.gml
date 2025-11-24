 //actionstates
//0 - Still x
//1 - Movement
//2 - Shooting
//3 - Bombs


if !gamepad_is_connected(global.pad) {
	//initalize


	key_right = keyboard_check(ord("D"));
	key_left = keyboard_check(ord("A"));
	key_up = keyboard_check(ord("W"));
	key_down = keyboard_check(ord("S"));


	////////////////////////////////// Actionstate 0 - Still

	if (!keyboard_check(ord ("W")) && !keyboard_check(ord ("A")) && !keyboard_check(ord ("S")) && !keyboard_check(ord ("D")))
		{
		if hsp != 0
			{
			hsp = 0;
			}
			if vsp != 0
			{
			vsp = 0;
			}
		actionstate = 0;
		}
	
	////////////////////////////////// Actionstate 1 - Movement

	if (keyboard_check(ord ("W")) || keyboard_check(ord ("A")) || keyboard_check(ord ("S")) || keyboard_check(ord ("D"))) && actionstate < 2
		{actionstate = 1;}

	if actionstate = 1 {
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

	////////////////////////////////// Actionstate 2 - Fire Bullet
	if mouse_check_button_pressed(mb_left) {
		if (numOfGuns % 2 == 1) { //even # of guns

			for (var i=0; i <= numOfGuns; i += 1;) {
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 40
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
				if instance_exists(obj_horiShmup_drone) {
					instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_droneBullet, {
					speed:40,
					direction: 0,
				});
				} else {
					instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0,
				});
				}
			
				instance_create_layer(x + sprite_get_width(sprite_index)-10, y + alternatingVar, "Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
			}	
			numOfGunsSwitch = 0;
			alternatingVar = 0;
		}

		if (numOfGuns % 2 == 0) { //odd # of guns
			for (var i=0; i <= numOfGuns; i += 1;) {
				instance_create_layer(x + sprite_get_width(sprite_index),y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0
				});
				instance_create_layer(x + sprite_get_width(sprite_index)-10,y + alternatingVar,"Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 60
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
			}	
			numOfGunsSwitch = 0;
			alternatingVar = 0;
		}
	}

	if mouse_check_button(mb_left) {
		bulletTimer += 1;
	}

	if mouse_check_button_released(mb_left) {
		bulletTimer = 0;
	}

	if (bulletTimer > 5) {
		if (numOfGuns % 2 == 1) { //even # of guns

			for (var i=0; i <= numOfGuns; i += 1;) {
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 40
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
		
				instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0
				});
				instance_create_layer(x + sprite_get_width(sprite_index)-10, y + alternatingVar, "Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
			}	
			numOfGunsSwitch = 0;
			alternatingVar = 0;
		}

		if (numOfGuns % 2 == 0) { //odd # of guns
			for (var i=0; i <= numOfGuns; i += 1;) {
				instance_create_layer(x + sprite_get_width(sprite_index),y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0
				});
				instance_create_layer(x + sprite_get_width(sprite_index)-10,y + alternatingVar,"Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 60
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
			}	
			numOfGunsSwitch = 0;
			alternatingVar = 0;
		}
	}

	////////////////////////////////// End Step



	//activate shield obj when shield is attained
	if (shieldStatus = 1 && !instance_exists(obj_horiShmup_playerShield)) {
		instance_create_layer(x,y, "Instances", obj_horiShmup_playerShield);
	}





	if (actionstate = 1) {
	
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
	
		if ((x + hsp > (camera_x2 - 100)) || (x + hsp < camera_x1)) {
			hsp = 0;
		}
		if ((y + vsp > (camera_y2 - 50)) || (y + vsp < camera_y1)) {
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
	direction = point_direction(0, 0, haxis, vaxis);
	speed = point_distance(0 ,0, haxis, vaxis) * 10;
	/*if (x < 130) {
		x = 130;
	}	
	if (x > 2270) {
		x = 2270;
	}*/


	////////////////////////////////// Actionstate 2 - Fire Bullet
	if gamepad_button_check_pressed(global.pad,gp_face3) {
		if (numOfGuns % 2 == 1) { //even # of guns

			for (var i=0; i <= numOfGuns; i += 1;) {
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 40
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
				if instance_exists(obj_horiShmup_drone) {
					instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_droneBullet, {
					speed:40,
					direction: 0,
				});
				} else {
					instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0,
				});
				}
			
				instance_create_layer(x + sprite_get_width(sprite_index)-10, y + alternatingVar, "Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
			}	
		numOfGunsSwitch = 0;
		alternatingVar = 0;
		}

	if (numOfGuns % 2 == 0) { //odd # of guns
		for (var i=0; i <= numOfGuns; i += 1;) {
			instance_create_layer(x + sprite_get_width(sprite_index),y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
				speed:40,
				direction: 0
			});
			instance_create_layer(x + sprite_get_width(sprite_index)-10,y + alternatingVar,"Instances", obj_playerMuzzle, {
				instanceYDiff: alternatingVar
			});
			bulletTimer = 0;
		
			if (numOfGunsSwitch = 1) {
				alternatingVar *= -1;
				numOfGunsSwitch = 0;
			} else {
				alternatingVar += 60
				alternatingVar *= -1;
				numOfGunsSwitch = 1;
			}
		}	
		numOfGunsSwitch = 0;
		alternatingVar = 0;
		}
	}

	if gamepad_button_check(global.pad, gp_face3) {
		bulletTimer += 1;
	}

	if gamepad_button_check_released(global.pad, gp_face3) {
		bulletTimer = 0;
	}

	if (bulletTimer > 5) {
		if (numOfGuns % 2 == 1) { //even # of guns

			for (var i=0; i <= numOfGuns; i += 1;) {
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 40
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
		
				instance_create_layer(x + sprite_get_width(sprite_index), y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0
				});
				instance_create_layer(x + sprite_get_width(sprite_index)-10, y + alternatingVar, "Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
			}	
			numOfGunsSwitch = 0;
			alternatingVar = 0;
		}

		if (numOfGuns % 2 == 0) { //odd # of guns
			for (var i=0; i <= numOfGuns; i += 1;) {
				instance_create_layer(x + sprite_get_width(sprite_index),y + alternatingVar, "Instances", obj_horiShmup_playerBullet, {
					speed:40,
					direction: 0
				});
				instance_create_layer(x + sprite_get_width(sprite_index)-10,y + alternatingVar,"Instances", obj_playerMuzzle, {
					instanceYDiff: alternatingVar
				});
				bulletTimer = 0;
		
				if (numOfGunsSwitch = 1) {
					alternatingVar *= -1;
					numOfGunsSwitch = 0;
				} else {
					alternatingVar += 60
					alternatingVar *= -1;
					numOfGunsSwitch = 1;
				}
			}	
			numOfGunsSwitch = 0;
			alternatingVar = 0;
		}
	}

	////////////////////////////////// End Step



	//activate shield obj when shield is attained
	if (shieldStatus = 1 && !instance_exists(obj_horiShmup_playerShield)) {
		instance_create_layer(x,y, "Instances", obj_horiShmup_playerShield);
	}

}