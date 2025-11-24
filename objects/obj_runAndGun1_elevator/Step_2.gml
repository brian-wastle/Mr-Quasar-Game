

switch (elevatorState) {
    case 0:
        if (obj_RunAndGun_Player.x > 11270) {
		    image_index += 1;
			elevatorState = 1;
		}
        break;
	case 1:
		if (y < 860) {
		    y += 4;
			if (place_meeting(x,y - 1,obj_RunAndGun_Player) && !place_meeting(x,y,obj_RunAndGun_Player)) {
		        obj_RunAndGun_Player.y += 4;
				obj_RunAndGun_Player.actionstate = 0;
				obj_RunAndGun_Player.vsp = 0;
			}
		} else {
			elevatorState = 2;
			y = 860;
			image_index += 1;
		}
        break;
}


