camView = view_camera[0];
x = camera_get_view_x(camView) + 210;
y = camera_get_view_y(camView) + 170;
var previousStamina = currentStamina;
currentStamina = obj_TwinStickShooter_player.playerStamina;

currentAngle = map_range(currentStamina);

xCoordinate = 100 * dsin(currentAngle) + 150;
yCoordinate = 100 * dcos(currentAngle) + 150;

needleAngle = point_direction(90,140,xCoordinate,yCoordinate) + 270;

if (currentStamina > 100) {
	currentStamina = 100;
}
if (currentStamina < 0) {
	currentStamina = 0;
	
}
map_stamina(currentStamina);
staminaArray = split_digits(currentStamina);

//handle hundred place


	if ((staminaIndex[0] / 6) != staminaArray[0]) {
		if (currentStamina = 100) {
			staminaIndex[0] += 1;
			if (staminaIndex[0] = 60) {
				staminaIndex[0] = 0
			}
		} else {
			staminaIndex[0] -= 1;
			if (staminaIndex[0] < 0) {
				staminaIndex[0] = 59
			}
		}
}





//handle tens place

if ((staminaIndex[1] / 6) != staminaArray[1]) {
	staminaIndex[1] += 1;
	if (staminaIndex[1] = 60) {
		staminaIndex[1] = 0
	}
}

//handle ones place


if ((staminaIndex[2] / 6) != staminaArray[2]) {
	staminaIndex[2] += 5;
	if (staminaIndex[2] = 60) {
		staminaIndex[2] = 0;
	}
}