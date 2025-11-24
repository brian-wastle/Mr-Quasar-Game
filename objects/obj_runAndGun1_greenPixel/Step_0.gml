switch (blinkState) {
    case 0:
        if (blinkTimer < blinkRate) {
			blinkTimer += 1;
		} else if (blinkTimer == blinkRate) {
			image_index += 1;
			blinkState = 1;
			blinkTimer = 0;
		}
        break;
    default:
        blinkTimer += 1;
		if (blinkTimer == 15) {
		image_index += 1;
		blinkTimer = 0;
		blinkState = 0;
		}
        break;
}