y -= 1;

timer += 1;

if (timer = 1300) {
	instance_destroy(initInst);
	initInst = instance_create_layer(x,y,"Instances",obj_vertShmup_BossTurretBeams);
}

if (timer = 2600) {
	instance_destroy(initInst);
	initInst = instance_create_layer(x,y,"Instances",obj_vertShmup_BossTurretSpray);
}