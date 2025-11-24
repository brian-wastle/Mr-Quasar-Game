player = noone;
currentHealth = 0;
bulletType = 0;
heartArray = [		//Five full hearts
	0,
	0,
	0,
	0,
	0
]
heartSprArray = [
	spr_runAndGun_heart1,
	spr_runAndGun_heart2,
	spr_runAndGun_heart3,
	spr_runAndGun_heart4,
	spr_runAndGun_heart5
]

// prepare each heart in array
function setHearts() {
	currentHealth = obj_RunAndGun_Player.playerHealth;
	for (var i = 0; i < array_length(heartArray); ++i) {
	    var heartCount = floor(currentHealth/20);
		if (i * 20 + 20 <= currentHealth) {
		    healthArray[i] = 0;
		} else {
			healthArray[i] = 2;
		}
	}
	for (var i = 0; i < array_length(heartArray); ++i) {
	    var heartCount = floor(currentHealth/20);
		if (2 * i * 20 + 20 <= currentHealth) {
		    healthArray[i] = 1;
		}
	}
}