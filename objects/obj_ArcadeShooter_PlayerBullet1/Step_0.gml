pathDistance -= speed;
imageSize = (1 - (pathDistance/initPathDist));


if (point_distance(x, y, destinationX, destinationY) < speed || point_distance(initialX, initialY, x, y) > point_distance(initialX,initialY,destinationX,destinationY)) {
	instance_create_layer(destinationX,destinationY,"Instances", obj_ArcadeShooter_PlayerBullet1Pop)
	instance_destroy();
}

rotateAngle += 5;
if (rotateAngle = 360) {
	rotateAngle = 0;
}