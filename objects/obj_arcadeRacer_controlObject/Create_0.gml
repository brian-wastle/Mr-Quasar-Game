enum sg
{
    world_x, world_y, world_z,
    screen_x, screen_y, screen_w,
    scale, scale2, curve, rotation,
    c_terrain, c_road, c_rumble, c_strip,
	obstacle, polygon, glass, vehicle, roof, 
	smokeL, smokeR, terrain2, rotated, 
	roadWidth, screen, screen_ceiling, draw_distance
}

image_speed = 0;
step = 1/60; //fps
width = view_wport[0]; // width of viewport
height = view_hport[0]; //height of viewport
segmentLength = 100; // length of each individual road panel that is rendered from world onto screen
fieldOfView = 80; // angle of view on screen
camZ = 0; // pan camera forward or backward parallel to car's direction
camY = 1100; //camera's y position for curves
camH = 0; //camera height perpendicular to car's direction
cameraDepth = 1 / tan((fieldOfView / 4) * pi /180);
currentPos = 0; //compare current track position
startPosTest = 0; // current track position
position = 0; //position on track
potential = 0; //position on track
playerX = 0; //player's offset position (from center) on x-axis left or right
playerY = 980; //player's position in space vertically
x_speed = 0; //current speed along x-axis
y_speed = 0; //current speed along y-axis
speedModX = 0; //prevents car from moving on x-axis while stopped or slowed
speedModY = 0; //prevents car from moving on y-axis while stopped or slowed
currentSegmentCurve = 0; //keeps track of curvature of current segment
currentElevation = 0; // keeps track of current elevation
futureElevation = 0; //elevation slightly ahead of current position
previousElevation = 0; //tracks previous elevation to compare with current elevation for measuring traction
elevationMod = 0; //represents traction against road due to elevation change
camTilt = 0; // tilt of the camera on hills
camRotate = 0; // rotation of camera on curves
carSpriteTimer = 0; //keep track of current car sprite
carMirror = 0; //whether to mirror car sprite or not depending on direction of turn
vehicleSpeed = [[62,65,68],[62,65,68],[62,65,68]] // speed of other cars on the road, in order of lane right to left, arranged into child arrays by game difficulty
difficulty = 2;
sandCount = 0; //keep track of how long player has been driving on sand
smokeCount = 0; //timer to make clouds of sand while driving offroad
deathState = 0; // whether player is crashed or not, and cannot control the car
deathSide = 0; //side of track death occurred on
targetX = 0; //location for car to return after crash, center left or right depending on deathSide variable
crashIndex = 0; //keeps track of image_index for explosion sprite
flyState = 0; //whether player can fly yet or not
playerControl = 1; // whether player has control of their vehicle during cutscenes
///debug
testVar1 = 0;

myspeed = 0; // current speed
mySpeedPrevious = 0; //previous speed for change in speed
maxSpeed = segmentLength / step * 3;

accel = maxSpeed / 5;
braking = -maxSpeed / 5.5;
decel = -maxSpeed / 6;

trackSize = 33000;

var stripsize = 5;
var c = 0;
var stripstate = true;
var targetElevation = 0;
var elevation = 0;
var drawDistanceVar = 1200; //only needs to be changed during the tunnel sequence for underwater effect


