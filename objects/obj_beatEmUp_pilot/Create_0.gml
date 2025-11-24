image_speed = 0;
actionTimer = 0;
objectState = 0;
tapTimer = round(random_range(2,4) * 60);

exhaustIndex = 0;
flameIndex = 0;

shakeIncrement = 20;
shakeTimer = 20;
shakeOffset = 0;

propulsion = 0;
xSpeed = 0;

ySpeed = 0;
lift = 14;
liftIncrement = .005;
grav = .5;
maxFall = 16;

curvePosition = 0;
channelX = animcurve_get_channel(curve_beatEmUp_jetpackX, 0);
channelY = animcurve_get_channel(curve_beatEmUp_jetpackY, 0);
cx = 0;
cy = 0;

initialX = x;
initialY = y;
puffTimer = 7;
currentIndex = 0;