
pathDistance -= speed;


if (point_distance(x, y, destinationX, destinationY) < 5 || point_distance(initialX, initialY, x, y) > point_distance(initialX,initialY,destinationX,destinationY)) {
	instance_destroy();
}

rotateAngle += 5;
if (rotateAngle = 360) {
	rotateAngle = 0;
}