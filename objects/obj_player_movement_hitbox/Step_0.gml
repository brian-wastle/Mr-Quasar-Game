 //actionstates
//0 - Still x
//1 - Walking x
//2 - Jumping x
//3 - Jetpack x
//4 - Grapple x
//5 - Slide x
//6 - Air Dodge x
//7 - 
//8 - Wall Jump x
//9 - Attack
//10 - Reload
//11 - Take Damage
//12 - Stagger
//13 - Die
//14 - Fall x
//15 - Backwards Fall x


//initalize

sprite_index = spr_robot_hitbox1;

key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_fall = keyboard_check(ord("S"));
key_jump = keyboard_check(vk_space);
key_slide = keyboard_check_pressed(vk_shift);
key_hook = mouse_check_button_pressed(mb_right);

if !instance_exists(obj_player)
	{
	instance_create_layer(x, y, "Instances", obj_player);
	}
	
if !instance_exists(obj_grapple)
	{
	instance_create_layer(obj_player.x , obj_player.y, "Instances", obj_grapple);
	}


if hsp_walk > hsp_max_walk
	{
	hsp_walk = hsp_max_walk;
	}
	
if hsp > hsp_max_walk
	{
	hsp = hsp_max_walk;
	}
if hsp < hsp_max_walk * -1
	{
	hsp = hsp_max_walk * -1;
	}

	hsp = (key_right - key_left) * hsp_walk;


////////////////////////////////// Actionstate 0 - Still

if (!keyboard_check(ord ("A")) && !keyboard_check(ord ("D"))) && actionstate != 2 && actionstate != 3 && actionstate != 4 && actionstate != 5  && actionstate != 6 && actionstate != 8 && actionstate != 14
	{
	if hsp_walk != 0
		{
		hsp_walk -= 2;
		if (hsp_walk > 0 && hsp_walk < 2 ) || (hsp_walk < 0 && hsp_walk > -2)
			{
			hsp_walk = 0;
			}
		}
	actionstate = 0;
	}


////////////////////////////////// Actionstate 1 - Walking

if (keyboard_check(ord ("A")) || keyboard_check(ord ("D"))) && actionstate < 2
	{actionstate = 1;}

