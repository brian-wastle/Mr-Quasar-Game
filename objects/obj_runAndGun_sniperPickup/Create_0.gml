stateTimer[0]			= 0;
stateTimer[1]			= 0;
stateTimer[2]			= 0;

currentIndex			= 0;
glowState				= 0;
glowIndex				= 0;
glowAlpha				= .01;
fadeState				= 0;
cleanUp					= 0;

initialX = x;
initialY = y;

yOffset = 0;

channel = animcurve_get_channel(curve_runAndGun_pickup, 0);
cx = 0;
cy = 0;

image_speed = 0;