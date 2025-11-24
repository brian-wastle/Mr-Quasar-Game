
frameCount++;
if (frameCount == 60) {
	frameCount = 0;
}
if (frameCount % 2 == 0) {
    spriteOpacity = applyNoiseFilter(.4);
	outlineOpacity = applyNoiseFilter(.4, .05);
	bgOpacity = applyNoiseFilter(.2, .03);
}