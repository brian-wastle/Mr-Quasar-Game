if blinkTimer = 0 {
	if (!instance_exists(obj_TwinStickShooter_Room4Fog)) {
		instance_create_layer(0,0,"Instances",obj_TwinStickShooter_Room4Fog);
	}
	obj_TwinStickShooter_Room4Fog.fogTimer = (fps * 10);
	blinkTimer = 10;
}

if blinkTimer = 1 {
	
	blinkOpacity *= .99;
} else {
	blinkTimer -= 1;
}

if (blinkOpacity < .05) {
	instance_destroy();
}
