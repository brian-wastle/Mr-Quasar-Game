event_inherited();
stateTimer[0] = 0;

// Current velocity
xSpeed = 0;
ySpeed = 0;

// Target velocity
targetVX = 0;
targetVY = 0;

// Movement tuning
maxSpeed    = 32;    // max magnitude of velocity
easeFactor  = 0.08; // easing speed (0–1, lower = smoother)

// Bob
bobPhase      = irandom_range(0, 2 * pi);
bobSpeedMain = 0.1;     // slow big bob
bobAmpMain   = 8;        // pixels up/down

bobPhaseRip   = irandom_range(0, 2 * pi);      
bobSpeedRip   = 0.25;
bobAmpRip     = 0.5;

bobOffset = 0;            // final vertical offset added in Draw

// Bullet collision
bulletInst = id;
rifleCharge = rifleCharge;