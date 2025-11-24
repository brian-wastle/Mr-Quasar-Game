
var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
var centerX = x1 + ((x2-x1)/2);
var centerY = y1 + ((y2-y1-120)/2);


if !instance_exists(obj_horiShmup_pauseObject) {


layer_hspeed(lay_id, -.4 * bgSpeedVar);

layer_hspeed(lay1_id, -.2 * bgSpeedVar);

layer_hspeed(lay2_id, -.1 * bgSpeedVar);


if (instance_exists(cloneInst)) {
	if ((cloneInst.y < yPrevious) && cloneSpriteTrigger = 0) {
		cloneInst.sprite_index = spr_horiShmup_cloneUp;
		cloneSpriteTrigger = 1;
	};
	if ((cloneInst.y > yPrevious) && cloneSpriteTrigger = 0) {
		cloneInst.sprite_index = spr_horiShmup_cloneDown;
		cloneSpriteTrigger = 1;
	};
	if (cloneSpriteTimer >= 30) {
		cloneInst.sprite_index = spr_horiShmup_player0;
		
	};
	if (((cloneInst.sprite_index = spr_horiShmup_cloneUp) || (cloneInst.sprite_index = spr_horiShmup_cloneDown)) && cloneSpriteTrigger = 1) {
		cloneSpriteTimer += 1;
	}
	if ((cloneInst.y <= yPrevious + 2) && (cloneInst.y >= yPrevious - 2)) {
		cloneSpriteTrigger = 0;
		cloneSpriteTimer = 0;
	}

yPrevious = cloneInst.y;
}


if (instance_exists(mooredShipInst)) {
		mooredShipInst.speed = -.7 * bgSpeedVar;
		if (!point_in_rectangle( mooredShipInst.x + sprite_get_width(mooredShipInst.sprite_index), mooredShipInst.y, x1, y1, x2, y2)) { 
			instance_destroy(mooredShipInst); 
		}
	}


if (timelinePoint = 0) {
	eventTimer += 1;
	if (!instance_exists(mooredShipInst)) {
		mooredShipInst = instance_create_layer(x1, y2, "BG_Objects_Front", obj_horiShmup_mooredShip);
	}
	if (!instance_exists(cloneInst)) {
		cloneInst = instance_create_layer(-300, centerY, "Instances", obj_horiShmupClone);
	}
	
	
	if initialTimer >= 200 {
		mooredShipInst.speed = -.5 * bgSpeedVar;
	
		timelinePoint = .5;
	
		if (cloneInst) {
			xTimer += .002;
			var tempXTimer = 700 *  xTimer;
			cloneInst.y = 500 + (100 * dsin( tempXTimer ));
		}
	}
	if (initialTimer < 300) {
		initialTimer += 1;
	}
}



if (timelinePoint = .5) {	
	eventTimer += 1;
	if (initialTimer < 400) {
		initialTimer += 1;
	}
	
	if (initialTimer = 280 && !instance_exists(shipFlash)) {
		shipFlash = instance_create_layer(mooredShipInst.x,mooredShipInst.y,"BG_Objects_Rear",obj_horiShmup_mooredFlash, 
		{	
			image_speed:3
		});
		shipFlash.speed = -.5 * bgSpeedVar;
	}
	
	
	if (instance_exists(shipFlash)) {
		if (shipFlash.image_index > (shipFlash.image_number - 1)) {
			instance_destroy(shipFlash);
		}
	}
	
	if (cloneInst) {
		xTimer += .002;
		var tempXTimer = 700 *  xTimer;
		cloneInst.y = 500 + (100 * dsin( tempXTimer ));
	}
	
	if (cloneInst.x < 100) {
	cloneInst.direction = 0;
	
	cloneInst.speed = 5;
	}
	
	if (cloneInst.speed < 6) {
		cloneShipSpeedVar += .01;
		cloneInst.speed = cloneInst.speed + (sqr(cloneShipSpeedVar) * .1);
	} else {
	cloneInst.speed = 6;
	}
	
	if (bgSpeedVar < 250) {
		bgSpeedVar *= 1.025;
	} else {
		bgSpeedVar = 250;
	}
	
	if (cloneInst.x >= 800) {
		cloneShipSpeedVar = 0;
		initialTimer = 0;
		timelinePoint = 1;
	}
	
}



if (timelinePoint = 1) {
	eventTimer += 1;
	if (cloneInst) {
		xTimer += .002;
		var tempXTimer = 700 *  xTimer;
		cloneInst.y = 500 + (100 * dsin( tempXTimer ));
	}
	
	//slow to a stop
	
	if (cloneInst.speed > 0.2 ) {
		cloneShipSpeedVar += .01;
		cloneInst.speed = cloneInst.speed + (-sqr(cloneShipSpeedVar) * .1);
	} else {
	timelinePoint = 1.15;
	cloneInst.speed = 0;
	cloneShipSpeedVar = 0;
	}
	
	if (bgSpeedVar < 250) {
		bgSpeedVar *= 1.05;
	} else {
		bgSpeedVar = 250;
	}
	
}

if (timelinePoint = 1.15) {
	eventTimer += 1;
	if (cloneInst) {
		xTimer += .002;
		var tempXTimer = 700 *  xTimer
		cloneInst.y = 500 + (100 * dsin( tempXTimer ));
	}
	
	//move backgrounds
	if (stillCloneTimer < 100) {
		stillCloneTimer += 1;
	}
	
	if (stillCloneTimer >= 100) {
		if (cloneInst.speed > -4 ) {
			cloneShipSpeedVar += .01;
			cloneInst.speed = cloneInst.speed + (-sqr(cloneShipSpeedVar) * .1);
		} else {
		timelinePoint = 1.25;
		stillCloneTimer = 0;
		cloneShipSpeedVar = 0;
		}
	
	}
	
	if (bgSpeedVar < 250) {
		bgSpeedVar *= 1.05;
	} else {
		bgSpeedVar = 250;
	}
	
}

if (timelinePoint = 1.25) {
	eventTimer += 1;
	if (cloneInst) {
		xTimer += .001;
		var tempXTimer = 700 *  xTimer;
		cloneInst.y = 500 + (100 * dsin( tempXTimer ));
	}
	
	if (cloneInst.x <= 1000) {
		
		
		if (bgSpeedVar > 10) {
			bgSpeedVar *= .979;
		} else {
			bgSpeedVar = 10;
		}
		
		
		if (cloneInst.speed <= 0 ) {
			cloneShipSpeedVar += .005;
			cloneInst.speed = cloneInst.speed + (sqr(cloneShipSpeedVar) * .1);
		} else {
			cloneInst.speed = 0;
			cloneShipSpeedVar = 0;
			timelinePoint = 2;
		}
	}
	
	
}

if (timelinePoint = 2) {
	eventTimer += 1;
	if (bgSpeedVar > 10) {
			bgSpeedVar *= .979;
		} else {
			bgSpeedVar = 10;
		}
		
	if (instance_exists(cloneInst)) {
	var cloneXCoordinate = cloneInst.x;
	var cloneYCoordinate = cloneInst.y;

	instance_destroy(cloneInst);
	instance_create_layer(cloneXCoordinate, cloneYCoordinate, "Instances", obj_horiShmup_player);
	}
	
}


//create scrap
if (eventTimer = scrapFrequency) {
	if (scrapFrequency < 400) {
		tempVar_a = 3 + irandom(5);
		tempVar_b = tempVar_b + (tempVar_a * 90);
		if (tempVar_b > camera_get_view_height(view_camera[0])) {
			tempVar_b = tempVar_b - camera_get_view_height(view_camera[0]);
		}
		instance_create_layer(x2 + 100, y1 + tempVar_b, "BG_Objects_Front", obj_horiShmup_scrap);
		scrapFrequency += 50;
	}
	
	if (scrapFrequency >= 400 && scrapFrequency < 1000) {
		tempVar_a = 3 + irandom(5);
		tempVar_b = tempVar_b + (tempVar_a * 90);
		if (tempVar_b > camera_get_view_height(view_camera[0])) {
			tempVar_b = tempVar_b - camera_get_view_height(view_camera[0]);
		}
		instance_create_layer(x2 + 100, y1 + tempVar_b, "BG_Objects_Front", obj_horiShmup_scrap);
		scrapFrequency += 25;
	}
	
	if (scrapFrequency >= 1000 && scrapFrequency < 1300) {
		tempVar_a = 3 + irandom(5);
		tempVar_b = tempVar_b + (tempVar_a * 90);
		if (tempVar_b > camera_get_view_height(view_camera[0])) {
			tempVar_b = tempVar_b - camera_get_view_height(view_camera[0]);
		}
		instance_create_layer(x2 + 100, y1 + tempVar_b, "BG_Objects_Rear", obj_horiShmup_scrap);
		scrapFrequency += 90;
	}

}

//generate scrap with right click

if (mouse_check_button_pressed(mb_right)) {
	instance_create_layer(mouse_x, mouse_y, "BG_Objects_Rear", obj_horiShmup_scrap);
}


//unique wreckage
if (eventTimer = 830) {
	wreckedShipsInst = instance_create_layer(x2 + 1000, y2 + 100, "BG_Objects_Rear", obj_horiShmup_wreckedShips, {
		image_index:0		
	});
}

if (eventTimer = 900) {
	wreckedShipsInst = instance_create_layer(x2 + 1200, centerY+100, "BG_Objects_Rear", obj_horiShmup_wreckedShips, {
		image_index:1		
	});
}

if (eventTimer = 1400) {
	wreckedShipsInst = instance_create_layer(x2 + 1200, centerY+700, "BG_Objects_Rear", obj_horiShmup_wreckedShips, {
		image_index:2		
	});
}

//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////// Enemy Spawns
//////////////////////////////////////////////////////////////////////////////////////


if (eventTimer = 1100) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY-300, "Instances", obj_horiShmup_enemyGlider);
}
if (eventTimer = 1200) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY+200, "Instances", obj_horiShmup_enemyGlider);
}
if (eventTimer = 1250) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY-500, "Instances", obj_horiShmup_enemyGlider);
}




