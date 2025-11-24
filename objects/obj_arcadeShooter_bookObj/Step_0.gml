if (enemyHealth <= 0 && trigger = 0) {
	image_index = 4;
	image_speed = 1.2;
	trigger = 1;
};

if (image_index >= image_number - 4 && trigger = 1) {
	depth = 149;
	for (var i = 0; i < 2; ++i) {
		var copiedArray = array_shuffle(shredArray);
		var newInstance = array_pop(copiedArray);
	    var tempAngle = irandom_range(45,135);
		instance_create_layer(x + 26 + (lengthdir_x(27, tempAngle) * 4), y + (lengthdir_y(27, tempAngle) * 4), "Instances", newInstance);
	}
	trigger = 2;
};

if (image_index >= image_number - .5) {
	instance_destroy();
};
