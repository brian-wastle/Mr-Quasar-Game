
collisionArrayLength[0] = collision_line_list(1255,822 + 58, 1255,961 + 58, obj_twinStickShooter_bulletParent, 1, 0, collisionListRight, 0);
collisionArrayLength[1] = collision_line_list(1048,822 + 58, 1255,822 + 58, obj_twinStickShooter_bulletParent, 1, 0, collisionListTop, 0);
collisionArrayLength[2] = collision_line_list(1048,961 + 58, 1048,822 + 58, obj_twinStickShooter_bulletParent, 1, 0, collisionListLeft, 0);
collisionArrayLength[3] = collision_line_list(1048,961 + 58, 1255,961 + 58, obj_twinStickShooter_bulletParent, 1, 0, collisionListBottom, 0);


for (var i = 0; i < 4; ++i) {
	if (collisionArrayLength[i] > 0) {
		for (var j = 0; j < collisionArrayLength[i]; ++j) {
			//list right
			if (i = 0) {
				if (collisionListRight[| j].direction = 225) {
					collisionListRight[| j].direction = 315;
					collisionListRight[| j].sprite_index = spr_twinStickShooter_bullet0h;
					collisionListRight[| j].x -= 78;
					collisionListRight[| j].y += 16;
				}
				if (collisionListRight[| j].direction = 180) {
					collisionListRight[| j].direction = 0;
					collisionListRight[| j].sprite_index = spr_twinStickShooter_bullet0a;
					collisionListRight[| j].x -= 78;
				}
				if (collisionListRight[| j].direction = 135) {
					collisionListRight[| j].direction = 45;
					collisionListRight[| j].sprite_index = spr_twinStickShooter_bullet0b;
					collisionListRight[| j].x -= 98;
					collisionListRight[| j].y -= 16;
				}		
			}
			//list top
			if (i = 1) {
				if (collisionListTop[| j].direction = 225) {
					collisionListTop[| j].direction = 135;
					collisionListTop[| j].sprite_index = spr_twinStickShooter_bullet0d;
					collisionListTop[| j].x -= 4;
					collisionListTop[| j].y += 78;
				}
				if (collisionListTop[| j].direction = 270) {
					collisionListTop[| j].direction = 90;
					collisionListTop[| j].sprite_index = spr_twinStickShooter_bullet0c;
					collisionListTop[| j].x -= 16;
					collisionListTop[| j].y += 98;
				}
				if (collisionListTop[| j].direction = 315) {
					collisionListTop[| j].direction = 45;
					collisionListTop[| j].sprite_index = spr_twinStickShooter_bullet0b;
					collisionListTop[| j].y += 78;
				}		
			}
			//list left
			if (i = 2) {
				if (collisionListLeft[| j].direction = 45) {
					collisionListLeft[| j].direction = 135;
					collisionListLeft[| j].sprite_index = spr_twinStickShooter_bullet0d;
					collisionListLeft[| j].x += 98;
					collisionListLeft[| j].y -= 8;
				}
				if (collisionListLeft[| j].direction = 0) {
					collisionListLeft[| j].direction = 180;
					collisionListLeft[| j].sprite_index = spr_twinStickShooter_bullet0e;
					collisionListLeft[| j].x += 78;
				}
				if (collisionListLeft[| j].direction = 315) {
					collisionListLeft[| j].direction = 225;
					collisionListLeft[| j].sprite_index = spr_twinStickShooter_bullet0f;
					collisionListLeft[| j].x += 78;
					collisionListLeft[| j].y += 16;
				}		
			}
			//list bottom
			if (i = 3) {
				if (collisionListBottom[| j].direction = 45) {
					collisionListBottom[| j].direction = 315;
					collisionListBottom[| j].sprite_index = spr_twinStickShooter_bullet0h;
					collisionListBottom[| j].x += 20;
					collisionListBottom[| j].y -= 75;
				}
				if (collisionListBottom[| j].direction = 90) {
					collisionListBottom[| j].direction = 270;
					collisionListBottom[| j].sprite_index = spr_twinStickShooter_bullet0g;
					collisionListBottom[| j].x += 16;
					collisionListBottom[| j].y -= 75;
				}
				if (collisionListBottom[| j].direction = 135) {
					collisionListBottom[| j].direction = 225;
					collisionListBottom[| j].sprite_index = spr_twinStickShooter_bullet0f;
					collisionListBottom[| j].x -= 20;
					collisionListBottom[| j].y -= 75;
				}		
			}
		}
	}
}

ds_list_clear(collisionListRight);
ds_list_clear(collisionListTop);
ds_list_clear(collisionListLeft);
ds_list_clear(collisionListBottom);
collisionArrayLength[0] = 0;
collisionArrayLength[1] = 0;
collisionArrayLength[2] = 0;
collisionArrayLength[3] =0;