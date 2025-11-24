//actionstates
//0 - Still x
//1 - Walking x
//2 - Jumping x
//11 - Take Damage
//13 - Die
//14 - Fall x
//15 - Shoot rifle
//16 - Shelf Ride (falling shelf support)
if (obj_runAndGun_camera.cutscene == false) {
	if !gamepad_is_connected(global.pad) {
		//initalize
		image_speed = 1;
		key_right = keyboard_check(ord("D"));
		key_left = keyboard_check(ord("A"));
		key_up = keyboard_check(ord("W"));
		key_fall = keyboard_check(ord("S"));
		key_jump = keyboard_check(vk_space);
		key_slide = keyboard_check_pressed(vk_shift);
		key_hook = mouse_check_button_pressed(mb_right);

		if hspWalk > hspMaxWalk
			{
			hspWalk = hspMaxWalk;
			}
	
		if hsp > hspMaxWalk
			{
			hsp = hspMaxWalk;
			}
		if hsp < hspMaxWalk * -1
			{
			hsp = hspMaxWalk * -1;
			}

			hsp = (key_right - key_left) * hspWalk;

		if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
			if (sprite_index == legSprStruct.idle[weaponType][0])  {
				if (xOffset = 1) {
					directionOffset = "right";
				} else if (xOffset = -1) {
					directionOffset = "left";
				}
			}
		}
		if (sprite_index != spr_runAndGun_PlayerStillRifleRFire && headSprite != spr_RunAndGun_PlayerProneRifleFire) {
			if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && keyboard_check(ord("D"))) {
				directionOffset = "right";
				xOffset = 1;
			} else if (keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && keyboard_check(ord("D"))) {
				directionOffset = "upRight";
				xOffset = 1;
			} else if (keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
				directionOffset = "up";
				yOffset = 1;
			} else if (keyboard_check(ord("W")) && keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
				directionOffset = "upLeft";
				xOffset = -1;
			} else if (!keyboard_check(ord("W")) && keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
				directionOffset = "left";
				xOffset = -1;
			} else if (!keyboard_check(ord("W")) && keyboard_check(ord("A")) && keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
				directionOffset = "downLeft";
				xOffset = -1;
			} else if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
				directionOffset = "down";
				yOffset = -1;
			} else if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && keyboard_check(ord("S")) && keyboard_check(ord("D"))) {
				directionOffset = "downRight";
				xOffset = 1;
			}
			if (!keyboard_check(ord("W")) && !keyboard_check(ord("S"))) {
				yOffset = 0;
			}
		}

		// Collision against falling shelf masks using player origin
		var shelfContact = false;
		var shelfTiltedOff = false;
		var shelfCandidate = noone;
		var prevSupport = support_platform;
		var prevSupportIsMask = false;
		if (prevSupport != noone) {
			if (instance_exists(prevSupport)) {
				if (prevSupport.object_index == obj_RunAndGun2_fallingMask) {
					prevSupportIsMask = true;
				}
			}
		}

		if (support_detach_timer > 0) {
			support_detach_timer -= 1;
			if (support_detach_timer <= 0) {
				support_detach_id = noone;
			}
		}

		support_candidate_id = noone;
		support_candidate_score = 1000000000;
		support_candidate_projx = x;
		support_candidate_projy = y;
		support_candidate_dist = 0;
		support_candidate_t = 0;
		support_candidate_normal.x = 0;
		support_candidate_normal.y = -1;
		support_candidate_tangent.x = 1;
		support_candidate_tangent.y = 0;
		support_edge_length = 0;
		support_surface_origin.x = x;
		support_surface_origin.y = y;

		with (obj_RunAndGun2_fallingMask) {
			if (id != other.support_detach_id) {

				var px = other.x;
				var py = other.y;
				var relx = px - surface_x1;
				var rely = py - surface_y1;
				var len = local.half_w * 2;
				var along = relx * surface_tangent_x + rely * surface_tangent_y;

				if (along >= -24 && along <= len + 24) {
					var clearance = relx * surface_normal_x + rely * surface_normal_y;
					if (clearance >= -18 && clearance <= 48) {
						var clamped = clamp(along, 0, len);
						var projx = surface_x1 + surface_tangent_x * clamped;
						var projy = surface_y1 + surface_tangent_y * clamped;
						var edgePenalty = abs(along - clamped);
						var currentScore = abs(clearance) * 100 + edgePenalty;

						if (currentScore < other.support_candidate_score) {
							other.support_candidate_id = id;
							other.support_candidate_score = currentScore;
							other.support_candidate_projx = projx;
							other.support_candidate_projy = projy;
							other.support_candidate_dist = clearance;
							other.support_candidate_t = (len > 0) ? (clamped / len) : 0;
							other.support_candidate_normal.x = surface_normal_x;
							other.support_candidate_normal.y = surface_normal_y;
							other.support_candidate_tangent.x = surface_tangent_x;
							other.support_candidate_tangent.y = surface_tangent_y;
							other.support_edge_length = len;
							other.support_surface_origin.x = surface_x1;
							other.support_surface_origin.y = surface_y1;
						}
					}
				}
			}
		}

		if (support_candidate_id != noone) {
			var tiltDot = clamp(-support_candidate_normal.y, -1, 1);
			var tiltAngle = arccos(tiltDot);
			if (tiltAngle <= 45) {
				shelfContact = true;
				shelfCandidate = support_candidate_id;
			} else {
				shelfTiltedOff = true;
			}
		}

		if (shelfContact) {
			var clearance = clamp(support_candidate_dist, 0, 4);
			support_surface_normal.x = support_candidate_normal.x;
			support_surface_normal.y = support_candidate_normal.y;
			support_surface_tangent.x = support_candidate_tangent.x;
			support_surface_tangent.y = support_candidate_tangent.y;
			support_world_pos.x = support_candidate_projx;
			support_world_pos.y = support_candidate_projy;
			support_world_pos.clearance = clearance;
			support_platform = shelfCandidate;
			support_contact = true;
			support_on_ground = true;
			vspJumpDuration = 0;
			vspJump = 0;
			vsp = 0;

			with (support_platform) {
				var rel_x = other.support_candidate_projx - pivot_x;
				var rel_y = other.support_candidate_projy - pivot_y;
				var loc_x = rel_x * basis_cos + rel_y * basis_sin;
				var loc_y = -rel_x * basis_sin + rel_y * basis_cos;
				other.support_local_pos.x = loc_x;
				other.support_local_pos.y = loc_y;
			}

			x = support_world_pos.x + support_surface_normal.x * clearance;
			y = support_world_pos.y + support_surface_normal.y * clearance;
		} else if (prevSupportIsMask) {
			if (shelfTiltedOff) {
				var slideDirX = support_candidate_tangent.x;
				hspJump = slideDirX * max(hspWalk, 6);
				vsp = max(vsp, 2);
				actionstate = 14;
				support_detach_id = prevSupport;
				support_detach_timer = 8;
			}

			support_detach_id = prevSupport;
			support_detach_timer = max(support_detach_timer, 6);
			support_platform = noone;
			support_contact = false;
			support_on_ground = false;
		}

		////////////////////////////////// Actionstate 0 - Still

		if (!keyboard_check(ord ("A")) && !keyboard_check(ord ("D"))) && actionstate != 2 && actionstate != 14 && actionstate != 16 {
			if hspWalk != 0
				{
				hspWalk -= 2;
				if (hspWalk > 0 && hspWalk < 2 ) || (hspWalk < 0 && hspWalk > -2)
					{
					hspWalk = 0;
					}
				}
			actionstate = 0;
			}

		if (actionstate = 0) {
			if (sprite_index != spr_runAndGun_PlayerStillRifleRFire && headSprite != spr_RunAndGun_PlayerProneRifleFire) {
			    sprite_index = legSprStruct.idle[weaponType][0];
				if (xOffset = 1) {
					bulletDir = 0;
				} else {
					bulletDir = 180;
				}
				if (yOffset = 1) {
					sprite_index = legSprStruct.idle[weaponType][1]; //up sprite
					bulletDir = 90;
				} else if (yOffset = -1) {
					sprite_index = legSprStruct.idle[weaponType][2]; //prone sprite
				}

				switch (sprite_index) {
					case legSprStruct.idle[weaponType][0]:	//idle
					    headSprite = headSprStruct.idle[weaponType][0];
					    break;
					case legSprStruct.idle[weaponType][1]:	//dir
					    headSprite = headSprStruct.idle[weaponType][1];
					    break;
					case legSprStruct.idle[weaponType][2]:	//prone
					    headSprite = headSprStruct.idle[weaponType][2];
					    break;
				}
			}
		}



		////////////////////////////////// Actionstate 1 - Walking

		if ((keyboard_check(ord ("A")) || keyboard_check(ord ("D"))) && 
		actionstate < 2 && sprite_index != spr_runAndGun_PlayerStillRifleRFire && headSprite != spr_RunAndGun_PlayerProneRifleFire) {
			actionstate = 1;
		}
		if actionstate = 1 {
			sprite_index = legSprStruct.run;
			//move horizontally
			if (key_right || key_left) && (hspWalk < hspMaxWalk) {
				hspWalk += .5;
			}
			if (key_right && key_left) || (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) || (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D"))) {
				hspWalk = 0;
			}
			hsp = (key_right - key_left) * hspWalk;
	
			if (directionOffset = "right" || directionOffset = "left") {
				headSprite = headSprStruct.run[weaponType][1];
				if (xOffset = 1) {
					bulletDir = 0;
				} else {
					bulletDir = 180;
				}
			}
			if (directionOffset = "downRight" || directionOffset = "downLeft") {
				headSprite = headSprStruct.run[weaponType][0];
				if (xOffset = 1) {
					bulletDir = 315;
				} else {
					bulletDir = 225;
				}
			}
			if (directionOffset = "upRight" || directionOffset = "upLeft") {
				headSprite = headSprStruct.run[weaponType][2];
				if (xOffset = 1) {
					bulletDir = 45;
				} else {
					bulletDir = 135;
				}
			}
		}

		////////////////////////////////// Actionstate 16 - Shelf Ride

		var onShelf = support_contact && support_platform != noone;

		if (onShelf && actionstate != 2 && actionstate != 14 && actionstate != 15 &&
		sprite_index != spr_runAndGun_PlayerStillRifleRFire && headSprite != spr_RunAndGun_PlayerProneRifleFire) {
			actionstate = 16;
		} else if (!onShelf && actionstate == 16) {
			actionstate = 14;
		}

		if (actionstate == 16) {
			var moveInput = key_right - key_left;
			if (moveInput != 0 && hspWalk < hspMaxWalk) {
				hspWalk += .5;
			}
			if ((key_right && key_left) || (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) || (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D")))) {
				hspWalk = 0;
			}
			if (moveInput == 0 && hspWalk != 0) {
				hspWalk -= 2;
				if (hspWalk > -2 && hspWalk < 2) {
					hspWalk = 0;
				}
			}

			var moveStep = moveInput * hspWalk;
			var clearance = clamp(support_world_pos.clearance, 0, 4);

			if (support_contact && support_platform != noone) {
				if (moveStep != 0) {
					support_world_pos.x += support_surface_tangent.x * moveStep;
					support_world_pos.y += support_surface_tangent.y * moveStep;

					var relx = support_world_pos.x - support_surface_origin.x;
					var rely = support_world_pos.y - support_surface_origin.y;
					var along = relx * support_surface_tangent.x + rely * support_surface_tangent.y;
					if (along < -8 || along > support_edge_length + 8) {
						var slideSign = sign(moveStep);
						hspJump = support_surface_tangent.x * max(abs(moveStep), 6) * slideSign;
						vsp = max(vsp, 2);
						actionstate = 14;
						support_detach_id = support_platform;
						support_detach_timer = max(support_detach_timer, 6);
						support_platform = noone;
						support_contact = false;
						support_on_ground = false;
					} else {
						with (support_platform) {
							var rel_x = other.support_world_pos.x - pivot_x;
							var rel_y = other.support_world_pos.y - pivot_y;
							var loc_x = rel_x * basis_cos + rel_y * basis_sin;
							var loc_y = -rel_x * basis_sin + rel_y * basis_cos;
							other.support_local_pos.x = loc_x;
							other.support_local_pos.y = loc_y;
						}
					}
				}
			}

			if (support_contact) {
				x = support_world_pos.x + support_surface_normal.x * clearance;
				y = support_world_pos.y + support_surface_normal.y * clearance;
				support_world_pos.clearance = clearance;
			}

			if (moveInput == 0) {
				if (sprite_index != spr_runAndGun_PlayerStillRifleRFire && headSprite != spr_RunAndGun_PlayerProneRifleFire) {
					sprite_index = legSprStruct.idle[weaponType][0];
					if (xOffset = 1) {
						bulletDir = 0;
					} else {
						bulletDir = 180;
					}
					if (yOffset = 1) {
						sprite_index = legSprStruct.idle[weaponType][1];
						bulletDir = 90;
					} else if (yOffset = -1) {
						sprite_index = legSprStruct.idle[weaponType][2];
					}
					switch (sprite_index) {
						case legSprStruct.idle[weaponType][0]:
							headSprite = headSprStruct.idle[weaponType][0];
							break;
						case legSprStruct.idle[weaponType][1]:
							headSprite = headSprStruct.idle[weaponType][1];
							break;
						case legSprStruct.idle[weaponType][2]:
							headSprite = headSprStruct.idle[weaponType][2];
							break;
					}
				}
			} else {
				sprite_index = legSprStruct.run;

				if (directionOffset = "downRight" || directionOffset = "downLeft") {
					headSprite = headSprStruct.run[weaponType][0];
					if (xOffset = 1) {
						bulletDir = 315;
					} else {
						bulletDir = 225;
					}
				} else if (directionOffset = "upRight" || directionOffset = "upLeft") {
					headSprite = headSprStruct.run[weaponType][2];
					if (xOffset = 1) {
						bulletDir = 45;
					} else {
						bulletDir = 135;
					}
				} else {
					headSprite = headSprStruct.run[weaponType][1];
					if (xOffset = 1) {
						bulletDir = 0;
					} else {
						bulletDir = 180;
					}
				}
			}

			hsp = 0;
			vsp = 0;
		}

		////////////////////////////////// Actionstate 2 - Jumping
		if (sprite_index != spr_runAndGun_PlayerJumpRifleRFire &&		// Rifle animation overrides state
		sprite_index != spr_runAndGun_PlayerStillRifleRFire &&
		headSprite != spr_RunAndGun_PlayerProneRifleFire) {
			
			// Fall through floor
			if (actionstate = 0 && key_fall && key_jump) {
				// Check for collision with screen overlay
				var floorCollision = collision_line(x - 12, y + 1, x + 12, y + 1, obj_runAndGun_ParentOverlay, 1, 1);
				if (!floorCollision) {
				    // Bump player down a few pixels and trigger fall state
					y += 8;
					var detach_id = support_platform;
					support_contact = false;
					support_platform = noone;
					support_on_ground = false;
					support_detach_id = detach_id;
					support_detach_timer = 8;
					support_candidate_id = noone;
					support_candidate_score = 1000000000;
					actionstate = 14;
				}
			}
			
			// Jump input held status
		    if ((keyboard_check_released(vk_space) || (actionstate == 2 || actionstate == 14)) && jumpStatus == 1) {
				jumpStatus = 2;
			}
			if (keyboard_check_pressed(vk_space) && (actionstate <= 1 || actionstate == 16)) {
				jumpStatus = 1;
			}
			
			// Initiate jump state
			if ((!key_fall || (key_left || key_right)) && key_jump && jumpStatus < 2) { 
				var colA = collision_line(x - 10, y + 1, x + 10, y + 1, obj_runAndGun_ParentPlatform, 1, 1);
				var colB = collision_line(x - 12, y + 1, x + 12, y + 1, obj_runAndGun_ParentOverlay, 1, 1);
				if (colA || colB || support_on_ground) {
					if (support_on_ground) {
						var detach_id = support_platform;
						support_contact = false;
						support_platform = noone;
						support_on_ground = false;
						support_detach_id = detach_id;
						support_detach_timer = 8;
						support_candidate_id = noone;
						support_candidate_score = 1000000000;
					}
				    hspJump = hsp;
					hsp = 0;
					actionstate = 2;
				}
			}
		}
		
		// Jump state logic
		if (actionstate == 2) {
			// Rate at which jump comes to and end and char begins to descend
			vsp = -vspJumpMax;
			vspJumpDuration += vspJumpDecay;
			
			// Airborne Horizontal Movement
			if key_right && (abs(hspJump) < hspJumpMax) {
				hspJump += .7;
			}
			if key_left && (abs(hspJump) < hspJumpMax) {
				hspJump -= .7;
			}
			hsp = hspJump;
			
				//stop horizontal movement when no key press left or right
			if (!key_right && !key_left) || (key_right && key_left) {
				if (hspJump != 0) {
					if hspJump < 0 {
						hspJump += .3;
					}
					if hspJump > 0 {
						hspJump -= .3;
					}
					if (hspJump > 0 && hspJump < .3 ) || (hspJump < 0 && hspJump > -.3) {
						hspJump = 0;
					}
				}
			}
			
			// Set bullet dir and sprites
			if (sprite_index != spr_runAndGun_PlayerJumpRifleRFire) {
				if (directionOffset == "right" || directionOffset == "left") {
					headSprite = headSprStruct.jump[weaponType][2];
					if (xOffset = 1) {
						bulletDir = 0;
					} else {
						bulletDir = 180;
					}
				}
				if (directionOffset == "up") {
					headSprite = headSprStruct.jump[weaponType][4];
					bulletDir = 90;
				}
				if (directionOffset == "down") {
					headSprite = headSprStruct.jump[weaponType][0];
					bulletDir = 270;
				}
				if (directionOffset == "downRight" || directionOffset == "downLeft") {
					headSprite = headSprStruct.jump[weaponType][1];
					if (xOffset = 1) {
						bulletDir = 315;
					} else {
						bulletDir = 225;
					}
				}
				if (directionOffset == "upRight" || directionOffset == "upLeft") {
					headSprite = headSprStruct.jump[weaponType][3];
					if (xOffset = 1) {
						bulletDir = 45;
					} else {
						bulletDir = 135;
					}
				}
				sprite_index = spr_RunAndGun_PlayerJump;
				if image_index <= 2 {
					image_speed = .8;
				} else {
					image_speed = 0;
				}
				if (image_index >= 3) {
					image_index = 1;
				}
			}
		}

		////////////////////////////////// Actionstate 14 - Falling
		
		// Check if character should be falling
		if (actionstate <= 2 || vspJumpDuration > vspJumpMax ) {
			// No collision with platforms, or at the peak of a jump
			var overlayCollision = collision_line(x - 12, y, x + 12, y, obj_runAndGun_ParentOverlay, 1, 1);
			var platformCollision = collision_line(x - 10, y, x + 10, y, obj_runAndGun_ParentPlatform, 1, 1);
			var supportCollision = support_on_ground;
		    if ((actionstate == 2 && !key_jump) || (vspJumpDuration > vspJumpMax) || 
			(actionstate < 2  && !overlayCollision && !platformCollision && !supportCollision)) {
				vspJumpDuration = 0;	
				actionstate = 14;
				// Set initial x movement speed when transitioning from run state
				if (hspJump == 0 && hspWalk != 0) {
					hspJump = sign(hsp) * hspWalk;
				}
			}
		}

		// Fall state logic
		if actionstate == 14 {
			//move horizontally
			if (key_right && !key_left && (sign(hspJump) == -1 || (abs(hspJump) < hspJumpMax) )) {
				hspJump += .6;
			}
			if (key_left && !key_right && (sign(hspJump) == 1 || (abs(hspJump) < hspJumpMax))) {
				hspJump -= .6;
			}
			hsp = hspJump;
			
			//move vertically
			if (vsp > 24) {
				vsp = 24;
			}
	
			// Stop horizontal movement when no/both direction key pressed
			if ((!key_right && !key_left) || (key_right && key_left)) {
				if (hspJump != 0) {
					if (hspJump < 0) {
						hspJump += .3;
					}
					if (hspJump > 0) {
						hspJump -= .3;
					}
					if (hspJump > -.3 && hspJump < .3) {
						hspJump = 0;
					}
				}
			}
			if (sprite_index != spr_runAndGun_PlayerJumpRifleRFire) {
				if (directionOffset == "right" || directionOffset == "left") {
					headSprite = headSprStruct.jump[weaponType][2];
					if (xOffset = 1) {
						bulletDir = 0;
					} else {
						bulletDir = 180;
					}
				}
				if (directionOffset == "up") {
					headSprite = headSprStruct.jump[weaponType][4];
					bulletDir = 90;
				}
				if (directionOffset == "down") {
					headSprite = headSprStruct.jump[weaponType][0];
					bulletDir = 270;
				}
				if (directionOffset == "downRight" || directionOffset == "downLeft") {
					headSprite = headSprStruct.jump[weaponType][1];
					if (xOffset = 1) {
						bulletDir = 315;
					} else {
						bulletDir = 225;
					}
				}
				if (directionOffset == "upRight" || directionOffset == "upLeft") {
					headSprite = headSprStruct.jump[weaponType][3];
					if (xOffset = 1) {
						bulletDir = 45;
					} else {
						bulletDir = 135;
					}
				}
				sprite_index = spr_RunAndGun_PlayerJump;
				if (image_index < image_number - .5) {
					image_speed = .8;
				} else {
					image_speed = 0;
				}
			}
		}



		// Check if player bumps head on ceiling
		if ((actionstate == 2 || actionstate == 14) && collision_line(x - 12, y + vsp - 140, x + 12, y + vsp - 140, obj_runAndGun_ParentOverlay, 1, 1)) {
			while (!collision_line(x - 12, y - 140, x + 12, y - 140, obj_runAndGun_ParentOverlay, 1, 1)) {
				y -= 1;
			}
			vspJumpDuration = 0;	
			actionstate = 14;
			vsp = 0;
			vspJump = 0;
		}
	
		// Check left and right collision with overlay
		if ((actionstate == 2 || actionstate == 14) && 
	    (collision_line(x + hsp - 14, y - 20 , x + hsp - 14, y - 120, obj_runAndGun_ParentOverlay, 1, 1) 
	    || collision_line(x + hsp + 14, y - 20 , x + hsp + 14, y - 120, obj_runAndGun_ParentOverlay, 1, 1))) {
		    var onepixel = sign(hsp);
		    while (!collision_line(x + onepixel + (onepixel * 14), y, x + onepixel + (onepixel * 14), y - 140, obj_runAndGun_ParentOverlay, 1, 1)) {
		        x += onepixel;
		    }
		    hsp = 0;
		    hspJump = 0;
		}
		
		////////////////////////////////// Actionstate 15 - Shoot

		switch (weaponType) {
		    case 0:
		        if (mouse_check_button_pressed(mb_left)) {
					instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
						speed:40,
						direction:bulletDir,
						spriteDir:xOffset
					});
					swapFireSprite();
				}
				if (mouse_check_button(mb_left)) {
					bulletTimer += 1;
					if bulletTimer >= 8 {
						instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
							speed:40,
							direction:bulletDir,
							spriteDir:xOffset
						});
						swapFireSprite();
						bulletTimer = 0;
					}
				}
				if mouse_check_button_released(mb_left) {
					bulletTimer = 0;
				}
		        break;
		    case 1:
		        if (rifleTimer[0] < 30) {
				    rifleTimer[0] += 1;
				} else if (mouse_check_button(mb_left)) {
					if (chargeInst == noone) {
					    chargeInst = instance_create_layer(x, y, "Instances", obj_runAndGun_rifleCharge);
					}
					if (rifleCharge < 900) {
					    rifleCharge += 10;		
					}
				} else if (mouse_check_button_released(mb_left)) {
					if (rifleCharge > 0) {
						instance_destroy(chargeInst);
						chargeInst = noone;
						swapFireSprite();
					}
					rifleTimer[0] = 0;
				} 
		        break;
		}
		
		if (sprite_index == spr_runAndGun_PlayerStillRifleRFire) {
			// Handle animation
			image_speed = 0;
			if (stateTimer[0] < 3) {
			    stateTimer[0] += 1;
			} else if (currentIndex < image_number - 1) {
				stateTimer[0] = 0;
				currentIndex += 1;
				if (currentIndex == 1) {
					kbSpeed = kbImpulse;
				    stateTimer[0] = -10;
				} else if (currentIndex == 6) {
					stateTimer[0] = -35;
				}
			} else if (currentIndex == image_number - 1) {
				actionstate = 0;
				sprite_index = legSprStruct.idle[1][0];
				headSprite = headSprStruct.idle[1][0];
				image_speed = 1;
				stateTimer[0] = 0;
				currentIndex = 0;
				kbSpeed = kbImpulse;
			}
			// Handle movement
			if (currentIndex >= 2 && currentIndex < 9) {
				var kbTime = kbSpeed / kbImpulse;
				var dropoff = (1 - (1 / (1 + exp(-12 * (kbTime - 0.55))))) * kbImpulse;
				if (kbSpeed < 2) {
				    kbSpeed = 0;
				} else {
					kbSpeed -= dropoff;
				};
				hsp = -xOffset * kbSpeed;
				if (dustEmitter == noone || !instance_exists(dustEmitter)) {
				    dustEmitter = instance_create_layer(x, y - 1, "Instances", obj_runAndGun_smokeEmitter, {
						active: true
					});
				};
				if (kbSpeed == 0) {
				    if (instance_exists(dustEmitter)) {
						dustEmitter.active = false;   
						dustEmitter = noone;           
					}
				}
			}
			// Spawn bullet
		    if (currentIndex == 2 && !instance_exists(rifleBulletID)) {
			    rifleBulletID = instance_create_layer(x,y - 102,"Instances",obj_RunAndGun_playerBullet2, {
					speed:45,
					direction:bulletDir,
					spriteDir:xOffset,
					rifleCharge: rifleCharge
				});
				rifleCharge = 0;
			};
			image_index = currentIndex;
		} else if (headSprite == spr_RunAndGun_PlayerProneRifleFire) {
			image_speed = 0;
			if (stateTimer[0] < 5) {
				stateTimer[0] += 1;
			} else if (currentIndex < image_number - 1) {
				// Spawn bullet
				if (currentIndex == 0 && !instance_exists(rifleBulletID)) {
				    rifleBulletID = instance_create_layer(x,y - 102,"Instances",obj_RunAndGun_playerBullet2, {
						speed:45,
						direction:bulletDir,
						spriteDir:xOffset,
						rifleCharge: rifleCharge
					});
					rifleCharge = 0;
				};
				currentIndex += 1;
				stateTimer[0] = 0;
				image_index = currentIndex;
			} else if (currentIndex == image_number - 1) {
				actionstate = 0;
				sprite_index = legSprStruct.idle[1][2];
				headSprite = headSprStruct.idle[1][2];
				image_speed = 1;
				stateTimer[0] = 0;
				currentIndex = 0;
			}
						
		} else if (sprite_index == spr_runAndGun_PlayerJumpRifleRFire) {
			// Handle animation
			image_speed = 0;
			if (stateTimer[0] < 3) {
			    stateTimer[0] += 1;
			} else if (currentIndex < image_number - 1) {
				stateTimer[0] = 0;
				currentIndex += 1;
				if (currentIndex == 1) {
				    kbSpeed = kbImpulse * 2;
				}
			} else if (currentIndex == image_number - 1) {
				sprite_index = legSprStruct.jump;
				headSprite = headSprStruct.jump[1][2];
				hspWalk = hsp;
				hspJump = hsp;
			}
			// Handle movement
			if (currentIndex >= 1) {
				var kbTime = kbSpeed / (kbImpulse * 2);
				var dropoff = (1 - (1 / (1 + exp(-14 * (kbTime - 0.6))))) * kbImpulse;
				if (kbSpeed < 4) {
				    kbSpeed = 4;
				} else {
					kbSpeed -= dropoff;
				}
				hsp = -xOffset * kbSpeed;
				
			}
			// Spawn bullet
		    if (currentIndex == 1 && !instance_exists(rifleBulletID)) {
			    rifleBulletID = instance_create_layer(x,y - 102,"Instances",obj_RunAndGun_playerBullet2, {
					speed:45,
					direction:bulletDir,
					spriteDir:xOffset,
					rifleCharge: rifleCharge
				});
				rifleCharge = 0;
			}
			image_index = currentIndex;
		} 
		
		if (sprite_index != spr_runAndGun_PlayerJumpRifleRFire &&
		headSprite != spr_RunAndGun_PlayerProneRifleFire &&
		sprite_index != spr_runAndGun_PlayerStillRifleRFire) {
		    
			if (currentIndex != 0) {
			    currentIndex = 0;
				stateTimer[0] = 0;
				kbSpeed = 0;
			}

			if (instance_exists(dustEmitter)) {
				dustEmitter.active = false;   
				dustEmitter = noone;           
			}
		}
		
		////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

		//////////////////////////// Actionstate 1 - Walking

		if (actionstate == 1 || sprite_index = spr_runAndGun_PlayerJumpRifleRFire || 
		sprite_index = spr_runAndGun_PlayerStillRifleRFire) {
		    
			if (actionstate == 1) {
				if (hspWalk > hspMaxWalk) {
			        hspWalk = hspMaxWalk;
			    }
			    if (hsp > hspMaxWalk) {
			        hsp = hspMaxWalk;
			    }
			    if (hsp < -hspMaxWalk) {
			        hsp = -hspMaxWalk;
			    }
			}

			if (hsp != 0) {
			    var onepixel = sign(hsp);
			    // If the player is about to collide in the horizontal direction
			    if (collision_line(x + hsp - 14, y - 1, x + hsp + 14, y - 128, obj_runAndGun_ParentOverlay, 1, 1)) {
			        // Move as close as possible without colliding
			        while (!collision_line(x + onepixel - 34, y - 1, x + onepixel + 34, y - 128, obj_runAndGun_ParentOverlay, 1, 1)) {
			            x += onepixel;
			        }
			        hsp = 0;
			    }
			}
		}

		/////////////////////////// Actionstate 14 - Falling
		
		if (!key_jump && actionstate != 2 && actionstate != 14) {
		    jumpStatus = 0;
		}

		// Apply gravity
		vsp = vsp + grv;

		// Handle airborne vertical collisions
		if (vsp > 0) {
		    var onepixel = sign(vsp); // up = -1, down = 1

		    // Check if falling onto a platform
		    if ((collision_line(x-10, y + vsp, x+10, y + vsp, obj_runAndGun_ParentPlatform, 1, 1) 
		        && !collision_line(x-10, y-1, x+10, y-1, obj_runAndGun_ParentPlatform, 1, 1) 
		        && actionstate != 2)) {
        
		        // Move player down until exactly on the platform
		        while (!collision_line(x-10, y + onepixel, x+10, y + onepixel, obj_runAndGun_ParentPlatform, 1, 1)) {
		            y = y + onepixel;
				}
		        vsp = 0;
			}
		}
		// Check if colliding with a wall or floor object
		if (vsp != 0) {
			var onepixel = sign(vsp);
			if (collision_line(x - 12, y + vsp, x + 12, y + vsp, obj_runAndGun_ParentOverlay, 1, 1)) {
				while (!collision_line(x - 12, y + onepixel, x + 12, y + onepixel, obj_runAndGun_ParentOverlay, 1, 1)) {
					y += onepixel;
				}
				vsp = 0;
			}
		}
		// Handle airborne horizontal collisions
		if (actionstate == 2 || actionstate == 14) {
		    if (hsp != 0) {
			    var onepixel = sign(hsp);
			    // If the player is about to collide in the horizontal direction
				var collisionE = collision_line(x + hsp - 14, y - 1, x + hsp + 14, y - 1, obj_runAndGun_ParentOverlay, 1, 1);
				var collisionF = collision_line(x + onepixel - 34, y - 1, x + onepixel + 34, y - 1, obj_runAndGun_ParentOverlay, 1, 1);
			    if (collisionE) {
			        // Move as close as possible without colliding
			        while (!collisionF) {
			            x += onepixel;
			        }
			        hsp = 0;
			    }
			}
		}

		// Apply vertical movement
		y = y + vsp;
		// Apply horizontal movement
		x += hsp;	
		
		// End falling state when player reaches a platform or overlay
		var platformUnderfoot = collision_line(x-10, y, x+10, y, obj_runAndGun_ParentPlatform, 1, 1);		// Platform below char's feet
		var platformCollide = collision_line(x-10, y - 1, x+10, y - 1, obj_runAndGun_ParentPlatform, 1, 1);		// 1 pixel above player's feet
		var overlayUnderfoot = collision_line(x - 12, y, x + 12, y, obj_runAndGun_ParentOverlay, 1, 1);			// Overlay below char's feet
		var overlayCollide = collision_line(x - 12, y - 1, x + 12, y - 1, obj_runAndGun_ParentOverlay, 1, 1);	// 1 pixel above player's feet
		
		if (actionstate == 14 && (support_on_ground || (platformUnderfoot && !platformCollide) || (overlayUnderfoot && !overlayCollide))) { 
			actionstate = 0;
			hspWalk = abs(hspJump);
			hspJump = 0;
			vspJump= 0;
		}
		
		
		
	} // if gamepad is not connected




















	//if gamepad_is_connected(global.pad) {
	//		//initalize

	//	image_speed = 1;

	//	haxis = gamepad_axis_value(global.pad, gp_axislh);
	//	vaxis = gamepad_axis_value(global.pad, gp_axislv);



	//	if (haxis <= .2 && haxis >= -.2 && vaxis <= .2 && vaxis >= -.2)  {
	//		if (sprite_index = spr_RunAndGun_PlayerStillIdle)  {
	//			if (xOffset = 1) {
	//				directionOffset = "right";
	//			} else if (xOffset = -1) {
	//				directionOffset = "left";
	//			}
		
	//		}
	//	}

	//	if (haxis >= .85 && vaxis <= .4 && vaxis >= -.4) {
	//		directionOffset = "right";
	//		xOffset = 1;
	//	} else if (haxis > .4 && haxis < .85 && vaxis < -.3 && vaxis > -.75) {
	//		directionOffset = "upRight";
	//		xOffset = 1;
	//	} else if (vaxis <= -.75 && haxis <= .4 && haxis >= -.4) {
	//		directionOffset = "up";
	//		yOffset = 1;
	//	} else if (haxis < -.4 && haxis > -.85 && vaxis < -.3 && vaxis > -.75) {
	//		directionOffset = "upLeft";
	//		xOffset = -1;
	//	} else if (haxis <= -.85 && vaxis <= .4 && vaxis >= -.4) {
	//		directionOffset = "left";
	//		xOffset = -1;
	//	} else if (haxis < -.4 && haxis > -.85 && vaxis > .3 && vaxis < .75) {
	//		directionOffset = "downLeft";
	//		xOffset = -1;
	//	} else if (vaxis >= .75 && haxis <= .4 && haxis >= -.4) {
	//		directionOffset = "down";
	//		yOffset = -1;
	//	} else if (haxis > .4 && haxis < .85 && vaxis > .3 && vaxis < .75) {
	//		directionOffset = "downRight";
	//		xOffset = 1;
	//	}
	//	if (vaxis < .85 && vaxis > -.85) {
	//		yOffset = 0;
	//	}

	//	////////////////////////////////// Actionstate 0 - Still

	//	if (haxis > -.2 && haxis < .2) && actionstate != 2 && actionstate != 14 {
	//		speed = 0;
	//		actionstate = 0;
	//		}

	//	if (actionstate = 0) {
	//		sprite_index = spr_RunAndGun_PlayerStillIdle;
	//		if (xOffset = 1) {
	//			bulletDir = 0;
	//		} else {
	//			bulletDir = 180;
	//		}
	//		if (yOffset = 1) {
	//			sprite_index = spr_RunAndGun_PlayerStillDir; //up sprite
	//			bulletDir = 90;
	//		} else if (yOffset = -1) {
	//			sprite_index = spr_RunAndGun_PlayerStillProne; //prone sprite
	//			speed = 0;
	//		}
	//	}



	//	////////////////////////////////// Actionstate 1 - Walking

	//	if ((haxis < -.2 || haxis > .2) && actionstate < 2) {
	//		actionstate = 1;
	//	}

	//	if actionstate = 1 {
	
	//		//move horizontally
	//		direction = point_direction(0, 0, haxis, 0);
	//		speed = point_distance(0 ,0, haxis, 0) * 7;
	

	
	//		if (directionOffset = "right" || directionOffset = "left") {
	//			sprite_index = legSprStruct.run;
	//			if (xOffset = 1) {
	//				bulletDir = 0;
	//			} else {
	//				bulletDir = 180;
	//			}
	//		}
	//		if (directionOffset = "up") {
	//			sprite_index = legSprStruct.runUp;
	//			bulletDir = 90;
	//		}
	//		if (directionOffset = "downRight" || directionOffset = "downLeft") {
	//			sprite_index = legSprStruct.runDownRight;
	//			if (xOffset = 1) {
	//				bulletDir = 315;
	//			} else {
	//				bulletDir = 225;
	//			}
	//		}
	//		if (directionOffset = "upRight" || directionOffset = "upLeft") {
	//			sprite_index = legSprStruct.runUpRight;
	//			if (xOffset = 1) {
	//				bulletDir = 45;
	//			} else {
	//				bulletDir = 135;
	//			}
	//		}
	
	//	}



	//	////////////////////////////////// Actionstate 2 - Jumping

	
	//	if (gamepad_button_check_released(global.pad,gp_face1) || (actionstate == 2 || actionstate == 14)) && jumpStatus == 1 {
	//		jumpStatus = 2;
	//	}
		
	
	//	if gamepad_button_check_pressed(global.pad,gp_face1) && actionstate != 2 && actionstate != 14 && actionstate != 3 {
	//		jumpStatus = 1;
	//	}
	
	//	//collision check
	//	if ((collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && (directionOffset != "down") && gamepad_button_check(global.pad,gp_face1) && jumpStatus < 2)) { 
	
	//	actionstate = 2;
	//	}
	
	
	
	//	if (actionstate = 2) {	
	//		vspJumpDuration -= 2;
	
	//		//move vertically	
	//		if (gamepad_button_check(global.pad,gp_face1)) && (vspJump > vspJumpMax) {
	//			vspJump = vspJumpMax;
	//		}
		
	//		vsp = vspJump;
	
	//		if vspJump < vspJumpMax {
	//			vspJump = vspJumpMax;
	//		}
			
	//		//move horizontally
	//		if key_right && (abs(hspJump) < hspJumpMax) {
	//			direction = 0;
	//		}
	//		if key_left && (abs(hspJump) < hspJumpMax) {
	//			direction = 180;
	//		}
	//		speed = point_distance(0 ,0, haxis, 0) * 10;
	
	
	//		if (directionOffset = "right" || directionOffset = "left") {
	//			sprite_index = spr_RunAndGun_PlayerJump;
	//			if (xOffset = 1) {
	//				bulletDir = 0;
	//			} else {
	//				bulletDir = 180;
	//			}
	//		}
	//		if (directionOffset = "up") {
	//			sprite_index = spr_RunAndGun_PlayerJumpUp_UpperAK;
	//			bulletDir = 90;
	//		}
	//		if (directionOffset = "down") {
	//			sprite_index = spr_RunAndGun_PlayerJumpDown_UpperAK;
	//			bulletDir = 270;
	//		}
	//		if (directionOffset = "downRight" || directionOffset = "downLeft") {
	//			sprite_index = spr_RunAndGun_PlayerJumpDownRight_UpperAK;
	//			if (xOffset = 1) {
	//				bulletDir = 315;
	//			} else {
	//				bulletDir = 225;
	//			}
	//		}
	//		if (directionOffset = "upRight" || directionOffset = "upLeft") {
	//			sprite_index = spr_RunAndGun_PlayerJumpUpRight_UpperAK;
	//			if (xOffset = 1) {
	//				bulletDir = 45;
	//			} else {
	//				bulletDir = 135;
	//			}
	//		}
	
	//		if image_index <= 2 {
	//			image_speed = .8;
	//		} else {
	//			image_speed = 0;
	//		}
	//		if (image_index >= 3) {
	//			image_index = 1;
	//		}
	//	}

	//	////////////////////////////////// Actionstate 3 - Shoot


	//	if gamepad_button_check_pressed(global.pad,gp_face3) {
	
	//		instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
	//			speed:20,
	//			direction:bulletDir,
	//			spriteDir:xOffset
	//		});
	//	}

	//	if gamepad_button_check(global.pad,gp_face3) {
	//		bulletTimer += 1;
	//		if bulletTimer >= 15 {

	//			instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
	//				speed:20,
	//				direction:bulletDir,
	//				spriteDir:xOffset
	//			});
	//			bulletTimer = 0;
	//		}
	//	}

	//	if gamepad_button_check_released(global.pad,gp_face3) {
	//		bulletTimer = 0;
	//	}


	//	////////////////////////////////// Actionstate 14 - Falling

	//	if (actionstate = 0 && vaxis >= .75 && gamepad_button_check(global.pad,gp_face1)) {
	//		y += 1;
	//	}

	//	if ((actionstate = 2 && !gamepad_button_check(global.pad,gp_face1)) || (vspJumpDuration < vspJumpMax) || (actionstate < 2 && !collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1))) {
	//		vspJumpDuration = 0;	
	//		actionstate = 14;
	//	}
	

	//	if actionstate == 14 {
	//		sprite_index = spr_RunAndGun_PlayerJump;
	//		if haxis > 0 && (abs(hspJump) < hspJumpMax) {
	//			direction = 0;
	//		}
	//		if haxis < 0 && (abs(hspJump) < hspJumpMax) {
	//			direction = 180;
	//		}
	//		speed = point_distance(0 ,0, haxis, 0) * 10;
		
	//		if vsp > 24
	//			{vsp = 24;}
	
	
	//		if (directionOffset = "right" || directionOffset = "left") {
	//			sprite_index = spr_RunAndGun_PlayerJump;
	//			if (xOffset = 1) {
	//				bulletDir = 0;
	//			} else {
	//				bulletDir = 180;
	//			}
	//		}
	//		if (directionOffset = "up") {
				
	//			bulletDir = 90;
	//		}
	//		if (directionOffset = "down") {
	//			sprite_index = spr_RunAndGun_PlayerJumpDown_UpperAK;
	//			bulletDir = 270;
	//		}
	//		if (directionOffset = "downRight" || directionOffset = "downLeft") {
	//			sprite_index = spr_RunAndGun_PlayerJumpDownRight_UpperAK;
	//			if (xOffset = 1) {
	//				bulletDir = 315;
	//			} else {
	//				bulletDir = 225;
	//			}
	//		}
	//		if (directionOffset = "upRight" || directionOffset = "upLeft") {
	//			sprite_index = spr_RunAndGun_PlayerJumpUpRight_UpperAK;
	//			if (xOffset = 1) {
	//				bulletDir = 45;
	//			} else {
	//				bulletDir = 135;
	//			}
	//		}
	
	//		if (image_index < image_number - .5) {
	//			image_speed = .8;
	//		} else {
	//			image_speed = 0;
	//		}
	
	//	}



	//	////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	//	if (!gamepad_button_check(global.pad,gp_face1) && actionstate != 2 && actionstate != 14) {
	//		jumpStatus = 0;
	//	}

	//	vsp = vsp + grv;
	//	if (vsp > 0) {
	//		var onepixel = sign(vsp) //up = -1, down = 1.
	//		if (collision_line(x-10, y + vsp, x+10, y + vsp, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y-1, x+10, y-1, obj_RunAndGun_ParentPlatform, 1, 1) && (actionstate != 2)) {
	//			while (!collision_line(x-10, y + onepixel, x+10, y + onepixel, obj_RunAndGun_ParentPlatform, 1, 1)) {
	//				y = y + onepixel;
	//			}
	//			vsp = 0;
	//		}
	//	}

	//	if x - 20 < camera_get_view_x(view_camera[0]) {
	//		x = camera_get_view_x(view_camera[0]) + 20;
	//	}


	//	y = y + vsp;
	//	/////////////////////////// Actionstate 1 - Walking
	//	if (sprite_index = legSprStruct.run) {
	//		speed = 0;
	//	}
	
	//	/////////////////////////// Actionstate 14 - Falling
		
	//	if (collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y, x+10, y, obj_RunAndGun_ParentPlatform, 1, 1) && actionstate == 14) { 
	//		actionstate = 0;
	//		hspJump = 0;
	//		vspJump= 0;
	//		if (playerHealth <= 0) {
	//		    actionstate = 13;
	//		}
	//	}	
	//}

	///////////////////////////// 
	///////////////////////////// Actionstate 13 - Death
	///////////////////////////// 

	//if (playerHealth <= 0 && actionstate != 14) {
	//    actionstate = 13;
	//}

	//if (actionstate == 13) {
	//	sprite_index = 0;
	//}





	// Clamp to frame, under-the-hood stuff
	if (y > camera_get_view_height(view_camera[0])) {
		y = 200;
	}

	x = round(x / 4) * 4;
	y = round(y / 4) * 4;

	
	// Upper half of body / gun sprites
	switch (actionstate) {
	    case 0:	// Idle
	        
	        break;
	    case 1:	// Run
			
			break;
		case 2:	// Jump
		case 14: // Fall
	        
	}

} else if (obj_runAndGun_camera.cutscene == true) {
	sprite_index = spr_RunAndGun_PlayerStillIdle;
}

// Handle weapon changing

if (keyboard_check_pressed(vk_tab)) {
	var weaponLength = array_length(weaponsHeld);
	var nextWeapon = weaponType + 1;
	if (weaponType < weaponLength - 1 && weaponsHeld[nextWeapon] == 1) {
	    weaponType = nextWeapon;
	} else if (weaponType < weaponLength - 2 && weaponsHeld[nextWeapon + 1] == 1) {
		weaponType = nextWeapon + 1;
	} else {
		weaponType = 0;
	}
	
}

if (weaponType != 1 && rifleCharge != 0) {
    rifleCharge = 0;
}


// Clamp player within view during gameplay
if (obj_runAndGun_camera.cutscene == false) {
	var viewID   = view_camera[0];
    var leftEdge = camera_get_view_x(viewID);
    var rightEdge = leftEdge + camera_get_view_width(viewID);

    if (instance_exists(obj_runAndGun_camera)) {
        var cam = obj_runAndGun_camera;
        var vWidth = cam.camWidth;
        var pad = max(0, (vWidth - vWidth / cam.zoom) * 0.5);
        leftEdge  -= pad;
        rightEdge += pad;
    }

    if (x < leftEdge)  x = leftEdge;
    if (x > rightEdge) x = rightEdge;
}

