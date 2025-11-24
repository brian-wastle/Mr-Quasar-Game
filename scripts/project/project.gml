
function projectGround(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	segment[@ index, sg.scale] = abs(cameraDepth / (segment[@ index, sg.world_z] - camZ));
	segment[@ index, sg.screen_x] = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] - camX)) * (width/2 + camRotate * 40);
	segment[@ index, sg.screen_y] =  height - ((1 - segment[@ index, sg.scale] * (segment[@ index, sg.world_y]  - camY)) * (height/4 - camTilt) + 200);
	segment[@ index, sg.screen_w] = segment[@ index, sg.scale] * segment[@ index, sg.roadWidth] * width/2;

}

function projectWater(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	for (var i = 0; i < array_length(segment[@ index, sg.terrain2]); i += 1) {
		segment[@ index, sg.scale] = abs(cameraDepth / (segment[@ index, sg.world_z] - camZ));
		segment[@ index, sg.terrain2][i].xScreen1 = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] + segment[@ index, sg.terrain2][i].xCoordinate - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.terrain2][i].xScreen2 = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] - segment[@ index, sg.terrain2][i].xCoordinate - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.terrain2][i].yScreen =  height - ((1 - segment[@ index, sg.scale] * (segment[@ index, sg.terrain2][i].yCoordinate  - camY)) * (height/4 - camTilt) + 200);
		segment[@ index, sg.terrain2][i].wScreen = segment[@ index, sg.scale] * (segment[@ index, sg.roadWidth] + 300) * width/2;
	}

}


function projectObject(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	for (i = 0; i < array_length(segment[@ index, sg.obstacle]); i += 1) {
		segment[@ index, sg.scale] = abs(cameraDepth / (segment[@ index, sg.obstacle][i].zCoordinate - camZ));
		segment[@ index, sg.obstacle][i].xScreen = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] + segment[@ index, sg.obstacle][i].xCoordinate - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.obstacle][i].yScreen = (1 - segment[@ index, sg.scale] * (segment[@ index, sg.world_y] + segment[@ index, sg.obstacle][i].yCoordinate - camY)) * (height/4 - camTilt) + 200;
		segment[@ index, sg.obstacle][i].wScreen = segment[@ index, sg.scale] * width;
	}
}

