
actionstate = 0;
directionOffset = 1; // sprite is facing left or right
spriteSpeed = 0; // negative when sprite is walking backwards
depth = -300;
playerChar = 0; // 0 - girl, 1 - boy, 2 - robot
playerHealth = 1050;

grv = 1.1;				// gravity
hsp = 0;				// current horizontal speed
vsp = 0;				// current vertical speed
zsp = 0;				// current jump speed
hspWalk = 0;			// walk speed
vspWalk = 0;
hspJump = 0;			// jump horizontal speed
vspJump = 0;			// jump vertical speed
zspJump = 0;			// jump height speed
hspMaxWalk = 4;			// walk speed
vspMaxWalk = 2;
hspMaxJump = 8;			// jump horizontal max speed
vspMaxJump = 3;			// jump vertical max speed
zspMaxJump = 19;
jumpStatus = 0;			// prevents character from jumping immediately on landing
jumpBoost = 0;			// Upward velocity during jump
landingTimer = 0;		// keeps player in landing position for a moment after falling 
fastFall = 0;			// Track speed of fast fall
shadowSize = 0;
airAttackState = 0;		// whether jumping player is attacking, resets to 0 on landing.
attackStack = 0;		// track progress towards knockdown state
jumpQueue = 0;			// Triggered when player jumps out of an attack without a cancel
freezeTimer = 0;		// Allows for animation delays on enemy contact
heightArray = [280, 284, 279];
playerHeight = heightArray[playerChar];
knockbackTimer = 0;
iFrameTimer = 0;
damageTimer = 0;
knockbackDir = 0;
knockbackState = 0;
zVel = 0;              // Vertical velocity for bounces
xVel = 0;              // Horizontal velocity for bounces
bounceFactor = 0.5;    // How much of the bounce remains after each impact (50% = half as high next bounce)
edgeSlamOldVel = 0;    // Store old velocity if we collide with the screen edge
shakeTimer = 0;        // If you want the “shake” effect
zGravity = 0.7;        // Gravity used each step while in-air

backAttackState = 0;   // Trigger back attack state
returnIndex = 0;	   // Keep track of current image_index when entering back attack state
backTimer = 0;

grabTimer = 0;		   // Image speed control
grabBack = 0;		   // Whether player has begun backward grab throw
grabForwardState = 0;  // How many times forward grab kick has occurred
grabAnim = 0;		   // Repeat forward grab kick animation

// Jump physics constants (adjust as needed)
jumpHeight = 48;       // Max height (z-axis) for jumps
jumpBoost = 0.5;       // Boost applied when jump button is held
jumpSpeed = sqrt(2 * grv * jumpHeight); // Calculated max upward velocity


// Attacks

attackQueue = 0;		// keeps track of how many attacks to use in a combo
airAttackState = 0;		// whether the player is doing an air attack or not
comboTimer = 0;

key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_jump = keyboard_check(vk_space);
key_block = keyboard_check_pressed(vk_shift);
key_attack = mouse_check_button_pressed(mb_left);
key_super = mouse_check_button_pressed(mb_right);
deadzone = 0;

// Player sprite arrays

charArray[0,0] = spr_BeatEmUp_PlayerGirlIdle;
charArray[0,1] = spr_BeatEmUp_PlayerBoyIdle;
charArray[0,2] = spr_BeatEmUp_PlayerRobotIdle;
charArray[1,0] = spr_BeatEmUp_PlayerGirlWalk;
charArray[1,1] = spr_BeatEmUp_PlayerBoyWalk;
charArray[1,2] = spr_BeatEmUp_PlayerRobotWalk;
charArray[2,0] = spr_BeatEmUp_PlayerGirlCombo;
charArray[2,1] = spr_BeatEmUp_PlayerBoyCombo;
charArray[2,2] = spr_BeatEmUp_PlayerRobotCombo;
charArray[3,0] = spr_BeatEmUp_PlayerGirlAirAttack;
charArray[3,1] = spr_BeatEmUp_PlayerBoyAirAttack;
charArray[3,2] = spr_BeatEmUp_PlayerRobotAirAttack;
charArray[4,0] = spr_BeatEmUp_PlayerGirlDamage;
charArray[4,1] = -1;
charArray[4,2] = -1;
charArray[5,0] = spr_BeatEmUp_PlayerGirlBackAttack;
charArray[5,1] = -1;
charArray[5,2] = -1;
charArray[6,0] = spr_BeatEmUp_PlayerGirlGrabFront;
charArray[6,1] = -1;
charArray[6,2] = -1;
charArray[7,0] = spr_BeatEmUp_PlayerGirlGrabRear;
charArray[7,1] = -1;
charArray[7,2] = -1;
charArray[8,0] = spr_BeatEmUp_PlayerGirlSpike;
charArray[8,1] = -1;
charArray[8,2] = -1;

// Gamepad

analogX = 0;
analogY = 0;

// Initialize attack hitboxes

instance_create_layer(x,y,"Instances", obj_beatEmUp_Player_hb, {
	parentId: id,
	playerChar: playerChar
});


// Push other instances
function apply_push(obj, push_strength) {
    // List of overlapping instances
    var collision_list = ds_list_create();
    var collisions = instance_place_list(x, y, obj, collision_list, false);

    if (collisions > 0) {
        // Calculate the average push vector
        var total_push_x = 0;
        var total_push_y = 0;

        for (var i = 0; i < ds_list_size(collision_list); i++) {
            var otherInst = collision_list[| i];
            if (otherInst.id != id) { // Ignore self
                var dx = x - otherInst.x;
                var dy = y - otherInst.y;
                var dist = point_distance(0, 0, dx, dy);

                // Avoid division by zero
                if (dist > 0) {
                    total_push_x += (dx / dist);
                    total_push_y += (dy / dist);
                }
            }
        }

        // Normalize the total push vector
        var push_length = point_distance(0, 0, total_push_x, total_push_y);
        if (push_length > 0) {
            total_push_x /= push_length;
            total_push_y /= push_length;
        }

        // Apply the push force
        x += total_push_x * push_strength;
        y += total_push_y * push_strength;
    }

    ds_list_destroy(collision_list); // Clean up
}