for(var n = 0; n < trackSize; n += 1) {
    segments[n, sg.world_x] = 0;
    segments[n, sg.world_y] = height;
    segments[n, sg.world_z] = n * segmentLength;

    segments[n, sg.screen_x] = 0;
    segments[n, sg.screen_y] = 0;
    segments[n, sg.screen_w] = 0;
    segments[n, sg.scale] = 0;
	segments[n, sg.rotation] = 0;
    
    segments[n, sg.c_terrain] = #aa4531;
	segments[n, sg.terrain2] = [];
	segments[n, sg.roadWidth] = 600;
    segments[n, sg.c_rumble] = make_color_rgb(85,85,85);
    segments[n, sg.c_road] = make_color_rgb(107,107,107);
    segments[n, sg.c_strip] = make_color_rgb(187,187,187);
	
	segments[n, sg.obstacle] = [];//{sprite:0, spriteIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:0, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0};
	segments[n, sg.rotated] = [];
	segments[n, sg.polygon] = [];//{color:#hex, xCoordinate1:0, xCoordinate2:0, yCoordinate1:0, yCoordinate2:0, zCoordinate1:0, zCoordinate2:0, animationSpeed:0, xScreen1:0, xScreen2:0, yScreen1:0,  yScreen2:0, wScreen1:0, wScreen2:0};
	segments[n, sg.roof] = [];
	segments[n, sg.vehicle] = [];
	segments[n, sg.glass] = [];
	segments[n, sg.screen] = [];
	segments[n, sg.smokeL] = [];
	segments[n, sg.smokeR] = [];
	segments[n, sg.screen_ceiling] = [];
	segments[n, sg.draw_distance] = drawDistanceVar;
	
    if(c==stripsize) {
        stripstate = !stripstate;
        c = 0;
    }
    else {
     c++;
    }
    
    if(stripstate) {
        segments[n,sg.c_terrain] =  #61292b;
        segments[n,sg.c_rumble] = make_color_rgb(85,85,85);
        segments[n,sg.c_road] = make_color_rgb(107,107,107);
        segments[n,sg.c_strip] = make_color_rgb(107,107,107);
    }
    else {
        segments[n,sg.c_terrain] =  #632a2b;
        segments[n,sg.c_rumble] = make_color_rgb(187,187,187);
        segments[n,sg.c_road] = make_color_rgb(105,105,105);
        segments[n,sg.c_strip] = make_color_rgb(187,187,187);
    }
    
	if ((n < 3650) && (n % 100 = 0)) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Cactus, imageIndex:irandom(2), xCoordinate:(3000 + irandom(20000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Cactus, imageIndex:irandom(2), xCoordinate:(-3000 - irandom(20000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if ((n < 3650) && (n % 40 = 0)) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Shrubs, imageIndex:irandom(3), xCoordinate:(3000 + irandom(20000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Shrubs, imageIndex:irandom(3), xCoordinate:(-3000 - irandom(20000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}

	
	//Section 1 Start
	//Canyon
	
	if (n = 50) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 50) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight4, imageIndex:0, xCoordinate:1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 80) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Tree1, imageIndex:0, xCoordinate:1400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 100) {
        array_push(segments[n, sg.rotated], {sprite:spr_ArcadeRacer_Skeleton1, imageIndex:0, objLength: 10, xCoordinate1:-1400, xCoordinate2:-1930, yCoordinate1:0, yCoordinate2:800, zCoordinate1:n * segmentLength-50, zCoordinate2:(n + 10) * segmentLength-50, animationSpeed:0, xScreen1:0, yScreen1:0, xScreen2:0, yScreen2:0, xScreen3:0, yScreen3:0, xScreen4:0, yScreen4:0 });
    }
	if (n = 112) {
        array_push(segments[n, sg.rotated], {sprite:spr_ArcadeRacer_Skeleton3, imageIndex:0, objLength: 8, xCoordinate1:-1025, xCoordinate2:-1555, yCoordinate1:0, yCoordinate2:800, zCoordinate1:n * segmentLength-50, zCoordinate2:(n + 8) * segmentLength-50, animationSpeed:0, xScreen1:0, yScreen1:0, xScreen2:0, yScreen2:0, xScreen3:0, yScreen3:0, xScreen4:0, yScreen4:0 });
    }
	if (n = 102) {
        array_push(segments[n, sg.rotated], {sprite:spr_ArcadeRacer_Skeleton2, imageIndex:0, objLength: 10, xCoordinate1:-1650, xCoordinate2:-2270, yCoordinate1:0, yCoordinate2:800, zCoordinate1:n * segmentLength-50, zCoordinate2:(n + 10) * segmentLength-50, animationSpeed:0, xScreen1:0, yScreen1:0, xScreen2:0, yScreen2:0, xScreen3:0, yScreen3:0, xScreen4:0, yScreen4:0 });
    }
	
	if (n = 160) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-3600, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-6000), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 160) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight, imageIndex:0, xCoordinate:2600, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight2, imageIndex:0, xCoordinate:(2080 * i) + (5000), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 200) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-2000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-4400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 280) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Tree2, imageIndex:0, xCoordinate:-3400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 300) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight, imageIndex:0, xCoordinate:5600, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight2, imageIndex:0, xCoordinate:(2080 * i) + (8000), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }

	if (n = 430) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-5000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 500) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Tree3, imageIndex:0, xCoordinate:-6000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 500) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight, imageIndex:0, xCoordinate:4600, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight2, imageIndex:0, xCoordinate:(2080 * i) + (7000), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 650) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-4200, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 7; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-6600), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 740) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 760) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Tree4, imageIndex:0, xCoordinate:4000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 780) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_RouteSign, imageIndex:0, xCoordinate:-1400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 800) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-6000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-10400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 800) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight4, imageIndex:0, xCoordinate:4000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight3, imageIndex:0, xCoordinate:(2080 * i) + (8400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 850) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-6400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 900) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1038) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-6000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-10400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1100) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1900) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Billboard, imageIndex:0, xCoordinate:-5500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 1214) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-4000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-8400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1310) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-4000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-8400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1400) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1420) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Tree5, imageIndex:0, xCoordinate:-1000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	if (n = 1470) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1600) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-4000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-8400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1700) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 1950) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-14000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-18400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	if (n = 1900) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight4, imageIndex:0, xCoordinate:1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight3, imageIndex:0, xCoordinate:(2080 * i) + (5900), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 2100) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight, imageIndex:0, xCoordinate:2000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight2, imageIndex:0, xCoordinate:(2080 * i) + (6400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 2150) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-13000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-17400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	
	
	if (n = 2200) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-3000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 24; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-7400), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 2200) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_LeftTurnSign, imageIndex:0, xCoordinate:1000, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }
	
	
	if (n = 2230) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight4, imageIndex:0, xCoordinate:5500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight3, imageIndex:0, xCoordinate:(2080 * i) + (9900), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 2300) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight, imageIndex:0, xCoordinate:1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 18; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRockRight2, imageIndex:0, xCoordinate:(2080 * i) + (5900), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n >= 2500 && n <= 3400 && (n - 2500) mod 100 = 0) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_LeftChevron, imageIndex:0, xCoordinate:1800, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
    }

	if (n = 3340) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 11; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock2, imageIndex:0, xCoordinate:(-2080 * i) + (-3900), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }

	if (n = 3400) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-1400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 2; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-3800), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }
	
	if (n = 3500) {
        array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock4, imageIndex:0, xCoordinate:-1600, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		for (var i = 0; i < 2; ++i) {
		    array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestRock3, imageIndex:0, xCoordinate:(-2080 * i) + (-3800), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
    }

    if (n > 500 && n < 2000) {
        segments[n, sg.curve] = easeInXAxis(500, 2000, n, 250, 250, 0.3);
    }
	
	if (n > 500 && n < 1000) {
		targetElevation = easeInYAxis(500, 1000,n,targetElevation, 250, 250, 43) 
    }
	
	if (n >1000 && n < 2300) {
		targetElevation = easeInYAxis(1000,2300,n,targetElevation, 500, 500, -35) 
    }
	
	if (n > 2300 && n < 3200) {
        targetElevation = easeInYAxis(2300,3200,n,targetElevation, 500, 250, 50) 
    }
	
	if (n > 2100 && n < 3600) {
        segments[n, sg.curve] = easeInXAxis(2100, 3600, n, 500, 350, -0.4);
    }
	
	if (n > 3300 && n < 4200) {
        targetElevation = easeInYAxis(3300,4200,n,targetElevation, 250, 250, -90) 
    }
	
	
	//Farm
	
	
	if (n = 3700 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Welcome, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 3720 ) {
		for (var i = 0; i < 10; i += 1) {
			array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Railing, imageIndex:0, xCoordinate:-1200 - (500 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
			array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Railing, imageIndex:0, xCoordinate:1200 + (500 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
	}
	
	if ((n >= 3760) && (n <= 4000) && (n % 10 = 0)) {
		for (var i = 0; i < 30; i += 1) {
			array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Shrub1, imageIndex:0, xCoordinate:-2020 - (900 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
	}
	
	if (n = 4000 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1House, imageIndex:0, xCoordinate:-6020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 4090 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Pond, imageIndex:0, xCoordinate:-11020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 4100 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Windmill, imageIndex:0, xCoordinate:-5020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 4110 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Generator, imageIndex:0, xCoordinate:-5020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if ((n >= 4010) && (n <= 4130) && (n % 10 = 0)) {
		for (var i = 0; i < 10; i += 1) {
			array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Shrub1, imageIndex:0, xCoordinate:-16020 - (900 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
	}
	
	if (n = 3800 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Silo, imageIndex:0, xCoordinate:5020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 3850 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Silo, imageIndex:0, xCoordinate:6520, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if ((n >= 4140) && (n <= 6220) && (n % 10 = 0)) {
		for (var i = 0; i < 40; i += 1) {
			array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Shrub1, imageIndex:0, xCoordinate:-2020 - (900 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
			array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Shrub1, imageIndex:0, xCoordinate:2020 + (900 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		}
	}
	
	if (n = 4180 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester, imageIndex:0, xCoordinate:-10020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 5200 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester2, imageIndex:0, xCoordinate:5020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 5440 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester2, imageIndex:0, xCoordinate:10020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 5600 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester2, imageIndex:0, xCoordinate:16020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 5760 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester, imageIndex:0, xCoordinate:-10020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 5800 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester2, imageIndex:0, xCoordinate:12020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 6000 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester2, imageIndex:0, xCoordinate:16020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 6000 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Harvester, imageIndex:0, xCoordinate:-14020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	
	
	if (n = 6260 ) {
			for (var i = 0; i < 2; i += 1) {
				array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Railing, imageIndex:0, xCoordinate:-3020 - (1000 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
				array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Railing, imageIndex:0, xCoordinate:3020 + (1000 * i), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
			}
		}
		
	if (n = 6280 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Town1Welcome2, imageIndex:0, xCoordinate:-2520, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if ((n > 6300) && (n <= 8190) && (n % 100 = 0)) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_CactusSilhouette, imageIndex:irandom(2), xCoordinate:(3000 + irandom(40000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_CactusSilhouette, imageIndex:irandom(2), xCoordinate:(-3000 - irandom(40000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if ((n > 6300) && (n <= 8190) && (n % 40 = 0)) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_ShrubsSilhouette, imageIndex:irandom(3), xCoordinate:(3000 + irandom(30000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_ShrubsSilhouette, imageIndex:irandom(3), xCoordinate:(-3000 - irandom(30000)), yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 7400 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_GasSign, imageIndex:0, xCoordinate:1100, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_FoodSign, imageIndex:0, xCoordinate:1400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 7400 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Oil3, imageIndex:0, xCoordinate:-7020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 7700 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Oil2, imageIndex:0, xCoordinate:10920, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	
	
	if (n = 7700 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_SpeedSign, imageIndex:0, xCoordinate:-1100, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 7930 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Oil2, imageIndex:0, xCoordinate:-9020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 8000 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Oil1, imageIndex:0, xCoordinate:10020, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 8100 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_HighwaySign, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n > 3700 && n < 4800) {
        segments[n, sg.curve] = easeInXAxis(3700, 4800, n, 350, 350, 0.5);
    }
	
	if (n > 4200 && n < 4900) {
        targetElevation = easeInYAxis(4200,4900,n,targetElevation, 350, 150, 40) 
    }
	
	if (n > 4900 && n < 5700) {
        targetElevation = easeInYAxis(4900,5700,n,targetElevation, 100, 450, -60) 
    }
	
		if (n > 5000 && n < 5600) {
        segments[n, sg.curve] = easeInXAxis(5000, 5600, n, 200, 350, -0.3);
    }
	
	if (n > 5800 && n < 7400) {
        segments[n, sg.curve] = easeInXAxis(5800, 7400, n, 500, 350, 0.3);
    }
	
	if (n > 5700 && n < 6500) {
        targetElevation = easeInYAxis(5700,6500,n,targetElevation, 100, 450, 40) 
    }
	
	if (n > 6800 && n < 8300) {
        targetElevation = easeInYAxis(6800,8300,n,targetElevation, 500, 25, -8) 
    }
	
	//Section 1 End 7400
	
	//Checkpoint
	
	//Section 2 Start 8400
	
	//cars
	if (n = 5600) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 5800) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 6300) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 6500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 7400) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 7800) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 8200) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 8400) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 8650) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 8850) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 8850) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	
	if (n = 9100) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 9500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 9500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 9640) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 10000) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 10300) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 10600) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 10930) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 11400) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 11400) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 11600) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 11900) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 12100) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 12300) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 12400) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 12500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 12500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 12560) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 12700) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	if (n = 13100) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 13300) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver3, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 13500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver1, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	if (n = 13500) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:-400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][2]});
	}
	
	if (n = 13700) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:400, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][0]});
	}
	
	
	if (n = 13800) {
		array_push(segments[n, sg.vehicle], {sprite:spr_ArcadeRacer_Driver2, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0, velocity:vehicleSpeed[difficulty][1]});
	}
	
	
	
	//Tunnel
	
	
	if (n > 8300 && n < 10500) {
		targetElevation = easeInYAxis(8300, 10500,n,targetElevation, 250, 500, -20) 
    }

	if (n > 9500 && n < 11000) {
        segments[n, sg.curve] = easeInXAxis(9500, 11000, n, 200, 200, 0.28);
    }
	
	if (n > 10500 && n < 11000) {
		targetElevation = easeInYAxis(10500, 11000,n,targetElevation, 200, 250, 20) 
    }
	
	if (n > 11000 && n < 12000) {
        segments[n, sg.curve] = easeInXAxis(11000, 12000, n, 200, 50, -0.24);
    }
	
	if (n > 8600 && n < 9600) {
		array_push(segments[n, sg.terrain2], {hex:#1d2f45, xCoordinate:-1500, yCoordinate:segments[n, sg.world_y], xScreen1:0, xScreen2:0, yScreen:0, wScreen:0});
	}
	
	if (n = 9601) {
		for (var i = 8601; i <= 9600; ++i) {
			if (array_length(segments[i, sg.terrain2]) > 0) {
				for (var j = 0; j < array_length(segments[i, sg.terrain2]); ++j) {
				    segments[i, sg.terrain2][j].yCoordinate = segments[8600, sg.world_y];
				}
				
			}
		}
	}
	
	if (n = 8500 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 8501 && n <= 8800) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 8650 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 8800 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 8801 && n <= 9100) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 9100 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 9101 && n <= 9300) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 9250 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 9300 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 9301 && n <= 9500) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 9500 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 9501 && n <= 9800) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 9650 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 9800 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 9801 && n <= 10100) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0,  opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	
	
	if (n = 10100 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 10101 && n <= 10400) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 10250 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 10400 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 10401 && n <= 10700) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 10700 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	
	if (n >= 10701 && n <= 10900) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 10850 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 10900 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 10901 && n <= 11200) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n > 11000 && n < 12100) {
		targetElevation = easeInYAxis(11000, 15000,n,targetElevation, 250, 250, 10) 
    }
	
	if (n = 11200 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 11201 && n <= 11500) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 11350 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 11500 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 11501 && n <= 11800) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 11800 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 11801 && n <= 12100) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 11950 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	
	if (n = 12100 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel3, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	//Underwater Scene
	
	if (n >= 12101 && n <= 13300) {
		segments[n, sg.c_terrain] = 0;
	}
	 
	//underwater box
	if (n >= 12101 && n <= 13300) {
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-2500, xCoordinate2:-2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:2500, xCoordinate2:2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_WaterWall2, xCoordinate1:-3000, xCoordinate2:3000, yCoordinate1:4000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_WaterWall3, xCoordinate1:-3000, xCoordinate2:3000, yCoordinate1:-3000, yCoordinate2:-3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	 
	//Glass
	if (n >= 12101 && n <= 12400) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}

	if (n >= 12401 && n <= 12700) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}

	if (n >= 12701 && n <= 13000) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n >= 13001 && n <= 13300) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 13300 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel3, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 13300) {
		array_push(segments[n, sg.screen], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-1500, xCoordinate2:-2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.screen], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:1500, xCoordinate2:2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.screen_ceiling], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.screen_ceiling], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:-3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n >= 13301 && n <= 13600) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	 
	if (n = 13600 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel3, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 13601 && n <= 14800) {
		segments[n, sg.c_terrain] = 0;
	}
	
	//underwater box
	
	if (n >= 13601 && n <= 14800) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-2500, xCoordinate2:-2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:2500, xCoordinate2:2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_WaterWall2, xCoordinate1:-3000, xCoordinate2:3000, yCoordinate1:4000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_WaterWall3, xCoordinate1:-3000, xCoordinate2:3000, yCoordinate1:-3000, yCoordinate2:-3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	//glass
	
	if (n >= 13601 && n <= 13900) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n >= 13901 && n <= 14200) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n >= 14201 && n <= 14500) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n >= 14501 && n <= 14800) {
        array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:-1000, xCoordinate2:-1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.glass], {sprite:spr_ArcadeRacer_TestGlass1, xCoordinate1:1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass3, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestGlass2, xCoordinate1:-1000, xCoordinate2:1000, yCoordinate1:-50, yCoordinate2:-50, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: .1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 14800 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel3, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 14800) {
        array_push(segments[n, sg.screen], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-1500, xCoordinate2:-2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.screen], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:1500, xCoordinate2:2500, yCoordinate1:-3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.screen_ceiling], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.screen_ceiling], {sprite:spr_ArcadeRacer_WaterWall1, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:-3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n >= 14801 && n <= 15100) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 15100 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	
	if (n > 15100 && n < 15600) {
        segments[n, sg.curve] = easeInXAxis(15100, 16100, n, 150, 50, -0.18);
    }
	
	if (n > 15601 && n < 16100) {
        segments[n, sg.curve] = easeInXAxis(15100, 16100, n, 50, 150, 0.18);
    }
	
	if (n > 15100 && n < 16100) {
		targetElevation = easeInYAxis(15100, 16100,n,targetElevation, 150, 150, 30) 
    }
	
	if (n >= 15101 && n <= 15300) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 15250 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 15300 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 15301 && n <= 15600) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 15600 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 15601 && n <= 15900) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 15750 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TunnelLights, imageIndex:0, xCoordinate:0, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n = 15900 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	if (n >= 15901 && n <= 16200) {
        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:1500, xCoordinate2:1500, yCoordinate1:0, yCoordinate2:4000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
		array_push(segments[n, sg.roof], {sprite:spr_ArcadeRacer_TestWall2, xCoordinate1:-1500, xCoordinate2:1500, yCoordinate1:3000, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, opacity: 1, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
	}
	
	if (n = 16200 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_TestTunnel2, imageIndex:0, xCoordinate:-1500, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	// Section 2 End 16,400
	if (n = 16400 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Pylon, imageIndex:0, xCoordinate:-900, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	
	
	
	if (n = 17400 ) {
		array_push(segments[n, sg.obstacle], {sprite:spr_ArcadeRacer_Pylon, imageIndex:0, xCoordinate:-900, yCoordinate:0, zCoordinate:n * segmentLength-50, animationSpeed:0, xScreen:0, yScreen:0, wScreen:0});
	}
	// Checkpoint
	
	//Section 3 Start 17,400 
	
	//if (n >= 200 && n <= 300) {
//        array_push(segments[n, sg.polygon], {sprite:spr_ArcadeRacer_TestWall1, xCoordinate1:-1500, xCoordinate2:-1500, yCoordinate1:0, yCoordinate2:3000, zCoordinate1:n * segmentLength, scale1: 0, scale2: 0, animationSpeed:0, xScreen1:0, xScreen2:0, xScreen3:0, xScreen4: 0, yScreen1:0, yScreen2:0, yScreen3: 0, yScreen4: 0});
//    }
	
	
    if(targetElevation > elevation) {
        elevation  = targetElevation;
    }
    else if(targetElevation < elevation) {
        elevation = targetElevation;
    }
        

	segments[n, sg.world_y] = elevation;

    
}