function projectObjectRotated(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	for (i = 0; i < array_length(segment[@ index, sg.rotated]); i += 1) {
		var length = segment[@ index, sg.rotated][i].objLength;
		var zCoord2 = segment[@ index, sg.rotated][i].zCoordinate1;
		var zCoord1 = segment[@ index, sg.rotated][i].zCoordinate2;
	
		segment[@ index, sg.rotated][i].scale1 = abs(cameraDepth / (zCoord1 - camZ));
		segment[@ index, sg.rotated][i].scale2 = abs(cameraDepth / (zCoord2 - camZ));
		
		segment[@ index, sg.rotated][i].xScreen1 = (1 + segment[@ index, sg.rotated][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.rotated][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.rotated][i].yScreen1 = (1 - segment[@ index, sg.rotated][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.rotated][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.rotated][i].xScreen2 = (1 + segment[@ index, sg.rotated][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.rotated][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.rotated][i].yScreen2 = (1 - segment[@ index, sg.rotated][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.rotated][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.rotated][i].xScreen3 = (1 + segment[@ index, sg.rotated][i].scale2 * (segment[@ index + length, sg.world_x] + segment[@ index, sg.rotated][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40) ;
		segment[@ index, sg.rotated][i].yScreen3 = (1 - segment[@ index, sg.rotated][i].scale2 * (segment[@ index + length, sg.world_y] + segment[@ index, sg.rotated][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.rotated][i].xScreen4 = (1 + segment[@ index, sg.rotated][i].scale2 * (segment[@ index + length, sg.world_x] + segment[@ index, sg.rotated][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.rotated][i].yScreen4 = (1 - segment[@ index, sg.rotated][i].scale2 * (segment[@ index + length, sg.world_y] + segment[@ index, sg.rotated][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
	}
}

function projectPolygon(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;
	
	

	for (i = 0; i < array_length(segment[@ index, sg.polygon]); i += 1) {
		
		var zCoord2 = segment[@ index, sg.polygon][i].zCoordinate1;
		var zCoord1 = zCoord2 - segmentLength;
	
		segment[@ index, sg.polygon][i].scale1 = abs(cameraDepth / (zCoord1 - camZ));
		segment[@ index, sg.polygon][i].scale2 = abs(cameraDepth / (zCoord2 - camZ));
		
		segment[@ index, sg.polygon][i].xScreen1 = (1 + segment[@ index, sg.polygon][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.polygon][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.polygon][i].yScreen1 = (1 - segment[@ index, sg.polygon][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.polygon][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.polygon][i].xScreen2 = (1 + segment[@ index, sg.polygon][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.polygon][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.polygon][i].yScreen2 = (1 - segment[@ index, sg.polygon][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.polygon][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.polygon][i].xScreen3 = (1 + segment[@ index, sg.polygon][i].scale2 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.polygon][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40) ;
		segment[@ index, sg.polygon][i].yScreen3 = (1 - segment[@ index, sg.polygon][i].scale2 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.polygon][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.polygon][i].xScreen4 = (1 + segment[@ index, sg.polygon][i].scale2 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.polygon][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.polygon][i].yScreen4 = (1 - segment[@ index, sg.polygon][i].scale2 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.polygon][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		if ( segment[@ index, sg.polygon][i].xCoordinate1 > 0) {
			segment[@ index, sg.polygon][i].xScreen1 += (4 + segment[@ index, sg.polygon][i].scale1 * segment[@ index, sg.curve]);
			segment[@ index, sg.polygon][i].xScreen2 += (4 + segment[@ index, sg.polygon][i].scale1 * segment[@ index, sg.curve]);
			segment[@ index, sg.polygon][i].xScreen3 -= (4 + segment[@ index, sg.polygon][i].scale2 * segment[@ index, sg.curve]);
			segment[@ index, sg.polygon][i].xScreen4 -= (4 + segment[@ index, sg.polygon][i].scale2 * segment[@ index, sg.curve]);
		} else 
		if ( segment[@ index, sg.polygon][i].xCoordinate1 < 0) {
			segment[@ index, sg.polygon][i].xScreen1 -= (4 + segment[@ index, sg.polygon][i].scale1 * segment[@ index, sg.curve]);
			segment[@ index, sg.polygon][i].xScreen2 -= (4 + segment[@ index, sg.polygon][i].scale1 * segment[@ index, sg.curve]);
			segment[@ index, sg.polygon][i].xScreen3 += (4 + segment[@ index, sg.polygon][i].scale2 * segment[@ index, sg.curve]);
			segment[@ index, sg.polygon][i].xScreen4 += (4 + segment[@ index, sg.polygon][i].scale2 * segment[@ index, sg.curve]);
		}
	}
}

function projectPolygonCeiling(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;
	
	

	for (i = 0; i < array_length(segment[@ index, sg.roof]); i += 1) {
		
		var zCoord2 = segment[@ index, sg.roof][i].zCoordinate1;
		var zCoord1 = zCoord2 - segmentLength;
	
		segment[@ index, sg.roof][i].scale1 = abs(cameraDepth / (zCoord1 - camZ));
		segment[@ index, sg.roof][i].scale2 = abs(cameraDepth / (zCoord2 - camZ));
		
		segment[@ index, sg.roof][i].xScreen1 = (1 + segment[@ index, sg.roof][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.roof][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.roof][i].yScreen1 = (1 - segment[@ index, sg.roof][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.roof][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.roof][i].xScreen2 = (1 + segment[@ index, sg.roof][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.roof][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.roof][i].yScreen2 = (1 - segment[@ index, sg.roof][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.roof][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.roof][i].xScreen3 = (1 + segment[@ index, sg.roof][i].scale2 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.roof][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.roof][i].yScreen3 = (1 - segment[@ index, sg.roof][i].scale2 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.roof][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.roof][i].xScreen4 = (1 + segment[@ index, sg.roof][i].scale2 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.roof][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.roof][i].yScreen4 = (1 - segment[@ index, sg.roof][i].scale2 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.roof][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
	}
}


function projectVehicle(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	for (i = 0; i < array_length(segment[@ index, sg.vehicle]); i += 1) {
		segment[@ index, sg.scale] = abs(cameraDepth / (segment[@ index, sg.vehicle][i].zCoordinate - camZ));
		segment[@ index, sg.vehicle][i].xScreen = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] + segment[@ index, sg.vehicle][i].xCoordinate - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.vehicle][i].yScreen = (1 - segment[@ index, sg.scale] * (segment[@ index, sg.world_y] + segment[@ index, sg.vehicle][i].yCoordinate - camY)) * (height/4 - camTilt) + 200;
		segment[@ index, sg.vehicle][i].wScreen = segment[@ index, sg.scale] * width;
		segment[@ index, sg.vehicle][i].zCoordinate += segment[@ index, sg.vehicle][i].velocity;
		if (segment[@ index, sg.vehicle][i].zCoordinate > (index * segmentLength + segmentLength)) {
			array_push(segments[index+1, sg.vehicle], segments[index, sg.vehicle][i]);
			array_delete(segments[index, sg.vehicle], i, 1);
			i -= 1;
		}
	}
}


function projectGlass(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;
	
	

	for (i = 0; i < array_length(segment[@ index, sg.glass]); i += 1) {
		
		var zCoord2 = segment[@ index, sg.glass][i].zCoordinate1;
		var zCoord1 = zCoord2 - segmentLength;
	
		segment[@ index, sg.glass][i].scale1 = abs(cameraDepth / (zCoord1 - camZ));
		segment[@ index, sg.glass][i].scale2 = abs(cameraDepth / (zCoord2 - camZ));
		
		segment[@ index, sg.glass][i].xScreen1 = (1 + segment[@ index, sg.glass][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.glass][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.glass][i].yScreen1 = (1 - segment[@ index, sg.glass][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.glass][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.glass][i].xScreen2 = (1 + segment[@ index, sg.glass][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.glass][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.glass][i].yScreen2 = (1 - segment[@ index, sg.glass][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.glass][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.glass][i].xScreen3 = (1 + segment[@ index, sg.glass][i].scale2 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.glass][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40) ;
		segment[@ index, sg.glass][i].yScreen3 = (1 - segment[@ index, sg.glass][i].scale2 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.glass][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.glass][i].xScreen4 = (1 + segment[@ index, sg.glass][i].scale2 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.glass][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.glass][i].yScreen4 = (1 - segment[@ index, sg.glass][i].scale2 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.glass][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
	}
}


function projectScreen(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;
	
	

	for (i = 0; i < array_length(segment[@ index, sg.screen]); i += 1) {
		
		var zCoord1 = segment[@ index, sg.screen][i].zCoordinate1;
	
		segment[@ index, sg.screen][i].scale1 = abs(cameraDepth / (zCoord1 - camZ));
		
		segment[@ index, sg.screen][i].xScreen1 = (1 + segment[@ index, sg.screen][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.screen][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen][i].yScreen1 = (1 - segment[@ index, sg.screen][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.screen][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.screen][i].xScreen2 = (1 + segment[@ index, sg.screen][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.screen][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen][i].yScreen2 = (1 - segment[@ index, sg.screen][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.screen][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.screen][i].xScreen3 = (1 + segment[@ index, sg.screen][i].scale1 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.screen][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40) ;
		segment[@ index, sg.screen][i].yScreen3 = (1 - segment[@ index, sg.screen][i].scale1 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.screen][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.screen][i].xScreen4 = (1 + segment[@ index, sg.screen][i].scale1 * (segment[@ index + 1, sg.world_x] + segment[@ index, sg.screen][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen][i].yScreen4 = (1 - segment[@ index, sg.screen][i].scale1 * (segment[@ index + 1, sg.world_y] + segment[@ index, sg.screen][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;		
	}
	
	
}

function projectScreenCeiling(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;
	
	

	for (i = 0; i < array_length(segment[@ index, sg.screen_ceiling]); i += 1) {
		
		var zCoord1 = segment[@ index, sg.screen_ceiling][i].zCoordinate1;
	
		segment[@ index, sg.screen_ceiling][i].scale1 = abs(cameraDepth / (zCoord1 - camZ));
		
		segment[@ index, sg.screen_ceiling][i].xScreen1 = (1 + segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.screen_ceiling][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen_ceiling][i].yScreen1 = (1 - segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.screen_ceiling][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.screen_ceiling][i].xScreen2 = (1 + segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.screen_ceiling][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen_ceiling][i].yScreen2 = (1 - segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.screen_ceiling][i].yCoordinate1 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.screen_ceiling][i].xScreen3 = (1 + segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.screen_ceiling][i].xCoordinate2 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen_ceiling][i].yScreen3 = (1 - segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.screen_ceiling][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
		segment[@ index, sg.screen_ceiling][i].xScreen4 = (1 + segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_x] + segment[@ index, sg.screen_ceiling][i].xCoordinate1 - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.screen_ceiling][i].yScreen4 = (1 - segment[@ index, sg.screen_ceiling][i].scale1 * (segment[@ index, sg.world_y] + segment[@ index, sg.screen_ceiling][i].yCoordinate2 - camY)) * (height/4 - camTilt) + 200;
		
	}
}

function projectSmokeL(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	for (i = 0; i < array_length(segment[@ index, sg.smokeL]); i += 1) {
		segment[@ index, sg.scale] = abs(cameraDepth / (segment[@ index, sg.smokeL][i].zCoordinate - camZ));
		segment[@ index, sg.smokeL][i].xScreen = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] + segment[@ index, sg.smokeL][i].xCoordinate - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.smokeL][i].yScreen = (1 - segment[@ index, sg.scale] * (segment[@ index, sg.world_y] + segment[@ index, sg.smokeL][i].yCoordinate - camY)) * (height/4 - camTilt) + 200;
		segment[@ index, sg.smokeL][i].wScreen = segment[@ index, sg.scale] * width;
	}
}

function projectSmokeR(argument0, argument1, argument2, argument3, argument4){
	var segment = argument0;
	var index  = argument1;
	var camX = argument2;
	var camY = argument3;
	var camZ = argument4;

	for (i = 0; i < array_length(segment[@ index, sg.smokeR]); i += 1) {
		segment[@ index, sg.scale] = abs(cameraDepth / (segment[@ index, sg.smokeR][i].zCoordinate - camZ));
		segment[@ index, sg.smokeR][i].xScreen = (1 + segment[@ index, sg.scale] * (segment[@ index, sg.world_x] + segment[@ index, sg.smokeR][i].xCoordinate - camX)) * (width/2 + camRotate * 40);
		segment[@ index, sg.smokeR][i].yScreen = (1 - segment[@ index, sg.scale] * (segment[@ index, sg.world_y] + segment[@ index, sg.smokeR][i].yCoordinate - camY)) * (height/4 - camTilt) + 200;
		segment[@ index, sg.smokeR][i].wScreen = segment[@ index, sg.scale] * width;
	}
}