if (eventTimer = 1400) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 200, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:0,
		direction:180
		
	});
}
if (eventTimer = 1412) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 200, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:0,
		direction:180
	});
}
if (eventTimer = 1424) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 200, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:0,
		direction:180
	});
}
if (eventTimer = 1436) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 200, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:0,
		direction:180
	});
}
if (eventTimer = 1448) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 200, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:1,
		direction:180
	});
}




if (eventTimer = 1590) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY - 160, "Instances", obj_horiShmup_enemyDivePlane, {
		divePlaneType:1
	});
}
if (eventTimer = 1610) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY + 160, "Instances", obj_horiShmup_enemyDivePlane, {
		divePlaneType:-1
	});
}
if (eventTimer = 1640) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY - 160, "Instances", obj_horiShmup_enemyDivePlane, {
		divePlaneType:1
	});
}




if (eventTimer = 1760) {
	wreckedShipsInst = instance_create_layer(x2 - 400, y1 - 100, "Instances", obj_horiShmup_enemyWheelGun);
}
if (eventTimer = 1760) {
	wreckedShipsInst = instance_create_layer(x2 - 400, y2, "Instances", obj_horiShmup_enemyWheelGun);
}




if (eventTimer = 2100) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 200, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}
if (eventTimer = 2100) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 500, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}
if (eventTimer = 2100) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 800, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}
if (eventTimer = 2140) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 50, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}
if (eventTimer = 2140) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 350, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}
if (eventTimer = 2140) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 650, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}
if (eventTimer = 2140) {
	wreckedShipsInst = instance_create_layer(x2 + 100, y1 + 950, "Instances", obj_horiShmup_enemyRocket, {
		direction:180
	});
}




