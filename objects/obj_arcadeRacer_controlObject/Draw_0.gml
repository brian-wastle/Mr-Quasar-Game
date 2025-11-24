var i, p;
var _x = 0;
var _dx = 0;
var maxy = height;


if (startPosTest >= 0) {
	camH = camY + segments[startPosTest, sg.world_y];
} else {
	camH = 1300;
}
if currentPos >= 0 {
	for(var n = currentPos; n < currentPos + segments[startPosTest, sg.draw_distance]; n+=1) {
	    i = modulo(n, trackSize);
	
	    camZ = 0;
    
	    if (n-650 >= trackSize) {
	        camZ = trackSize * segmentLength;
	    }
		if (flyState = 0) {
			projectGround(segments, i, playerX - _x , camH, potential - camZ); //project road
			projectWater(segments, i, playerX - _x , camH, potential - camZ); //project road
			projectObject(segments, n, playerX - _x , camH, potential - camZ); //project objects
			projectObjectRotated(segments, n, playerX - _x , camH, potential - camZ); //project objects
			projectPolygon(segments, n, playerX - _x , camH, potential - camZ); //project polygons
			projectPolygonCeiling(segments, n, playerX - _x , camH, potential - camZ); //project polygons
			projectVehicle(segments, n, playerX - _x , camH, potential - camZ); //project objects
			projectGlass(segments, n, playerX - _x , camH, potential - camZ); //project polygons
			projectScreen(segments, n, playerX - _x , camH, potential - camZ); //project polygons
			projectScreenCeiling(segments, n, playerX - _x , camH, potential - camZ); //project polygons
			projectSmokeL(segments, n, playerX - _x , camH, potential - camZ); //project objects
			projectSmokeR(segments, n, playerX - _x , camH, potential - camZ); //project objects
		} else if flyState = 1 {
			projectGround(segments, i, _x , camH, potential - camZ); //project road
			projectWater(segments, i, _x , camH, potential - camZ); //project road
			projectObject(segments, n, _x , camH, potential - camZ); //project objects
			projectPolygon(segments, n, _x , camH, potential - camZ); //project polygons
			projectPolygonCeiling(segments, n, _x , camH, potential - camZ); //project polygons
			projectVehicle(segments, n, _x , camH, potential - camZ); //project objects
			projectGlass(segments, n, _x , camH, potential - camZ); //project polygons
			projectScreen(segments, n, _x , camH, potential - camZ); //project polygons
			projectScreenCeiling(segments, n, _x , camH, potential - camZ); //project polygons
			projectSmokeL(segments, n, _x , camH, potential - camZ); //project objects
			projectSmokeR(segments, n, _x , camH, potential - camZ); //project objects
		}
	    
	
	    _x   += _dx;
	    _dx  += segments[i, sg.curve];   
	}


	for(var n = currentPos + segments[startPosTest, sg.draw_distance]; n >= currentPos; n-=1) {
	    i = modulo(n, trackSize);
	
	
	    p = modulo((n-1 ), trackSize);

		
		//draw landscape
		if (segments[p, sg.c_terrain] != 0) {
			drawPolygon(0, height - segments[p, sg.screen_y], width, 0, height - segments[i, sg.screen_y], width, segments[i, sg.c_terrain])
		}
		
		if (startPosTest < 8550 || startPosTest > 9900) {
			if (array_length(segments[p, sg.terrain2]) != 0) {
			for (var j = 0; j < array_length(segments[i, sg.terrain2]); ++j) {
				drawPolygon(0, height - segments[p, sg.terrain2][j].yScreen, segments[p, sg.terrain2][j].xScreen1, 0, height - segments[i, sg.terrain2][j].yScreen, segments[i, sg.terrain2][j].xScreen1, segments[i, sg.terrain2][j].hex)
				drawPolygon(width, height - segments[p, sg.terrain2][j].yScreen, width - segments[p, sg.terrain2][j].xScreen2, width, height - segments[i, sg.terrain2][j].yScreen, width - segments[i, sg.terrain2][j].xScreen2, segments[i, sg.terrain2][j].hex)
			}
		}
		}
		
		
	    drawPolygon(segments[p, sg.screen_x], height - segments[p, sg.screen_y],segments[p, sg.screen_w]*1.1, segments[i,sg.screen_x] , height - segments[i, sg.screen_y],segments[i, sg.screen_w]*1.1,segments[i, sg.c_rumble]);
		
	    drawPolygon(segments[p, sg.screen_x], height - segments[p, sg.screen_y],segments[p, sg.screen_w], segments[i,sg.screen_x],height - segments[i, sg.screen_y],segments[i, sg.screen_w],segments[i, sg.c_road]);
	    
		drawPolygon(segments[p, sg.screen_x] - segments[p, sg.screen_w] * .3, height - segments[p, sg.screen_y],segments[p, sg.screen_w]*0.015, segments[i,sg.screen_x]  - segments[p, sg.screen_w] * .3, height - segments[i, sg.screen_y],segments[i, sg.screen_w]*0.015,segments[i, sg.c_strip]);
		drawPolygon(segments[p, sg.screen_x] + segments[p, sg.screen_w] * .3 , height - segments[p, sg.screen_y],segments[p, sg.screen_w]*0.015, segments[i,sg.screen_x] + segments[p, sg.screen_w] * .3, height - segments[i, sg.screen_y],segments[i, sg.screen_w]*0.015,segments[i, sg.c_strip]);
	
	
		//draw obstacles
		if (array_length(segments[p, sg.obstacle]) != 0) {
			for (var j = 0; j < array_length(segments[p, sg.obstacle]); j += 1) {
			    draw_sprite_ext(segments[p, sg.obstacle][j].sprite, segments[p, sg.obstacle][j].imageIndex, segments[p, sg.obstacle][j].xScreen,segments[p, sg.obstacle][j].yScreen,segments[p, sg.obstacle][j].wScreen,segments[p, sg.obstacle][j].wScreen,0,c_white,1);
				if (segments[p, sg.obstacle][j].sprite = spr_ArcadeRacer_Town1Harvester && segments[p, sg.obstacle][j].xCoordinate < -2400) {
					segments[p, sg.obstacle][j].xCoordinate += 20;
				}
				if (segments[p, sg.obstacle][j].sprite = spr_ArcadeRacer_Town1Harvester2 && segments[p, sg.obstacle][j].xCoordinate > 2400) {
					segments[p, sg.obstacle][j].xCoordinate -= 20;
				}
			}
		}
		
		//rotated objects
		if (array_length(segments[p, sg.rotated]) != 0) {
			for (var j = 0; j < array_length(segments[p, sg.rotated]); j += 1) {
			    draw_sprite_pos(segments[p, sg.rotated][j].sprite, 0, segments[p, sg.rotated][j].xScreen2, segments[p, sg.rotated][j].yScreen2, segments[p, sg.rotated][j].xScreen3, segments[p, sg.rotated][j].yScreen3, segments[p, sg.rotated][j].xScreen4, segments[p, sg.rotated][j].yScreen4, segments[p, sg.rotated][j].xScreen1, segments[p, sg.rotated][j].yScreen1, 1);
			}
		}
		
		//draw polygons & glass
		if (array_length(segments[p, sg.polygon]) != 0) {
			for (var k = 0; k < array_length(segments[p, sg.polygon]); k += 1) {
			    draw_sprite_pos(segments[p, sg.polygon][k].sprite, 0, segments[p, sg.polygon][k].xScreen1, segments[p, sg.polygon][k].yScreen1, segments[p, sg.polygon][k].xScreen2, segments[p, sg.polygon][k].yScreen2, segments[p, sg.polygon][k].xScreen3, segments[p, sg.polygon][k].yScreen3, segments[p, sg.polygon][k].xScreen4, segments[p, sg.polygon][k].yScreen4, segments[p, sg.polygon][k].opacity);
			}
		}
		
		if (array_length(segments[p, sg.glass]) != 0) {
			for (var k = 0; k < array_length(segments[p, sg.glass]); k += 1) {
			    draw_sprite_pos(segments[p, sg.glass][k].sprite, 0, segments[p, sg.glass][k].xScreen1, segments[p, sg.glass][k].yScreen1, segments[p, sg.glass][k].xScreen2, segments[p, sg.glass][k].yScreen2, segments[p, sg.glass][k].xScreen3, segments[p, sg.glass][k].yScreen3, segments[p, sg.glass][k].xScreen4, segments[p, sg.glass][k].yScreen4, segments[p, sg.glass][k].opacity);
			}
		}
		
		if (array_length(segments[p, sg.roof]) != 0) {
			for (var k = 0; k < array_length(segments[p, sg.roof]); k += 1) {
			    draw_sprite_pos(segments[p, sg.roof][k].sprite, 0, segments[p, sg.roof][k].xScreen1, segments[p, sg.roof][k].yScreen1, segments[p, sg.roof][k].xScreen2, segments[p, sg.roof][k].yScreen2, segments[p, sg.roof][k].xScreen3, segments[p, sg.roof][k].yScreen3, segments[p, sg.roof][k].xScreen4, segments[p, sg.roof][k].yScreen4, segments[p, sg.roof][k].opacity);
			}
		}
		
		if (array_length(segments[p, sg.screen]) != 0) {
			for (var k = 0; k < array_length(segments[p, sg.screen]); k += 1) {
			    draw_sprite_pos(segments[p, sg.screen][k].sprite, 0, segments[p, sg.screen][k].xScreen1, segments[p, sg.screen][k].yScreen1, segments[p, sg.screen][k].xScreen2, segments[p, sg.screen][k].yScreen2, segments[p, sg.screen][k].xScreen3, segments[p, sg.screen][k].yScreen3, segments[p, sg.screen][k].xScreen4, segments[p, sg.screen][k].yScreen4, segments[p, sg.screen][k].opacity);
			}
		}
		
		if (array_length(segments[p, sg.screen_ceiling]) != 0) {
			for (var k = 0; k < array_length(segments[p, sg.screen_ceiling]); k += 1) {
			    draw_sprite_pos(segments[p, sg.screen_ceiling][k].sprite, 0, segments[p, sg.screen_ceiling][k].xScreen1, segments[p, sg.screen_ceiling][k].yScreen1, segments[p, sg.screen_ceiling][k].xScreen2, segments[p, sg.screen_ceiling][k].yScreen2, segments[p, sg.screen_ceiling][k].xScreen3, segments[p, sg.screen_ceiling][k].yScreen3, segments[p, sg.screen_ceiling][k].xScreen4, segments[p, sg.screen_ceiling][k].yScreen4, segments[p, sg.screen_ceiling][k].opacity);
			}
		}
		
		//draw vehicles
		if (array_length(segments[p, sg.vehicle]) != 0) {
			for (var j = 0; j < array_length(segments[p, sg.vehicle]); j += 1) {
			    draw_sprite_ext(segments[p, sg.vehicle][j].sprite, 0, segments[p, sg.vehicle][j].xScreen,segments[p, sg.vehicle][j].yScreen,segments[p, sg.vehicle][j].wScreen,segments[p, sg.vehicle][j].wScreen,0,c_white,1);
			}
		}
		
	}
}

