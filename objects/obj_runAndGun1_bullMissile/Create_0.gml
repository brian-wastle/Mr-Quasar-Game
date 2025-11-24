depth = -550;
image_speed = 0;
image_angle = direction;			// Direction is injected by spawner
currentIndex = 0;
stateTimer[0] = 0;
stateTimer[1] = 0;
stateTimer[2] = 0;
stateTimer[3] = 0;

phase				= 0;			// 0 = ascending, 1 = homing, 2 = fly straight
spinSpeed			= 45;
missileGrav			= 0.3;			// Added against ySpeed each step while airborne
vImpulse			= 18;			// Initial upwards velocity

// Set initial impulse direction and velocity
xSpeed = lengthdir_x(vImpulse, direction);
ySpeed = lengthdir_y(vImpulse, direction);

playerX = 0;
playerY = 0;
playerDir = 0;
playerOffset = 0;

travelSpeed = 4;

thisExplosion = 0;