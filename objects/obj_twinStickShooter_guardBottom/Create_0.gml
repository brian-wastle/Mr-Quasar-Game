enemyHealth = 100;
dir = 0;
movementPath = path_add();
enemyDir = 0;
mask_index = spr_twinStickShooter_playerHb;
imageIndexVar = 0;
enemyTimer = 0;
enemyDirPrevious = 0;

topInst = instance_create_layer(x,y,"Instances",obj_twinStickShooter_guardTop);
topInst.owner = id;
blinkVar = 0;

origin = 0; // spawn point (door) which created this object
controlObject = 0; //which room created this object



//every enemy has to have these in create event
pushDistance = 0;
pushDirection = 0;
