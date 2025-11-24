
switch (powerupType) {
	case 0:
		obj_TwinStickShooter_player.bulletType = 1;
	    break;
	case 1:
	    obj_TwinStickShooter_player.bulletType = 2;
	    break;
	case 2:
	    obj_TwinStickShooter_player.bulletType = 3;
	    break;
}
instance_destroy(self);