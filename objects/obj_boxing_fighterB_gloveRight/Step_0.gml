var targetDistance = point_distance(x,y,parentId.x, parentId.y)
if ( targetDistance > 2) {
	rate = targetDistance/(500 + targetDistance) * 10;
	move_towards_point( parentId.x, parentId.y, rate * objectSpeed );
} else {
	speed *= 1/3;
}