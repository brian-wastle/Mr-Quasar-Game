
actionstate = 0;
directionOffset = 1; // 1 or -1, sprite is facing left or right
spriteSpeed = 0; // negative when sprite is walking backwards
depth = -300;
playerChar = 0; //0 - girl, 1 - boy, 2 - robot


grv = 1.4; //gravity
hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed
zsp = 0; //current jump speed
hspWalk = 0; //walk speed
vspWalk = 0;
hspJump = 0; //jump horizontal speed
vspJump = 0; //jump vertical speed
zspJump = 0; // jump height speed
hspMaxWalk = 7; //walk speed
vspMaxWalk = 3;
hspMaxJump = 8; //jump horizontal max speed
vspMaxJump = 3; //jump vertical max speed
zspMaxJump = 25;
zspMaxDoubleJump = 21;
jumpStatus = 0; //prevents character from jumping immediately on landing
landingTimer = 0; // keeps player in landing position for a moment after falling 
shadowSize = 0;



key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_jump = keyboard_check(vk_space);
key_block = keyboard_check_pressed(vk_shift);
key_attack = mouse_check_button_pressed(mb_left);
key_super = mouse_check_button_pressed(mb_right);


haxis = 0;
vaxis = 0;

//player sprite arrays

charArray[0,0] = spr_ArcadeShooter_PlayerGirlIdle;
charArray[0,1] = spr_ArcadeShooter_PlayerBoyIdle;
charArray[0,2] = spr_ArcadeShooter_PlayerRobotIdle;
charArray[1,0] = spr_ArcadeShooter_PlayerGirlRun;
charArray[1,1] = spr_ArcadeShooter_PlayerBoyRun;
charArray[1,2] = spr_ArcadeShooter_PlayerRobotRun;
charArray[2,0] = spr_ArcadeShooter_PlayerGirlTorso;
charArray[2,1] = spr_ArcadeShooter_PlayerBoyTorso;
charArray[2,2] = spr_ArcadeShooter_PlayerRobotTorso;
charArray[3,0] = spr_ArcadeShooter_PlayerGirlRoll;
//charArray[3,1] = spr_ArcadeShooter_PlayerBoyRoll;
//charArray[3,2] = spr_ArcadeShooter_PlayerRobotRoll;
charArray[4,0] = spr_ArcadeShooter_PlayerGirlJump;
//charArray[3,1] = spr_ArcadeShooter_PlayerBoyRoll;
//charArray[3,2] = spr_ArcadeShooter_PlayerRobotRoll;

stepOffset = 0; // offsets Y axis of torso sprite when running
tempOffset = 0; //used for locking direction in place, ie during a roll

//torso vars
torsoArrayX = 0;
torsoArrayY = 0;
torsoIndex = 0; //keeps track of image_index of torso sprite

//shooting
bulletType = 1; // machine gun, shotgun
bulletTimer = 0; // keeps track of delay between shots
bulletIncrement = 0; // how small should bullet become based on distance from origin
bulletOffsetX = 0;
bulletOffsetY = 0;
bulletArray = [obj_ArcadeShooter_PlayerBullet1, obj_ArcadeShooter_PlayerBuckshot1];
speedArray = [36,96]
shotDelayArray = [5,45];
shotDelayTimer = 0;
shotDelay = 0;
bulletOffsetArray = [[84,192,84]];
reticleDir = 0;