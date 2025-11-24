
timelinePoint = 0;
eventTimer = 0; //timer that runs in background throughout the level
lay_id = layer_get_id("Background");
lay1_id = layer_get_id("Backgrounds_1");
lay2_id = layer_get_id("Backgrounds_2");
layer_hspeed(lay_id, -4);
layer_hspeed(lay1_id, -2);
layer_hspeed(lay2_id, -1);
cloneInst = 0; //instance ID of clone ship
mooredShipInst = 0; //instance ID of moored ship
shipFlash = 0; //instance ID of ship flash effect
bgSpeedVar = 1; //controls speed of the parallax background
cloneShipSpeedVar = 0;
xTimer = 0; //timer to determine y position of plane during cutscenes

xPrevious = 0; // previous x position for sprite index
yPrevious = 0; // previous y position for sprite index

initialTimer = 0; //initial timer before any movement on screen
cloneSpriteTimer = 0; //tracks how long the ship has been in the up or down position;
cloneSpriteTrigger = 0; //tracks whether the clone ship sprite has changed since changing y direction;
stillCloneTimer = 0; //keep track of how long clone ship is stationary

scrapFrequency = 300; //used to randomly generate scrap in space

tempVar_a = 0;//keeps track of distance between 2 pieces of scrap vertically
tempVar_b = 0;

wreckedShipsInst = 0; //inst for wrecked ships