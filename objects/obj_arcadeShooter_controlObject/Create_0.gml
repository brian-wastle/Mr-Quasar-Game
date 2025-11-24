waveTimer = 0;
enemyYStartArray = [300,426,600];
enemyXSpeedArray = [4,6,8,10,12,14];
xSideArray = [-90,2490];




////////////////// bullet flash effect functions
function bulletFunction1() {
	if (self.image_index >= self.image_number - 1) {
		instance_destroy(self);
	}
}


////////balcony glass
locationArray = [1047, 1152, 1352, 1552, 1752];
balconyGlassSpriteArray = [spr_arcadeShooter_balconyGlass1, spr_arcadeShooter_balconyGlass2, spr_arcadeShooter_balconyGlass3, spr_arcadeShooter_balconyGlass4, spr_arcadeShooter_balconyGlass5];
trophySpriteArray = [spr_arcadeShooter_rhino, spr_arcadeShooter_ramHead, spr_arcadeShooter_spider, spr_arcadeShooter_antlers];

for (var i = 0; i < 5; ++i) {
	if (i = 0 ) {
		instance_create_layer(1048, 204, "Instances", obj_arcadeShooter_balconyGlass, {
			sprite_index: balconyGlassSpriteArray[i],
			depth: 200
		});
	} else {
		instance_create_layer((i - 1) * 200 + 1152, 204, "Instances", obj_arcadeShooter_balconyGlass, {
			sprite_index: balconyGlassSpriteArray[i],
			depth: 200
		});
	}
}

for (var i = 0; i < 4; ++i) {
	instance_create_layer(i * 84 + 1300, 128, "Instances", obj_arcadeShooter_trophy, {
		sprite_index: trophySpriteArray[i],
		depth: 200
	});
}

//////////////////////BOOKSHELF//////////////////////////////////////////
//////// gold dish
instance_create_layer(1434, 586, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_goldDish,
	offset: 116,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 150
});

//////// pink nemaji pot
instance_create_layer(1005, 480, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_nemaji1,
	offset: 0,
	rotationSpeed: 0,
	objectType: 1,
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 150
});

//////// green nemaji pot
instance_create_layer(1056, 528, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_nemaji2,
	offset: 0,
	rotationSpeed: 0,
	objectType: 1,
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 150
})

//////// wine
instance_create_layer(1488, 596, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_wine,
	offset: 0,
	rotationSpeed: 0,
	objectType: 1,
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 150
})

//////// golden statue
instance_create_layer(918, 514, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_goldenStatue,
	offset: 185,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 150
});

///////// sailboat
instance_create_layer(1356, 596, "Instances", obj_arcadeShooter_trophy, {
	sprite_index: spr_arcadeShooter_sailboat,
	depth: 150
});


///////// books
bookSpriteArray = [
	[
		[spr_arcadeShooter_threeByThreePlus, 40],
		[spr_arcadeShooter_threeByThreePlus, 40],
		[spr_arcadeShooter_threeByThreePlus, 40],
		[spr_arcadeShooter_threeByThree, 36],
		[spr_arcadeShooter_fourByThree, 48]
	],
	[
		[spr_arcadeShooter_threeByThree, 36],
		[spr_arcadeShooter_threeByThree, 36],
		[spr_arcadeShooter_threeByThree, 36],
		[spr_arcadeShooter_fourByThree, 48],
		[spr_arcadeShooter_fourByThree, 48]
	]
];

/////left shelf
//top shelf
shelfWidth = 0;
shuffledArray0 = array_shuffle(bookSpriteArray[0]);
for (var i = 0; i < 5; ++i) {
	instance_create_layer(876 + shelfWidth,476,"Instances", obj_arcadeShooter_bookObj, {
		sprite_index: shuffledArray0[i][0],
	});
	shelfWidth += shuffledArray0[i][1];
};

//third and fourth shelf
shelfWidth = 0;
shuffledArray2 = array_shuffle(bookSpriteArray[0]);
shuffledArray3 = array_shuffle(bookSpriteArray[1]);
for (var i = 0; i < 5; ++i) {
	instance_create_layer(876 + shelfWidth,596,"Instances", obj_arcadeShooter_bookObj, {
		sprite_index: shuffledArray2[i][0],
	});
	shelfWidth += shuffledArray2[i][1];
};
shelfWidth = 0;
for (var i = 0; i < 5; ++i) {
	instance_create_layer(876 + shelfWidth,656,"Instances", obj_arcadeShooter_bookObj, {
		sprite_index: shuffledArray3[i][0],
	});
	shelfWidth += shuffledArray3[i][1];
};


/////right shelf
//first and second shelf
shelfWidth = 0;
shuffledArray0 = array_shuffle(bookSpriteArray[0]);
shuffledArray1 = array_shuffle(bookSpriteArray[1]);
for (var i = 0; i < 5; ++i) {
	instance_create_layer(1320 + shelfWidth,476,"Instances", obj_arcadeShooter_bookObj, {
		sprite_index: shuffledArray1[i][0],
	});
	shelfWidth += shuffledArray1[i][1];
};
shelfWidth = 0;
for (var i = 0; i < 5; ++i) {
	instance_create_layer(1320 + shelfWidth,536,"Instances", obj_arcadeShooter_bookObj, {
		sprite_index: shuffledArray0[i][0],
	});
	shelfWidth += shuffledArray0[i][1];
};

//fourth shelf
shelfWidth = 0;
shuffledArray1 = array_shuffle(bookSpriteArray[1]);
for (var i = 0; i < 5; ++i) {
	instance_create_layer(1320 + shelfWidth,656,"Instances", obj_arcadeShooter_bookObj, {
		sprite_index: shuffledArray1[i][0],
	});
	shelfWidth += shuffledArray1[i][1];
};

//////////////////////End Table//////////////////////////////////////////
////////gold bowl
instance_create_layer(2000, 596, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_goldBowl,
	offset: 135,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: -110
});

///////// golden vase
instance_create_layer(2052, 616, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_goldenVase,
	offset: 0,
	rotationSpeed: 0,
	objectType: 1,
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}], 
	depth: -111
});

//////////////////////PLAQUES//////////////////////////////////////////
////////broken sword
instance_create_layer(1762, 362, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_brokenSword,
	offset: 303,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});

////////other plaque
instance_create_layer(934, 367, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_otherPlaque,
	offset: 320,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});
		
////////pistol plaque
instance_create_layer(1648, 360, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_pistolPlaque,
	offset: 320,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});



////////rifle plaque
instance_create_layer(1432, 368, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_rifle,
	offset: 320,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});

////////shield plaque
instance_create_layer(1030, 358, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_shieldPlaque,
	offset: 320,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});

////////swords plaque
instance_create_layer(688, 244, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_swords,
	offset: 430,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});


////////////////////////// Horseshoes

for (var i = 0; i < 4; ++i) {
    instance_create_layer(60 * i + 596, 316, "Instances", obj_arcadeShooter_bounceDest, {
	sprite_index: spr_arcadeShooter_horseshoe,
	objectType: 2,
	offset: 374,
	rotationSpeed: irandom_range(10,14),
	effectObjects: [obj_arcadeShooter_bulletEffect], //any effects that are triggered when the object is struck by a bullet
	effectOptions:[{
		spriteIndex: spr_arcadeShooter_bulletFlash1,
		func: bulletFunction1
	}],
	depth: 175
});
}




////////////////////////// Furniture

//////////boss chair
instance_create_layer(200, 840, "Instances", obj_arcadeShooter_trophy, {
	sprite_index: spr_arcadeShooter_chair
});
