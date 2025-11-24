active = 0;	// Whether shelf is at rest (0) or falling (1)
platformType = 0;	// Whether the shelf has stationary or moving platforms
queued = 0; // Whether it's this shelf's turn to tilt
fallDist = .01;	// how far to tilt over
slideLen = 2;	// how far to try to slide down
edgeRightPx  = 320;   // x-offset to the right-edge along shelf axis
edgeLenPx    = 1020;  // length of the right-edge line (shelf height)
sweepStepDeg = 5;     // sweep resolution in degrees

// Create shelf front
var front = instance_create_layer(x, y, "ShelvesFront", obj_runAndGun_fallingShelfFront, {
	parentID: id
});

function checkEdgeCollision(dir) {
	var nx = x + lengthdir_x(slideLen, dir);
	var ny = y + lengthdir_y(slideLen, dir);

	// Rebuild the same right-edge line at angle a, but from the translated position
	var x0 = nx + lengthdir_x(edgeRightPx, image_angle);
	var y0 = ny + lengthdir_y(edgeRightPx, image_angle);
	var x1 = x0 + lengthdir_x(edgeLenPx, image_angle + 90);
	var y1 = y0 + lengthdir_y(edgeLenPx, image_angle + 90);

	return !collision_line(x0, y0, x1, y1, obj_runAndGun_fallingShelfRear, 1, 1);
}

function normalizeAngle(angle) {
    // Normalize to [0,360)
    var n = angle mod 360;
    if (n < 0) n += 360;
    return n;
}
function diffAngle(from, to) {
    // Signed shortest path _to - _from in (-180,180]
    var d = (to - from + 540) mod 360 - 180;
    return d;
}


// Handle shelves
platforms = [];


platform_def = [
    { dx:  40, dy: -860, half_w: 164, h: 44 }, // top ledge
    { dx:  40, dy: -580, half_w: 164, h: 44 },
    { dx:  40, dy: -300, half_w: 164, h: 44 },
    { dx:  40, dy: -20, half_w: 164, h: 44 }, // lowest ledge
];

for (var i = 0; i < array_length(platform_def); ++i) {
	var xVar = platform_def[i].dx;
	var yVar = platform_def[i].dy;
    var p = instance_create_layer(x + xVar, y + yVar, "FallingShelfPlatforms", obj_RunAndGun2_fallingMaskInactive);
    p.owner = id;
    platforms[i] = p;
}
