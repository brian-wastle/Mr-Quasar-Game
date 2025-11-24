global.twinStickGrid1 = mp_grid_create(250, 150, 60, 40, 30, 30);


//berry bushes

for (var i = 0; i < 3; i += 1) {
	var tempX = 502;
	var tempY = 1290;
	if i = 0 {
	    instance_create_layer(tempX + (i * 72),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Bush1,
		});
	}
	if i = 1 {
	    instance_create_layer(tempX + (i * 72),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Bush2,
		});
	}
	if i = 2 {
	    instance_create_layer(tempX + (i * 72),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Bush3,
		});
	}
	
}

for (var j = 0; j < 3; j += 1) {
	var tempX = 502;
	var tempY = 1290;
    if j = 0 {
	    instance_create_layer(tempX + 36 + (j * 72),tempY + 20,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Bush4,
		});
	}
	if j = 1 {
	    instance_create_layer(tempX + 36 + (j * 72),tempY + 20,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Bush5,
		});
	}
	if j = 2 {
	    instance_create_layer(tempX + 36 + (j * 72),tempY + 20,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Bush6,
		});
	}
	
}

//eggplants

for (var i = 0; i < 4; i += 1) {
	var tempX = 512;
	var tempY = 1226;
	if i = 0 {
	    instance_create_layer(tempX + (i * 54),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant1,
		});
	}
	if i = 1 {
	    instance_create_layer(tempX + (i * 54),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant2,
		});
	}
	if i = 2 {
	    instance_create_layer(tempX + (i * 54),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant3,
		});
	}
	if i = 3 {
	    instance_create_layer(tempX + (i * 54),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant4,
		});
	}
	
}

for (var j = 0; j < 3; j += 1) {
	var tempX = 512;
	var tempY = 1218;
    if j = 0 {
	    instance_create_layer(tempX + 30 + (j * 54),tempY + 24,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant5,
		});
	}
	if j = 1 {
	    instance_create_layer(tempX + 30 + (j * 54),tempY + 24,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant6,
		});
	}
	if j = 2 {
	    instance_create_layer(tempX + 30 + (j * 54),tempY + 24,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Eggplant7,
		});
	}
	
}

//corn

for (var i = 0; i < 7; i += 1) {
	var tempX = 506;
	var tempY = 666;
	    instance_create_layer(tempX + (i * 72),tempY,"Instances",obj_TwinStickShooter_Room2Corn);
}

for (var j = 0; j < 7; j += 1) {
	var tempX = 542;
	var tempY = 682;
	    instance_create_layer(tempX + (j * 72),tempY,"Instances",obj_TwinStickShooter_Room2Corn);
}

//cabbages

for (var i = 0; i < 5; i += 1) {
	var tempX = 1324;
	var tempY = 1216;
	instance_create_layer(tempX + (i * 40),tempY,"Instances",obj_TwinStickShooter_Room2Cabbages, {
		sprite_index:spr_TwinStickShooter_Room2Cabbages,
	});
}

for (var j = 0; j < 5; j += 1) {
	var tempX = 1336;
	var tempY = 1238;
	instance_create_layer(tempX + (j * 40),tempY,"Instances",obj_TwinStickShooter_Room2Cabbages, {
		sprite_index:spr_TwinStickShooter_Room2Cabbages2,
	});
}

//tomatoes

for (var i = 0; i < 4; i += 1) {
	var tempX = 1622;
	var tempY = 1220;
	if i = 0 {
	    instance_create_layer(tempX + (i * 52),tempY-60,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes1,
		});
	}
	if i = 1 {
	    instance_create_layer(tempX + (i * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes3,
		});
	}
	if i = 2 {
	    instance_create_layer(tempX + (i * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes5,
		});
	}
	if i = 3 {
	    instance_create_layer(tempX + (i * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes7,
		});
	}
	
}

for (var j = 0; j < 4; j += 1) {
	var tempX = 1646;
	var tempY = 1236;
    if j = 0 {
	    instance_create_layer(tempX + 8 + (j * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes2,
		});
	}
	if j = 1 {
	    instance_create_layer(tempX + (j * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes4,
		});
	}
	if j = 2 {
	    instance_create_layer(tempX + (j * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes6,
		});
	}
	if j = 3 {
	    instance_create_layer(tempX + (j * 52),tempY,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
			sprite_index:spr_TwinStickShooter_Room2Tomatoes8,
		});
	}
	
}

instance_create_layer(1608,1206 + 58,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
	sprite_index:spr_TwinStickShooter_Room2Pumpkin1,
});
		
instance_create_layer(1648,1206 + 58,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
	sprite_index:spr_TwinStickShooter_Room2Pumpkin2,
});

instance_create_layer(1692,1206 + 58,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
	sprite_index:spr_TwinStickShooter_Room2Pumpkin3,
});

instance_create_layer(1724,1206 + 58,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
	sprite_index:spr_TwinStickShooter_Room2Pumpkin4,
});

instance_create_layer(1764,1206 + 58,"Instances",obj_TwinStickShooter_Room2BerryBushes, {
	sprite_index:spr_TwinStickShooter_Room2Pumpkin5,
});