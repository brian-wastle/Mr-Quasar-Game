cellLowQueue = ds_queue_create();
cellHighQueue = ds_queue_create();
currentLowPosition = 0;
currentHighPosition = 0;
depth = 305;
cellArrayLow = [
	[[0, 428], spr_arcadeShooter_blood01, 0],
	[[429,860], spr_arcadeShooter_blood02, 0],
	[[861,1096], spr_arcadeShooter_blood03, 0],
	[[1097,1304], spr_arcadeShooter_blood04, 0],
	[[1305,1540], spr_arcadeShooter_blood05, 0],
	[[1541,2020], spr_arcadeShooter_blood06, 0],
	[[2021,2400], spr_arcadeShooter_blood07, 0]
];

cellArrayHigh = [
	[[988, 1364], spr_arcadeShooter_blood08, 0],
	[[1365,1545], spr_arcadeShooter_blood09, 0],
	[[1546,1902], spr_arcadeShooter_blood10, 0]
];