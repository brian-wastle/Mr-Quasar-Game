mask_index = spr_RunAndGun_PlayerHitbox;
actionstate = 0;
directionOffset = 0;
xOffset = 1;
yOffset = 0;
depth = -400;
weaponType = 0;			// 0 - SMG rifle, 1 - Sniper Rifle
rifleCharge = 0;		// 0-900 range
rifleBulletID = noone;

grv = 1.1; //gravity
hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed
hspWalk = 0; //walk speed
hspJump = 0; //jump horizontal speed
vspJump = 0; //jump vertical speed
hspMaxWalk = 9; //walk speed
hspJumpMax = 9; //jump horizontal max speed
vspJumpMax = 24; //jump vertical max speed
vspJumpDuration = 0; //counter to keep track of char's height during jump
vspJumpDecay = 6;
jumpStatus = 0; //prevents character from jumping immediately on landing

bulletTimer = 0; //allows bullets to continuously fire
bulletDir = 0;
weaponsHeld = [1,0,0];

// mover collisions
moverState = 0;		// Track whether player is in contact with a mover.

// rotating platform support scaffolding
support_platform = noone;
support_contact = false;
support_tick = -1;
support_local_pos = { x: 0, y: 0 };
support_world_pos = { x: x, y: y, clearance: 0 };
support_motion = { dx: 0, dy: 0, da: 0 };
support_surface_normal = { x: 0, y: -1 };
support_surface_tangent = { x: 1, y: 0 };
support_surface_param = 0;
support_candidate_id = noone;
support_candidate_score = 1000000000;
support_candidate_projx = x;
support_candidate_projy = y;
support_candidate_dist = 0;
support_candidate_t = 0;
support_candidate_normal = { x: 0, y: -1 };
support_candidate_tangent = { x: 1, y: 0 };
support_edge_length = 0;
support_surface_origin = { x: x, y: y };
support_on_ground = false;
support_detach_timer = 0;
support_detach_id = noone;


playerHealth = 100;
bulletType = 0;
rifleTimer[0] = 0;
stateTimer[0] = 0;
currentIndex = 0;
knockbackTime = 0;
kbImpulse = 12;
kbSpeed = kbImpulse;
headSprImgIndex = 0;
dustEmitter = noone;
chargeInst = noone;

key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_fall = keyboard_check(ord("S"));
key_jump = keyboard_check(vk_space);
key_slide = keyboard_check_pressed(vk_shift);
key_hook = mouse_check_button_pressed(mb_right);



//gamepad
haxis = 0;
vaxis = 0;

headSprite = 0;

legSprStruct = {
	idle:[
		[
			spr_RunAndGun_PlayerStillIdle,
			spr_RunAndGun_PlayerStillDir, 
			spr_RunAndGun_PlayerStillProne
		],
		[
			spr_RunAndGun_PlayerStillIdle,
			spr_RunAndGun_PlayerStillIdle,
			spr_RunAndGun_PlayerStillProne
		]
	],
	jump: spr_RunAndGun_PlayerJump,
	run: spr_RunAndGun_PlayerRun
};

headSprStruct = {
	idle:[
		[
			spr_RunAndGun_PlayerStillAK,
			spr_RunAndGun_PlayerStillUpAK, 
			spr_RunAndGun_PlayerProneAK
		],
		[
			spr_runAndGun_PlayerStillRifleR,
			spr_runAndGun_PlayerStillRifleR, 
			spr_RunAndGun_PlayerProneRifle
		],
	],
	jump: [
		[
			spr_RunAndGun_PlayerJumpD_UpperAK,
			spr_RunAndGun_PlayerJumpDR_UpperAK,
			spr_RunAndGun_PlayerJumpR_UpperAK,
			spr_RunAndGun_PlayerJumpUR_UpperAK,
			spr_RunAndGun_PlayerJumpU_UpperAK
		],
		[
			spr_runAndGun_PlayerJumpRifleR,
			spr_runAndGun_PlayerJumpRifleR,
			spr_runAndGun_PlayerJumpRifleR,
			spr_runAndGun_PlayerJumpRifleR,
			spr_runAndGun_PlayerJumpRifleR,
		]
	],
	run: [
		[
			spr_RunAndGun_PlayerRunDR_UpperAK,
			spr_RunAndGun_PlayerRunR_UpperAK,
			spr_RunAndGun_PlayerRunUR_UpperAK
		],
		[
			spr_RunAndGun_PlayerRun_UpperRifle,
			spr_RunAndGun_PlayerRun_UpperRifle,
			spr_RunAndGun_PlayerRun_UpperRifle
		]
	]
};