if (eventTimer = 2200) {
	wreckedShipsInst = instance_create_layer(x2 + 100, 120, "Instances", obj_horiShmup_enemyGreenRanger, {
		enemyType:0,
		enemyDir:1
	});
}

if (eventTimer = 2290) {
	wreckedShipsInst = instance_create_layer(x2 + 100, 840, "Instances", obj_horiShmup_enemyGreenRanger, {
		enemyType:0,
		enemyDir:-1
	});
}




if (eventTimer = 2380) {
	wreckedShipsInst = instance_create_layer(x2 + 100, 840, "Instances", obj_horiShmup_enemyBlueRanger, {
		enemyType:0
	});
}



if (eventTimer = 2880) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY, "Instances", obj_horiShmup_enemyPinkRanger, {
		enemyType : 0
	});
}



if (eventTimer = 3050) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY+150, "Instances", obj_horiShmup_enemyBlueRanger, {
		enemyType:1
	});
}

if (eventTimer = 3050) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY-100, "Instances", obj_horiShmup_enemyBlueRanger, {
		enemyType:1
	});
}

if (eventTimer = 3050) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY-350, "Instances", obj_horiShmup_enemyBlueRanger, {
		enemyType:1
	});
}

if (eventTimer = 3050) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY-600, "Instances", obj_horiShmup_enemyBlueRanger, {
		enemyType:1
	});
}

if (eventTimer = 3250) {
	wreckedShipsInst = instance_create_layer(x2 + 100, centerY, "Instances", obj_horiShmup_enemyGreenRanger, {
		enemyType:1
	});
}





if (eventTimer = 3850) {
	wreckedShipsInst = instance_create_layer(centerX, y1 - 70, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:2,
		direction:0
	});
}

if (eventTimer = 3850) {
	wreckedShipsInst = instance_create_layer(centerX + 70, y1 - 70, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:2,
		direction:0
	});
}

if (eventTimer = 3850) {
	wreckedShipsInst = instance_create_layer(centerX + 140, y1 - 70, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:2,
		direction:0
	});
}

if (eventTimer = 3870) {
	wreckedShipsInst = instance_create_layer(centerX, y1 - 70, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:2,
		direction:0
	});
}

if (eventTimer = 3870) {
	wreckedShipsInst = instance_create_layer(centerX + 70, y1 - 70, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:2,
		direction:0
	});
}

if (eventTimer = 3870) {
	wreckedShipsInst = instance_create_layer(centerX + 140, y1 - 70, "Instances", obj_horiShmup_enemySeekerPlane, {
		enemyType:3,
		direction:0
	});
}







} else {
	layer_hspeed(lay_id, 0);

	layer_hspeed(lay1_id, 0);

	layer_hspeed(lay2_id, 0);
}