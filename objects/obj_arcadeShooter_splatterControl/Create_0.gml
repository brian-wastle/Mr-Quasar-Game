cellFrontQueue = ds_queue_create();
cellBackQueue = ds_queue_create();
cellHighQueue = ds_queue_create();
currentFrontPosition = 0;
currentBackPosition = 0;
currentHighPosition = 0;
depth = 305;
cellArrayFront = [
	[[232, 424], spr_arcadeShooter_splatter1, 0],
	[[2024,2168], spr_arcadeShooter_splatter4, 0]
];

cellArrayBack = [
	[[648,816], spr_arcadeShooter_splatter2, 0],
	[[1584,1752], spr_arcadeShooter_splatter3, 0]
]

cellArrayHigh = [
	[[1056,1218], spr_arcadeShooter_splatter5, 0],
	[[1219,1354], spr_arcadeShooter_splatter6, 0],
	[[1355,1521], spr_arcadeShooter_splatter7, 0],
	[[1522,1651], spr_arcadeShooter_splatter8, 0],
	[[1652,1852], spr_arcadeShooter_splatter9, 0]
];