if actionstate = 1 
	{
	
	//move horizontally
	if (key_right || key_left) && (hsp_walk < hsp_max_walk)
		{
		hsp_walk += .5;
		}
	if (key_right && key_left) || (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) || (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D")))
		{
		hsp_walk = 0;
		}
	hsp = (key_right - key_left) * hsp_walk;
	
	//Check for horizontal collisions and then move if we can
	var onepixel = sign(hsp) //moving left or right? right = 1, left = -1.
	if (place_meeting(x+hsp,y+vsp,obj_test_platform))
		{
		hsp_walk = 0;
		//move as close as we can
		while (!place_meeting(x+onepixel,y+vsp,obj_test_platform))
			{
			x = x + onepixel;
			}
		hsp = 0;
		}
	
	}



////////////////////////////////// Actionstate 2 - Jumping

	
	if (keyboard_check_released(vk_space) || (actionstate = 2 || actionstate = 14)) && jump_status = 1
		{
		jump_status = 2;
		}
		
	
	if keyboard_check_pressed(vk_space) && actionstate != 2 && actionstate != 14 && actionstate != 3
		{
		jump_status = 1;
		}
	
	//collision check
	if ((place_meeting(x,y+1,obj_test_platform)) && (key_jump) && jump_status < 2) || (actionstate = 8 && (key_jump) && jump_status < 2 /*&& ((obj_player.walljump_scale = 1 && key_left) || (obj_player.walljump_scale = -1 && key_right))*/)
		{ 
		
		if actionstate != 5
			{
			if hsp > 0
				{
				hsp_jump = hsp_walk ;
				hsp_walk = 4;
				}
			if hsp < 0
				{
				hsp_jump = hsp_walk * -1;
				hsp_walk = 4;
				}
			}else{
			
			if (mouse_x >= x && hsp = 0) || hsp > 0 //facing right
				{
				hsp_jump = 20;
				}
			if (mouse_x < x && hsp = 0) || hsp < 0 //facing left
				{
				hsp_jump = -20;
				}
			
			}
			
		if actionstate = 8
			{
			if obj_player.walljump_scale = 1
				{
				x -= 10;
				hsp_jump = -4;
				}
			if obj_player.walljump_scale = -1
				{
				x += 10;
				hsp_jump = 4;
				}
			}
		
		actionstate = 2;
		}
	
	
	
	if actionstate = 2
		{	
		vsp_max_height -= 1;
		
	
		//move vertically
		
		if (key_jump) && (vsp_jump > vsp_max_jump)
			{
			vsp_jump = vsp_max_jump;
			}
		
		vsp = vsp_jump;
	
		if vsp_jump < vsp_max_jump
			{
			vsp_jump = vsp_max_jump;
			}
			
	
		//move horizontally
		if key_right && (abs(hsp_jump) < hsp_max_jump)
			{
			hsp_jump += .6;
			}
		if key_left && (abs(hsp_jump) < hsp_max_jump)
			{
			hsp_jump -= .6;
			}
			hsp = hsp_jump;
	
	
		//Check for horizontal collisions and then move if we can
	var onepixel = sign(hsp) //moving left or right? right = 1, left = -1.
	if (place_meeting(x+hsp,y+vsp,obj_test_platform))
		{
		//move as close as we can
		while (!place_meeting(x+onepixel,y+vsp,obj_test_platform))
			{
			x = x + onepixel;
			}
		hsp = 0;
		}
		
		
		//stop horizontal movement when no key press left or right
		if (!key_right && !key_left) || (key_right && key_left)
			{
			if hsp_jump != 0 
				{
				if hsp_jump < 0
					{
					hsp_jump += .3;
					}
				if hsp_jump > 0
					{
					hsp_jump -= .3;
					}
				if (hsp_jump > 0 && hsp_jump < .3 ) || (hsp_jump < 0 && hsp_jump > -.3)
					{
					hsp_jump = 0;
					}
				}
			}
		}

////////////////////////////////// Actionstate 3 - Jetpack

///activate actionstate


if actionstate = 14 && init_jetpack = 1 && key_jump && jetpack_refuel = 0
	{
	actionstate = 3;
	}

if (actionstate = 2 || actionstate = 14) && !key_jump
	{
	init_jetpack = 1;
	}else{
	init_jetpack = 0;
	}


///create jetpack fuel gauge

if jetpack_fuel <= 0 && actionstate != 6
	{
	jetpack_refuel = 1;
	actionstate = 14;
	}

if actionstate != 3 && actionstate != 6 && jetpack_fuel < jetpack_max_fuel
	{
	jetpack_fuel += .5;
	}
	
if jetpack_fuel > jetpack_max_fuel
	{
	jetpack_fuel = jetpack_max_fuel;
	}

if (jetpack_refuel = 1 && jetpack_fuel >= 60)
	{
	jetpack_refuel = 0;
	}


if actionstate = 3
	{
	
	//jetpack fuel
	if (jetpack_refuel = 0 && jetpack_fuel > 0) 
		{
		jetpack_fuel -= 1.5;
		}

	
	//move vertically
	
	vsp_jetpack -= .1;
	if vsp_jetpack > vsp_max_jetpack
		{
		vsp_jetpack = vsp_max_jetpack;
		}
		
	vsp = vsp_jetpack;
	
	if keyboard_check_released(vk_space)
		{
		vsp_jetpack = 0;
		}
	
	
	//move horizontally
		
			
			
			
		hsp = hsp_jump;	
		
		
		if slide_status = 0
			{
			if key_right && (abs(hsp_jump) < hsp_max_jump)
				{
				hsp_jump += .6;
				}
			if key_left && (abs(hsp_jump) < hsp_max_jump)
				{
				hsp_jump -= .6;
				}
			}
		
		if slide_status = 1
			{
				
			if jetpack_slide = 1
				{

				if key_left && hsp > hsp_max_jump && hsp > 0 // && (abs(hsp_jump) < hsp_max_jump)
					{
					hsp_jump -= 2;
					}

				if key_right && hsp < hsp_max_jump * -1 && hsp < 0// && (abs(hsp_jump) < hsp_max_jump)
					{
					hsp_jump += 2;
					}
				}
				
			if jetpack_slide = 0
				{
				if key_right && (abs(hsp_jump) < hsp_max_jump)
					{
					hsp_jump += .6;
					}
				if key_left && (abs(hsp_jump) < hsp_max_jump)
					{
					hsp_jump -= .6;
					}
				}
			}

		

		
	
	
		
	
	
	
	//Check for horizontal collisions and then move if we can
	var onepixel = sign(hsp) //moving left or right? right = 1, left = -1.
	if (place_meeting(x+hsp,y+vsp,obj_test_platform))
		{
		//move as close as we can
		while (!place_meeting(x+onepixel,y+vsp,obj_test_platform))
			{
			x = x + onepixel;
			}
		hsp = 0;
		}


	//stop horizontal movement when no key press left or right
	if (!key_right && !key_left) || (key_right && key_left)
		{
		if hsp_jump != 0 
			{
			if hsp_jump < 0
				{
				hsp_jump += .3;
				}
			if hsp_jump > 0
				{
				hsp_jump -= .3;
				}
			if (hsp_jump > 0 && hsp_jump < .3 ) || (hsp_jump < 0 && hsp_jump > -.3)
				{
				hsp_jump = 0;
				}
			}
		}
	}




////////////////////////////////// Actionstate 4 - Grapple


//determine line of sight for grapple
//make sure player isnt clipping into walls too badly
//move player

if key_hook
	{
	mouse_grapple = point_direction(obj_grapple.x, obj_grapple.y, mouse_x, mouse_y)
	grappletarget_x = obj_grapple.x +  lengthdir_x(1500, mouse_grapple);
	grappletarget_y = obj_grapple.y +  lengthdir_y(1500, mouse_grapple);
	
	
	with obj_grapple
		{
		mp_linear_path_object(obj_player_movement_hitbox.grapplepath, obj_player_movement_hitbox.grappletarget_x, obj_player_movement_hitbox.grappletarget_y, 16, obj_test_platform);
		}
		
	if path_get_length(grapplepath) < 1450
		{
		hsp = 0;
		vsp = 0;
		actionstate = 4;
		}
	}


if actionstate = 4
	{
	with obj_grapple
		{
		mp_linear_path_object(obj_player_movement_hitbox.grapplepath, obj_player_movement_hitbox.grappletarget_x, obj_player_movement_hitbox.grappletarget_y, 16, obj_test_platform);
		}
	hsp = lengthdir_x(30, mouse_grapple);
	vsp = lengthdir_y(30, mouse_grapple);
	
	
	var onepixel = sign(hsp) //moving left or right? right = 1, left = -1.
	if (place_meeting(x+hsp,y+vsp,obj_test_platform))
		{
		//move as close as we can
		while (!place_meeting(x+onepixel,y+vsp,obj_test_platform))
			{
			x = x + onepixel;
			}
		hsp = 0;
		}
	
	}



////////////////////////////////// Actionstate 5 - Slide


if (place_meeting(x,y+1,obj_test_platform)) && (key_slide) && actionstate < 2 && slide_status = 0 && (jetpack_refuel != 1 || (jetpack_refuel = 1 && jetpack_fuel > 60))
		{ 
		if (mouse_x >= x && hsp = 0 && !key_left) || key_right //facing right
			{
			hsp_slide = 24;
			}
		if (mouse_x < x && hsp = 0 && !key_right) || key_left //facing left
			{
			hsp_slide = -24;
			}
		jetpack_fuel -= 25;
		slide_status = 1;
		actionstate = 5;
		}


if actionstate = 5
	{
	
	slide_timer += 1;
	if slide_timer >= 15
		{
		slide_timer = 0;
		actionstate = 0;
		}

	
	//revert to actionstate 0
	
	
	hsp = hsp_slide;
	
	//Check for horizontal collisions and then move if we can
	var onepixel = sign(hsp) //moving left or right? right = 1, left = -1.
	if (place_meeting(x+hsp,y+vsp,obj_test_platform))
		{
		//move as close as we can
		while (!place_meeting(x+onepixel,y+vsp,obj_test_platform))
			{
			x = x + onepixel;
			}
		hsp = 0;
		}
		
	if keyboard_check_pressed(key_jump)
		{
		jetpack_slide = 1;
		}
	}




////////////////////////////////// Actionstate 6 - Air Dodge




if actionstate = 14 && key_slide && (jetpack_refuel != 1 || (jetpack_refuel = 1 && jetpack_fuel > 60))
	{
	vsp_max_height = 0;	
	hsp = 0;
	vsp = 0;
	hsp_jump = 0;
	vsp_jump= 0;
	jetpack_fuel -= 30;
	actionstate = 6;
	
	if !(key_up && key_left) && !(key_up && key_right) && !(key_fall && key_left) && !(key_fall && key_right)
		{
		if key_right
			{
			dodge_direction = 1;
			}
		if key_up
			{
			dodge_direction = 3;
			}
		if key_left
			{
			dodge_direction = 5;
			}
		if key_fall
			{
			dodge_direction = 7;
			}
		}
	if key_up && key_right
			{
			dodge_direction = 2;
			}
	if key_up && key_left
			{
			dodge_direction = 4;
			}
	if key_fall && key_left
			{
			dodge_direction = 6;
			}
	if key_fall && key_right
			{
			dodge_direction = 8;
			}
	if !key_right && !key_up && !key_left && !key_fall
		{
		dodge_direction = 0;
		}
	}
	
if actionstate = 6
	{
	if dodge_direction = 0
		{
		hsp = 0;
		vsp = 0;
		}
	if dodge_direction = 1
		{
		hsp = 35;
		}
	if dodge_direction = 2
		{
		hsp = 26;
		vsp = -26;
		}
	if dodge_direction = 3
		{
		vsp = -35;
		}
	if dodge_direction = 4
		{
		hsp = -26;
		vsp = -26;
		}
	if dodge_direction = 5
		{
		hsp = -35;
		}
	if dodge_direction = 6
		{
		hsp = -26;
		vsp = 26;
		}
	if dodge_direction = 7
		{
		vsp = 35;
		}
	if dodge_direction = 8
		{
		hsp = 26;
		vsp = 26;
		}
	
	
	dodge_timer += 10;
	
	
	
	if (place_meeting(x+1,y,obj_test_platform)) || dodge_timer >= dodge_max_timer
		{
		dodge_timer = 0;
		hsp = 0;
		vsp = 0;
		actionstate = 0;
		}
	
	}




////////////////////////////////// Actionstate 8 - Wall Jump

if actionstate != 3 && jump_status != 1 && (((place_meeting(x+1,y,obj_test_platform)) && (collision_point(x + 34, y, obj_test_platform, true, false) && collision_point(x + 34, y, obj_test_platform, true, false))) || ((place_meeting(x-1,y,obj_test_platform)) && (collision_point(x - 38, y, obj_test_platform, true, false) && collision_point(x - 38, y+30, obj_test_platform, true, false)))) && !(place_meeting(x,y+1,obj_test_platform))
	{
	vsp_max_height = 0;
	actionstate = 8;
	}


if actionstate = 8
	{
	hsp_jump = 0;
	hsp_walk = 0;
	hsp = 0;
	vsp = 0;
	
	if (place_meeting(x+1,y,obj_test_platform))
		{
		obj_player.walljump_scale = 1;
		}
	
	if (place_meeting(x-1,y,obj_test_platform))
		{
		obj_player.walljump_scale = -1;
		}
	
	}


////////////////////////////////// Actionstate 14 - Falling

if ((((actionstate = 2 && !key_jump) || (vsp_max_height < vsp_max_jump) || (actionstate < 2 && !(place_meeting(x,y+1,obj_test_platform)))) && actionstate != 3) || (actionstate = 3 && !key_jump)) && actionstate != 6
	{
	dodge_timer = 0;
	vsp_max_height = 0;	
	actionstate = 14;
	if hsp_jump = 0 && hsp_walk != 0
		{
		if hsp > 0
			{hsp_jump = hsp_walk;}
		if hsp < 0
			{hsp_jump = hsp_walk * -1;}
		}
	}

if actionstate = 14
	{
	
	//move horizontally
		if key_right && (abs(hsp_jump) < hsp_max_jump)
			{
			hsp_jump += .6;
			}
		if key_left && (abs(hsp_jump) < hsp_max_jump)
			{
			hsp_jump -= .6;
			}

			hsp = hsp_jump;
	
	if key_fall && vsp <= 0
		{vsp = 0;}
	
	if key_fall && vsp >= 0
		{vsp *= 1.6;}
		
	if vsp > 24
		{vsp = 24;}
	
	
	//Check for horizontal collisions and then move if we can
	var onepixel = sign(hsp) //moving left or right? right = 1, left = -1.
	if (place_meeting(x+hsp,y+vsp,obj_test_platform))
		{
		//move as close as we can
		while (!place_meeting(x+onepixel,y+vsp,obj_test_platform))
			{
			x = x + onepixel;
			}
		hsp = 0;
		}


	//stop horizontal movement when no key press left or right
	if (!key_right && !key_left) || (key_right && key_left)
		{
		if hsp_jump != 0 
			{
			if hsp_jump < 0
				{
				hsp_jump += .3;
				}
			if hsp_jump > 0
				{
				hsp_jump -= .3;
				}
			if (hsp_jump > 0 && hsp_jump < .3 ) || (hsp_jump < 0 && hsp_jump > -.3)
				{
				hsp_jump = 0;
				}
			}
		}
	}






////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

if !key_jump && actionstate != 2 && actionstate != 14
	{
	jump_status = 0;
	}


		
if actionstate != 4 && actionstate != 6 && actionstate != 8
	{
	vsp = vsp + grv;
	}



var onepixel = sign(vsp) //up = -1, down = 1.
if (place_meeting(x,y+vsp,obj_test_platform))
			{
			//move as close as we can
			while (!place_meeting(x,y+onepixel,obj_test_platform)) //&& actionstate != 14
				{
				y = y + onepixel;
				}
			vsp = 0;
			}

		y = y + vsp;
	
	
	
	
	
	
//////////////////////////// Actionstate 1 - Walking
if actionstate = 1
	{

	if hsp_walk > hsp_max_walk
		{
		hsp_walk = hsp_max_walk;
		}
	
	if hsp > hsp_max_walk
		{
		hsp = hsp_max_walk;
		}
	if hsp < (hsp_max_walk * -1)
		{
		hsp = hsp_max_walk * -1;
		}
	
	}
	x = x + hsp;		
	
	
	
	
	
	
/////////////////////////// Actionstate 2 - Jumping
	
	
if (place_meeting(x,y+1,obj_test_platform)) && actionstate = 2
	{ 
	actionstate = 0;
	hsp_jump = 0;
	vsp_jump = 0;
	}


/////////////////////////// Actionstate 5 - Slide

if keyboard_check_released(key_slide) && actionstate <= 1
	{
	slide_timer = 0;
	slide_status = 0;
	}

if abs(hsp) < hsp_max_jump 
	{
	jetpack_slide = 0;
	}
	
	
/////////////////////////// Actionstate 8 - Wall Jump

if actionstate = 8 && key_fall
	{
	if obj_player.walljump_scale = 1
		{
		x -= 10;
		}
	if obj_player.walljump_scale = -1
		{
		x += 10;
		}
	actionstate = 14;
	}	
	
	


/////////////////////////// Actionstate 14 - Falling
		
if (place_meeting(x,y+1,obj_test_platform)) && (actionstate = 14 || actionstate = 4)
	{ 
	actionstate = 0;
	hsp_jump = 0;
	vsp_jump= 0;
	}