// currentIndex - current hitbox image_index
// depth - depth of char minus 8 px
// char - playerChar index
dirOffset = obj_beatEmUp_player.directionOffset;
effectType = 0;
if (obj_beatEmUp_player.actionstate == 3) {
    effectType = 0;
} else if (obj_beatEmUp_player.actionstate == 11) {
	effectType = 1;
} else if (obj_beatEmUp_player.airAttackState == 1) {
	effectType = 2;
} else if (obj_beatEmUp_player.airAttackState == 2) {
	effectType = 3;
}

// Combo offsets
effectOffset[0,0] = [
	{index: 0, xOffset: 140, yOffset: 216},
	{index: 3, xOffset: 140, yOffset: 216},
	{index: 9, xOffset: 180, yOffset: 210},
	{index: 15, xOffset: 180, yOffset: 180},
	{index: 22, xOffset: 160, yOffset: 236}
];

// Back attack
effectOffset[1,0] = [
	{index: 1, xOffset: -164, yOffset: 204},
]

// Air attack
effectOffset[2,0] = [
	{index: 5, xOffset: 154, yOffset: 144}
];

// Spike attack
effectOffset[3,0] = [
	{index: 5, xOffset: 0, yOffset: 0}
];

structArray = effectOffset[effectType,char];
xOffset = 0;
yOffset = 0;
for (var i = 0; i < array_length(structArray); i++) {
	if (structArray[i].index >= currentIndex - 1 && structArray[i].index <= currentIndex + 1) {
		xOffset = structArray[i].xOffset;
		yOffset = structArray[i].yOffset;
		break;
	}
}

depth = -y - 100;
zsp = obj_beatEmUp_player.zsp;

x = x - xOffset * -dirOffset;
y = y - zsp - yOffset;

if (effectType == 2) {
    dirOffset *= -1;
}