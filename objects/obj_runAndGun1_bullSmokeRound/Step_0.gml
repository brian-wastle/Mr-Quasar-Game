if (stateTimer[0] < 5) {
	stateTimer[0] += 1;
} else if (currentIndex < initialIndex + 3) {
	stateTimer[0] = 0;
	currentIndex += 1;
} else {
	var radius = 16;           
	// rotation of the entire triangle pattern
	var rot = irandom(359);          
	for ( var i = 0; i < 3; i++ ) {
	    var ang = rot + i * 120;
	    // m/n = offset from center along that angle
	    var m = lengthdir_x(radius, ang);
	    var n = lengthdir_y(radius, ang);
	    instance_create_layer(
	        x + m, 
	        y + n, 
	        "Instances", 
	        obj_runAndGun1_bullSmokeSmall, 
	        { smokeDir: ang }
	    );
	}	
	instance_destroy();
}
x += 1 * smokeDir;
y += .5 * instDir;