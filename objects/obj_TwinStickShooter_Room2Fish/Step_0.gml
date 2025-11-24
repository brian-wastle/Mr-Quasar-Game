if (initSequence = 1) {
	image_speed = 0;
	if sequenceTimer = 0 {
		sequenceTimer = irandom_range(30,50);
	}
	
	if sequenceTimer > 0 {
		sequenceTimer -= 1;
	}
	
	if (sequenceTimer = 0) {
		initSequence = 0;
	}
}

if (initSequence = 0) {
	image_speed = .8;
	if sequenceTimer = 0 {
		sequenceTimer = irandom_range(2,6) * fps;
	}
	
	if sequenceTimer > 0 {
		sequenceTimer -= 1;
	}
	
	if (sequenceTimer = 0) {
		initSequence = 1;
	}
	
}