image_speed = 0;
stateTimer = 0;
currentDuration = 0;

function switchState () {
	switch (image_index) {
	    case 0:
	        currentDuration = 30;
			image_index = irandom_range(1,2);
	        break;
	    default:
	        currentDuration = irandom_range(3,4) * fps;
			image_index = 0;
	        break;
	}
}