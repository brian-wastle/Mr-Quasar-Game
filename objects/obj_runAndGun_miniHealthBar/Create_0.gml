bullPhase			= 0;		// Which phase of the fight
currentHealth		= 2999;		// How much health in current phase
totalHealth			= 3000;		// How much total health in phase

barLength			= 0;		// Length of active bar
phaseLoc			= 0;		// Length of inactive bars

objState			= 0;		// Health bar animation states
fillPhase[0]		= 0;		// Used to animate health bar on spawn
fillPhase[1]		= 0;
fillPhase[2]		= 0;

loadingIndex		= 0;		// Image index for loading bar
loadingAlpha		= 1;
stateTimer[0]		= 0;