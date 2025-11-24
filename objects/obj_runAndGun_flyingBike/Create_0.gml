event_inherited();
stateTimer[0] = 0;	// state
stateTimer[1] = 0;	// exhaust
stateTimer[2] = 0;	// damage

enemyHealth = 100;
image_xscale = -1;
image_index = image_number - 1;	// mini version sprite
offsetX = 12;
offsetY = 80;
exhaustIndex = 0;
image_speed = 0;
enemyState = 0;
previousState = 0;
shortDelay = irandom_range(30,50);

laneArray = [[972,952],[732,672],[488,392]];
y = laneArray[laneIndex][0];

deathFlag = 0;
mask_index = spr_blank;