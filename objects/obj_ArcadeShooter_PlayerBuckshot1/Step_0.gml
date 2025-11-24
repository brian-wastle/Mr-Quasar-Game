pathDistance -= speed;

if (point_distance(x, y, destinationX, destinationY) < speed || point_distance(initialX, initialY, x, y) > point_distance(initialX,initialY,destinationX,destinationY)) {
	instance_create_layer(destinationX,destinationY,"Instances", obj_ArcadeShooter_PlayerBuckshot1Pop)
	instance_destroy();
}

