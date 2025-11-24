sprite_index = spr_robot_hitbox1;
mask_index = sprite_index;
actionstate = 0;

grv = 0.6; //gravity
hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed
hsp_walk = 0; //walk speed
hsp_jump = 0; //jump horizontal speed
vsp_jump = 0; //jump vertical speed
hsp_max_walk = 9; //walk speed
hsp_max_jump = 10; //jump horizontal max speed
vsp_max_jump = -12; //jump vertical max speed
vsp_max_height = 0; //counter to keep track of char's height during jump
jump_status = 0; //prevents character from jumping immediately on landing

mouse_grapple = 0; // mouse direction for grapple hook
grappletarget_x = 0; //determine direction of grapple hook
grappletarget_y = 0; //determine direction of grapple hook
grapplepath = path_add();


hsp_slide = 0;
slide_timer = 0; //controls for how long the slide will last and therefore distance
slide_status = 0; //trigger for whether player can slide or not after a slide
jetpack_slide = 0; //checks hsp when transitioning from slidejump to jetpack

dodge_direction = 0;
dodge_timer = 0;
dodge_max_timer = 100;

jetpack_max_fuel = 100;//total jetpack fuel
jetpack_fuel = 100;//current jetpack fuel
jetpack_refuel = 0; //state where jetpack fuel is recharging
vsp_jetpack = 0; //verticalspeed for jetpack
vsp_max_jetpack = -6; //max vertical speed for jetpack
init_jetpack = 0; //release jump button after a jump to allow jetpack to start


