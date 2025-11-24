if obj_vertShmup_PlayerChar.actionState != 10 {
	obj_vertShmup_PlayerChar.actionState = 10;
	instance_create_layer(x,y,"Instances",obj_vertShmup_Explosions);
	instance_destroy();
}

