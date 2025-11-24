
depth = (y * -1) -200;

if (place_meeting(x,y,obj_twinStickShooter_boundaryParent)) {

	instance_destroy();
	instance_create_layer(bulletOffsetX,bulletOffsetY,"Instances", obj_twinStickShooter_bulletSmoke0);
}