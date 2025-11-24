levelFrames += 1;

if (levelFrames = 60) {
    levelSecs += 1;
	levelFrames = 0;
}

if levelSecs = 60 {
	levelMins += 1;
	levelSecs = 0;
}

if levelMins = 60 {
	levelHours += 1;
	levelMins = 0;
}


// Scripted Progress

// first pilot
if (levelSecs = 5 && levelProgress = 0) {
	levelProgress = 1;
}