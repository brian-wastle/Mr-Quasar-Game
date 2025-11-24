event_inherited();
image_xscale = xFacing;

// Create exhaust rings
if (stateTimer[0] < 19) {
    stateTimer[0] += 1;
} else {
	for (var i = 0; i < 3; ++i) {
		var ring = instance_create_layer(x + exhaustOffsets[i].xPos * xFacing, y + exhaustOffsets[i].yPos,"Instances", obj_runAndGun_flyingExhaustRings, {ownerId: id});
		array_push(ringArrays[i], {ring:ring, offset:0});
	}
	stateTimer[0] = 0;
}

// Position flame
for (var k = 0; k < 3; ++k) {
	flameArray[k].x = x + exhaustOffsets[k].xPos * xFacing;
	flameArray[k].y = y + exhaustOffsets[k].yPos + bobOffset;
}

// Position exhaust rings
for (var i = 0; i < 3; ++i) {
	if (array_length(ringArrays[i])) {
	    for (var j = array_length(ringArrays[i]) - 1; j >= 0 ; --j) {
			ringArrays[i][j].ring.xOrigin = x + exhaustOffsets[i].xPos * xFacing;
			ringArrays[i][j].ring.yOrigin = y + exhaustOffsets[i].yPos + bobOffset;
			if (ringArrays[i][j].offset < 35) {
			    ringArrays[i][j].offset += 1;
				ringArrays[i][j].ring.offset += 1;
			} else {
				instance_destroy(ringArrays[i][j].ring);
				array_delete(ringArrays[i], j, 1);
			}
		}
	}
}
