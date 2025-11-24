// move mover into position
if (instance_exists(creatorID)) {
    x = creatorID.x;
	y = creatorID.y;
	sprite_index = creatorID.sprite_index;
	image_index  = creatorID.image_index;
	image_angle  = creatorID.image_angle;
	image_xscale = creatorID.image_xscale;
	image_yscale = creatorID.image_yscale;
	moveSpeed	 = creatorID.moveSpeed;
	dirState	 = creatorID.dirState;
} else {
	instance_destroy();
}



switch (dirState) {
    case 1:		// carry player
        var onTop = collision_line(x - 96, y - 49, x + 144, y - 49, obj_RunAndGun_Player, 1, 1);
		var inside = collision_line(x - 96, y - 44, x + 144, y - 44, obj_RunAndGun_Player, 1, 1);
		if (onTop && !inside &&  obj_RunAndGun_Player.actionstate != 14) {
		    obj_RunAndGun_Player.x += moveSpeed;
			if (place_meeting(x, y, obj_RunAndGun_Player)) {
				while (collision_line(x - 96, y - 48, x + 144, y - 48, obj_RunAndGun_Player, 1, 1)) {
					obj_RunAndGun_Player.y -= 1;
				}
			}
		} else if (place_meeting(x, y, obj_RunAndGun_Player) && obj_RunAndGun_Player.actionstate == 14) {
			var fallCollision = collision_line(x - 96, y - 42, x + 144, y - 42, obj_RunAndGun_Player, 1, 1);
			var playerSpeed = obj_RunAndGun_Player.vsp;
			if (obj_RunAndGun_Player.y < y) {
			    while (collision_line(x - 96, y - 48, x + 144, y - 48, obj_RunAndGun_Player, 1, 1)) {
					obj_RunAndGun_Player.y -= 1;
				}
				obj_RunAndGun_Player.actionstate = 0;
			}
		}
        break;
    case -1:	// push player
		if (x < 7000) {
		    var inFront = collision_line(x - 104, y - 104, x - 104, y + 108, obj_RunAndGun_Player, 1, 1);
			var playerCollision = place_meeting(x, y, obj_RunAndGun_Player);
			if (playerCollision && obj_RunAndGun_Player.x < x) {
			    while (place_meeting(x, y, obj_RunAndGun_Player)) {
					obj_RunAndGun_Player.x -= 1;
				}
			}
		}
        break;
}