fireSprStruct = {
	idle:[
		[
			spr_RunAndGun_PlayerStillAKfire,
			spr_RunAndGun_PlayerStillUpAKfire, 
			spr_RunAndGun_PlayerProneAKfire
		],
		[
			spr_runAndGun_PlayerStillRifleRFire,
			spr_RunAndGun_PlayerProneRifleFire
		]
	],
	jump: [
		[
			spr_RunAndGun_PlayerJumpD_UpperAKfire,
			spr_RunAndGun_PlayerJumpDR_UpperAKfire,
			spr_RunAndGun_PlayerJumpR_UpperAKfire,
			spr_RunAndGun_PlayerJumpUR_UpperAKfire,
			spr_RunAndGun_PlayerJumpU_UpperAKfire
		],
		spr_runAndGun_PlayerJumpRifleRFire
	],
	run: [
		[
			spr_RunAndGun_PlayerRunDR_UpperAKfire,
			spr_RunAndGun_PlayerRunR_UpperAKfire,
			spr_RunAndGun_PlayerRunUR_UpperAKfire
		],
		spr_runAndGun_PlayerStillRifleRFire
	]
};

function swapFireSprite() {
	var thisIndex = image_index;
	    switch (actionstate) {
			case 0:	// idle
				switch (weaponType) {
				    case 0:
				        headSprite = fireSprStruct.idle[0][0];
						if (yOffset == 1) {
							headSprite = fireSprStruct.idle[0][1];
							thisIndex = irandom_range(0,3);
						} else if (yOffset == -1) {
							headSprite = fireSprStruct.idle[0][2];
							thisIndex = irandom_range(0,3);
						}
				        break;
				    case 1:
						sprite_index = fireSprStruct.idle[1][0];
						if (yOffset == -1) {
							sprite_index = legSprStruct.idle[1][2];
							headSprite = fireSprStruct.idle[1][1];
						} else {
							headSprite = noone;
						}
						thisIndex = 0;
				        break;
				}
				break;
			case 1:	// walk	
				switch (weaponType) {
				    case 0:
				        if (directionOffset = "right" || directionOffset = "left") {
							headSprite = fireSprStruct.run[0][1];
						}
						if (directionOffset = "downRight" || directionOffset = "downLeft") {
							headSprite = fireSprStruct.run[0][0];
						}
						if (directionOffset = "upRight" || directionOffset = "upLeft") {
							headSprite = fireSprStruct.run[0][2];
						}
				        break;
				    case 1:
				        sprite_index = fireSprStruct.idle[1][0];
						headSprite = noone;
						actionstate = 0;
						hsp_walk = 0;
						hsp = 0;
						thisIndex = 0;
				        break;
				}
				break;
			case 2: // jump
			case 14: //fall
				switch (weaponType) {
				    case 0:
				        if (directionOffset = "right" || directionOffset = "left") {
							headSprite = fireSprStruct.jump[0][2];
						}
						if (directionOffset = "up") {
							headSprite = fireSprStruct.jump[0][4];
						}
						if (directionOffset = "down") {
							headSprite = fireSprStruct.jump[0][0];
						}
						if (directionOffset = "downRight" || directionOffset = "downLeft") {
							headSprite = fireSprStruct.jump[0][1];
						}
						if (directionOffset = "upRight" || directionOffset = "upLeft") {
							headSprite = fireSprStruct.jump[0][3];
						}
				        break;
				    case 1:
				        sprite_index = fireSprStruct.jump[1];
						headSprite = noone;
				        break;
				}
				break;
		}
	image_index = thisIndex;
}

// Mover collision functions


