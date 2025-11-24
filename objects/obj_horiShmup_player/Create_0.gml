

mask_index = sprite_index;
actionstate = 0;

hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed


bulletTimer = 0; //used to repeat shots while holding down mouse button 1
numOfGuns = 0; // number of shots from ship per step
numOfGunsSwitch = 0; // create next gun above or below 
alternatingVar = 0; // used for creating guns

bulletSize = 0; //bullet size
shieldStatus = 0; //whether player has a shield or not
homingBullets = 0;



///gamepad


haxis = 0;
vaxis = 0;