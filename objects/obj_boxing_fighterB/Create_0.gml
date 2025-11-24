// Create Event
playerState = 0;
armControlInst = instance_create_layer(x,y,"Instances", obj_boxing_fighterB_armControl);
spriteArray = [spr_boxing_fighterB_bgL, spr_boxing_fighterB_bgC, spr_boxing_fighterB_bgR];
slideArray = [spr_boxing_fighterB_bgL_slide, spr_boxing_fighterB_bgC_slide, spr_boxing_fighterB_bgR_slide];
blockArray = [spr_boxing_fighterB_bgL_block, spr_boxing_fighterB_bgC_block, spr_boxing_fighterB_bgR_block];
maxScrollRate = 8;
maxSpeed = 7;

keyA = 0;
keyD = 0;
keySpace = 0;

screenBuffer = 500; 
roomLeftBound = screenBuffer;
roomRightBound = room_width - screenBuffer;
centerX = room_width / 2; 
layerId = layer_get_id("Background");
backgroundSpeed = 0;
targetSpeed = 0;
punchState = 0;
xOffset = 0; // Difference in x position between player and enemy
instance_create_layer(0,0,"Background2", obj_boxing_standsControl);
instance_create_layer(0,0,"Spotlight", obj_boxing_spotlight);

//slide
slideTime = .4;
channel = animcurve_get_channel(curve_boxing_fighterB_slide, 0);
cx = 0;
cy = 0;
enemyPos = 0;
targetDir = 0;

playerNearLeftEdge = 0;
playerNearRightEdge = 0;