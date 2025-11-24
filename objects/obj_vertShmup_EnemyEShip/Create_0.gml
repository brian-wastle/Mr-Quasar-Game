breakTimer = 0; //how long in between shots
bulletTimer = 32; //how long gun shoots
gunState = -1;
chargeIndex = 0; // image_index for charging sprite
initPause = irandom_range(0,90);
breakTimer += initPause;
enemyHealth = 100;
deathState = 0;