//set car sprites 

if (startPosTest >= 0) {
	if (deathState = 0) {
		if (abs(x_speed) > 0 && abs(x_speed) <= 25) {
			image_index = 0;
		}
		if (abs(x_speed) > 25 && abs(x_speed) <= 35) {
			image_index = 1;
		}
		if (abs(x_speed) > 35 && abs(x_speed) <= 80) {
			image_index = 2;
		}
		if (abs(x_speed) > 80 && abs(x_speed) <= 100) {
			image_index = 3;
		}
		if (sign(x_speed) < 0) {
			carMirror = 1;
		}
		if (sign(x_speed) >= 0) {
			carMirror = -1;
		}
		if myspeed > mySpeedPrevious {
			carSpriteTimer = myspeed/100;
		}
	
	//road elevation, road curve, cam tilt, cam rotate
		currentElevation = segments[startPosTest, sg.world_y];
		if startPosTest > segmentLength {
			futureElevation = segments[startPosTest - segmentLength, sg.world_y];
		}
		currentSegmentCurve = segments[startPosTest, sg.curve];
		elevationMod = (currentElevation - previousElevation)/500;
		if (currentElevation > futureElevation) {
			image_index += 4;
		}
	}
	
	
	if (flyState = 0) {
		draw_sprite_ext(sprite_index, image_index, width/2, playerY, carMirror,1,0, c_white,1 );
	}
	if (flyState = 1) {
		draw_sprite_ext(sprite_index, image_index, playerX, playerY, carMirror * .8, .8, 0, c_white,1 );
	}
	
	if (sprite_index = spr_ArcadeRacer_PlayerCarCrash && crashIndex < 9) {
		draw_sprite_ext(spr_ArcadeRacer_PlayerCarExplosion, crashIndex, width/2, 1000, carMirror,1,0, c_white,1 );
	}
	
	for(var n = currentPos + segments[startPosTest, sg.draw_distance]; n >= currentPos; n-=1) {
	    i = modulo(n, trackSize);
	
	
	    p = modulo((n-1 ), trackSize);
	
		//draw smoke
		if (array_length(segments[p, sg.smokeL]) != 0) {
			for (var j = 0; j < array_length(segments[p, sg.smokeL]); j += 1) {
			    draw_sprite_ext(segments[p, sg.smokeL][j].sprite, segments[p, sg.smokeL][j].imageIndex, segments[p, sg.smokeL][j].xScreen,segments[p, sg.smokeL][j].yScreen,segments[p, sg.smokeL][j].wScreen,segments[p, sg.smokeL][j].wScreen,0,c_white,.2);
			}
		}
		if (array_length(segments[p, sg.smokeR]) != 0) {
			for (var j = 0; j < array_length(segments[p, sg.smokeR]); j += 1) {
			    draw_sprite_ext(segments[p, sg.smokeR][j].sprite, segments[p, sg.smokeR][j].imageIndex, segments[p, sg.smokeR][j].xScreen,segments[p, sg.smokeR][j].yScreen,segments[p, sg.smokeR][j].wScreen,segments[p, sg.smokeR][j].wScreen,0,c_white,.2);
			}
		}
	}
	
	if (startPosTest < trackSize - 30 && flyState = 0) {
		camTilt = (segments[startPosTest + 5, sg.world_y] - segments[startPosTest + 6, sg.world_y]) * 1.7;
		camRotate = segments[startPosTest, sg.curve];
		if (segments[startPosTest , sg.curve] != 0) {
			playerX -= ((180 * currentSegmentCurve) * speedModX/2.26);
		}
	}
}


//debug
draw_text(100,100, startPosTest);
draw_text(100,200, x_speed);
draw_text(100,300, playerX);
draw_text(100,400, targetX);
draw_text(100,500, deathState);
//draw_text(100,600, deathState);
//draw_text(100,700, segments[9600, sg.vehicle][0].mix);
//draw_text(100,800,segments[9600, sg.vehicle][0].yScreen4);
//draw_text(100,900,segments[9600, sg.vehicle][0].yScreen4);


//
mySpeedPrevious = myspeed;
previousElevation = currentElevation;