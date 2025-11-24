if (image_index < image_number - 1) {
	image_index = (11 * (100-enemyHealth)/100);
} else {
	instance_create_layer(x,y,"Instances",obj_TwinStickShooter_Room4Blink);
	instance_destroy();
}


event_inherited();