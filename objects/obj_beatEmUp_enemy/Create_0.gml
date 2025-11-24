/// --- GENERAL SETUP ---
// Random seed if you want variation in freezeTimer or other random events
randomize();

/// --- ENEMY STATE & HEALTH ---
enemyState = 100; // 100 = Appear from screen margins
previousState = 0; // Previous step’s state
enemyHealth = 500; // Starting health

/// --- TIMERS & UTILITY ---
freezeTimer = irandom_range(120, 180); // Delay used across multiple states
iFrameTimer = 0; // I-frames after being hit
shakeTimer = 0; // Timer for shaking/flashing effects
knockbackTimer	= 0;	 // Timer for handling knockback image_index
shakeDir= 1; // +/- direction for shake
shakeOffset = 0; // Pixel offset for shake effect
currentOpac = 1; // Current draw opacity
finalOpac = 1; // Used when fading out enemies
hitflag			= 0;	 // Keeps track of hitStop state
playerHitflag	= 0;	 // Track player's hitflag state
currentIndex	= 0;	 // Track enemy hitbox object's image_index to control hitflag
comboTimer		= 0;	 // Track frame length for attack animations
hitboxInst		= 0;	 // Hitbox object instance

/// --- SPRITE & ANIMATION ---
// Assume you have charIndex defined somewhere else (e.g. in the parent object or globally)
spriteArray = [
[
spr_beatEmUp_yjacketIdle, // 0
spr_beatEmUp_yjacketWalk, // 1
spr_beatEmUp_yjacketDamage, // 2
spr_beatEmUp_yjacketAttack1, // 3
		spr_beatEmUp_yjacketGrabbed // 4
]
];

heightArray = [272];

sprite_index = spriteArray[charIndex][1]; // Start on a "walk" or default sprite
image_index = 0;
image_speed = 1; 

//Enemy collision mask arrays
maskArray[0] = [spr_beatEmUp_lrgEnemyCollision, spr_beatEmUp_lrgEnemyCollision2];
maskArray[1] = spr_beatEmUp_medEnemyCollision;

/// --- POSITIONING & MOVEMENT GOALS ---
dirOffset = 0; // Will be -1 or +1 depending on left/right of player
xGoal = 0; // Where we want the enemy to move horizontally
yGoal = y; // Where we want the enemy to move vertically
playerDist= 0; // Distance to player
shadowSize= 0; // Size of shadow (scaled by z-position if 2.5D)

/// --- CAMERA / VIEW SETUP ---
var mid_x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)
if (x < mid_x) {
// Enemy spawns on the left
dirOffset = -1;
} else {
// Enemy spawns on the right
dirOffset = 1;
}
xGoal = mid_x + 760 * dirOffset; // Appear from margin

/// --- PATHFINDING / AI ---
foundPosition = 0; // Used in states 8 & 10 to find a valid position
targetSet = 0; // For storing position once
targetX= 0;
targetY= 0;
pathState = 0; // Used for detours around player
finalTargetX = 0;
initialPlayerX = 0; 
initialEnemyX = 0;
tempDistance = 0;

/// --- KNOCKBACK, BOUNCE, & SLIDE ---
knockbackState = 0; // Tracks sub-state of knockback in enemyState=7
knockbackDir = 1; // Direction for knockback
knockbackForce	 = 0;	 // Height of knockback
knockbackDist	 = 0;	 // Distance of knockback, default to 12
hitAgain = 0; // Flag to handle mid-air juggles
zsp= 0; // “z-position” (vertical offset above ground)
zMaxKO = 150; // Parabolic arc height if you used param approach
zMaxBounce = 45; // Arc height for second bounce
knockbackSpeed = 0.03;
bounceProgress = 0;
bounceSpeed= 0.04;
slideSpeed = 6; // Speed for sliding to a stop
bounceCount = 0;


/// --- VELOCITY-BASED JUGGLE / PHYSICS ---
xVel				= 0;// Horizontal velocity
zVel				= 0;// Vertical velocity for “z” arc
zGravity			= 0.6; // Gravity pulling enemy back down
bounceFactor		= 0.5; // Velocity multiplier on bounce
edgeSlamOldVel		= 0; // Store velocity before freezing at wall

/// --- COMBAT & ATTACKS ---
attackStack		 = 0; // Number of hits taken toward a KO
comboTimer		 = 0; // Timer for potential combos
hbFlag			 = 0; // track creating of hitbox object
airkickFlag		 = 1;
spikeFlag		 = 0; // Marks whether KO is caused by a spike

/// --- SHADOW / DEPTH ---
depth = -y; 
