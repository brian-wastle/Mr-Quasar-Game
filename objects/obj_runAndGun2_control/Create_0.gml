obj_RunAndGun_Player.x = 1120;
obj_RunAndGun_Player.y = 50;
obj_runAndGun_camera.x = 800;
y = 540;
active = 0;
controlState = 0;
stateTimer  = array_create(2, 0);
stateAlarm[0] = 20;	// Spawn movers for player to ride on
moverArray = [];	// currently existing movers
moverCoords = array_create(4, undefined);	// mover obj ids with undefined place holders
moverYCoords = [128, 408, 688, 972]; // coords for mover objects along y axis
spawnGroups = [	// coords for mover objects along x axis
	[0, 608, -208, undefined],
	[undefined, 604, 0, 0],
	[-604, 424, 0, 556],
	[-508, 0, 344, 0],
	[undefined, 0, -512, 288],
	[0, -392, 548, undefined],
	[732, undefined, 0, -420],
	[0, -354, undefined, 244]
]
moverGroupIndex = undefined;
targetMover = noone;
moveSpeed = 0;		// track towards target
maxSpeed = 8;
accel = 1.1;
sd_smooth_time = 0.30;
sd_x = soft_damp1d_create(sd_smooth_time);
sd_active = false;

function stateFunction(timerIndex, callback) {
	if (stateTimer[timerIndex] < stateAlarm[timerIndex]) {
		stateTimer[timerIndex] += 1;
	} else {
		callback();
		stateTimer[timerIndex] = 0;
	}
};

function spawnGroup(index) {
	moverCoords = array_create(4, undefined);
	var cam = view_camera[0];
	var vx = camera_get_view_x(cam);
	var vw = camera_get_view_width(cam);
	var rightMargin = vx + vw + 720;
	for (var i = 0; i < 4; ++i) {
		if (spawnGroups[index][i] != undefined) {
		    var mover = instance_create_layer(rightMargin + spawnGroups[index][i], moverYCoords[i], "crateMovers", obj_runAndGun_crateMover);
			array_push(moverArray, mover);
			moverCoords[i] = mover;
		} else {
			moverCoords[i] = undefined;
		}
	}
}

function outsideView(objX, marginLeft, marginRight, view = 0) {
    var cam = view_camera[view];
    var vx = camera_get_view_x(cam);
    var vw = camera_get_view_width(cam);
    // Add margin to edge of view
    var leftEdge = vx - marginLeft;
    var rightEdge = vx + vw + marginRight;
    return (
        objX < leftEdge || objX > rightEdge
    );
}

function boardingCB() {
	moverGroupIndex = irandom(7);
	spawnGroup(moverGroupIndex);
};

function findCameraTarget() {
	// movers
	var group = spawnGroups[moverGroupIndex];	// array of xoffset coords
	var farRight = 0;						// smallest offset is closest to camera
	var forwardObj = noone;						// leader object
	// find the mover in front
	for (var i = 0; i < 4; ++i) {
		var offset = group[i];
		var mover = moverCoords[i];
	    if (offset != undefined && instance_exists(mover)) {
			if (offset < farRight) {
				farRight = offset;
				forwardObj = mover;
			}
		}
	}
	// fallback to any valid mover if offsets no longer match
	if (forwardObj == noone) {
		for (var j = 0; j < array_length(moverArray); ++j) {
			var candidate = moverArray[j];
			if (instance_exists(candidate)) {
				forwardObj = candidate;
				break;
			}
		}
	}
	// calc offset with this object, which is now camera target
	return forwardObj;
}

function clearMoverReference(mover) {
	for (var i = 0; i < array_length(moverCoords); ++i) {
		if (moverCoords[i] == mover) {
			moverCoords[i] = undefined;
			break;
		}
	}
	if (targetMover == mover) {
		targetMover = noone;
	}
}

function cleanUpMovers(left, right) {
	for (var i = array_length(moverArray) - 1; i >= 0; --i) {
		var mover = moverArray[i];
		if (!instance_exists(mover)) {
			clearMoverReference(mover);
			array_delete(moverArray, i, 1);
			continue;
		}
		if (outsideView(mover.x, left, right)) {
			clearMoverReference(mover);
			instance_destroy(mover);
			array_delete(moverArray, i, 1);
		}
	}
}

// Coming to a stop at boss platform
function soft_damp1d_create(_smooth_time)
{
    var dt     = 1 / 60;
    var omega  = 2 / max(0.0001, _smooth_time);
    var xCoord = omega * dt;
    var expfac = 1 / (1 + xCoord + 0.48*xCoord*xCoord + 0.235*xCoord*xCoord*xCoord);

    return {
        v     : 0,        // current velocity (px/step)
        omega : omega,
        exp   : expfac,
        dt    : dt
    };
}

/// Returns new position; updates sd.v (velocity)
function soft_damp1d_step(_current, _target, _sd)
{
    var change = _current - _target;
    var temp   = (_sd.v + _sd.omega * change) * _sd.dt;

    _sd.v      = (_sd.v - _sd.omega * temp) * _sd.exp;
    var out    = _target + (change + temp) * _sd.exp;

    // Prevent overshoot
    if ( (_target - _current) * (out - _target) > 0 ) {
        _sd.v = 0;
        return _target;
    }
    return out;
}