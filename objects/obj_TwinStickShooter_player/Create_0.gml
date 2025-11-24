playerHealth = 100;
playerStamina = 100;
actionState = 0;

hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed
xtarg = 0;
ytarg = 0;
dir = 0;
len = 0;

bulletTimer = 0;
stamRecharge = 0; // whether stamina is refilling after a roll

mask_index = spr_twinStickShooter_playerHb;

lhaxis = 0;
lvaxis = 0;
rhaxis = 0;
rvaxis = 0;
directionOffset = 0;
aimOffset = "down";
actualDir = 270;

bulletArray = [{object: obj_twinStickShooter_playerBullet, delay: 10, offset:0}, {object: obj_twinStickShooter_playerRocket, delay: 40, offset:75}, {object: obj_twinStickShooter_playerOrb, delay: 10, offset:25}];
bulletType = 0;
delayTimer = 0;
fireState = 0 //counter to prevent player from spamming rockets

cursorOffsetX = 0;
cursorOffsetY = 0;