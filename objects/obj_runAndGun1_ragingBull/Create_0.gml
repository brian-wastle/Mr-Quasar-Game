event_inherited();
//	enemyState			= 0;
//	attackState			= 0;
//	hitFlag				= 0;		// Allows miniboss to flash when hit
//	stateTimer[0]		= 0;
//	stateTimer[1]		= 0;

depth				= -520;
bossInst			= noone;
enemyHealth			= 2999;
currentIndex		= 0;
vibrationOffset		= 2;
vibeTimer[0]		= 0;
currentPhase		= 0;
damageFlag			= 0;		// Whether character will enter stunned state at end of current animation
damageState			= 0;		// Sub states of damage state

// Idle Effects
idleLoop			= 0;

// Dash Attack
maxSpeed			= 16;			// even #'s
currentDir			= -1;

xCenter				= 12676;
xBorder				= 708;

// Jump Attack
hopGravity			= 0.8;			// + each step while airborne
hopHSpeed			= 10;			// horizontal speed per frame
hopVImpulse			= -22;			// upward kick per hop

hopXSpeed			= 0;
hopYSpeed			= 0;
hopAir				= false;

lapCount			= 0;			// 0.5 added per wall touch
groundY				= y;			// captured on first use
hopInit				= false;		// captures ground once

// Tornado Attack
tornadoHSpeed		= 18;			// much faster across the screen
tornadoVImpulse		= -22;			// higher leap
recoverState		= 0

// Death
deathLoops			= 0;
startX				= x;

function jumpXMotion() {
	x += hopXSpeed;
	y += hopYSpeed;
	hopYSpeed += hopGravity;

	var leftWall = xCenter - xBorder;
	var rightWall = xCenter + xBorder;

	if ((hopXSpeed < 0 && x <= leftWall) ||
	(hopXSpeed > 0 && x >= rightWall)) {
		x = clamp(x, leftWall, rightWall);
		hopXSpeed = -hopXSpeed;
		currentDir = -currentDir;
		lapCount += 1;
	}
}

// Spawn two missiles from a single cannon
function spawnMissiles(_xOffset, _yOffset, _baseAngle) {
	var xOffsets   = [-8, 8];
    for (var i = 0; i < array_length(xOffsets); ++i) {
		var angleOffset = -3 + (i * 10);
        var ox = xOffsets[i];
        var m  = instance_create_layer(x + _xOffset + ox, y - _yOffset, "Instances", obj_runAndGun1_bullMissile, {
            // initial state
            direction    : _baseAngle + angleOffset,
			image_angle: irandom_range(0,359)
        });
    }
}


instance_create_layer(x, y, "Instances", obj_runAndGun_miniHealthBar);