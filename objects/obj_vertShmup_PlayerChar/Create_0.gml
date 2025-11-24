depth = -1;
audio_group_load(vertShmupSFX);
mask_index = spr_vertShmup_playerCharMask;
actionState = 0;

hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed


bulletTimer = 0; //used to repeat shots while holding down mouse button 1
bulletType = 1; // {0:simple bullet, 1:double speed}
bulletInterval = 0; //bullet frequency
shieldStatus = 0; //whether player has a shield or not
powerUp = 1; //level of bullet power ups
powerUpTimer = 0;

playerOpacity = 1; //player's opacity after death
deathTimer = 0;
bulletSprite = obj_vertShmup_playerBullet;

///gamepad


haxis = 0;
vaxis = 0;
xPrev = 0;
yPrev = 0;