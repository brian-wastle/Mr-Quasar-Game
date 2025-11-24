if (stateTimer[0] < 5) {
	stateTimer[0] += 1;
} else if (currentIndex < image_number - 1) {
	stateTimer[0] = 0;
	currentIndex += 1;
} else {
	instance_destroy();
}

var xOffset = lengthdir_x(1,smokeDir);
var yOffset = lengthdir_y(1,smokeDir);
x += xOffset;
y += yOffset;