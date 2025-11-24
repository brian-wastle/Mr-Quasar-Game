tvSprites = [
	spr_runAndGun1_tv1a,
	spr_runAndGun1_tv1b,
	spr_runAndGun1_tv1c,
	spr_runAndGun1_tv1b,
	spr_runAndGun1_tv1d,
	spr_runAndGun1_tv1e,
	spr_runAndGun1_tv1f,
]
currentIndex = 0;
triggerTimer = 0;
sparkInst = 0;
tvLeft = instance_create_layer(880, 272, "Objects", obj_runAndGun1_tv2);
tvRight = instance_create_layer(1016, 272, "Objects", obj_runAndGun1_tv3);
depth = 199;