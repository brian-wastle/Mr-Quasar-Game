xSpeed = lerp(xSpeed, targetVX, easeFactor);
ySpeed = lerp(ySpeed, targetVY, easeFactor);

// Clamp diagonal speed
var currentSpeed = point_distance(0, 0, xSpeed, ySpeed);
if (currentSpeed > maxSpeed) {
    var dir = point_direction(0, 0, xSpeed, ySpeed);
    xSpeed = lengthdir_x(maxSpeed, dir);
    ySpeed = lengthdir_y(maxSpeed, dir);
}

x += xSpeed;
y += ySpeed;

// Bob
bobPhase      += bobSpeedMain;
bobPhaseRip  += bobSpeedRip;

// main slow bob
var mainWave   = sin(bobPhase);

// small fast ripple
var rippleWave = sin(bobPhaseRip);

// combine them into final offset
bobOffset = mainWave * bobAmpMain + rippleWave * bobAmpRip;