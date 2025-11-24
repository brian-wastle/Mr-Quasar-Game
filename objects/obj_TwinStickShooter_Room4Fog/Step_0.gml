if (fogTimer = 0) {
	fogTimer = (fps * 10);
}

if (fogTimer = 1) {
	fogOpacity *= .98;
}

if (fogOpacity < .05) {
	instance_destroy();
}

if (layerX.topDir = 0) {
	layerX.top += 0.5
	if layerX.top >= 300 {
		layerX.topDir = 1;
	}
} else if (layerX.topDir = 1) {
	layerX.top -= 0.5
	if layerX.top <= 0 {
		layerX.topDir = 0;
	}
}

if (layerX.bottomDir = 0) {
	layerX.bottom += 0.5
	if layerX.bottom >= 300 {
		layerX.bottomDir = 1;
	}
} else if (layerX.bottomDir = 1) {
	layerX.bottom -= 0.5
	if layerX.bottom <= 0 {
		layerX.bottomDir = 0;
	}
}

if (fogTimer > 1) {
	fogTimer -= 1;
}