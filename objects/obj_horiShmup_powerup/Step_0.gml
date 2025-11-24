var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1-500, y1-100, x2 + 100, y2+100)) { 
	instance_destroy(); 
}

speed = -.5 * obj_horiShmup_controlObject.bgSpeedVar;

switch (powerupType)
{
    case 0:
        sprite_index = spr_horiShmup_powerupB;
    break;

    case 1:
		sprite_index = spr_horiShmup_powerupH;
    break;
	
	case 2:
		sprite_index = spr_horiShmup_powerupM;
    break;
	
    case 3:
        sprite_index = spr_horiShmup_powerupS;
    break;
	
	case 4:
        sprite_index = spr_horiShmup_powerupT;
    break;
}


if place_meeting(x, y, obj_horiShmup_player) {
	
	switch (powerupType)
	{
	    case 0:
			if (obj_horiShmup_player.bulletSize < 2) {
	        obj_horiShmup_player.bulletSize += 1;
			}
	    break;
	    case 1:
		obj_horiShmup_player.homingBullets = 1;
			if (obj_horiShmup_player.numOfGuns > 3) {
				obj_horiShmup_player.numOfGuns = 3;
			}
	    break;
		case 2:
			if (obj_horiShmup_player.numOfGuns < 4) {
				obj_horiShmup_player.numOfGuns += 1;
			}
		break;
	    case 3:
	        obj_horiShmup_player.shieldStatus = 1;
	    break;
		case 4:
			if (!instance_exists(obj_horiShmup_drone)) {
				if (obj_horiShmup_player.numOfGuns > 3) {
					obj_horiShmup_player.numOfGuns = 3;
				}
				instance_create_layer(obj_horiShmup_player.x,obj_horiShmup_player.y,"Instances",obj_horiShmup_drone);
			}
		
		    
			
			
	    break;
	}
	
	instance_destroy(); 
}
