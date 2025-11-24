xCoordinate = 0;
yCoordinate = 0;
currentAngle = 0;
currentStamina = 100;
depth = -1600
function map_range(stamina) {
     return -150 + 4 * stamina;
}

function map_stamina(input_value) {
    if (input_value <= 80) {
        return (input_value / 80) * 100;
    } else {
        return 100;
    }
}

//stamina gauge
surf = -1;
camView = view_camera[0];
needleAngle = 0;
staminaArray = [];
staminaIndex = [0,0,0];

function split_digits(stamina) {
	var digits = [0, 0, 0];
	digits[0] = (stamina div 100) % 10;
	digits[1] = (stamina div 10) % 10;
	digits[2] = stamina % 10;
	return digits;
}