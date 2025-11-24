//inputs
keyLeft = 0;
keyRight = 0;
//vars
punchState = 0;
subState = 0;
stateTimer = 0;
stateOverride = 0;


stateQueue = 0;
queueState = "open";

armOffset = [240, 80];
turnOffset = -50; 
enemyOffset = 0; // direction player is facing

pathData = {
	idle: [
		path_boxing_right_idle,
		path_boxing_center_idle,
		path_boxing_center_idle1,
		path_boxing_left_idle
	],
	jabRight: [
		path_boxing_left_jabL0R,
		path_boxing_left_jabR0R,
		path_boxing_left_jabL1R,
		path_boxing_left_jabR1R,
		path_boxing_left_idle,
		path_boxing_left_idle,
		path_boxing_right_jabL0R,
		path_boxing_right_jabR0R,
		path_boxing_right_jabL1R,
		path_boxing_right_jabR1R,
		path_boxing_right_idle,
		path_boxing_right_idle,
		path_boxing_center_jabL0R,
		path_boxing_center_jabR0R,
		path_boxing_center_jabL1R,
		path_boxing_center_jabR1R,
		path_boxing_center_idle,
		path_boxing_center_idle
	],
	jabLeft: [
		path_boxing_left_jabL0L,
		path_boxing_left_jabR0L,
		path_boxing_left_jabL1L,
		path_boxing_left_jabR1L,
		path_boxing_left_idle,
		path_boxing_left_idle,
		path_boxing_right_jabL0L,
		path_boxing_right_jabR0L,
		path_boxing_right_jabL1L,
		path_boxing_right_jabR1L,
		path_boxing_right_idle,
		path_boxing_right_idle,
		path_boxing_center_jabL0L,
		path_boxing_center_jabR0L,
		path_boxing_center_jabL1L,
		path_boxing_center_jabR1L,
		path_boxing_center_idle,
		path_boxing_center_idle
	],
	slide: [
		path_boxing_right_slide,
		path_boxing_center_slide,
		path_boxing_center_slide1,
		path_boxing_left_slide
	],
	block: [
		path_boxing_right_block,
		path_boxing_center_block,
		path_boxing_center_block1,
		path_boxing_left_block
	]
}
subStateData = {
	idleTimerArray: [5],
	idleSpeedArray: [20],
	
	jabTimerArray: [5,10,10],
	jabSpeedArray: [22.5,50,18],
}

pathPositionsArray = [0,.2,.4,.6,.8,1]; // positions of arm nodes
armDataRight = array_create(6); // instance ids for right arm
armDataLeft = array_create(6); // instance ids for left arm
xOnPath = 0; //calculate path positions
yOnPath = 0; //calculate path positions

currentRightPath = pathData.idle[1];
currentLeftPath = pathData.idle[2];
childSpeed = 0;


//create right arm
path_start(currentRightPath, 0, 0, 0);
for (var i = 0; i < 5; ++i) {
	xOnPath = path_get_x(path_index, pathPositionsArray[i]);
	yOnPath = path_get_y(path_index, pathPositionsArray[i]);
	armDataRight[i] = instance_create_layer(
		x + armOffset[0] + xOnPath, 
		y - armOffset[1] + yOnPath, 
		"Arms", 
		obj_boxing_fighterB_nodes, {
			node: "arm"
		}
	);
}

//create right glove
xOnPath = path_get_x(path_index, pathPositionsArray[5]);
yOnPath = path_get_y(path_index, pathPositionsArray[5]);
armDataRight[5] = instance_create_layer(
	x + armOffset[0] + xOnPath, 
	y - armOffset[1] + yOnPath, 
	"Arms", 
	obj_boxing_fighterB_nodes, {
		node: "gloveRight"
	}
);

//create left arm
path_start(currentLeftPath, 0, 0, 0);
for (var i = 0; i < 5; ++i) {
	xOnPath = path_get_x(path_index, pathPositionsArray[i]);
	yOnPath = path_get_y(path_index, pathPositionsArray[i]);
	armDataLeft[i] = instance_create_layer(
		x - armOffset[0] - xOnPath, 
		y - armOffset[1] + yOnPath, 
		"Arms", 
		obj_boxing_fighterB_nodes, {
			node: "arm"
		}
	);
}

//create left glove
xOnPath = path_get_x(path_index, pathPositionsArray[5]);
yOnPath = path_get_y(path_index, pathPositionsArray[5]);
armDataLeft[5] = instance_create_layer(
	x - armOffset[0] - xOnPath, 
	y - armOffset[1] + yOnPath, 
	"Arms", 
	obj_boxing_fighterB_nodes, {
		node: "gloveLeft"
	}
);