enemyOffset = abs(obj_boxing_fighterB.x - obj_boxing_fighterA.x) > 150 ? 
	sign(obj_boxing_fighterB.x - obj_boxing_fighterA.x) : 0;
	
sprite_index = spriteArray[enemyOffset + 1];
	
var targetDistance = point_distance(x,y,parentId.x, parentId.y);
if ( targetDistance > 2) {
	rate = targetDistance/(500 + targetDistance) * 10;
	move_towards_point( parentId.x, parentId.y, rate * objectSpeed );
} else {
	speed *= 1/2;
}

if (parentSpeed <= abs(obj_boxing_fighterB.speed)) {
	parentSpeed = abs(obj_boxing_fighterB.speed);
}

if (parentSpeed > abs(obj_boxing_fighterB.speed)) {
	if (abs(obj_boxing_fighterB.speed) - abs(previousSpeed) > 0) {
		parentSpeed = 0;
		tempRate = 0;
	} else if (abs(obj_boxing_fighterB.speed) - abs(previousSpeed) < 0) {
		parentSpeed = abs(parentSpeed * .98) > .25 ? parentSpeed * .96 : 0;
		tempRate = abs(parentSpeed/obj_boxing_fighterB.maxSpeed) * .06;
	}
}

tempRate = (tempRate > .01) ? tempRate * .98 : 0;
cx = (cx = 1) ? tempRate 
	: ((cx + tempRate > 1) ? tempRate - (1 - cx)
	: cx + tempRate);

var ch = animcurve_get_channel(curve_boxing_fighterB_idle, 0);
var cy = animcurve_channel_evaluate(ch, cx);
xOffset = round(cy * 250);
previousSpeed = obj_boxing_fighterB.speed;