y -= 1;

timer += 1;

if (timer = 500) {
	instance_destroy(initInst);
	initInst = instance_create_layer(x,y,"Instances",obj_vertShmup_TurretBurstTracking, {
	rotationSpeed:1, bulletSpeed:5, intervals:[5,5,5,15, 60]
	});
}

if (timer = 1200) {
	instance_destroy(initInst);
	initInst = instance_create_layer(x,y,"Instances",obj_vertShmup_TurretFlurryTracking);
}

if (timer = 1600) {
	instance_destroy(initInst);
	initInst = instance_create_layer(x,y,"Instances",obj_vertShmup_TurretSmallSpray1, {
		intervals:[5,10,5,80]
	});
}

if (timer = 2000) {
	instance_destroy(initInst);
	initInst = instance_create_layer(x,y,"Instances",obj_vertShmup_TurretStaticDir, {
		intervals:[5,10,120], bulletAngles:[0,90,180,270]
	});
}