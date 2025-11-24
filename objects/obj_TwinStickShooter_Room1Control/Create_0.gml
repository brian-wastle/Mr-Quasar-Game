depth = -1000;
global.twinStickGrid1 = mp_grid_create(250, 150, 60, 40, 30, 30);
refreshTimer = 0;
enemyWave = 0;

waveArray[0] = [{enemy:obj_twinStickShooter_guardBottom, amount:8, position:1}];
waveArray[1] = [{enemy:obj_twinStickShooter_guardBottom, amount:6, position:0}, {enemy:obj_twinStickShooter_guardBottom, amount:6, position:2}];
waveArray[2] = [{enemy:obj_twinStickShooter_guardBottom, amount:4, position:0}, {enemy:obj_twinStickShooter_dogDroid, amount:1, position:1}, {enemy:obj_twinStickShooter_guardBottom, amount:4, position:2}];
waveArray[3] = [{enemy:obj_twinStickShooter_dogDroid, amount:2, position:0},{enemy:obj_twinStickShooter_guardBottom, amount:6, position:1},{enemy:obj_twinStickShooter_dogDroid, amount:2, position:2}];
waveArray[4] = [];
waveArray[5] = [];

spawnPointArray[0] = [{xSpawn:1800,ySpawn:784},{xSpawn:1800,ySpawn:825},{xSpawn:1835,ySpawn:815}];
spawnPointArray[1] = [{xSpawn:1130,ySpawn:300},{xSpawn:1170,ySpawn:300},{xSpawn:1150,ySpawn:250}];
spawnPointArray[2] = [{xSpawn:510,ySpawn:784},{xSpawn:510,ySpawn:825},{xSpawn:475,ySpawn:815}];
spawnPointArray[3] = [{xSpawn:1125,ySpawn:1285},{xSpawn:1175,ySpawn:1285},{xSpawn:1150,ySpawn:1325}];
spawnPosition = 0; // which of the 3 spawn postions on each side is used

spawnStateTrigger = 0; // init spawn state
doorStateArray = [obj_twinStickShooter_RightDoor,obj_twinStickShooter_TopDoor,obj_twinStickShooter_LeftDoor, 0]; //keep track of door objects
doorTimer = 0; // delay after enemies spawn, collected from an array
stateTimer0 = 0; //triggers door close after spawn wave finishes
stateTimer1 = 0;
stateTimer2 = 0;

spawnTimer = 0; // triggers spawnState, which generates enemies
spawnState = 0; //whether conditions are met to spawn the next wave or not
waveIndex = 0; //which wave we are on
waveArrayLength = 0;
enemyQueueArray = [0, 0, 0, 0, 0, 0, 0, 0]; //names and amount of enemies in each wave by spawn point
enemyActiveArray = [[],[],[],[]]; // amount and names of enemies on screen (children arrays) and which origin they spawned from (parent array)
postSpawnActivity = 0; //keeps track of whether enemies have spawned or not, usually triggered by spawnState reverting to 0 -- used to implement triggers like powerup drops
waveTrigger = 0;
doorShutTimer = 0; 

function loadEnemyQueue() {
	waveArrayLength = array_length(waveArray[enemyWave]);
	//for each spawn location in the current wave, loop through each object once}
	for (var i = 0; i < 4; ++i) {
		for (var j = 0; j < waveArrayLength; ++j) {
			if (waveArray[enemyWave][j].position = i) {
				enemyQueueArray[(i * 2)] = waveArray[enemyWave][j].enemy;
				enemyQueueArray[(i * 2) + 1] = waveArray[enemyWave][j].amount;
			}
		}
	}
}
loadEnemyQueue();
spawnState = 0;

waveTimer = 0;