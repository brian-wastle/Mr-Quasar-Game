 //actionStates
//0 - Still x
//1 - Movement
//2 - Shooting
//3 - Bombs
//4 - Roll


if !gamepad_is_connected(global.pad) {
	//initalize
	
	if !instance_exists(obj_TwinStickShooter_PlayerTop) {
		instance_create_layer(x,y,"Instances",obj_TwinStickShooter_PlayerTop);
	}

	var camera_x1 = camera_get_view_x(view_camera[0]);
	var camera_y1 = camera_get_view_y(view_camera[0]);
	var camera_x2 = camera_x1 + camera_get_view_width(view_camera[0]);
	var camera_y2 = camera_y1 + camera_get_view_height(view_camera[0]);
	var centerX = (camera_x2 - camera_x1)/2 + camera_x1;
	var centerY = (camera_y2 - camera_y1)/2 + camera_y1;

	key_right = keyboard_check(ord("D"));
	key_left = keyboard_check(ord("A"));
	key_up = keyboard_check(ord("W"));
	key_down = keyboard_check(ord("S"));

	depth = y * -1;


	//set actualDir
	
	if ((point_direction(x, y, mouse_x, mouse_y) >= 0 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 22) ||
	    (point_direction(x, y, mouse_x, mouse_y) > 337 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 360)) {
		actualDir = 0
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 22 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 67) {
		actualDir = 45;
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 67 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 112) {
		actualDir = 90;
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 112 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 157) {
	    actualDir = 135;
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 157 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 202) {
	    actualDir = 180;
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 202 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 247) {
	    actualDir = 225;
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 247 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 292) {
	    actualDir = 270;
	}
	    if (point_direction(x, y, mouse_x, mouse_y) > 292 &&
	    point_direction(x, y, mouse_x, mouse_y) <= 337) {
	    actualDir = 315;
	}  


	
	////////////////////////////////// actionState 0 - Still

	if (!keyboard_check(ord ("W")) && !keyboard_check(ord ("A")) && !keyboard_check(ord ("S")) && !keyboard_check(ord ("D")) && actionState < 2)
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
	

	    if (!key_down) {
	        if (!key_up) {
	            if (!key_right && !key_left) { 
	                if (actionState = 0) {  
						sprite_index = spr_twinStickShooter_player;
	                    if ((point_direction(x, y, mouse_x, mouse_y) >= 0 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 22) ||
	                        (point_direction(x, y, mouse_x, mouse_y) > 337 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 360)) {
							image_index = 2;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 22 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 67) {
							image_index = 3;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 67 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 112) {
							image_index = 4;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 112 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 157) {
	                        image_index = 5;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 157 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 202) {
	                        image_index = 6;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 202 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 247) {
	                        image_index = 7;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 247 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 292) {
	                        image_index = 0;
	                    }
	                        if (point_direction(x, y, mouse_x, mouse_y) > 292 &&
	                        point_direction(x, y, mouse_x, mouse_y) <= 337) {
	                        image_index = 1;
	                    }  
						actionState = 0;
						image_speed = 0;
	                }       
	            }
	        }
	    }
	    
	

	
	////////////////////////////////// actionState 1 - Movement

	if (keyboard_check(ord ("W")) || keyboard_check(ord ("A")) || keyboard_check(ord ("S")) || keyboard_check(ord ("D"))) && actionState < 2 {
		actionState = 1;
	}


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
	
	
	    //4-DIRECTIONAL MOVEMENT
     
	    if key_up && !key_down && !key_left && !key_right {   
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerRunUp;  vsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  vsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  vsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerRunDown;  vsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  vsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  vsp -= .5; 
	            }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerStrafeLeft;  vsp -= .5; 
	        }
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerStrafeRight;  vsp -= .5; 
	        }
	        if vsp < -4 {
				vsp = -4;
			}
	        if vsp >  4 {
				vsp =  4;
			}
		}
     
     
	    if key_left && !key_down && !key_up && !key_right {
	        if hsp > 0 {
				hsp = 0;
			}
     
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerStrafeDown;  hsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  hsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  hsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerStrafeUp;  hsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  hsp -= .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  hsp -= .5; 
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  hsp -= .5;
	        }
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerRunRight;  hsp -= .5; 
	        }
	        if hsp >  4 {
				hsp =  4;
			}
	        if hsp < -4 {
				hsp = -4;
			}
		}
     
     
	    if !key_up && key_down && !key_left && !key_right {
                
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerRunUp;  vsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  vsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  vsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerRunDown;  vsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  vsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  vsp += .5; 
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerStrafeLeft;  vsp += .5; 
	        }
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerStrafeRight;  vsp += .5; 
	        }
	        if vsp < -4 {
				vsp = -4;
			}
	        if vsp >  4 {
				vsp =  4;
			}
		}
                      
     
	    if key_right && !key_left && !key_up && !key_down {
	        if hsp < 0 {
				hsp = 0;
			}
     
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerStrafeDown;  hsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  hsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  hsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerStrafeUp;  hsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  hsp += .5; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  hsp += .5; 
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  hsp += .5; 
	        }
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerRunRight;  hsp += .5; 
	        }
	        if hsp >  4 {
				hsp =  4;
			}
	        if hsp < -4 {
				hsp = -4;
			}
		}
     
    
     
	//DIAGONAL MOVEMENT
     
	    if key_up && key_left {
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerStrafeUpRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerStrafeDownLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	        hsp -= .5;
	        vsp -= .5;
	        if hsp > 4 {
				hsp = 4;
			}
	        if vsp > 4 {
				vsp = 4;
			}
	        if hsp < -4 {
				hsp = -4;
			}
	        if vsp < -4 {
				vsp = -4;
			}
	    }
	    if key_up && key_right {
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerStrafeUpLeft;  
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerStrafeDownRight;  
	        }
	        hsp += .5;
	        vsp -= .5;
	        if hsp > 4 {
				hsp = 4;
			}
	        if vsp > 4 {
				vsp = 4;
			}
	        if hsp < -4 {
				hsp = -4;
			}
	        if vsp < -4 {
				vsp = -4;
			}
	    }
	    if key_down && key_left {
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerStrafeUpLeft;  
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerStrafeDownRight;  
	        }
	        hsp -= .5;
	        vsp += .5;
	        if hsp > 4 {
				hsp = 4;
			}
	        if vsp > 4 {
				vsp = 4;
			}
	        if hsp < -4 {
				hsp = -4;
			}
	        if vsp < -4 {
				vsp = -4;
			}
	    }
	    if key_down && key_right {
	        if ((point_direction(x, y, mouse_x, mouse_y) > 337 && point_direction(x, y, mouse_x, mouse_y) <= 360) || (point_direction(x, y, mouse_x, mouse_y) >= 0 && point_direction(x, y, mouse_x, mouse_y) < 22)) {
	            sprite_index = spr_twinStickShooter_playerRunRight; 
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 22 && point_direction(x, y, mouse_x, mouse_y) <= 67 {
	            sprite_index = spr_twinStickShooter_playerStrafeUpRight;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 67 && point_direction(x, y, mouse_x, mouse_y) <= 112 {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 112 && point_direction(x, y, mouse_x, mouse_y) <= 157 {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  
	        }
	        if (point_direction(x, y, mouse_x, mouse_y) > 157 && point_direction(x, y, mouse_x, mouse_y) <= 202) {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 202 && point_direction(x, y, mouse_x, mouse_y) <= 247 {
	            sprite_index = spr_twinStickShooter_playerStrafeDownLeft;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 247 && point_direction(x, y, mouse_x, mouse_y) <= 292 {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if point_direction(x, y, mouse_x, mouse_y) > 292 && point_direction(x, y, mouse_x, mouse_y) <= 337 {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	        hsp += .5;
	        vsp += .5;
	        if hsp > 4 {
				hsp = 4;
			}
	        if vsp > 4 {
				vsp = 4;
			}
	        if hsp < -4 {
				hsp = -4;
			}
	        if vsp < -4 {
				vsp = -4;
			}
	    }
		image_speed = 1;
	}

	////////////////////////////////// actionState 2 - Fire Bullet
	
	cursorOffsetX = lengthdir_x(bulletArray[bulletType].offset,actualDir);
	cursorOffsetY = lengthdir_y(bulletArray[bulletType].offset,actualDir);
	if (actionState < 2 && mouse_check_button_pressed(mb_left) && fireState = 0) {
		fireState = 1;
		var currentDir = point_direction(x, y, mouse_x, mouse_y);
		var bulletDir = 45 * round(currentDir / 45);
		instance_create_layer(x + cursorOffsetX,y + cursorOffsetY,"Instances",bulletArray[bulletType].object, {
			speed:12,
			direction:bulletDir
		});
	}
	if (fireState = 1) {
		delayTimer += 1;
		if (delayTimer >=  bulletArray[bulletType].delay) {
			fireState = 0;
			delayTimer = 0;
		}
	}
	if (actionState < 2 && mouse_check_button(mb_left)) {
		bulletTimer += 1;
		if bulletTimer >= bulletArray[bulletType].delay {
			var currentDir = point_direction(x, y, mouse_x, mouse_y);
			var bulletDir = 45 * round(currentDir / 45);
			instance_create_layer(x + cursorOffsetX,y + cursorOffsetY,"Instances",bulletArray[bulletType].object, {
				speed:12,
				direction:bulletDir
			});
			bulletTimer = 0;
		}
	}
	if (mouse_check_button_released(mb_left)) {
		bulletTimer = 0;
	}
	
	
	////////////////////////////////// actionState 4 - Roll
	
	if (playerStamina < 100 && stamRecharge = 0) {
		playerStamina += 1;
	}
	
	if (playerStamina >= 90 && keyboard_check_pressed(vk_space)) {
		actionState = 4;
		//clear other actionStates' variables
		bulletTimer = 0;
		stamRecharge = 1;
	}
	
	if (actionState = 4) {
		if (stamRecharge = 1) {
			playerStamina -= 8;
			if (playerStamina <= 20) {
				stamRecharge = 0;
			}
		}
		//player movement
		
		//return to actionState = 0
	}
	
	
	

	///////////////////////////////////////////
	////////////////////////////////// End Step
	/////////////////////////////////////////////



	var xx, yy; //declare temporary variables



	if actionState <= 2 {
	    if keyboard_check(ord("W")) && keyboard_check(ord("S")) {
	        vsp *= .6;
	        }
	    if keyboard_check(ord("A")) && keyboard_check(ord("D")) {
	        hsp *= .6;
	    }
	}
    
	direction = 0;
	dir = direction;
	len = speed;
	
	
	xx =  x + lengthdir_x(hsp, dir);
	yy =  y + lengthdir_y(vsp, dir);


	xtarg = x + hsp;
	ytarg = y + vsp;
	

	///////////////////////////////////////////////////////////
	///////////Determine floor position
	///////////////////////////////////////////////////////////
	
	//if there is no object to block player from moving forward
	if (!place_meeting(xtarg, ytarg, obj_twinStickShooter_boundaryLowParent) && !place_meeting(xtarg, ytarg, obj_twinStickShooter_doorParent) && !place_meeting(xtarg, ytarg, obj_twinStickShooter_enemyParent)) {
		x = xtarg;
	    y = ytarg;
	} else {		
		//check collisions every 10 degrees	
		var sweep_interval = 10;        
		
	    for ( var angle = sweep_interval; angle <= 90; angle += sweep_interval) {	
	        for ( var multiplier = -1; multiplier <= 1; multiplier += 2) {  	
	            var angle_to_check = dir+angle*multiplier;
	            xtarg = x + lengthdir_x(hsp, angle_to_check);
	            ytarg = y + lengthdir_y(vsp, angle_to_check)
				if (!place_meeting(xtarg, ytarg, obj_twinStickShooter_enemyParent) && !place_meeting(xtarg, ytarg, obj_twinStickShooter_doorParent) && !place_meeting(xtarg, ytarg, obj_twinStickShooter_boundaryLowParent)) {
	                x = xtarg;
	                y = ytarg;
					exit;
	            }	
		    }	
		}
	}
	hsp = 0;
	vsp = 0;
}
/////////////////////////////////////////////////////////////////////////////--GAMEPAD--/////////////////////////////////////////////////////////////////////
if gamepad_is_connected(global.pad) {
	//initalize
	lhaxis = gamepad_axis_value(global.pad, gp_axislh);
	lvaxis = gamepad_axis_value(global.pad, gp_axislv);
	rhaxis = gamepad_axis_value(global.pad, gp_axisrh);
	rvaxis = gamepad_axis_value(global.pad, gp_axisrv);
	if !instance_exists(obj_TwinStickShooter_PlayerTop) {
		instance_create_layer(x,y,"Instances",obj_TwinStickShooter_PlayerTop);
	}

	var camera_x1 = camera_get_view_x(view_camera[0]);
	var camera_y1 = camera_get_view_y(view_camera[0]);
	var camera_x2 = camera_x1 + camera_get_view_width(view_camera[0]);
	var camera_y2 = camera_y1 + camera_get_view_height(view_camera[0]);
	var centerX = (camera_x2 - camera_x1)/2 + camera_x1;
	var centerY = (camera_y2 - camera_y1)/2 + camera_y1;


	depth = y * -1;

	if (lhaxis >= .85 && lvaxis <= .4 && lvaxis >= -.4) {
		directionOffset = "right";
	} else if (lhaxis > .4 && lhaxis < .85 && lvaxis < -.3 && lvaxis > -.75) {
		directionOffset = "upRight";
	} else if (lvaxis <= -.75 && lhaxis <= .4 && lhaxis >= -.4) {
		directionOffset = "up";
	} else if (lhaxis < -.4 && lhaxis > -.85 && lvaxis < -.3 && lvaxis > -.75) {
		directionOffset = "upLeft";
	} else if (lhaxis <= -.85 && lvaxis <= .4 && lvaxis >= -.4) {
		directionOffset = "left";
	} else if (lhaxis < -.4 && lhaxis > -.85 && lvaxis > .3 && lvaxis < .75) {
		directionOffset = "downLeft";
	} else if (lvaxis >= .75 && lhaxis <= .4 && lhaxis >= -.4) {
		directionOffset = "down";
	} else if (lhaxis > .4 && lhaxis < .85 && lvaxis > .3 && lvaxis < .75) {
		directionOffset = "downRight";
	}
	
	if (rhaxis >= .9 && rvaxis <= .2 && rvaxis >= -.2) {
		aimOffset = "right";
	} else if (rhaxis > .2 && rhaxis < .9 && rvaxis < -.2 && rvaxis > -.9) {
		aimOffset = "upRight";
	} else if (rvaxis <= -.9 && rhaxis <= .2 && rhaxis >= -.2) {
		aimOffset = "up";
	} else if (rhaxis < -.2 && rhaxis > -.9 && rvaxis < -.2 && rvaxis > -.9) {
		aimOffset = "upLeft";
	} else if (rhaxis <= -.85 && rvaxis <= .4 && rvaxis >= -.4) {
		aimOffset = "left";
	} else if (rhaxis < -.4 && rhaxis > -.85 && rvaxis > .3 && rvaxis < .75) {
		aimOffset = "downLeft";
	} else if (rvaxis >= .75 && rhaxis <= .4 && rhaxis >= -.4) {
		aimOffset = "down";
	} else if (rhaxis > .4 && rhaxis < .85 && rvaxis > .3 && rvaxis < .75) {
		aimOffset = "downRight";
	}

	////////////////////////////////// actionState 0 - Still

	if (lhaxis < .2 && lhaxis > -.2 && lvaxis < .2 && lvaxis > -.2) {
		speed = 0;
		actionState = 0;
	}
	

	if (actionState = 0) {  
		sprite_index = spr_twinStickShooter_player;
		
	    if (aimOffset = "right") {
			image_index = 2;
		}
		if (aimOffset = "upRight") {
			image_index = 3;
		}
		if (aimOffset = "up") {
			image_index = 4;
		}
		if (aimOffset = "upLeft") {
			image_index = 5;
		}
		if (aimOffset = "left") {
			image_index = 6;
		}
		if (aimOffset = "downLeft") {
			image_index = 7;
		}
		if (aimOffset = "down") {
			image_index = 0;
		}
		if (aimOffset = "downRight") {
			image_index = 1;
		}
		image_speed = 0;
	}       

	    
	

	
	////////////////////////////////// actionState 1 - Movement

	if (lhaxis < -.2 || lhaxis > .2 || lvaxis < -.2 || lvaxis > .2) && actionState < 2 {
		actionState = 1;
	}


	if actionState = 1 {
	direction = point_direction(0, 0, lhaxis, lvaxis);
	speed = point_distance(0 ,0, lhaxis, lvaxis) * 5;
	
	
	    //4-DIRECTIONAL MOVEMENT
     
	    if directionOffset = "up" {        
	        if (aimOffset = "up") { //up
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if (aimOffset = "upRight") { // upright
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  
	        }
	        if (aimOffset = "upLeft") { //upleft
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  
	        }
	        if (aimOffset = "down") { //down
	            sprite_index = spr_twinStickShooter_playerRunDown; 
	        }
	        if (aimOffset = "downRight") { //downright
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	        if (aimOffset = "downLeft") { //downleft
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  
	            }
	        if (aimOffset = "left") { //left
	            sprite_index = spr_twinStickShooter_playerStrafeLeft;  
	        }
	        if (aimOffset = "right") { // right
	            sprite_index = spr_twinStickShooter_playerStrafeRight; 
	        }
		}
     
     
	    if directionOffset = "left" {
     
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerStrafeDown;  
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerRunUpRight; 
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerStrafeUp; 
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerRunDownRight; 
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft; 
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerRunLeft; 
	        }
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
		}
     
     
	    if directionOffset = "down" {
                
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerRunUp; 
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft; 
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerStrafeLeft; 
	        }
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerStrafeRight; 
	        }
		}
                      
     
	    if directionOffset = "right" {
     
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerStrafeDown;  
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerRunUpRight; 
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft; 
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerStrafeUp; 
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft; 
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerRunLeft; 
	        }
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerRunRight;
	        }
		}
     
    
     
	//DIAGONAL MOVEMENT
     
	    if directionOffset = "upLeft" {
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerStrafeUpRight;  
	        }
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerStrafeDownLeft;  
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	    }
	    if directionOffset = "upRight" {
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  
	        }
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerStrafeUpLeft;  
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerStrafeDownRight;  
	        }
	    }
	    if directionOffset = "downLeft" {
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerRunRight;  
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerRunUpRight;  
	        }
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerStrafeUpLeft;  
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerRunDownLeft;  
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerStrafeDownRight;  
	        }
	    }
	    if directionOffset = "downRight" {
	        if (aimOffset = "right") {
	            sprite_index = spr_twinStickShooter_playerRunRight; 
	        }
	        if (aimOffset = "upRight") {
	            sprite_index = spr_twinStickShooter_playerStrafeUpRight;  
	        }
	        if (aimOffset = "up") {
	            sprite_index = spr_twinStickShooter_playerRunUp;  
	        }
	        if (aimOffset = "upLeft") {
	            sprite_index = spr_twinStickShooter_playerRunUpLeft;  
	        }
	        if (aimOffset = "left") {
	            sprite_index = spr_twinStickShooter_playerRunLeft;  
	        }
	        if (aimOffset = "downLeft") {
	            sprite_index = spr_twinStickShooter_playerStrafeDownLeft;  
	        }
	        if (aimOffset = "down") {
	            sprite_index = spr_twinStickShooter_playerRunDown;  
	        }
	        if (aimOffset = "downRight") {
	            sprite_index = spr_twinStickShooter_playerRunDownRight;  
	        }
	    }
		image_speed = 1;
	}


	////////////////////////////////// actionState 2 - Fire Bullet
	if (gamepad_button_check_pressed(global.pad,gp_shoulderrb) && fireState = 0) {
		fireState = 1;
		if (aimOffset = "right") {
	    actualDir = 0; 
		}
		if (aimOffset = "upRight") {
		    actualDir = 45; 
		}
		if (aimOffset = "up") {
		    actualDir = 90;   
		}
		if (aimOffset = "upLeft") {
		    actualDir = 135;  
		}
		if (aimOffset = "left") {
		    actualDir = 180; 
		}
		if (aimOffset = "downLeft") {
		    actualDir = 225; 
		}
		if (aimOffset = "down") {
		    actualDir = 270; 
		}
		if (aimOffset = "downRight") {
		    actualDir = 315; 
		}
		
		var bulletDir = 45 * round(actualDir / 45);
		cursorOffsetX = lengthdir_x(bulletArray[bulletType].offset,actualDir);
		cursorOffsetY = lengthdir_y(bulletArray[bulletType].offset,actualDir);
		instance_create_layer(x + cursorOffsetX,y + cursorOffsetY,"Instances",bulletArray[bulletType].object, {
			speed:12,
			direction:bulletDir
		});
	}
	
	if (fireState = 1) {
		delayTimer += 1;
		if (delayTimer >=  bulletArray[bulletType].delay) {
			fireState = 0;
			delayTimer = 0;
		}
	}

	if gamepad_button_check(global.pad,gp_shoulderrb) {
		bulletTimer += 1;
		if bulletTimer >= bulletArray[bulletType].delay {
			if (aimOffset = "right") {
		        actualDir = 0; 
		    }
		    if (aimOffset = "upRight") {
		        actualDir = 45; 
		    }
		    if (aimOffset = "up") {
		        actualDir = 90;   
		    }
		    if (aimOffset = "upLeft") {
		        actualDir = 135;  
		    }
		    if (aimOffset = "left") {
		        actualDir = 180; 
		    }
		    if (aimOffset = "downLeft") {
		        actualDir = 225; 
		    }
		    if (aimOffset = "down") {
		        actualDir = 270; 
		    }
		    if (aimOffset = "downRight") {
		        actualDir = 315; 
		    }
		
			var bulletDir = 45 * round(actualDir / 45);
			cursorOffsetX = lengthdir_x(bulletArray[bulletType].offset,actualDir);
			cursorOffsetY = lengthdir_y(bulletArray[bulletType].offset,actualDir);
			instance_create_layer(x + cursorOffsetX,y + cursorOffsetY,"Instances",bulletArray[bulletType].object, {
				speed:12,
				direction:bulletDir
			});
			bulletTimer = 0;
		}
	}

	if gamepad_button_check_released(global.pad,gp_shoulderrb) {
		bulletTimer = 0;
	}




	///////////////////////////////////////////
	////////////////////////////////// End Step
	/////////////////////////////////////////////


	dir = direction;
	len = speed;
	if (len > 5) {
		len = 5;
	}
	xtarg = x + lengthdir_x(len, dir);
	ytarg = y + lengthdir_y(len, dir);
	

	///////////////////////////////////////////////////////////
	///////////Determine floor position
	///////////////////////////////////////////////////////////
	
	//if there is no object to block player from moving forward
	if !place_meeting(xtarg, ytarg, obj_twinStickShooter_boundaryLowParent)  && !place_meeting(xtarg, ytarg, obj_twinStickShooter_enemyParent) {
		x = xtarg;
	    y = ytarg;
	} else {		
		//check collisions every 10 degrees	
		var sweep_interval = 10;        
		
	    for ( var angle = sweep_interval; angle <= 90; angle += sweep_interval) {	
	        for ( var multiplier = -1; multiplier <= 1; multiplier += 2) {  	
	            var angle_to_check = dir+angle*multiplier;
	            xtarg = x + lengthdir_x(len, angle_to_check);
	            ytarg = y + lengthdir_y(len, angle_to_check);
				if (!place_meeting(xtarg, ytarg, obj_twinStickShooter_enemyParent) && !place_meeting(xtarg, ytarg, obj_twinStickShooter_boundaryLowParent)) {
	                x = x + lengthdir_x(len, angle_to_check);
	                y = y + lengthdir_y(len, angle_to_check);
					exit;
	            }	
		    }	
		}
	}
	speed = 0;

		
}